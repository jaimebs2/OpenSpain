#!/bin/bash
set -e

# Smoke test para el servicio CNMC.
# Verifica dos operaciones del portal CKAN de la CNMC:
#   1. Búsqueda de datasets de electricidad
#   2. Detalle de un dataset con recursos descargables

BASE="https://catalogodatos.cnmc.es/api/3/action"

# --- 1. Búsqueda de datasets --------------------------------------------------

echo "▶ CNMC búsqueda de datasets (electricidad)..."

resp=$(curl -sf -H "Accept: application/json" \
  "${BASE}/package_search?q=electricidad&rows=5")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía del endpoint package_search" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.success == true' > /dev/null 2>&1; then
  echo "  ✗ la respuesta no tiene success=true" >&2
  exit 1
fi

count=$(echo "${resp}" | jq '.result.count')
if [ "${count}" -lt 1 ]; then
  echo "  ✗ no se encontraron datasets para 'electricidad' (count=${count})" >&2
  exit 1
fi

echo "  ✓ ${count} datasets encontrados para 'electricidad'"

# Obtener el ID del primer resultado para el siguiente paso
dataset_id=$(echo "${resp}" | jq -r '.result.results[0].id')
dataset_title=$(echo "${resp}" | jq -r '.result.results[0].title')
echo "  ✓ primer dataset: \"${dataset_title}\" (${dataset_id})"

# --- 2. Detalle del primer dataset con recursos ------------------------------

echo "▶ CNMC detalle del dataset y recursos descargables..."

resp2=$(curl -sf -H "Accept: application/json" \
  "${BASE}/package_show?id=${dataset_id}")

if [ -z "${resp2}" ]; then
  echo "  ✗ respuesta vacía del endpoint package_show" >&2
  exit 1
fi

if ! echo "${resp2}" | jq -e '.success == true' > /dev/null 2>&1; then
  echo "  ✗ package_show no devolvió success=true" >&2
  exit 1
fi

resource_count=$(echo "${resp2}" | jq '.result.resources | length')
if [ "${resource_count}" -lt 1 ]; then
  echo "  ✗ el dataset no tiene recursos descargables" >&2
  exit 1
fi

first_url=$(echo "${resp2}" | jq -r '.result.resources[0].url')
first_format=$(echo "${resp2}" | jq -r '.result.resources[0].format')
echo "  ✓ ${resource_count} recurso(s) disponible(s)"
echo "  ✓ primer recurso: ${first_format} → ${first_url}"

if [ -z "${first_url}" ] || [ "${first_url}" = "null" ]; then
  echo "  ✗ la URL del primer recurso es vacía o null" >&2
  exit 1
fi

echo
echo "✅ cnmc smoke test OK"
exit 0
