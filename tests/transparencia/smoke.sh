#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ Transparencia — búsqueda PLACSP (contratos sector público)..."
curl -sf -H "Accept: application/json" \
  "$BASE/title/PLACSP?_pageSize=5&_format=json" \
  | jq -e '.result.items | length > 0' > /dev/null
echo "  ✓ items encontrados"

echo "▶ Transparencia — distribution[] con accessURL real en PLACSP..."
curl -sf -H "Accept: application/json" \
  "$BASE/title/PLACSP?_pageSize=5&_format=json" \
  | jq -e '[.result.items[] | (.distribution | if type=="array" then .[] else . end) | .accessURL] | map(select(. != null and . != "")) | length > 0' > /dev/null
echo "  ✓ accessURL presente"

echo "▶ Transparencia — búsqueda subvenciones..."
curl -sf -H "Accept: application/json" \
  "$BASE/title/subvenciones?_pageSize=5&_format=json" \
  | jq -e '.result.items | length > 0' > /dev/null
echo "  ✓ items encontrados"

echo "▶ Transparencia — distribution[] con accessURL real en subvenciones..."
curl -sf -H "Accept: application/json" \
  "$BASE/title/subvenciones?_pageSize=5&_format=json" \
  | jq -e '[.result.items[] | (.distribution | if type=="array" then .[] else . end) | .accessURL] | map(select(. != null and . != "")) | length > 0' > /dev/null
echo "  ✓ accessURL presente"

echo "▶ Transparencia — búsqueda altos cargos..."
curl -sf -H "Accept: application/json" \
  "$BASE/title/altos%20cargos?_pageSize=5&_format=json" \
  | jq -e '.result.items | length > 0' > /dev/null
echo "  ✓ items encontrados"

echo "✅ Transparencia OK"
