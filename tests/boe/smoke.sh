#!/bin/bash
set -e

# Smoke test para el servicio BOE.
# Verifica dos endpoints públicos de la API de datos abiertos del BOE:
#   1. Sumario diario
#   2. Índice consolidado de la Constitución Española

BASE="https://www.boe.es/datosabiertos/api"
HDR="Accept: application/json"

# --- 1. Sumario diario --------------------------------------------------------
# El BOE no se publica en domingos ni festivos. Probamos con la fecha de hoy y,
# si no hay sumario, retrocedemos hasta encontrar un día laborable con BOE
# (máximo 7 días atrás).

echo "▶ BOE sumario diario..."

found_sumario=0
for offset in 0 1 2 3 4 5 6 7; do
  if [[ "$(uname)" == "Darwin" ]]; then
    fecha=$(date -v-${offset}d +%Y%m%d)
  else
    fecha=$(date -d "-${offset} days" +%Y%m%d)
  fi

  url="${BASE}/boe/sumario/${fecha}"
  resp=$(curl -sf -H "${HDR}" "${url}" || true)

  if [ -n "${resp}" ] && echo "${resp}" | jq -e '.data.sumario' > /dev/null 2>&1; then
    echo "  ✓ sumario encontrado para ${fecha}"
    found_sumario=1
    break
  fi
done

if [ "${found_sumario}" -ne 1 ]; then
  echo "  ✗ no se encontró sumario en los últimos 8 días" >&2
  exit 1
fi

# --- 2. Índice consolidado de la Constitución --------------------------------

echo "▶ BOE índice consolidado (Constitución Española)..."

url="${BASE}/legislacion-consolidada/id/BOE-A-1978-31229/texto/indice"
resp=$(curl -sf -H "${HDR}" "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía del índice consolidado" >&2
  exit 1
fi

# Verificar que .data existe y contiene al menos un bloque.
if ! echo "${resp}" | jq -e '.data' > /dev/null 2>&1; then
  echo "  ✗ falta .data en la respuesta del índice consolidado" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '[.. | objects | select(has("bloque"))] | length > 0' > /dev/null 2>&1; then
  echo "  ✗ no se encontró ningún bloque en .data" >&2
  exit 1
fi

echo "  ✓ índice consolidado con bloques"

echo
echo "✅ Todos los smoke tests del BOE pasan."
exit 0
