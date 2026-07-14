#!/bin/bash
set -e

# Smoke test para el servicio BNE (Biblioteca Nacional de España).
# Verifica dos endpoints públicos de datos.bne.es:
#   1. SPARQL GET con una consulta simple (ASK)
#   2. Dereferenciación JSON-LD de un recurso concreto (persona)

SPARQL="https://datos.bne.es/sparql"
RESOURCE="https://datos.bne.es/resource"

# --- 1. SPARQL GET — query simple -------------------------------------------
#
# Consulta ASK: devuelve { "head": {}, "boolean": true } cuando el endpoint
# responde y hay al menos un triple en el grafo. Es la query más barata posible
# y no depende de qué datos tenga cargado el Virtuoso.

echo "▶ BNE SPARQL endpoint (ASK)..."

QUERY='ASK WHERE { ?s ?p ?o }'
# URL-encode manual (portable, sin python ni jq).
ENC_QUERY=$(printf '%s' "$QUERY" | \
  sed -e 's/ /%20/g' -e 's/{/%7B/g' -e 's/}/%7D/g' -e 's/?/%3F/g')
FORMAT="application%2Fsparql-results%2Bjson"

resp=$(curl -sf "${SPARQL}?query=${ENC_QUERY}&format=${FORMAT}" --max-time 30 || true)

if [ -z "${resp}" ]; then
  echo "  ✗ respuesta vacía del endpoint SPARQL" >&2
  exit 1
fi

if ! echo "${resp}" | jq -e '.boolean == true' > /dev/null 2>&1; then
  echo "  ✗ el ASK no devolvió boolean=true" >&2
  echo "${resp}" | head -c 500 >&2
  echo >&2
  exit 1
fi

echo "  ✓ SPARQL ASK responde"

# --- 2. SPARQL GET — búsqueda real por label --------------------------------
#
# Query pequeña con LIMIT que busca la etiqueta "cervantes" en cualquier
# recurso del grafo. Verificamos que hay bindings.

echo "▶ BNE SPARQL búsqueda por etiqueta..."

QUERY2='PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> SELECT ?s ?label WHERE { ?s rdfs:label ?label . FILTER(CONTAINS(LCASE(STR(?label)), "cervantes")) } LIMIT 3'
ENC_QUERY2=$(printf '%s' "$QUERY2" | \
  sed -e 's/ /%20/g' \
      -e 's/{/%7B/g' -e 's/}/%7D/g' \
      -e 's/</%3C/g' -e 's/>/%3E/g' \
      -e 's/#/%23/g' \
      -e 's/"/%22/g' \
      -e 's/?/%3F/g')

resp2=$(curl -sf "${SPARQL}?query=${ENC_QUERY2}&format=${FORMAT}" --max-time 30 || true)

if [ -z "${resp2}" ]; then
  echo "  ✗ respuesta vacía del SELECT" >&2
  exit 1
fi

if ! echo "${resp2}" | jq -e '.results.bindings | length > 0' > /dev/null 2>&1; then
  echo "  ✗ el SELECT no devolvió bindings" >&2
  echo "${resp2}" | head -c 500 >&2
  echo >&2
  exit 1
fi

echo "  ✓ SELECT con bindings"

# --- 3. Dereferenciación JSON-LD de un recurso -------------------------------
#
# XX1784139 es una persona real en el catálogo (label "Cervantes, Miguel de").
# Verificamos que la dereferenciación devuelve JSON-LD con @graph.

echo "▶ BNE dereferenciación JSON-LD de recurso..."

resp3=$(curl -sfL -H "Accept: application/ld+json" \
  "${RESOURCE}/XX1784139" --max-time 20 || true)

if [ -z "${resp3}" ]; then
  echo "  ✗ respuesta vacía de la dereferenciación" >&2
  exit 1
fi

if ! echo "${resp3}" | jq -e '."@graph" | length > 0' > /dev/null 2>&1; then
  echo "  ✗ el JSON-LD no contiene @graph con elementos" >&2
  echo "${resp3}" | head -c 500 >&2
  echo >&2
  exit 1
fi

echo "  ✓ JSON-LD con @graph"

echo
echo "✅ Todos los smoke tests de la BNE pasan."
exit 0
