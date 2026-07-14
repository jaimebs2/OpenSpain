---
name: miteco
description: "Use when the user asks about Spanish environmental data or the Ministerio para la Transición Ecológica (MITECO) — reservoir levels (embalses, reservas hidráulicas), air quality monitoring (calidad del aire, RVCA), protected natural spaces (Red Natura 2000, ZEPA, ZEC, LIC), biodiversity, species and habitats. MITECO does not publish a single unified REST API; its datasets are scattered across river basin authorities, monitoring networks and the national biodiversity inventory, but all are indexed in the national open data catalog datos.gob.es which offers an open API. Triggers on: 'MITECO', 'embalses', 'reservas hidráulicas', 'agua España', 'confederación hidrográfica', 'calidad aire', 'calidad del aire', 'contaminación atmosférica', 'biodiversidad', 'red natura', 'red natura 2000', 'ZEPA', 'ZEC', 'LIC', 'espacios protegidos', 'medio ambiente España', 'transición ecológica'."
license: MIT
---

# MITECO — Datos ambientales vía datos.gob.es

El Ministerio para la Transición Ecológica **no publica una API REST
unificada** con todos sus datos. Los datasets ambientales están dispersos
entre confederaciones hidrográficas (SAIH), la Red de Vigilancia de la
Calidad del Aire (RVCA), el Inventario Español del Patrimonio Natural y
la Biodiversidad, etc. Todos ellos están (directa o indirectamente)
indexados en el catálogo nacional `datos.gob.es`, que sí ofrece una API
abierta bien documentada.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLS > SHP).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `miteco.gob.es`, `chebro.es`, `chguadalquivir.es`
o similares. Solo usar `accessURL` extraídas de la respuesta del catálogo.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header `Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. Embalses y reservas hidráulicas

```
GET https://datos.gob.es/apidata/catalog/dataset/title/embalses?_pageSize=10&_format=json
```

Devuelve datasets con nombres como:

- *Estado Embalses*
- *Embalses de las demarcaciones hidrográficas del Guadalquivir, Ceuta y Melilla*
- *Embalses. Gobierno de Navarra 1:5.000*

Términos alternativos si la búsqueda anterior no basta:

```
GET https://datos.gob.es/apidata/catalog/dataset/title/reservas%20hidr%C3%A1ulicas?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/hidrol%C3%B3gica?_pageSize=10&_format=json
```

Cada item trae `distribution[]` con URLs reales a CSV, JSON, XLS o SHP.

### 2. Calidad del aire

```
GET https://datos.gob.es/apidata/catalog/dataset/title/calidad%20aire?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Datos por horas calidad aire 2016-2020*
- *Datos por horas calidad aire 2021-2022*
- *Registros calidad aire*

Términos alternativos:

```
GET https://datos.gob.es/apidata/catalog/dataset/title/contaminaci%C3%B3n?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/aire?_pageSize=10&_format=json
```

> `aire` es un token corto y puede matchear falsos positivos
> (*aeronáutica*, *aeropuerto*…). Filtrar manualmente por título real
> conteniendo "calidad del aire" o "contaminación".

### 3. Red Natura 2000 y biodiversidad

```
GET https://datos.gob.es/apidata/catalog/dataset/title/red%20natura?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Base de datos de los espacios protegidos Red Natura 2000 de España (CNTRYES)*
- *Espacios Protegidos de la Red Natura 2000 - API - Datos Alto Valor*
- *Red Natura 2000. Zonas de Especial Protección de Aves (ZEPA)*
- *Red Natura 2000. Zonas Especiales de Conservación (ZEC)*
- *Lugares de importancia Comunitaria (LIC) en Castilla-La Mancha (Red Natura 2000)*

Términos alternativos para biodiversidad más amplia:

```
GET https://datos.gob.es/apidata/catalog/dataset/title/biodiversidad?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/espacios%20protegidos?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/especies?_pageSize=10&_format=json
```

## Estructura de respuesta

```
result.items[]
  .title                       → string o lista de { _value, _lang }
  .identifier                  → identificador interno
  .publisher                   → URL del publisher (DIR3)
  ._about                      → URL canónica del dataset en datos.gob.es
  .distribution[]              → array (o objeto) de distribuciones
    .accessURL                 → URL real de descarga (CSV, JSON, XLS, SHP…)
    .format._value             → "text/csv", "application/json", "application/zip"…
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
4. Elegir formato más útil (CSV > JSON > XLS > SHP > PDF)
5. WebFetch a esa accessURL para descargar los datos
6. Si el fichero es muy grande (byteSize > ~5 MB), avisar antes al usuario
7. Si el dataset pertenece a una comunidad autónoma concreta y el usuario
   pregunta por España en global, indicarlo explícitamente
```

## Errores comunes

- **400 Bad Request**: estás usando `?q=` en vez de `/title/`.
- **0 items**: el término es demasiado específico — probar sinónimos
  (`embalses` → `reservas hidráulicas`, `calidad aire` → `contaminación`,
  `red natura` → `espacios protegidos` / `biodiversidad`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **Datos geoespaciales en SHP/GML**: no se pueden leer directamente con
  WebFetch — avisar al usuario de que necesita un cliente GIS (QGIS, ArcGIS)
  o preferir una distribución tabular (CSV/JSON) del mismo dataset si
  existe.
- **Resultados autonómicos**: muchos datasets de embalses o calidad del
  aire pertenecen a una comunidad concreta (Navarra, Andalucía, País
  Vasco…). Si el usuario pide datos de toda España, filtrar por datasets
  con ámbito nacional o agregados del ministerio.

## Cuándo NO usar esta skill

- Si el usuario pregunta por el tiempo, predicción meteorológica,
  temperaturas o lluvias previstas → **aemet**.
- Si pregunta por una norma ambiental concreta (ley, real decreto) →
  **boe**.
- Si pregunta por indicadores ambientales estadísticos agregados (INE) →
  **ine**.
- Si pregunta por un dataset genérico no ambiental → **datos-gob-es**.
- Si pregunta por **zonas inundables, Dominio Público Hidráulico (DPH),
  zona de policía o zona de servidumbre** para una coordenada, parcela o
  dirección concreta → **snczi** (consulta cartográfica punto a punto vía
  los WMS del SNCZI, no vía catálogo).
- Si pide un trámite real con MITECO (solicitud de subvención, permiso) →
  no es posible desde esta skill: redirigir a `https://sede.miteco.gob.es`.
