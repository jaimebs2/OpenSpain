#!/bin/bash
set -e

# Smoke test para el servicio Catastro.
# Verifica tres endpoints públicos de la API JSON del Catastro español:
#   1. Listado de provincias (ObtenerProvincias)
#   2. Datos de inmueble por dirección (Consulta_DNPLOC) — Gran Vía 1, Madrid
#   3. Referencia catastral por coordenadas (Consulta_RCCOOR) — CL Carretas 10, Madrid

CALLEJERO="https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc"
COORDENADAS="https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc"

# Comprobación rápida de dependencias.
for cmd in curl jq; do
  if ! command -v "${cmd}" > /dev/null 2>&1; then
    echo "✗ falta dependencia: ${cmd}" >&2
    exit 1
  fi
done

# --- 1. Listado de provincias ------------------------------------------------

echo "▶ Catastro ObtenerProvincias..."

url="${CALLEJERO}/json/ObtenerProvincias"
resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de ObtenerProvincias" >&2
  exit 1
fi

# Error reportado por la API (claves cuerr* > 0).
if echo "${resp}" | jq -e '.consulta_provincieroResult.control | to_entries | map(select(.key|startswith("cuerr"))) | map(.value|tonumber) | any(. > 0)' > /dev/null 2>&1; then
  echo "  ✗ la API devolvió un error en ObtenerProvincias" >&2
  echo "${resp}" | jq '.consulta_provincieroResult.lerr' >&2
  exit 1
fi

# Debe haber al menos una provincia con np (nombre) y cpine (código INE).
if ! echo "${resp}" | jq -e '.consulta_provincieroResult.provinciero.prov | length > 0' > /dev/null 2>&1; then
  echo "  ✗ no se encontraron provincias en la respuesta" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.consulta_provincieroResult.provinciero.prov[] | select(.np == "MADRID" and .cpine == "28")' > /dev/null 2>&1; then
  echo "  ✗ MADRID (cpine=28) no aparece en el listado de provincias" >&2
  exit 1
fi

num_prov=$(echo "${resp}" | jq '.consulta_provincieroResult.provinciero.prov | length')
echo "  ✓ ${num_prov} provincias listadas (incluye MADRID)"

# --- 2. Consulta de inmueble por dirección -----------------------------------

echo "▶ Catastro Consulta_DNPLOC (CL GRAN VIA 1 MADRID)..."

url="${CALLEJERO}/json/Consulta_DNPLOC?Provincia=MADRID&Municipio=MADRID&Sigla=CL&Calle=GRAN%20VIA&Numero=1"
resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de Consulta_DNPLOC" >&2
  exit 1
fi

if echo "${resp}" | jq -e '.consulta_dnplocResult.control | to_entries | map(select(.key|startswith("cuerr"))) | map(.value|tonumber) | any(. > 0)' > /dev/null 2>&1; then
  echo "  ✗ la API devolvió un error en Consulta_DNPLOC" >&2
  echo "${resp}" | jq '.consulta_dnplocResult.lerr' >&2
  exit 1
fi

# El refcat de 14 chars devuelve múltiples unidades en lrcdnp.rcdnp[].
if ! echo "${resp}" | jq -e '.consulta_dnplocResult.lrcdnp.rcdnp | length > 0' > /dev/null 2>&1; then
  echo "  ✗ no se encontraron inmuebles en Gran Via 1 Madrid" >&2
  exit 1
fi

# Verificar que el primer inmueble trae partes de referencia catastral.
if ! echo "${resp}" | jq -e '.consulta_dnplocResult.lrcdnp.rcdnp[0].rc | (.pc1 and .pc2 and .car and .cc1 and .cc2)' > /dev/null 2>&1; then
  echo "  ✗ falta alguna parte de la referencia catastral en rcdnp[0].rc" >&2
  exit 1
fi

refcat=$(echo "${resp}" | jq -r '.consulta_dnplocResult.lrcdnp.rcdnp[0].rc | .pc1 + .pc2 + .car + .cc1 + .cc2')
num_bi=$(echo "${resp}" | jq '.consulta_dnplocResult.lrcdnp.rcdnp | length')
echo "  ✓ ${num_bi} inmuebles encontrados (primer refcat: ${refcat})"

# --- 3. Referencia catastral por coordenadas ---------------------------------
# Coordenadas de un edificio con referencia catastral en el centro de Madrid
# (CL Carretas 10, junto a la Puerta del Sol) en WGS84.

echo "▶ Catastro Consulta_RCCOOR (CL Carretas 10 Madrid, EPSG:4326)..."

url="${COORDENADAS}/json/Consulta_RCCOOR?SRS=EPSG:4326&CoorX=-3.7033&CoorY=40.4153"
resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de Consulta_RCCOOR" >&2
  exit 1
fi

if echo "${resp}" | jq -e '.Consulta_RCCOORResult.control | to_entries | map(select(.key|startswith("cuerr"))) | map(.value|tonumber) | any(. > 0)' > /dev/null 2>&1; then
  echo "  ✗ la API devolvió un error en Consulta_RCCOOR" >&2
  echo "${resp}" | jq '.Consulta_RCCOORResult.lerr' >&2
  exit 1
fi

# coord puede ser objeto o array; normalizamos a array y pedimos al menos un elemento con pc y ldt.
if ! echo "${resp}" | jq -e '[.Consulta_RCCOORResult.coordenadas.coord] | flatten | map(select(.pc and .ldt)) | length > 0' > /dev/null 2>&1; then
  echo "  ✗ no se encontró refcat ni ldt para las coordenadas" >&2
  exit 1
fi

ldt=$(echo "${resp}" | jq -r '[.Consulta_RCCOORResult.coordenadas.coord] | flatten | .[0].ldt')
echo "  ✓ dirección resuelta: ${ldt}"

echo
echo "✅ Todos los smoke tests del Catastro pasan."
exit 0
