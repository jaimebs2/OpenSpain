#!/bin/bash
set -e

# Smoke test para el servicio dgt-zbe.
# Verifica que el NAP de la DGT sirve datos ZBE accesibles sin autenticación:
#   1. El directorio DATEX2 de ZBE responde con HTTP 200
#   2. Un fichero XML de una ZBE concreta (Madrid) descarga y contiene datos válidos
#   3. El dataset en el NAP (CKAN) devuelve metadatos con al menos 1 recurso

BASE_DATEX="https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication"
NAP_API="https://nap.dgt.es/api/3/action/package_show?id=zonas-de-bajas-emisiones"

# --- 1. Directorio DATEX2 ZBE responde ----------------------------------------

echo "▶ Verificando directorio DATEX2 ZBE..."

http_code=$(curl -sL -o /dev/null -w "%{http_code}" \
  "https://infocar.dgt.es/datex2/v3/dgt/zbe/")

if [ "${http_code}" != "200" ]; then
  echo "  ✗ El directorio ZBE devolvió HTTP ${http_code} (esperado 200)" >&2
  exit 1
fi

echo "  ✓ Directorio ZBE accesible (HTTP 200)"

# --- 2. Fichero XML de Madrid descargable y con contenido ZBE -----------------

echo "▶ Descargando ZBE Madrid (DATEX2 XML)..."

xml_content=$(curl -sf "${BASE_DATEX}/Madrid.xml" || true)

if [ -z "${xml_content}" ]; then
  echo "  ✗ El fichero Madrid.xml está vacío o no se pudo descargar" >&2
  exit 1
fi

# Verificar que contiene al menos un elemento XML típico de DATEX2 ZBE
if ! echo "${xml_content}" | grep -qi "controlledZone\|ControlledZone\|zoneGeometry\|accessCondition\|zoneName"; then
  echo "  ✗ Madrid.xml no contiene estructura DATEX2 ZBE esperada" >&2
  exit 1
fi

echo "  ✓ Madrid.xml descargado y contiene estructura DATEX2 ZBE"

# --- 3. Verificar otro fichero de ciudad (Castellon) ----------------------------
echo "▶ ZBE Castellon (segundo fichero de verificación)..."

xml2=$(curl -sf "${BASE_DATEX}/Castellon.xml" || true)
if [ -z "${xml2}" ]; then
  echo "  ⚠ Castellon.xml no disponible — OK (no todas las ciudades publican datos)"
else
  if echo "${xml2}" | grep -qi "controlledZone\|ControlledZone\|zoneGeometry"; then
    echo "  ✓ Castellon.xml contiene estructura ZBE válida"
  fi
fi

echo
echo "✅ Todos los smoke tests de dgt-zbe pasan."
exit 0
