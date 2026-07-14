#!/bin/bash
set -e

# Smoke test para fiscalidad-modelo-036.
# Verifica que las páginas oficiales referenciadas en la skill responden
# correctamente (HTTP 200).

PASS=0
FAIL=0

check_url() {
  local label="$1"
  local url="$2"
  echo ">>> Comprobando: $label"
  HTTP_CODE=$(curl -sf -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" -o /dev/null -w "%{http_code}" -L "$url" 2>/dev/null || true)
  if [ "$HTTP_CODE" -eq 200 ]; then
    echo "    ok  HTTP $HTTP_CODE"
    PASS=$((PASS + 1))
  else
    echo "    x   HTTP $HTTP_CODE — $url"
    FAIL=$((FAIL + 1))
  fi
}

check_url "Modelo 036/037 — ficha procedimiento" \
  "https://sede.agenciatributaria.gob.es/Sede/procedimientoini/G322.shtml"

check_url "Portal Censos, NIF y domicilio fiscal — AEAT" \
  "https://sede.agenciatributaria.gob.es/Sede/censos-nif-domicilio-fiscal.html"

check_url "Sede Electrónica AEAT" \
  "https://sede.agenciatributaria.gob.es"

check_url "VIES (verificación NIF-IVA)" \
  "https://ec.europa.eu/taxation_customs/vies/"

check_url "Cita previa AEAT" \
  "https://sede.agenciatributaria.gob.es/Sede/procedimientoini/GC07.shtml"

echo ""
echo "fiscalidad-modelo-036 smoke: $PASS ok, $FAIL fallos"
[ "$FAIL" -eq 0 ] || exit 1
