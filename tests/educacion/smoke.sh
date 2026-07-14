#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ educacion / datos.gob.es búsqueda por título 'centros educativos'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/centros%20educativos?_pageSize=5&_format=json")

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

# Verifica que algún título contenga "centro" o "educativ" (sanity check del filtrado por título)
HAS_EDU=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("centro|educativ"; "i"))) | length > 0')
if [ "$HAS_EDU" != "true" ]; then
  echo "  ✗ ningún título contiene 'centro' o 'educativ'"
  exit 1
fi
echo "  ✓ títulos contienen términos educativos"

echo ""
echo "▶ educacion / datos.gob.es búsqueda por título 'alumnado'..."
RESP2=$(curl -sf -H "Accept: application/json" "$BASE/title/alumnado?_pageSize=5&_format=json")

COUNT2=$(echo "$RESP2" | jq '.result.items | length')
if [ "$COUNT2" -lt 1 ]; then
  echo "  ✗ no hay items para 'alumnado'"
  exit 1
fi
echo "  ✓ $COUNT2 datasets encontrados"

HAS_DIST2=$(echo "$RESP2" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST2" != "true" ]; then
  echo "  ✗ ningún item de 'alumnado' tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

echo ""
echo "✅ educacion smoke test OK"
