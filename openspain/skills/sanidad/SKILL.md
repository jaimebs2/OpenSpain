---
name: sanidad
description: "Use when the user asks about Spanish health statistics, hospitals, primary care or the Ministerio de Sanidad — National Hospital Catalogue (Catálogo Nacional de Hospitales), mortality rates by cause and autonomous community, primary care centres, or any public health dataset of the Sistema Nacional de Salud. The Ministry of Health does not publish a single direct REST API; instead, discover and download its datasets through the national open data catalog datos.gob.es. Triggers on: 'sanidad', 'Ministerio de Sanidad', 'hospitales', 'Catálogo Nacional de Hospitales', 'atención primaria', 'centros de salud', 'mortalidad', 'causas de muerte', 'SNS', 'Sistema Nacional de Salud', 'salud España', 'estadísticas sanitarias'."
license: MIT
---

# Sanidad — Datos sanitarios vía datos.gob.es

El Ministerio de Sanidad **no publica una única API REST pública** con todas
sus estadísticas sanitarias. En su lugar, sus datasets (y los de las
consejerías de sanidad de las CCAA) están indexados en el catálogo nacional
`datos.gob.es`, que sí ofrece una API abierta.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLS).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `sanidad.gob.es` ni hacer scraping del portal del
ministerio. Solo usar `accessURL` extraídas de la respuesta del catálogo.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header `Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. Catálogo Nacional de Hospitales

```
GET https://datos.gob.es/apidata/catalog/dataset/title/hospitales?_pageSize=10&_format=json
```

Devuelve datasets con nombres como:

- *Catálogo Nacional de Hospitales*
- *Hospitales por comunidad autónoma y dependencia funcional*
- *Estancia media en hospitales …*
- *Altas hospitalarias por diagnóstico principal*

Cada item trae `distribution[]` con URLs reales a CSV, JSON o XLS. El
Catálogo Nacional de Hospitales se publica anualmente por el Ministerio de
Sanidad y contiene camas, dependencia funcional, finalidad asistencial,
dirección, provincia y CCAA de cada hospital del SNS y privado.

### 2. Mortalidad por causa y CCAA

```
GET https://datos.gob.es/apidata/catalog/dataset/title/mortalidad?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Tasas de mortalidad por causas (lista reducida), sexo y edad*
- *Tasa de Mortalidad Infantil por provincia, según sexo*
- *Defunciones por causa de muerte*
- *Mortalidad por tumores, enfermedades cardiovasculares, respiratorias, …*

Parte viene directamente del Ministerio de Sanidad y parte del INE. Si el
usuario quiere exclusivamente indicadores INE, derivar a la skill **ine**.

### 3. Centros de atención primaria

```
GET https://datos.gob.es/apidata/catalog/dataset/title/atenci%C3%B3n%20primaria?_pageSize=10&_format=json
```

`atención primaria` debe ir URL-encoded (`atenci%C3%B3n%20primaria`). Devuelve
datasets como:

- *Centros de atención primaria (SIAP)*
- *Zonas básicas de salud*
- *Consultorios locales y centros de salud por comunidad autónoma*
- *Actividad asistencial en atención primaria*

### 4. Otros datasets sanitarios (fallback)

```
GET https://datos.gob.es/apidata/catalog/dataset/title/salud?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/SNS?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/vacunaci%C3%B3n?_pageSize=10&_format=json
```

`salud` es un término muy amplio y puede matchear "salud laboral", "salud
animal", etc. — filtrar por título. Útil como fallback cuando los términos
específicos no encuentran nada.

## Estructura de respuesta

```
result.items[]
  .title                       → string o lista de { _value, _lang }
  .identifier                  → identificador interno
  .publisher                   → URL del publisher (DIR3)
  ._about                      → URL canónica del dataset en datos.gob.es
  .distribution[]              → array (o objeto) de distribuciones
    .accessURL                 → URL real de descarga (CSV, JSON, XLS, ...)
    .format._value             → "text/csv", "application/json", ...
    .byteSize                  → tamaño aproximado en bytes
    .title                     → nombre legible de la distribución
```

> `distribution` puede venir como objeto (1 sola) o como array. Tratar
> siempre como lista.
> `title` puede venir como string, objeto `{_value, _lang}` o lista de
> objetos. Si es lista, preferir `_lang == "es"`.

## Workflow recomendado

```
1. GET /title/{termino}?_pageSize=10&_format=json
2. Filtrar result.items[] por títulos realmente relevantes
3. Para cada candidato, iterar distribution[]
4. Elegir formato más útil (CSV > JSON > XLS > PDF)
5. WebFetch a esa accessURL para descargar los datos
6. Si el fichero es muy grande (byteSize > ~5 MB), avisar antes al usuario
```

## Errores comunes

- **400 Bad Request**: estás usando `?q=` en vez de `/title/`.
- **0 items**: el término es demasiado específico — probar sinónimos
  (`hospitales` → `centros hospitalarios`, `atención primaria` → `centros de salud`,
  `mortalidad` → `defunciones`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **Datasets autonómicos en vez de estatales**: muchos resultados vienen de
  consejerías de sanidad de CCAA (Canarias, Cataluña, Andalucía…). Si el
  usuario quiere datos estatales, filtrar por publisher del Ministerio o
  por títulos que incluyan "nacional" / "España".

## Cuándo NO usar esta skill

- Si el usuario pregunta por una norma sanitaria concreta (ley, real decreto) → **boe**.
- Si pregunta por indicadores del INE (esperanza de vida, encuesta nacional
  de salud) → **ine**.
- Si pide un trámite sanitario real (cita médica, tarjeta sanitaria) → no es
  posible desde esta skill: redirigir a `https://sede.sanidad.gob.es` o al
  portal de la CCAA correspondiente.
- Si pregunta por un dataset genérico no sanitario → **datos-gob-es**.
