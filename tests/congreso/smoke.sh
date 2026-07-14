#!/bin/bash
set -e

# Smoke test del servicio congreso.
# El portal del Congreso publica los datos como ficheros estáticos cuyo nombre
# incluye un timestamp que cambia a diario, por lo que primero hay que parsear
# la página HTML índice para descubrir la URL del día.
# Además, el servidor exige un User-Agent de navegador real (sin él devuelve 403).

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
BASE="https://www.congreso.es"

fetch_index_link() {
  # $1 = página índice (ej. /es/opendata/diputados)
  # $2 = prefijo del fichero (ej. DiputadosActivos)
  # $3 = extensión (json | csv | xml)
  curl -sf -A "$UA" "${BASE}$1" \
    | grep -oE "/webpublica/opendata/[^\"]*${2}__[0-9]+\.${3}" \
    | head -n1
}

echo "▶ Congreso · página índice diputados..."
DIP_PATH=$(fetch_index_link "/es/opendata/diputados" "DiputadosActivos" "json")
if [ -z "$DIP_PATH" ]; then
  echo "  ✗ no se encontró enlace JSON DiputadosActivos en /es/opendata/diputados"
  exit 1
fi
echo "  ✓ enlace encontrado: $DIP_PATH"

echo "▶ Congreso · descarga JSON DiputadosActivos..."
DIP_JSON=$(curl -sf -A "$UA" "${BASE}${DIP_PATH}")
if [ -z "$DIP_JSON" ]; then
  echo "  ✗ respuesta vacía"
  exit 1
fi
DIP_COUNT=$(printf '%s' "$DIP_JSON" | jq 'length')
if [ -z "$DIP_COUNT" ] || [ "$DIP_COUNT" -lt 100 ]; then
  echo "  ✗ se esperaban >100 diputados, obtenidos: $DIP_COUNT"
  exit 1
fi
DIP_FIRST=$(printf '%s' "$DIP_JSON" | jq -e '.[0] | .NOMBRE and .CIRCUNSCRIPCION and .GRUPOPARLAMENTARIO' >/dev/null && echo ok)
if [ "$DIP_FIRST" != "ok" ]; then
  echo "  ✗ el primer diputado no tiene los campos esperados (NOMBRE, CIRCUNSCRIPCION, GRUPOPARLAMENTARIO)"
  exit 1
fi
echo "  ✓ ${DIP_COUNT} diputados con campos válidos"

echo "▶ Congreso · página índice iniciativas..."
INI_PATH=$(fetch_index_link "/es/opendata/iniciativas" "IniciativasLegislativasAprobadas" "json")
if [ -z "$INI_PATH" ]; then
  echo "  ✗ no se encontró enlace JSON IniciativasLegislativasAprobadas en /es/opendata/iniciativas"
  exit 1
fi
echo "  ✓ enlace encontrado: $INI_PATH"

echo "▶ Congreso · descarga JSON IniciativasLegislativasAprobadas..."
INI_JSON=$(curl -sf -A "$UA" "${BASE}${INI_PATH}")
INI_COUNT=$(printf '%s' "$INI_JSON" | jq 'length')
if [ -z "$INI_COUNT" ] || [ "$INI_COUNT" -lt 1 ]; then
  echo "  ✗ se esperaba al menos 1 ley aprobada, obtenidas: $INI_COUNT"
  exit 1
fi
printf '%s' "$INI_JSON" | jq -e '.[0] | .TITULO_LEY and .FECHA_LEY' >/dev/null
echo "  ✓ ${INI_COUNT} leyes aprobadas con campos válidos"

echo "✓ Smoke test OK"
