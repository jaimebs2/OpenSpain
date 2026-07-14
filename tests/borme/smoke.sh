#!/bin/bash
set -e

# Smoke test del servicio BORME.
# Llama al sumario de una fecha laborable conocida y verifica
# que la respuesta tiene la estructura esperada.

FECHA="20260406"  # lunes 6 de abril de 2026

echo "▶ BORME sumario ${FECHA}..."
RESP=$(curl -sf -H "Accept: application/json" \
  "https://www.boe.es/datosabiertos/api/borme/sumario/${FECHA}")

echo "$RESP" | jq -e '.status.code == "200"' > /dev/null
echo "$RESP" | jq -e '.data.sumario' > /dev/null
echo "$RESP" | jq -e '.data.sumario.metadatos.publicacion == "BORME"' > /dev/null
echo "$RESP" | jq -e '.data.sumario.metadatos.fecha_publicacion == "'"${FECHA}"'"' > /dev/null
echo "$RESP" | jq -e '.data.sumario.diario[0].seccion | length > 0' > /dev/null

echo "  ✓ status 200, sumario presente, secciones encontradas"
