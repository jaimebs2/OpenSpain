#!/bin/bash
set -e

# Smoke test para el servicio Senado.
# El Senado no expone API REST: sólo XML estáticos vía ficopendataservlet.
# Verificamos dos endpoints públicos representativos:
#   1. Composición del hemiciclo (legislatura actual)
#   2. Sesiones plenarias (legislatura actual)

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
BASE="https://www.senado.es/web/ficopendataservlet"

# --- 1. Composición del hemiciclo (tipoFich=20) -------------------------------

echo "▶ Senado composición del hemiciclo..."

url="${BASE}?tipoFich=20"
resp=$(curl -sf -A "${UA}" "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de composición del hemiciclo" >&2
  exit 1
fi

if ! echo "${resp}" | grep -q '<?xml'; then
  echo "  ✗ la respuesta no parece XML" >&2
  exit 1
fi

if ! echo "${resp}" | grep -q '<hemiciclo'; then
  echo "  ✗ falta el tag raíz <hemiciclo>" >&2
  exit 1
fi

if ! echo "${resp}" | grep -q '<escaño>'; then
  echo "  ✗ no se encontró ningún <escaño> en la composición" >&2
  exit 1
fi

# Verificar al menos un campo de detalle por escaño.
if ! echo "${resp}" | grep -q '<apellidos>'; then
  echo "  ✗ los escaños no contienen <apellidos>" >&2
  exit 1
fi

echo "  ✓ composición del hemiciclo OK"

# --- 2. Sesiones plenarias legislatura actual (tipoFich=14&legis=15) ----------

echo "▶ Senado sesiones plenarias (legislatura 15)..."

url="${BASE}?tipoFich=14&legis=15"
resp=$(curl -sf -A "${UA}" "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de sesiones plenarias" >&2
  exit 1
fi

if ! echo "${resp}" | grep -q '<listaSesionesPlenarias>'; then
  echo "  ✗ falta el tag raíz <listaSesionesPlenarias>" >&2
  exit 1
fi

if ! echo "${resp}" | grep -q '<sesionPlenaria>'; then
  echo "  ✗ no se encontró ninguna <sesionPlenaria>" >&2
  exit 1
fi

if ! echo "${resp}" | grep -q '<sesionNumero>'; then
  echo "  ✗ las sesiones no contienen <sesionNumero>" >&2
  exit 1
fi

echo "  ✓ sesiones plenarias OK"

echo
echo "✅ Todos los smoke tests del Senado pasan."
exit 0
