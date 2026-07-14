#!/bin/bash
set -e

# Smoke test para el servicio Puertos del Estado (THREDDS OPeNDAP).
#
# Verifica:
#   1. El catálogo raíz THREDDS responde con XML válido.
#   2. El sub-catálogo del mareógrafo de Barcelona (mes actual) es accesible.
#   3. El endpoint .das de un fichero de análisis horario devuelve metadatos reales.
#
# Sin dependencias de autenticación. Requiere curl y grep.

BASE_THREDDS="http://opendap.puertos.es/thredds"
STATION_ID="tidegauge_bar2"

# Fechas del mes actual
YEAR=$(date +%Y)
MONTH=$(date +%m)

echo "▶ THREDDS catálogo raíz..."
catalog_resp=$(curl -sfL "${BASE_THREDDS}/catalog.xml")
if ! echo "${catalog_resp}" | grep -q "Medidas\|Modelos\|tidegauge\|mareogr\|PdE"; then
  echo "  ✗ el catálogo raíz no contiene las secciones esperadas" >&2
  echo "${catalog_resp}" | head -c 500 >&2
  exit 1
fi
echo "  ✓ catálogo raíz OK"

echo "▶ Sub-catálogo mareógrafo Barcelona ${YEAR}/${MONTH}..."
subcat_url="${BASE_THREDDS}/catalog/${STATION_ID}/${YEAR}/${MONTH}/catalog.xml"
subcat_resp=$(curl -sfL "${subcat_url}" || true)

if [ -z "${subcat_resp}" ]; then
  # Puede que el mes actual no tenga datos todavía; probar con el mes anterior
  PREV_YEAR=$YEAR
  PREV_MONTH=$(printf "%02d" $((10#$MONTH - 1)))
  if [ "$PREV_MONTH" = "00" ]; then
    PREV_MONTH="12"
    PREV_YEAR=$((YEAR - 1))
  fi
  echo "  ⚠ mes actual sin datos, probando ${PREV_YEAR}/${PREV_MONTH}..."
  subcat_url="${BASE_THREDDS}/catalog/${STATION_ID}/${PREV_YEAR}/${PREV_MONTH}/catalog.xml"
  subcat_resp=$(curl -sfL "${subcat_url}")
  YEAR=$PREV_YEAR
  MONTH=$PREV_MONTH
fi

if ! echo "${subcat_resp}" | grep -q "MIR2Z\|catalog\|dataset"; then
  echo "  ✗ el sub-catálogo no contiene datasets esperados" >&2
  echo "${subcat_resp}" | head -c 500 >&2
  exit 1
fi
echo "  ✓ sub-catálogo ${STATION_ID}/${YEAR}/${MONTH} OK"

echo "▶ Metadatos .das de un fichero analysis_HM del mes ${YEAR}/${MONTH}..."

# Extraer el primer urlPath de un fichero _analysis_HM.nc4
urlpath=$(echo "${subcat_resp}" | grep -o 'urlPath="[^"]*_analysis_HM\.nc4"' | head -1 | sed 's/urlPath="//;s/"//')

if [ -z "${urlpath}" ]; then
  echo "  ✗ no se encontró ningún fichero _analysis_HM.nc4 en el sub-catálogo" >&2
  echo "${subcat_resp}" | head -c 300 >&2
  exit 1
fi
echo "  urlPath: ${urlpath}"

das_resp=$(curl -sfL "${BASE_THREDDS}/dodsC/${urlpath}.das")
if ! echo "${das_resp}" | grep -qi "institution\|puertos\|Barcelona\|SLEV\|time_coverage"; then
  echo "  ✗ el .das no contiene los atributos esperados" >&2
  echo "${das_resp}" | head -c 500 >&2
  exit 1
fi
echo "  ✓ .das OK — metadatos del dataset accesibles"

echo
echo "✅ Smoke test de Puertos del Estado: THREDDS, sub-catálogo y metadatos OPeNDAP correctos."
exit 0
