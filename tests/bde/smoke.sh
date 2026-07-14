#!/bin/bash
set -e

# Smoke test para el servicio BDE (Banco de España — BIEst).
# Verifica dos llamadas a la API BIEst:
#   1. Endpoint /favoritas — último dato del Euribor a 1 año
#   2. Endpoint /listaSeries — serie histórica del Euribor a 1 año (12 meses)

BASE="https://app.bde.es/bierest/resources/srdatosapp"

# --- 1. /favoritas — último dato -----------------------------------------------

echo "▶ BDE BIEst — último dato Euribor 1 año (favoritas)..."

resp=$(curl -sf --compressed "${BASE}/favoritas?idioma=en&series=D_1NBAF472")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía del endpoint /favoritas" >&2
  exit 1
fi

# Verificar que el campo "valor" existe y es numérico
valor=$(echo "${resp}" | jq -e '.[0].valor' 2>/dev/null)
if [ -z "${valor}" ]; then
  echo "  ✗ no se encontró el campo .valor en la respuesta" >&2
  exit 1
fi

serie=$(echo "${resp}" | jq -r '.[0].serie' 2>/dev/null)
desc=$(echo "${resp}" | jq -r '.[0].descripcionCorta' 2>/dev/null)
fecha=$(echo "${resp}" | jq -r '.[0].fechaValor' 2>/dev/null)

echo "  ✓ serie: ${serie} | ${desc} | valor: ${valor}% | fecha: ${fecha}"

# --- 2. /listaSeries — serie histórica -----------------------------------------

echo "▶ BDE BIEst — serie histórica Euribor 1 año (listaSeries, 12M)..."

resp2=$(curl -sf --compressed "${BASE}/listaSeries?idioma=en&series=D_1NBAF472&rango=30M")

if [ -z "${resp2}" ]; then
  echo "  ✗ respuesta vacía del endpoint /listaSeries" >&2
  exit 1
fi

# Verificar que existe al menos 1 dato en el array "valores"
n_datos=$(echo "${resp2}" | jq -e '.[0].valores | length' 2>/dev/null)
if [ -z "${n_datos}" ] || [ "${n_datos}" -lt 1 ]; then
  echo "  ✗ el array valores está vacío o no existe" >&2
  exit 1
fi

fecha_inicio=$(echo "${resp2}" | jq -r '.[0].fechaInicio' 2>/dev/null)
fecha_fin=$(echo "${resp2}" | jq -r '.[0].fechaFin' 2>/dev/null)

echo "  ✓ ${n_datos} observaciones | desde ${fecha_inicio} hasta ${fecha_fin}"

echo
echo "✅ Todos los smoke tests del BDE pasan."
exit 0
