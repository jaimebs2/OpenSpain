#!/usr/bin/env bash
# Smoke test para carnet-conducir
# Verifica que las páginas informativas de la DGT referenciadas en la
# skill responden correctamente.

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

echo "=== carnet-conducir smoke test ==="
echo ""

check_url "DGT — Permisos de conducir (web)" \
  "https://www.dgt.es/nuestros-servicios/permisos-de-conducir/"

check_url "Sede DGT — Permisos de conducir" \
  "https://sede.dgt.gob.es/es/permisos-de-conducir/"

check_url "Sede DGT — Renovar permiso" \
  "https://sede.dgt.gob.es/es/permisos-de-conducir/renovar-permiso/"

check_url "Sede DGT — Canje permisos extranjeros" \
  "https://sede.dgt.gob.es/es/permisos-de-conducir/canje-permisos/"

check_url "Sede DGT — Consulta de puntos" \
  "https://sede.dgt.gob.es/es/otros-servicios/consulta-puntos/"

check_url "Sede DGT — Tasas" \
  "https://sede.dgt.gob.es/es/tramites-y-multas/tasas/"

echo ""
echo "Resultado: $PASS OK, $FAIL fallos"

if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
