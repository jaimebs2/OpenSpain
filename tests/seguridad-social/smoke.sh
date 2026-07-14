#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ Seguridad Social / datos.gob.es búsqueda por título 'afiliación'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/afiliaci%C3%B3n?_pageSize=10&_format=json")

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

# Verifica que algún título contenga 'afiliaci' o 'seguridad' (sanity check)
HAS_MATCH=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("afiliaci|seguridad"; "i"))) | length > 0')
if [ "$HAS_MATCH" != "true" ]; then
  echo "  ✗ ningún título contiene 'afiliación' o 'seguridad'"
  exit 1
fi
echo "  ✓ títulos contienen 'afiliación' o 'seguridad'"

echo ""
echo "▶ Seguridad Social / datos.gob.es búsqueda por título 'seguridad social'..."
RESP2=$(curl -sf -H "Accept: application/json" "$BASE/title/seguridad%20social?_pageSize=10&_format=json")

COUNT2=$(echo "$RESP2" | jq '.result.items | length')
if [ "$COUNT2" -lt 1 ]; then
  echo "  ✗ no hay items en la respuesta"
  exit 1
fi
echo "  ✓ $COUNT2 datasets encontrados"

HAS_DIST2=$(echo "$RESP2" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST2" != "true" ]; then
  echo "  ✗ ningún item tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

echo ""
echo "✅ seguridad-social smoke test OK"
