#!/bin/bash
set -e

BASE="https://servicios.ine.es/wstempus/js/ES"

echo "▶ INE OPERACIONES_DISPONIBLES..."
curl -sf -H "Accept: application/json" \
  "$BASE/OPERACIONES_DISPONIBLES" \
  | jq -e 'type == "array" and length > 0' > /dev/null
echo "  ✓"

echo "▶ INE SERIES_OPERACION/IPC (page=1)..."
curl -sf -H "Accept: application/json" \
  "$BASE/SERIES_OPERACION/IPC?page=1" \
  | jq -e 'type == "array" and length > 0 and .[0].COD' > /dev/null
echo "  ✓"

echo "▶ INE DATOS_SERIE/IPC206449?nult=10..."
curl -sf -H "Accept: application/json" \
  "$BASE/DATOS_SERIE/IPC206449?nult=10" \
  | jq -e '.COD == "IPC206449" and (.Data | type == "array") and (.Data | length > 0)' > /dev/null
echo "  ✓"

echo "OK"
