#!/bin/bash
set -e

# Smoke test para el servicio ESIOS.
#
# Verifica que la API de ESIOS responde correctamente.
#
# - Sin token: comprueba el endpoint público /indicators (lista de indicadores).
# - Con token (ESIOS_TOKEN definida): también comprueba el indicador 1001 (PVPC)
#   con autenticación.
#
# Ejecutar directamente: bash tests/esios/smoke.sh

BASE="https://api.esios.ree.es"
TODAY=$(date +%Y-%m-%d)

echo "▶ ESIOS lista de indicadores (endpoint público)..."

resp=$(curl -sf -H "Accept: application/json" "${BASE}/indicators" || true)

if [ -z "${resp}" ]; then
  echo "  ✗ sin respuesta del endpoint /indicators" >&2
  exit 1
fi

count=$(echo "${resp}" | jq -e '.indicators | length' 2>/dev/null || echo "0")

if [ "${count}" -eq 0 ] 2>/dev/null; then
  echo "  ✗ /indicators no devuelve indicadores (count=${count})" >&2
  echo "${resp}" | head -c 300 >&2
  exit 1
fi

echo "  ✓ /indicators OK — ${count} indicadores disponibles"

if [ -z "${ESIOS_TOKEN:-}" ]; then
  echo ""
  echo "  ⚠ SKIP: ESIOS_TOKEN no definida — los endpoints de datos requieren token."
  echo "  Obtener token gratuito en https://www.esios.ree.es/es/area-privada/api-de-acceso"
  echo ""
  echo "✅ esios smoke test OK (modo público)"
  exit 0
fi

echo "▶ ESIOS indicador 1001 (PVPC, requiere token)..."
YESTERDAY=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "yesterday" +%Y-%m-%d)
resp2=$(curl -sf \
  -H "Accept: application/json" \
  -H "Authorization: Token token=${ESIOS_TOKEN}" \
  "${BASE}/indicators/1001?start_date=${YESTERDAY}T00:00:00&end_date=${YESTERDAY}T23:59:59" \
  || true)

if [ -z "${resp2}" ]; then
  echo "  ✗ sin respuesta del indicador 1001 (¿token inválido?)" >&2
  exit 1
fi

pvpc_count=$(echo "${resp2}" | jq -e '.indicator.values | length' 2>/dev/null || echo "0")

if [ "${pvpc_count}" -eq 0 ] 2>/dev/null; then
  echo "  ✗ indicador 1001 no tiene valores para ${YESTERDAY} (¿token inválido o fecha sin datos?)" >&2
  echo "${resp2}" | head -c 300 >&2
  exit 1
fi

pvpc_name=$(echo "${resp2}" | jq -r '.indicator.short_name // .indicator.name // "?"')
echo "  ✓ indicador 1001 OK — \"${pvpc_name}\", ${pvpc_count} valores para ${YESTERDAY}"

echo ""
echo "✅ esios smoke test OK"
exit 0
