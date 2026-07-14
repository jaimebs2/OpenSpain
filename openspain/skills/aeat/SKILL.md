---
name: aeat
description: "Use when the user asks about Spanish tax statistics, fiscal data, or the Agencia Tributaria (AEAT) — income tax (IRPF) by bracket or municipality, tax collection (recaudación) by tax type, VAT (IVA) figures, or any public fiscal dataset. The Spanish tax agency does not publish a direct REST API; instead, discover and download its datasets through the national open data catalog datos.gob.es. Triggers on: 'AEAT', 'Agencia Tributaria', 'IRPF', 'IVA', 'recaudación', 'impuestos España', 'estadísticas fiscales', 'tramo de renta', 'base imponible', 'declarantes IRPF'."
license: MIT
---

# AEAT — Datos fiscales vía datos.gob.es

La Agencia Tributaria **no publica una API REST pública propia** con sus
estadísticas. En su lugar, sus datasets (y los de otras administraciones con
datos fiscales) están indexados en el catálogo nacional `datos.gob.es`, que
sí ofrece una API abierta.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLS).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `sede.agenciatributaria.gob.es`. Solo usar
`accessURL` extraídas de la respuesta del catálogo.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header `Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. IRPF por tramo / municipio / base imponible

```
GET https://datos.gob.es/apidata/catalog/dataset/title/IRPF?_pageSize=10&_format=json
```

Devuelve datasets con nombres como:

- *Base imponible del ahorro del IRPF (miles euros). Municipios*
- *Base imponible general del IRPF. Municipios*
- *Base liquidable general sometida a gravamen del IRPF. Municipios*

Cada item trae `distribution[]` con URLs reales a CSV y JSON.

### 2. Recaudación por impuesto

```
GET https://datos.gob.es/apidata/catalog/dataset/title/recaudaci%C3%B3n?_pageSize=10&_format=json
```

`recaudación` debe ir URL-encoded (`recaudaci%C3%B3n`). Devuelve datasets
como:

- *Recaudación Tributaria del Estado acumulada. Comunidades autónomas y provincias por periodos*
- *Recaudación tributaria de la Administración General de la Comunidad Autónoma por los tributos cedidos por el Estado*

### 3. IVA y otros impuestos

```
GET https://datos.gob.es/apidata/catalog/dataset/title/IVA?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/impuesto?_pageSize=10&_format=json
```

`IVA` como trigram puede matchear otras palabras (p.ej. "activa", "deportivas").
Filtrar manualmente los items cuyo título contenga realmente "IVA" o
"Impuesto sobre el Valor Añadido". Para estadísticas del IVA puede ser más
fiable combinar con la búsqueda por "impuesto".

La búsqueda `title/impuesto` devuelve también datasets de Patrimonio, IAE,
ITP/AJD, IBI, etc. — útil como fallback cuando los términos específicos no
encuentran nada.

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
  (`IRPF` → `renta`, `recaudación` → `tributos`, `IVA` → `valor añadido`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **Falsos positivos con `IVA`**: el token es corto y puede matchear otras
  palabras. Siempre filtrar por título real.

## Cuándo NO usar esta skill

- Si el usuario pregunta por una norma o ley fiscal concreta → **boe**.
- Si pregunta por indicadores macroeconómicos oficiales (PIB, paro, IPC) →
  **ine**.
- Si pregunta por un dataset genérico no fiscal → **datos-gob-es**.
- Si pregunta sobre **obligaciones fiscales** (presentar el IVA, calcular
  pagos fraccionados del IRPF) → **fiscalidad-iva** o
  **fiscalidad-irpf-autonomos**.
- Si pide hacer un trámite real en la AEAT (declarar, pagar, consultar
  expediente) → no es posible desde esta skill: redirigir a
  `https://sede.agenciatributaria.gob.es`.
