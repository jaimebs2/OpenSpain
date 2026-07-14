#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ sanidad / datos.gob.es búsqueda por título 'hospitales'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/hospitales?_pageSize=5&_format=json")

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

# Verifica que algún título contenga hospital (sanity check del filtrado por título)
HAS_HOSP=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("hospital"; "i"))) | length > 0')
if [ "$HAS_HOSP" != "true" ]; then
  echo "  ✗ ningún título contiene 'hospital'"
  exit 1
fi
echo "  ✓ títulos contienen 'hospital'"

echo ""
echo "✅ sanidad smoke test OK"
