#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ CIS / datos.gob.es búsqueda por título 'barómetro'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/bar%C3%B3metro?_pageSize=10&_format=json")

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

# Verifica que algún título contenga 'baróme' (sanity check del filtrado por título)
HAS_BARO=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("bar.{0,2}metro"; "i"))) | length > 0')
if [ "$HAS_BARO" != "true" ]; then
  echo "  ✗ ningún título contiene 'barómetro'"
  exit 1
fi
echo "  ✓ títulos contienen 'barómetro'"

echo ""
echo "▶ CIS / datos.gob.es búsqueda por título 'CIS' (fallback)..."
RESP2=$(curl -sf -H "Accept: application/json" "$BASE/title/CIS?_pageSize=5&_format=json")
COUNT2=$(echo "$RESP2" | jq '.result.items | length')
if [ "$COUNT2" -lt 1 ]; then
  echo "  ✗ no hay items en la respuesta"
  exit 1
fi
echo "  ✓ $COUNT2 datasets encontrados (filtrado manual necesario por trigrama corto)"

echo ""
echo "✅ cis smoke test OK"
