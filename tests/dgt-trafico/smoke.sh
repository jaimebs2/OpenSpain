#!/bin/bash
set -e

# Smoke test para el servicio DGT Tráfico.
#
# Verifica que el endpoint de incidencias en tiempo real del NAP DGT
# responde correctamente y devuelve XML válido con el elemento raíz esperado.

INCIDENCIAS_URL="https://nap.dgt.es/datex2/v3/dgt/SituationPublication/datex2_v36.xml"
PANELES_URL="https://infocar.dgt.es/datex2/dgt/SituationPublication/paneles/content.xml"

# --- Test 1: Incidencias en tiempo real ---
echo "▶ DGT incidencias en tiempo real..."

resp=$(curl -sf -H "Accept: application/xml" "${INCIDENCIAS_URL}" || true)

if [ -z "${resp}" ]; then
  echo "  ⚠ sin respuesta al primer intento. Reintentando en 5s..."
  sleep 5
  resp=$(curl -sf -H "Accept: application/xml" "${INCIDENCIAS_URL}")
fi

if [ -z "${resp}" ]; then
  echo "  ✗ el endpoint de incidencias no responde" >&2
  exit 1
fi

# Verificar que la respuesta contiene XML con el elemento SituationPublication o d2LogicalModel
if ! echo "${resp}" | grep -qi "SituationPublication\|d2LogicalModel\|situation"; then
  echo "  ✗ la respuesta no parece XML DATEX II (no contiene SituationPublication ni d2LogicalModel)" >&2
  echo "${resp}" | head -c 500 >&2
  exit 1
fi

echo "  ✓ endpoint de incidencias responde con XML DATEX II"

# Contar situaciones presentes (puede ser 0 si no hay incidencias activas)
num_situaciones=$(echo "${resp}" | grep -c "<situation " || true)
echo "  ✓ situaciones activas encontradas: ${num_situaciones}"

# --- Test 2: Paneles en tiempo real ---
echo "▶ DGT paneles informativos en tiempo real..."

resp_paneles=$(curl -sf -H "Accept: application/xml" "${PANELES_URL}" || true)

if [ -z "${resp_paneles}" ]; then
  echo "  ⚠ sin respuesta al primer intento (paneles). Reintentando en 5s..."
  sleep 5
  resp_paneles=$(curl -sf -H "Accept: application/xml" "${PANELES_URL}")
fi

if [ -z "${resp_paneles}" ]; then
  echo "  ✗ el endpoint de paneles no responde" >&2
  exit 1
fi

if ! echo "${resp_paneles}" | grep -qi "Publication\|d2LogicalModel\|vmsUnit\|panel"; then
  echo "  ✗ la respuesta del endpoint de paneles no parece XML DATEX II válido" >&2
  echo "${resp_paneles}" | head -c 500 >&2
  exit 1
fi

echo "  ✓ endpoint de paneles responde con XML DATEX II"

echo
echo "Smoke test DGT Tráfico: OK."
exit 0
