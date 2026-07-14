---
name: cis
description: "Use when the user asks about Spanish public opinion polls, surveys, or the Centro de Investigaciones Sociológicas (CIS) — CIS barometers, voting intention, social attitudes, or any sociological survey published by Spanish public bodies. The CIS does not publish a direct REST API; instead, discover datasets through the national open data catalog datos.gob.es, and reference the CIS web catalog (https://www.cis.es/estudios/catalogo) when the user cites a specific study number. Triggers on: 'CIS', 'Centro de Investigaciones Sociológicas', 'barómetro', 'barómetro CIS', 'encuesta España', 'intención de voto', 'sondeo', 'opinión pública', 'estudio 3400', 'microdatos CIS'."
license: MIT
---

# CIS — Encuestas y barómetros vía datos.gob.es y catálogo web

El **Centro de Investigaciones Sociológicas** (CIS) **no publica una API REST
pública** propia. Sus microdatos viven en fichas individuales del catálogo web
y se descargan manualmente como ASCII, CSV o SPSS.

Esta skill ofrece **dos rutas** según lo que pida el usuario:

1. **Descubrimiento abierto** → busca en `datos.gob.es` por título.
2. **Estudio concreto por número** → referencia la URL del catálogo web del CIS.

## ⚠️ Limitación importante con microdatos

Los **microdatos** del CIS (ficheros `.dat` ASCII de ancho fijo, `.csv`,
`.sav` SPSS, etc.) se publican como adjuntos zipeados en la ficha de cada
estudio. **`WebFetch` no puede procesar esos formatos directamente**:

- ASCII de ancho fijo → necesita el "diseño de registro" (DRE) del CIS para
  parsearse y un script local en Python/R/Stata.
- SPSS / SAV → requiere `pyreadstat` o similar.
- ZIPs → hay que descargarlos y descomprimirlos localmente.

Si el usuario quiere análisis cuantitativo real sobre microdatos, **avisa**
de que es una tarea de procesamiento local y ofrece, si acaso, generar el
script (no ejecutarlo desde la skill).

license: MIT
---

## Ruta 1 — Descubrimiento vía datos.gob.es

### Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre `?_format=json`. WebFetch con GET y `Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

### Operaciones

#### Búsqueda por barómetro

```
GET https://datos.gob.es/apidata/catalog/dataset/title/bar%C3%B3metro?_pageSize=10&_format=json
```

`barómetro` debe ir URL-encoded como `bar%C3%B3metro`. Devuelve datasets de
barómetros (de comercio minorista, de movilidad, de clima escolar, etc.) —
**no son del CIS**, pero son barómetros publicados por administraciones
españolas. Filtrar los relevantes por título.

#### Búsqueda por CIS

```
GET https://datos.gob.es/apidata/catalog/dataset/title/CIS?_pageSize=10&_format=json
```

> ⚠️ `CIS` es un trigrama corto que matchea muchas palabras (`aparcabicis`,
> `innovacis...`, `CIEMAT`, etc.). Filtrar manualmente los items cuyo título
> realmente mencione "CIS" como Centro de Investigaciones Sociológicas, o
> probar con variantes más específicas.

#### Búsqueda por encuesta / sondeo / opinión

```
GET https://datos.gob.es/apidata/catalog/dataset/title/encuesta?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/sondeo?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/opini%C3%B3n?_pageSize=10&_format=json
```

Útil como fallback. Devuelven encuestas de muy distinta procedencia
(municipios, comunidades autónomas, INE, …). Hay que filtrar por título.

### Estructura de respuesta

```
result.items[]
  .title                       → string o lista de { _value, _lang }
  .identifier                  → identificador interno
  .publisher                   → URL del publisher (DIR3)
  ._about                      → URL canónica del dataset en datos.gob.es
  .distribution[]              → array (o objeto) de distribuciones
    .accessURL                 → URL real de descarga
    .format._value             → "text/csv", "application/json", ...
    .byteSize                  → tamaño aproximado
    .title                     → nombre legible de la distribución
```

> `distribution` puede venir como objeto único o como array. Tratar siempre
> como lista. `title` puede ser string, objeto `{_value, _lang}` o lista de
> objetos — si es lista, preferir `_lang == "es"`.

license: MIT
---

## Ruta 2 — Catálogo web del CIS por número de estudio

Cuando el usuario menciona un número concreto (`3400`, `3480`, `3520`…) está
hablando del **número de estudio del CIS**. La ficha vive en el catálogo
web:

```
https://www.cis.es/estudios/catalogo
```

Patrón de búsqueda manual: el catálogo es un portal Liferay con buscador
interno; cada estudio tiene su propia ficha con cuestionario PDF, resultados,
ponderaciones y, en muchos casos, microdatos zipeados.

**Qué hacer**:

1. Indica al usuario la URL del catálogo: `https://www.cis.es/estudios/catalogo`.
2. Sugiérele buscar por el número de estudio en ese buscador.
3. Si el usuario quiere los microdatos, advierte de la limitación
   (ver arriba): hay que descargarlos manualmente y procesarlos en local.

**No** intentes hacer scraping del portal del CIS desde la skill. **No**
inventes URLs tipo `https://www.cis.es/cis/opencms/...` — la web del CIS
migró a Liferay y los antiguos paths devuelven 404.

license: MIT
---

## Workflow recomendado

```
Pregunta abierta ("¿hay datos del CIS sobre X?")
  → Ruta 1: GET /title/bar%C3%B3metro o /title/encuesta o /title/CIS
  → Filtrar items relevantes
  → Iterar distribution[] y elegir formato útil (CSV > JSON > XLS)
  → WebFetch a la accessURL

Pregunta concreta ("estudio 3400 del CIS")
  → Ruta 2: redirigir al catálogo web https://www.cis.es/estudios/catalogo
  → Avisar de la limitación de microdatos si procede
```

## Errores comunes

- **400 Bad Request** en datos.gob.es → estás usando `?q=` en vez de `/title/`.
- **0 items** → el término es demasiado específico o el dataset no está
  indexado en el catálogo nacional. Probar sinónimos
  (`CIS` → `barómetro`, `encuesta`, `opinión`, `sondeo`).
- **HTML en vez de JSON** → olvidaste `?_format=json`.
- **404 en cis.es/cis/opencms/...** → la web migró a Liferay; usa
  `https://www.cis.es/estudios/catalogo` o las rutas `/es/...`.
- **Falsos positivos con `CIS`** → trigrama corto. Filtrar manualmente.

## Cuándo NO usar esta skill

- Si el usuario pregunta por estadísticas oficiales del INE (paro, IPC,
  PIB, EPA) → **ine**.
- Si pregunta por resultados electorales oficiales → **datos-gob-es**
  (Ministerio del Interior).
- Si pregunta por una norma o ley → **boe**.
- Si pide acceder a microdatos reales del CIS y procesarlos → no es posible
  desde esta skill: redirigir al catálogo web y advertir que se necesita
  procesamiento local con código.
