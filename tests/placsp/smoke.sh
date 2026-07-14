#!/bin/bash
set -e

BASE="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ PLACSP / datos.gob.es búsqueda por título 'PLACSP'..."
RESP=$(curl -sf -H "Accept: application/json" "$BASE/title/PLACSP?_pageSize=5&_format=json")

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

# Verifica que algún título contenga PLACSP o "Contratos Mayores"
HAS_PLACSP=$(echo "$RESP" | jq '[.result.items[].title | (if type == "array" then .[0]._value else tostring end)] | map(select(test("PLACSP|Contratos Mayores|Contratos Menores|licitaci"; "i"))) | length > 0')
if [ "$HAS_PLACSP" != "true" ]; then
  echo "  ✗ ningún título contiene 'PLACSP' / 'Contratos Mayores' / 'licitaci...'"
  exit 1
fi
echo "  ✓ títulos relacionados con contratación pública"

echo ""
echo "▶ PLACSP / búsqueda por título 'contratos mayores'..."
RESP2=$(curl -sf -H "Accept: application/json" "$BASE/title/contratos%20mayores?_pageSize=5&_format=json")

COUNT2=$(echo "$RESP2" | jq '.result.items | length')
if [ "$COUNT2" -lt 1 ]; then
  echo "  ✗ no hay items en la respuesta de 'contratos mayores'"
  exit 1
fi
echo "  ✓ $COUNT2 datasets encontrados"

HAS_DIST2=$(echo "$RESP2" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST2" != "true" ]; then
  echo "  ✗ ningún item de 'contratos mayores' tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

echo ""
echo "✅ placsp smoke test OK"
