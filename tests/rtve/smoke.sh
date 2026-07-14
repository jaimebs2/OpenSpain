#!/bin/bash
set -e

# Smoke test para el servicio RTVE.
# La API de RTVE no es oficialmente abierta — verificamos los dos endpoints
# de listado más estables (noticias y programas) y comprobamos que devuelven
# JSON con la estructura .page.items[] esperada.

BASE="https://api.rtve.es/api"
HDR="Accept: application/json"

# --- 1. Listado de noticias --------------------------------------------------

echo "▶ RTVE noticias..."

resp=$(curl -sf -H "${HDR}" "${BASE}/noticias.json?size=3")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de /noticias.json" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.page.items | type == "array"' > /dev/null 2>&1; then
  echo "  ✗ /noticias.json no devolvió .page.items como array" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.page.items | length > 0' > /dev/null 2>&1; then
  echo "  ✗ /noticias.json devolvió 0 items" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.page.items[0] | has("id") and has("title") and has("htmlUrl")' > /dev/null 2>&1; then
  echo "  ✗ los items de /noticias.json no traen id/title/htmlUrl" >&2
  exit 1
fi

echo "  ✓ noticias OK"

# --- 2. Listado de programas -------------------------------------------------

echo "▶ RTVE programas..."

resp=$(curl -sf -H "${HDR}" "${BASE}/programas.json?size=3")

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía de /programas.json" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.page.items | type == "array"' > /dev/null 2>&1; then
  echo "  ✗ /programas.json no devolvió .page.items como array" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.page.items | length > 0' > /dev/null 2>&1; then
  echo "  ✗ /programas.json devolvió 0 items" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.page.items[0] | has("id") and has("name") and has("channel")' > /dev/null 2>&1; then
  echo "  ✗ los items de /programas.json no traen id/name/channel" >&2
  exit 1
fi

echo "  ✓ programas OK"

echo
echo "✅ Todos los smoke tests de RTVE pasan."
exit 0
