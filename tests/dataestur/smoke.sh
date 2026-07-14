#!/bin/bash
set -e

BASE="https://dataestur.azure-api.net/API-SEGITTUR-v1"

echo "▶ DataEstur FRONTUR (enero 2025)..."
# Filtramos a un mes concreto para minimizar el tamaño de respuesta
HTTP_CODE=$(curl -sf --max-time 60 \
  "${BASE}/FRONTUR_DL?desde%20(a%C3%B1o)=2025&desde%20(mes)=1&hasta%20(a%C3%B1o)=2025&hasta%20(mes)=1" \
  -o /tmp/dataestur_frontur_test.xlsx \
  -w "%{http_code}")

if [ "$HTTP_CODE" != "200" ]; then
  echo "  ✗ HTTP $HTTP_CODE — se esperaba 200"
  exit 1
fi
echo "  ✓ HTTP 200"

# Verificar que es un fichero XLSX (magic bytes PK = ZIP)
MAGIC=$(xxd -l 2 /tmp/dataestur_frontur_test.xlsx 2>/dev/null | awk '{print $2}')
if [ "$MAGIC" != "504b" ]; then
  echo "  ✗ El fichero no es XLSX (magic: $MAGIC)"
  exit 1
fi
SIZE=$(wc -c < /tmp/dataestur_frontur_test.xlsx)
echo "  ✓ Fichero XLSX válido (${SIZE} bytes)"

# Verificar que el XLSX tiene contenido (más de 10KB = tiene datos reales)
if [ "$SIZE" -lt 10000 ]; then
  echo "  ✗ Fichero demasiado pequeño (${SIZE} bytes), posiblemente vacío"
  exit 1
fi
echo "  ✓ Tamaño razonable (esperado >10 KB)"

rm -f /tmp/dataestur_frontur_test.xlsx

echo ""
echo "✅ dataestur smoke test OK"
