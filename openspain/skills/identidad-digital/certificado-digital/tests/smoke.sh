#!/usr/bin/env bash
# Smoke test para certificado-digital
# Verifica que las páginas informativas de la FNMT y otros servicios
# referenciados en la skill responden correctamente.

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

echo "=== certificado-digital smoke test ==="
echo ""

check_url "Portal certificados FNMT — persona física" \
  "https://www.sede.fnmt.gob.es/certificados/persona-fisica"

check_url "Solicitar certificado" \
  "https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software"

check_url "Renovar certificado" \
  "https://www.sede.fnmt.gob.es/certificados/persona-fisica/renovar"

check_url "Revocar certificado" \
  "https://www.sede.fnmt.gob.es/certificados/persona-fisica/anular"

check_url "VALIDe — validación de certificados" \
  "https://valide.redsara.es"

check_url "Portal Cl@ve" \
  "https://clave.gob.es"

echo ""
echo "Resultado: $PASS OK, $FAIL fallos"

if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
