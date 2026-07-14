#!/bin/bash
set -e

# Smoke test para el servicio AEMET.
#
# Verifica el patrón de doble salto sobre el endpoint de predicción diaria
# municipal para Madrid (código INE 28079). Requiere la variable de entorno
# AEMET_API_KEY. Si no está definida, se omite el test (exit 0 con SKIP).

if [ -z "${AEMET_API_KEY:-}" ]; then
  echo "SKIP: AEMET_API_KEY no definida"
  exit 0
fi

BASE="https://opendata.aemet.es/opendata"
MUN="28079" # Madrid

echo "▶ AEMET predicción diaria municipio ${MUN} (primer salto)..."

URL1="${BASE}/api/prediccion/especifica/municipio/diaria/${MUN}?api_key=${AEMET_API_KEY}"

# Primer salto. Si devuelve 429, esperar y reintentar una vez.
resp1=$(curl -sf -H "Accept: application/json" "${URL1}" || true)

if [ -z "${resp1}" ]; then
  echo "  ⚠ primer intento sin respuesta (posible 429). Reintentando en 5s..."
  sleep 5
  resp1=$(curl -sf -H "Accept: application/json" "${URL1}")
fi

if [ -z "${resp1}" ]; then
  echo "  ✗ sin respuesta en el primer salto" >&2
  exit 1
fi

estado=$(echo "${resp1}" | jq -r '.estado // empty')
if [ "${estado}" != "200" ]; then
  echo "  ✗ estado inesperado en el primer salto: ${estado}" >&2
  echo "${resp1}" >&2
  exit 1
fi

datos_url=$(echo "${resp1}" | jq -r '.datos // empty')
if [ -z "${datos_url}" ]; then
  echo "  ✗ el primer salto no contiene campo .datos" >&2
  echo "${resp1}" >&2
  exit 1
fi

echo "  ✓ primer salto OK → ${datos_url}"

echo "▶ AEMET predicción diaria municipio ${MUN} (segundo salto)..."

resp2=$(curl -sf -H "Accept: application/json" "${datos_url}" || true)

if [ -z "${resp2}" ]; then
  echo "  ⚠ segundo salto sin respuesta. Reintentando en 5s..."
  sleep 5
  resp2=$(curl -sf -H "Accept: application/json" "${datos_url}")
fi

if [ -z "${resp2}" ]; then
  echo "  ✗ sin respuesta en el segundo salto" >&2
  exit 1
fi

# Verificar que hay al menos un día de predicción.
if ! echo "${resp2}" | jq -e '.[0].prediccion.dia | length > 0' > /dev/null 2>&1; then
  echo "  ✗ segundo salto no contiene .prediccion.dia con elementos" >&2
  echo "${resp2}" | head -c 500 >&2
  exit 1
fi

nombre=$(echo "${resp2}" | jq -r '.[0].nombre // "?"')
dias=$(echo "${resp2}" | jq -r '.[0].prediccion.dia | length')
echo "  ✓ segundo salto OK → ${nombre}, ${dias} día(s) de predicción"

echo
echo "✅ Smoke test de AEMET: doble salto correcto."
exit 0
