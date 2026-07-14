#!/usr/bin/env bash
# Smoke test para empadronamiento
# Verifica que las páginas informativas referenciadas en la skill
# responden correctamente.

set -euo pipefail

PASS=0
FAIL=0

check_url() {
  local label="$1"
  local url="$2"
  local http_code
  http_code=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" -o /dev/null -w '%{http_code}' -L --max-time 15 "$url" || true)
  if [[ "$http_code" =~ ^(200|301|302|303)$ ]]; then
    echo "  ✓ $label ($http_code)"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $label → HTTP $http_code ($url)"
    FAIL=$((FAIL + 1))
  fi
}

echo "=== empadronamiento smoke test ==="
echo ""

check_url "INE — Padrón municipal" \
  "https://www.ine.es/dyngs/INEbase/es/operacion.htm?c=Estadistica_C&cid=1254736177012&menu=ultiDatos&idp=1254734710990"

# sede.madrid.es (ejemplo de sede municipal, citado en SKILL.md) está tras un
# challenge de Cloudflare que rechaza a curl (403) aunque el sitio funcione.
# Se usa Barcelona como ejemplo verificable de sede electrónica municipal.
check_url "Sede electrónica Barcelona" \
  "https://seuelectronica.ajuntament.barcelona.cat"

echo ""
echo "Resultado: $PASS OK, $FAIL fallos"

if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
