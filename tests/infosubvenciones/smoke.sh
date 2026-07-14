#!/bin/bash
set -e

BDNS="https://www.pap.hacienda.gob.es/bdnstrans/api"
DATOS="https://datos.gob.es/apidata/catalog/dataset"

echo "▶ BDNS — últimas convocatorias..."
curl -sf "$BDNS/convocatorias/ultimas" \
  | jq -e '.content | length > 0 and (.[0] | has("numeroConvocatoria") and has("descripcion") and has("fechaRecepcion"))' > /dev/null
echo "  ✓"

echo "▶ BDNS — búsqueda de convocatorias (descripcion=cultura)..."
curl -sf "$BDNS/convocatorias/busqueda?descripcion=cultura&pageSize=5" \
  | jq -e '.content | length > 0 and (.[0] | has("numeroConvocatoria"))' > /dev/null
echo "  ✓"

echo "▶ BDNS — concesiones recientes (búsqueda sin filtros)..."
curl -sf "$BDNS/concesiones/busqueda?pageSize=5" \
  | jq -e '.content | length > 0 and (.[0] | has("codConcesion") and has("beneficiario") and has("importe"))' > /dev/null
echo "  ✓"

echo "▶ BDNS — detalle de convocatoria por numConv..."
NUMCONV=$(curl -sf "$BDNS/convocatorias/ultimas" | jq -r '.content[0].numeroConvocatoria')
curl -sf "$BDNS/convocatorias?numConv=$NUMCONV" \
  | jq -e 'has("codigoBDNS") and has("descripcion") and has("organo")' > /dev/null
echo "  ✓ ($NUMCONV)"

echo "▶ datos.gob.es — fallback búsqueda 'subvenciones'..."
curl -sf -H "Accept: application/json" \
  "$DATOS/title/subvenciones?_pageSize=3&_format=json" \
  | jq -e '.result.items | length > 0 and (.[0] | has("distribution"))' > /dev/null
echo "  ✓"

echo ""
echo "✅ Todos los tests de infosubvenciones han pasado."
