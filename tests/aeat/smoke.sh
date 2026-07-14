#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ AEAT / datos.gob.es búsqueda por título 'IRPF'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/IRPF?_pageSize=3&_format=json")

COUNT=$(echo "$RESP" | jq '.result.items | length')
if [ "$COUNT" -lt 1 ]; then
  echo "  ✗ no hay items en la respuesta"
  exit 1
fi
echo "  ✓ $COUNT datasets encontrados"

# Verifica que al menos un item tenga distribution con accessURL
HAS_DIST=$(echo "$RESP" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST" != "true" ]; then
  echo "  ✗ ningún item tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

# Verifica que algún título contenga IRPF (sanity check del filtrado por título)
HAS_IRPF=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("IRPF"; "i"))) | length > 0')
if [ "$HAS_IRPF" != "true" ]; then
  echo "  ✗ ningún título contiene 'IRPF'"
  exit 1
fi
echo "  ✓ títulos contienen 'IRPF'"

echo ""
echo "✅ aeat smoke test OK"
