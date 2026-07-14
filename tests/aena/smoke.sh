#!/bin/bash
set -e

# Smoke test para el servicio Aena.
# Verifica que los ficheros XLS de estadísticas aeroportuarias son accesibles
# y tienen contenido válido (formato XLSX).
#
# Uso: bash tests/aena/smoke.sh

BASE_URL="https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&ssbinary=true"

# Informe anual 2024 (XLS, ~60 KB) — URL verificada
ANNUAL_2024_BLOB="1576871820226"
ANNUAL_2024_URL="${BASE_URL}&blobwhere=${ANNUAL_2024_BLOB}"

# Informe anual 2025 (XLS, ~54 KB) — URL verificada
ANNUAL_2025_BLOB="1576873058143"
ANNUAL_2025_URL="${BASE_URL}&blobwhere=${ANNUAL_2025_BLOB}"

echo "▶ Aena — informe anual 2024 (XLS)..."

# Descargar y verificar que el fichero tiene firma de ZIP/XLSX (PK header)
tmpfile=$(mktemp /tmp/aena_smoke_XXXXXX.xlsx)
http_code=$(curl -sf -o "${tmpfile}" -w "%{http_code}" "${ANNUAL_2024_URL}")

if [ "${http_code}" != "200" ]; then
  echo "  ✗ HTTP ${http_code} al descargar el informe anual 2024" >&2
  rm -f "${tmpfile}"
  exit 1
fi

filesize=$(wc -c < "${tmpfile}")
if [ "${filesize}" -lt 10000 ]; then
  echo "  ✗ fichero demasiado pequeño (${filesize} bytes) — posible error" >&2
  rm -f "${tmpfile}"
  exit 1
fi

# Los ficheros XLSX son ZIPs: comienzan con los bytes PK (0x50 0x4B)
magic=$(xxd -p -l 2 "${tmpfile}" 2>/dev/null || od -An -tx1 -N2 "${tmpfile}" | tr -d ' \n')
# Aceptar tanto "504b" (xxd) como variaciones de od
if [[ "${magic}" != "504b"* ]] && [[ "${magic}" != "50 4b"* ]] && ! file "${tmpfile}" 2>/dev/null | grep -qi "zip\|excel\|openxml"; then
  echo "  ✗ el fichero no parece un XLSX válido (magic: ${magic})" >&2
  rm -f "${tmpfile}"
  exit 1
fi

echo "  ✓ informe anual 2024 descargado correctamente (${filesize} bytes)"
rm -f "${tmpfile}"

echo "▶ Aena — informe anual 2025 (XLS)..."

tmpfile2=$(mktemp /tmp/aena_smoke_XXXXXX.xlsx)
http_code2=$(curl -sf -o "${tmpfile2}" -w "%{http_code}" "${ANNUAL_2025_URL}")

if [ "${http_code2}" != "200" ]; then
  echo "  ✗ HTTP ${http_code2} al descargar el informe anual 2025" >&2
  rm -f "${tmpfile2}"
  exit 1
fi

filesize2=$(wc -c < "${tmpfile2}")
if [ "${filesize2}" -lt 10000 ]; then
  echo "  ✗ fichero demasiado pequeño (${filesize2} bytes) — posible error" >&2
  rm -f "${tmpfile2}"
  exit 1
fi

echo "  ✓ informe anual 2025 descargado correctamente (${filesize2} bytes)"
rm -f "${tmpfile2}"

echo "▶ Aena — página de informes mensuales accesible..."

http_monthly=$(curl -sf -o /dev/null -w "%{http_code}" \
  "https://www.aena.es/es/estadisticas/informes-mensuales.html")

if [ "${http_monthly}" != "200" ]; then
  echo "  ✗ HTTP ${http_monthly} en la página de informes mensuales" >&2
  exit 1
fi

echo "  ✓ página de informes mensuales accesible"

echo
echo "✅ Todos los smoke tests de Aena pasan."
exit 0
