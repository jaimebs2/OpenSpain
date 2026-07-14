#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ datos.gob.es búsqueda por título 'paro'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/paro?_pageSize=3&_format=json")
COUNT=$(echo "$RESP" | jq '.result.items | length')
if [ "$COUNT" -lt 1 ]; then
  echo "  ✗ no hay items en la respuesta"
  exit 1
fi
echo "  ✓ $COUNT datasets encontrados"

# Verifica que el primer item tenga distribuciones con accessURL
HAS_DIST=$(echo "$RESP" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST" != "true" ]; then
  echo "  ✗ ningún item tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

echo ""
echo "✅ datos.gob.es smoke test OK"
