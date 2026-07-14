---
name: sepe
description: "Use when the user asks about Spanish unemployment statistics, labour market data, or the Servicio Público de Empleo Estatal (SEPE, formerly INEM) — registered unemployment (paro registrado) by municipality, province or autonomous community, unemployment by sex and age group, registered contracts by sector or occupation, or jobseekers (demandantes de empleo). The SEPE does not publish a direct REST API; instead, discover and download its datasets through the national open data catalog datos.gob.es. Triggers on: 'SEPE', 'INEM', 'paro registrado', 'desempleo', 'demandantes de empleo', 'contratos registrados', 'mercado laboral', 'estadísticas de empleo', 'paro por municipio', 'paro por sexo y edad'."
license: MIT
---

# SEPE — Datos de empleo vía datos.gob.es

El Servicio Público de Empleo Estatal (SEPE, antiguo INEM) **no publica una
API REST pública propia** con sus estadísticas mensuales. En su lugar, sus
datasets (y los de otras administraciones con datos de empleo) están
indexados en el catálogo nacional `datos.gob.es`, que sí ofrece una API
abierta.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLSX).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `sepe.es` o `sepe.gob.es`. Solo usar `accessURL`
extraídas de la respuesta del catálogo.

## ⚠️ Aviso obligatorio — anonimización SEPE

En los CSV del SEPE, los valores entre **1 y 4** aparecen como `<5` (literal,
entre comillas o como texto plano). Es una medida de anonimización oficial
para proteger la privacidad en cruces muy desagregados (municipio pequeño ×
sexo × grupo de edad × sector).

**Siempre** mencionar este detalle al usuario cuando se muestren cifras
desagregadas: "los valores entre 1 y 4 aparecen como `<5` por anonimización
del SEPE". Si el agente intenta sumar celdas desagregadas con `<5` dentro,
debe avisar de que el total es una estimación.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header
`Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. Paro registrado por municipio / provincia / comunidad autónoma

```
GET https://datos.gob.es/apidata/catalog/dataset/title/paro%20registrado?_pageSize=10&_format=json
```

Devuelve datasets con nombres como:

- *Paro registrado según sexos y grupos de edad. Provincias de España por meses*
- *Paro registrado según sectores económicos. Provincias de España por meses*
- *Paro registrado según grupos de edad y niveles de estudios. Municipios…*
- *Paro registrado del colectivo sin empleo anterior según sexos y grupos de edad. Provincias de España por meses*
- *Paro registrado de los extranjeros según sectores económicos. Provincias de España por meses*

Los datasets incluyen desagregaciones por provincia e islas (con datos
detallados para Canarias publicados por el ISTAC en `datos.canarias.es`).

### 2. Paro por sexo y edad

```
GET https://datos.gob.es/apidata/catalog/dataset/title/paro?_pageSize=10&_format=json
```

Devuelve tanto datasets del SEPE ("Paro registrado según sexos y grupos de
edad…") como de la EPA del INE ("Tasa de paro de las personas entre 16 y 74
años por sexo…"). **Filtra manualmente** por título:

- Títulos que empiezan por "Paro registrado" → SEPE / datos administrativos.
- Títulos que contienen "EPA" o "Tasa de paro" → INE, encuesta de población
  activa. Para esos casos es preferible redirigir a la skill **ine**.

### 3. Contratos registrados por sector u ocupación

```
GET https://datos.gob.es/apidata/catalog/dataset/title/contratos?_pageSize=10&_format=json
```

Devuelve datasets relevantes como:

- *Contratos Registrados por municipios*
- *Contratos registrados. Según grandes grupos de ocupación y sexo. Por provincias*
- *Contratos registrados. Según tamaño de la cuenta de cotización y sexo. Por provincias*
- *Duración media de los contratos temporales registrados, según sexo*

Filtra los datasets de "Contratos menores" o "Contratos del Senado" — esos
son de contratación pública administrativa, no del mercado laboral.

### 4. Demandantes de empleo y colectivos específicos

```
GET https://datos.gob.es/apidata/catalog/dataset/title/demandantes?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/empleo?_pageSize=10&_format=json
```

Útiles para preguntas sobre demandantes registrados, colectivos vulnerables,
jóvenes, parados de larga duración, etc.

## Estructura de respuesta

```
result.items[]
  .title                       → string o lista de { _value, _lang }
  .identifier                  → identificador interno
  .publisher                   → URL del publisher (DIR3)
  ._about                      → URL canónica del dataset en datos.gob.es
  .distribution[]              → array (o objeto) de distribuciones
    .accessURL                 → URL real de descarga (CSV, JSON, XLSX, ...)
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
2. Filtrar result.items[] por títulos realmente del SEPE (empiezan por
   "Paro registrado", "Contratos registrados", "Demandantes…")
3. Para cada candidato, iterar distribution[]
4. Elegir formato más útil (CSV > JSON > XLSX > PDF)
5. WebFetch a esa accessURL para descargar los datos
6. Si el fichero es grande (byteSize > ~5 MB), avisar antes al usuario
7. Al presentar resultados con desagregación fina, recordar siempre la
   anonimización "<5" del SEPE
```

## Errores comunes

- **400 Bad Request**: estás usando `?q=` en vez de `/title/`.
- **0 items**: el término es demasiado específico — probar sinónimos
  (`paro` → `desempleo`, `contratos` → `contratación`, `demandantes` →
  `empleo`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **Confundir SEPE con EPA (INE)**: la búsqueda `title/paro` mezcla ambas
  fuentes. Filtrar por título real.
- **Ignorar la anonimización `<5`**: si sumas celdas con `<5` dentro, el
  total queda infravalorado. Avisar siempre al usuario.

## Cuándo NO usar esta skill

- Si el usuario pregunta por la **tasa de paro** de la EPA, encuestas de
  población activa o indicadores macroeconómicos → **ine**.
- Si pregunta por la norma que regula una prestación por desempleo → **boe**.
- Si pide hacer un trámite real en el SEPE (solicitar prestación, consultar
  expediente, cita previa) → no es posible desde esta skill: redirigir a
  `https://sede.sepe.gob.es`.
- Si pregunta por un dataset genérico no laboral → **datos-gob-es**.
