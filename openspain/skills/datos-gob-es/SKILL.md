---
name: datos-gob-es
description: "Use when the user asks about Spanish public datasets or open data that don't have their own dedicated OpenSpain skill — search the national open data catalog (datos.gob.es, +90,000 datasets) by title, publisher, or theme, and discover the real download URLs (CSV/XLS/JSON) for any dataset published by Spanish public administrations. Triggers on: 'datos abiertos', 'datos.gob.es', 'catálogo nacional', 'dataset España', 'datos públicos', 'CKAN España', 'DCAT', 'qué datos hay sobre...', '¿hay un dataset de...?'. Use this as the entry point when no other skill matches the user's question."
license: MIT
---

# datos.gob.es — Catálogo Nacional de Datos Abiertos

API pública sin autenticación. Convención **Linked Data API** (no CKAN nativo). Devuelve JSON con `result.items[]`.

**Importante**: si la pregunta del usuario encaja con otra skill de OpenSpain (BOE, INE, Catastro, AEMET, etc.), usa esa skill. Esta es solo el "fallback" para descubrir datasets que no tienen skill propia.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json` al final. WebFetch con GET.

## Operaciones

### 1. Búsqueda por título (texto libre)

```
GET https://datos.gob.es/apidata/catalog/dataset/title/{texto}?_pageSize=10&_format=json
```

`{texto}` debe ir URL-encoded. Acepta una o varias palabras (sin operadores booleanos). Devuelve datasets cuyo título contiene el texto.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar la ruta `/title/{texto}`.

Ejemplo:
```
https://datos.gob.es/apidata/catalog/dataset/title/paro?_pageSize=5&_format=json
```

### 2. Datasets de un publisher

```
GET https://datos.gob.es/apidata/catalog/dataset/publisher/{publisherId}?_pageSize=10&_format=json
```

`{publisherId}` es el código DIR3 del organismo (ej. `E05068001` para el Ministerio de Industria). El listado de publishers está en:

```
GET https://datos.gob.es/apidata/catalog/publisher?_format=json
```

### 3. Datasets por tema DCAT-AP-ES

```
GET https://datos.gob.es/apidata/catalog/dataset/theme/{tema}?_pageSize=10&_format=json
```

Temas válidos (DCAT-AP-ES, en inglés en la URL):
`agriculture`, `economy`, `education`, `energy`, `environment`, `government`, `health`, `housing`, `industry`, `legislation`, `population`, `regions`, `science`, `security`, `social`, `sport`, `tourism`, `transport`, `urbanism`.

> Algunos temas devuelven 0 items aunque existan datasets — preferir búsqueda por título o publisher para resultados garantizados.

### 4. Detalle de un dataset (extraer URLs de descarga)

Desde cualquiera de las búsquedas anteriores, cada item de `result.items[]` ya trae:

```
items[i].title                        → string o lista de objetos { _value, _lang }
items[i].identifier                   → identificador interno
items[i].publisher                    → URL del publisher
items[i]._about                       → URL canónica del dataset en datos.gob.es
items[i].distribution[]               → array (o objeto) de distribuciones
  .accessURL                          → URL de descarga real (CSV, XLS, JSON, etc.)
  .format._value                      → "text/csv", "application/json", etc.
  .byteSize                           → tamaño aproximado
  .title                              → nombre legible de la distribución
```

> `distribution` puede venir como objeto (1 sola) o como array. Tratar siempre como lista.
> `title` puede venir como string, objeto `{_value, _lang}` o lista de objetos. Si es lista, preferir `_lang == "es"`.

## Workflow recomendado

```
1. Búsqueda por título o publisher para localizar datasets candidatos
2. Para cada candidato relevante, leer items[i].distribution[]
3. Elegir la distribución con el formato más útil (CSV > JSON > XLS > PDF)
4. WebFetch a esa accessURL para descargar los datos
5. Si el fichero es muy grande, avisar al usuario antes de descargar
```

## Errores comunes

- **400 Bad Request**: estás usando `?q=` en vez de `/title/`.
- **0 items con `theme`**: el tema no tiene datasets indexados con esa etiqueta — intenta búsqueda por título.
- **404 sobre publisher**: el código DIR3 no existe — listar publishers primero.
- **HTML en vez de JSON**: olvidaste `?_format=json`.

## Cuándo NO usar esta skill

- Si el usuario pregunta por una norma o ley → **boe**.
- Si pregunta por estadísticas oficiales del INE → **ine**.
- Si pregunta por inmuebles o referencias catastrales → **catastro**.
- Si pregunta por meteorología → **aemet**.
- (Y así con todas las skills que tengan su propia SKILL.md.)

Esta skill solo brilla cuando ninguna otra encaja.
