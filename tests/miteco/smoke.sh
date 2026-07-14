#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ MITECO / datos.gob.es búsqueda por título 'embalses'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/embalses?_pageSize=5&_format=json")

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

# Verifica que algún título contenga "embalse" (sanity check del filtrado por título)
HAS_EMBALSE=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("embalse"; "i"))) | length > 0')
if [ "$HAS_EMBALSE" != "true" ]; then
  echo "  ✗ ningún título contiene 'embalse'"
  exit 1
fi
echo "  ✓ títulos contienen 'embalse'"

echo ""
echo "▶ MITECO / datos.gob.es búsqueda por título 'calidad aire'..."
RESP2=$(curl -sf -H "Accept: application/json" "$BASE/title/calidad%20aire?_pageSize=5&_format=json")

COUNT2=$(echo "$RESP2" | jq '.result.items | length')
if [ "$COUNT2" -lt 1 ]; then
  echo "  ✗ no hay items en la respuesta de 'calidad aire'"
  exit 1
fi
echo "  ✓ $COUNT2 datasets encontrados"

HAS_DIST2=$(echo "$RESP2" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST2" != "true" ]; then
  echo "  ✗ ningún item de 'calidad aire' tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

echo ""
echo "✅ miteco smoke test OK"
