#!/bin/bash
set -e

# Smoke test para el servicio CNIG (CartoCiudad / IGN).
# Verifica tres endpoints públicos:
#   1. Geocodificación directa (find)
#   2. Geocodificación inversa (reverseGeocode)
#   3. Búsqueda de candidatos / topónimos (candidates)

BASE="https://www.cartociudad.es/geocoder/api/geocoder"

# --- 1. Geocodificación directa ----------------------------------------------

echo "▶ CartoCiudad find — Puerta del Sol, Madrid..."

url="${BASE}/find?q=Puerta%20del%20Sol%2C%20Madrid&limit=5"
resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de find" >&2
  exit 1
fi

# Verificar que devuelve coordenadas no nulas y que el municipio es Madrid.
if ! echo "${resp}" | jq -e '.lat and .lng and .lat != 0 and .lng != 0' > /dev/null 2>&1; then
  echo "  ✗ find no devolvió coordenadas válidas" >&2
  echo "${resp}" | head -c 500 >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.muni | ascii_downcase | contains("madrid")' > /dev/null 2>&1; then
  echo "  ✗ find no identificó Madrid como municipio" >&2
  exit 1
fi

lat=$(echo "${resp}" | jq -r '.lat')
lng=$(echo "${resp}" | jq -r '.lng')
echo "  ✓ coordenadas devueltas: lat=${lat}, lng=${lng}"

# --- 2. Geocodificación inversa ----------------------------------------------

echo "▶ CartoCiudad reverseGeocode — -3.70237, 40.41696..."

url="${BASE}/reverseGeocode?lon=-3.70237&lat=40.41696"
resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de reverseGeocode" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.address and .muni' > /dev/null 2>&1; then
  echo "  ✗ reverseGeocode no devolvió address/muni" >&2
  echo "${resp}" | head -c 500 >&2
  exit 1
fi

echo "  ✓ dirección devuelta: $(echo "${resp}" | jq -r '.address') ($(echo "${resp}" | jq -r '.muni'))"

# --- 3. Búsqueda de candidatos / topónimos -----------------------------------

echo "▶ CartoCiudad candidates — Teide..."

url="${BASE}/candidates?q=Teide&limit=10"
resp=$(curl -sf "${url}")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de candidates" >&2
  exit 1
fi

# Debe ser una lista con al menos un elemento y algún tipo reconocible.
if ! echo "${resp}" | jq -e 'type == "array" and length > 0' > /dev/null 2>&1; then
  echo "  ✗ candidates no devolvió una lista no vacía" >&2
  echo "${resp}" | head -c 500 >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '[.[] | .type] | any(. == "Municipio" or . == "poblacion" or . == "callejero" or . == "portal")' > /dev/null 2>&1; then
  echo "  ✗ candidates no devolvió ningún tipo reconocible" >&2
  exit 1
fi

count=$(echo "${resp}" | jq 'length')
echo "  ✓ ${count} candidatos devueltos"

echo
echo "✅ Todos los smoke tests de CNIG/CartoCiudad pasan."
exit 0
