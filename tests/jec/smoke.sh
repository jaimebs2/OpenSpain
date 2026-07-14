#!/bin/bash
set -e

API="https://infoelectoral.interior.gob.es/min"
ZIPS="https://infoelectoral.interior.gob.es/estaticos/docxl/apliextr"
CATALOG="https://datos.gob.es/apidata/catalog/dataset"
AUTH="apiInfoelectoral:apiInfoelectoralPro"
UA="Mozilla/5.0"

echo "▶ jec / Infoelectoral — tipos de convocatoria..."
RESP=$(curl -sf -A "$UA" -u "$AUTH" "$API/convocatorias/tipos/")
COUNT=$(echo "$RESP" | jq '.data | length')
if [ "$COUNT" -lt 5 ]; then
  echo "  ✗ se esperaban al menos 5 tipos, se obtuvieron $COUNT"
  exit 1
fi
echo "  ✓ $COUNT tipos de convocatoria"

# Verifica que aparecen Congreso y Municipales
HAS_CONGRESO=$(echo "$RESP" | jq '[.data[] | select(.descripcion == "Congreso")] | length')
HAS_MUNI=$(echo "$RESP" | jq '[.data[] | select(.descripcion == "Municipales")] | length')
if [ "$HAS_CONGRESO" != "1" ] || [ "$HAS_MUNI" != "1" ]; then
  echo "  ✗ no aparecen Congreso/Municipales en la lista"
  exit 1
fi
echo "  ✓ Congreso y Municipales presentes"

echo "▶ jec / Infoelectoral — convocatorias del Congreso..."
RESP=$(curl -sf -A "$UA" -u "$AUTH" "$API/convocatorias?tipoConvocatoria=2")
COUNT=$(echo "$RESP" | jq '.data | length')
if [ "$COUNT" -lt 10 ]; then
  echo "  ✗ se esperaban >=10 convocatorias del Congreso, se obtuvieron $COUNT"
  exit 1
fi
echo "  ✓ $COUNT convocatorias del Congreso"

echo "▶ jec / Infoelectoral — archivos descargables Congreso 202307..."
RESP=$(curl -sf -A "$UA" -u "$AUTH" "$API/archivos/extraccion?tipoConvocatoria=2&idConvocatoria=202307")
ZIP_URL=$(echo "$RESP" | jq -r '.data[0].url')
if [ -z "$ZIP_URL" ] || [ "$ZIP_URL" = "null" ]; then
  echo "  ✗ no se obtuvo URL de ZIP"
  exit 1
fi
echo "  ✓ URL de ZIP obtenida: $ZIP_URL"

echo "▶ jec / Infoelectoral — HEAD al ZIP..."
HTTP_CODE=$(curl -sI -A "$UA" -o /dev/null -w "%{http_code}" "$ZIP_URL")
if [ "$HTTP_CODE" != "200" ]; then
  echo "  ✗ HEAD del ZIP devolvió $HTTP_CODE"
  exit 1
fi
echo "  ✓ ZIP accesible (HTTP 200)"

echo "▶ jec / datos.gob.es — búsqueda 'elecciones'..."
RESP=$(curl -sf -H "Accept: application/json" "$CATALOG/title/elecciones?_pageSize=5&_format=json")
COUNT=$(echo "$RESP" | jq '.result.items | length')
if [ "$COUNT" -lt 1 ]; then
  echo "  ✗ datos.gob.es no devolvió items"
  exit 1
fi
echo "  ✓ $COUNT datasets en datos.gob.es"

# Verifica que al menos un item tenga distribution con accessURL
HAS_DIST=$(echo "$RESP" | jq '[.result.items[] | (.distribution // []) | (if type == "object" then [.] else . end)[] | .accessURL] | length > 0')
if [ "$HAS_DIST" != "true" ]; then
  echo "  ✗ ningún item tiene distribution.accessURL"
  exit 1
fi
echo "  ✓ distribuciones con accessURL presentes"

echo ""
echo "✅ jec smoke test OK"
