#!/bin/bash
set -e

# Smoke test para el servicio SNCZI (MITECO).
#
# Verifica los cuatro endpoints WMS que la skill usa para responder si un
# punto está en zona inundable o en el Dominio Público Hidráulico:
#   1. ZI_LaminasQ10       — GetCapabilities
#   2. ZI_LaminasQ100      — GetCapabilities + GetFeatureInfo sobre río Turia
#   3. ZI_LaminasQ500      — GetCapabilities
#   4. DPHCartografico     — GetCapabilities

BASE="https://wms.mapama.gob.es/sig/Agua"

for cmd in curl; do
  if ! command -v "${cmd}" > /dev/null 2>&1; then
    echo "✗ falta dependencia: ${cmd}" >&2
    exit 1
  fi
done

PASS=0

check_capabilities () {
  local name="$1"
  local layer_path="$2"
  local expected_title="$3"

  local url="${BASE}/${layer_path}/wms.aspx?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities"
  echo "▶ SNCZI ${name} GetCapabilities..."
  local resp
  resp=$(curl -sf "${url}")

  if [ -z "${resp}" ]; then
    echo "  ✗ respuesta vacía de ${layer_path}" >&2
    exit 1
  fi

  if ! echo "${resp}" | grep -q "<WMS_Capabilities\|<WMT_MS_Capabilities"; then
    echo "  ✗ no es un documento WMS Capabilities válido" >&2
    echo "${resp}" | head -c 400 >&2
    exit 1
  fi

  if [ -n "${expected_title}" ]; then
    if ! echo "${resp}" | grep -q "${expected_title}"; then
      echo "  ✗ no aparece el título esperado: ${expected_title}" >&2
      exit 1
    fi
  fi

  echo "  ✓ capabilities válidas"
  PASS=$((PASS + 1))
}

check_capabilities "ZI T=10 (alta probabilidad)"   "ZI_LaminasQ10"   "Z.I. con alta probabilidad"
check_capabilities "ZI T=100 (probabilidad media)" "ZI_LaminasQ100"  "probabilidad media"
check_capabilities "ZI T=500 (probabilidad baja)"  "ZI_LaminasQ500"  "probabilidad baja"
check_capabilities "DPH cartográfico"              "DPHCartografico" "DPH cartogr"

# --- GetFeatureInfo sobre punto en zona inundable T=100 (río Turia, Valencia) ---
#
# Punto aproximado del cauce del Turia a su paso por Valencia en WGS84.
# Debe caer dentro de la lámina T=100. Si la respuesta HTML contiene una
# tabla con filas de atributos, el WMS está respondiendo correctamente.

echo "▶ SNCZI GetFeatureInfo T=100 (río Turia, Valencia)..."

lat="39.4735"
lon="-0.3821"
d="0.0001"
lat_min=$(awk "BEGIN{printf \"%.4f\", ${lat} - ${d}}")
lat_max=$(awk "BEGIN{printf \"%.4f\", ${lat} + ${d}}")
lon_min=$(awk "BEGIN{printf \"%.4f\", ${lon} - ${d}}")
lon_max=$(awk "BEGIN{printf \"%.4f\", ${lon} + ${d}}")

url="${BASE}/ZI_LaminasQ100/wms.aspx?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetFeatureInfo"
url="${url}&LAYERS=NZ.RiskZone&QUERY_LAYERS=NZ.RiskZone&CRS=EPSG:4326"
url="${url}&BBOX=${lat_min},${lon_min},${lat_max},${lon_max}"
url="${url}&WIDTH=101&HEIGHT=101&I=50&J=50&INFO_FORMAT=text/html"

resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de GetFeatureInfo" >&2
  exit 1
fi

# Cualquier respuesta HTML válida del WMS sirve: si trae una tabla con datos,
# el punto cae dentro; si trae el aviso "no se han encontrado datos", el WMS
# responde pero el punto está fuera. En ambos casos el endpoint está vivo.
if ! echo "${resp}" | grep -qi "<html\|<table\|no se han encontrado"; then
  echo "  ✗ GetFeatureInfo no devolvió una respuesta HTML reconocible" >&2
  echo "${resp}" | head -c 400 >&2
  exit 1
fi

echo "  ✓ GetFeatureInfo responde"
PASS=$((PASS + 1))

echo
echo "✅ snczi smoke test OK (${PASS} comprobaciones)"
exit 0
