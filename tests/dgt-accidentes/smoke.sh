#!/bin/bash
set -e

# Smoke test para el servicio DGT Accidentes de Tráfico.
#
# Verifica que la página de catálogo de datos.gob.es devuelve el dataset
# de microdatos de accidentes 2024 publicado por la DGT, y que la URL
# de descarga del fichero XLSX responde con un encabezado HTTP 200.

CATALOG_URL="https://datos.gob.es/es/catalogo/e00130502-ficheros-de-microdatos-de-accidentes-con-victimas-2024"
XLSX_URL="https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/publicaciones/Ficheros_microdatos_de_accidentalidad_con_victimas/TABLA_ACCIDENTES_24.XLSX"

# --- Test 1: Página del catálogo datos.gob.es responde ---
echo "▶ Verificando catálogo datos.gob.es (microdatos accidentes 2024)..."

http_status=$(curl -s -o /dev/null -w "%{http_code}" "${CATALOG_URL}")

if [ "${http_status}" != "200" ]; then
  echo "  ✗ la página del catálogo devolvió HTTP ${http_status} (esperado 200)" >&2
  exit 1
fi

echo "  ✓ catálogo responde HTTP 200"

# --- Test 2: URL de descarga del XLSX responde ---
echo "▶ Verificando URL de descarga TABLA_ACCIDENTES_24.XLSX..."

# Solo comprobamos cabeceras (no descargamos el fichero de 24 MB)
http_status_xlsx=$(curl -s -o /dev/null -w "%{http_code}" --head "${XLSX_URL}")

if [ "${http_status_xlsx}" != "200" ] && [ "${http_status_xlsx}" != "302" ] && [ "${http_status_xlsx}" != "301" ]; then
  echo "  ✗ la URL de descarga devolvió HTTP ${http_status_xlsx} (esperado 200/301/302)" >&2
  exit 1
fi

echo "  ✓ URL de descarga responde HTTP ${http_status_xlsx}"

echo
echo "Smoke test DGT Accidentes: OK."
exit 0
