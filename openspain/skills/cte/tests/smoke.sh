#!/bin/bash
set -e

# Smoke test para cte.
# Verifica que las URLs oficiales referenciadas en la skill responden
# correctamente (HTTP 200).

PASS=0
FAIL=0

check_url() {
  local label="$1"
  local url="$2"
  echo ">>> Comprobando: $label"
  HTTP_CODE=$(curl -sf -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" -o /dev/null -w "%{http_code}" -L --max-time 60 "$url" 2>/dev/null || true)
  if [ "$HTTP_CODE" -eq 200 ]; then
    echo "    ok  HTTP $HTTP_CODE"
    PASS=$((PASS + 1))
  else
    echo "    x   HTTP $HTTP_CODE — $url"
    FAIL=$((FAIL + 1))
  fi
}

check_url "Portal oficial del CTE (codigotecnico.org)" \
  "https://www.codigotecnico.org"

check_url "DB-SE Seguridad estructural (PDF)" \
  "https://www.codigotecnico.org/pdf/Documentos/SE/DBSE.pdf"

check_url "DB-SI Seguridad en caso de incendio (PDF)" \
  "https://www.codigotecnico.org/pdf/Documentos/SI/DBSI.pdf"

check_url "DB-SUA Seguridad de utilización y accesibilidad (PDF)" \
  "https://www.codigotecnico.org/pdf/Documentos/SUA/DBSUA.pdf"

check_url "DB-HS Salubridad, incl. HS6 radón (PDF)" \
  "https://www.codigotecnico.org/pdf/Documentos/HS/DBHS.pdf"

check_url "DB-HR Protección frente al ruido (PDF)" \
  "https://www.codigotecnico.org/pdf/Documentos/HR/DBHR.pdf"

check_url "DB-HE Ahorro de energía (PDF)" \
  "https://www.codigotecnico.org/pdf/Documentos/HE/DBHE.pdf"

check_url "Guía de rehabilitación frente al radón" \
  "https://www.codigotecnico.org/Guias/GuiaRadon.html"

check_url "RD 314/2006 texto consolidado (BOE)" \
  "https://www.boe.es/buscar/act.php?id=BOE-A-2006-5515"

echo ">>> Comprobando: API BOE legislación consolidada (índice BOE-A-2006-5515)"
HTTP_CODE=$(curl -sf -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" -o /dev/null -w "%{http_code}" -H "Accept: application/json" --max-time 30 \
  "https://www.boe.es/datosabiertos/api/legislacion-consolidada/id/BOE-A-2006-5515/texto/indice" 2>/dev/null || true)
if [ "$HTTP_CODE" -eq 200 ]; then
  echo "    ok  HTTP $HTTP_CODE"
  PASS=$((PASS + 1))
else
  echo "    x   HTTP $HTTP_CODE — API BOE legislación consolidada"
  FAIL=$((FAIL + 1))
fi

echo ""
echo "cte smoke: $PASS ok, $FAIL fallos"
[ "$FAIL" -eq 0 ] || exit 1
