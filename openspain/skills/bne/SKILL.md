---
name: bne
description: "Use when the user wants to query the Spanish National Library (BNE — Biblioteca Nacional de España) Linked Open Data: search authors, works, subjects or entities in the BNE authority and bibliographic catalogue, fetch a resource card (person, work) as JSON-LD by its BNE URI, or run SPARQL queries against datos.bne.es. Triggers on: 'BNE', 'Biblioteca Nacional', 'bibliografía', 'fondo BNE', 'ISBN España', 'autoridades BNE', 'obras BNE', 'catálogo BNE', 'datos.bne.es'."
license: MIT
---

# BNE — datos enlazados de la Biblioteca Nacional de España

Acceso al catálogo de autoridades y registros bibliográficos de la BNE como Linked Open Data. Endpoint Virtuoso público, sin autenticación. Usar `WebFetch` con **GET**.

## Operaciones

### 1. Consulta SPARQL (GET)

```
GET https://datos.bne.es/sparql?query={sparql_urlencoded}&format=application%2Fsparql-results%2Bjson
```

- Sin cabecera `Accept` — el parámetro `format` ya pide JSON.
- La consulta SPARQL debe ir URL-encoded completa en el parámetro `query`.
- **Siempre incluir `LIMIT`** (por ejemplo `LIMIT 20`). Consultas que escanean todo el grafo revientan el timeout del servidor.
- La respuesta es `application/sparql-results+json` con la forma:

```
{
  "head": { "vars": ["s", "label", ...] },
  "results": {
    "bindings": [
      { "s": {"type": "uri", "value": "..."}, "label": {"type": "literal", "value": "..."} },
      ...
    ]
  }
}
```

### 2. Dereferenciación de un recurso (JSON-LD)

```
GET https://datos.bne.es/resource/{id}
Accept: application/ld+json
```

`id` es el identificador que aparece al final de una URI `https://datos.bne.es/resource/...` (por ejemplo `XX1784139` para una persona, `bimo0000022363` para una monografía).

El servidor responde con un **303 See Other** redirigiendo a `https://datos.bne.es/persona/{id}.jsonld` (u otra subruta según el tipo). `WebFetch` sigue redirects automáticamente, así que basta con pedir la URI canónica; el resultado final es `application/ld+json` con un `@graph` y un `@context`. El recurso aparece como un objeto con `@id`, `@type`, `label`, `id` y una lista de propiedades `P...`/`OP...` (ver ontología BNE más abajo).

## Ontología BNE (prefijos y clases útiles)

Namespace de la ontología: `https://datos.bne.es/def/`

Clases verificadas:

| Clase                                  | Significado                   |
|----------------------------------------|-------------------------------|
| `https://datos.bne.es/def/C1005`       | Persona (autor/autoridad)     |
| `https://datos.bne.es/def/C1003`       | Obra / monografía             |
| `https://datos.bne.es/def/C1006`       | Entidad corporativa           |

Propiedades frecuentes en fichas de persona:

| Propiedad   | Significado                                |
|-------------|--------------------------------------------|
| `rdfs:label` (`label`) | Nombre o título preferente       |
| `P5024`     | Enlace VIAF                                |
| `P50102`    | Nacionalidad                               |
| `P50116`    | Género                                     |
| `OP5002`    | Obras relacionadas (URIs de recursos BNE)  |

No asumas que una propiedad existe: inspecciona el JSON-LD devuelto por la dereferenciación antes de construir queries que dependan de ella.

## Plantillas SPARQL

### Buscar por etiqueta (autor, obra, materia)

```sparql
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT ?s ?label WHERE {
  ?s rdfs:label ?label .
  FILTER(CONTAINS(LCASE(STR(?label)), "cervantes"))
}
LIMIT 20
```

### Buscar solo personas (autoridades)

```sparql
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT ?s ?label WHERE {
  ?s a <https://datos.bne.es/def/C1005> .
  ?s rdfs:label ?label .
  FILTER(CONTAINS(LCASE(STR(?label)), "cervantes, miguel"))
}
LIMIT 10
```

### Buscar solo obras / monografías

```sparql
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT ?s ?label WHERE {
  ?s a <https://datos.bne.es/def/C1003> .
  ?s rdfs:label ?label .
  FILTER(CONTAINS(LCASE(STR(?label)), "quijote"))
}
LIMIT 20
```

## URL-encoding de la consulta

Antes de pasar la SPARQL al parámetro `query`, hay que URL-encode todo el texto (espacios → `%20` o `+`, `{` → `%7B`, `}` → `%7D`, `<` → `%3C`, `>` → `%3E`, `#` → `%23`, comillas → `%22`, saltos de línea → `%0A`). `WebFetch` no encodea automáticamente: construye la URL ya lista.

Y el parámetro `format=application/sparql-results+json` también necesita encoding: `format=application%2Fsparql-results%2Bjson`.

## Desambiguación

El catálogo tiene muchos homónimos (varios "Cervantes, Miguel"). Tras una búsqueda por label, siempre:

1. Lista al usuario los candidatos con su URI y, si está disponible, nacionalidad/fechas.
2. Confirma cuál es antes de dereferenciar la ficha completa.

## Qué NO hacer

- **No omitir `LIMIT`**. El servidor tira un timeout con consultas amplias.
- **No enviar cabecera `Accept`** en el SPARQL GET — usa el parámetro `format`.
- **No inventar** URIs `resource/...` ni clases `def/...` que no hayas visto en una respuesta real: verifica siempre con una query SELECT primero.
- **No usar POST** desde `WebFetch`: devuelve 406 cuando va con `Accept` genérico.
