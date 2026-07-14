---
name: seguridad-social
description: "Use when the user asks about Spanish Social Security statistics, affiliation (afiliación), contributory or non-contributory pensions, contribution regimes, monthly highs and lows (altas y bajas), jubilación data, or the Tesorería General de la Seguridad Social (TGSS). The Social Security does not publish a direct REST API; instead, discover and download its datasets through the national open data catalog datos.gob.es. Triggers on: 'Seguridad Social', 'TGSS', 'afiliación', 'afiliados', 'pensiones', 'pensionistas', 'cotización', 'régimen general', 'autónomos', 'jubilación', 'viudedad', 'altas y bajas', 'pensión contributiva', 'pensión no contributiva'."
license: MIT
---

# Seguridad Social — Datos vía datos.gob.es

La Tesorería General de la Seguridad Social (TGSS) y el INSS **no publican
una API REST pública propia** con sus estadísticas mensuales. En su lugar,
sus datasets (y los de otras administraciones con datos laborales y de
protección social, como el ISTAC para Canarias) están indexados en el
catálogo nacional `datos.gob.es`, que sí ofrece una API abierta.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLSX).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `seg-social.es`, `seg-social.gob.es` o
`sede.seg-social.gob.es`. Solo usar `accessURL` extraídas de la respuesta
del catálogo.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header
`Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. Afiliación a la Seguridad Social por régimen y CCAA

```
GET https://datos.gob.es/apidata/catalog/dataset/title/afiliaci%C3%B3n?_pageSize=10&_format=json
```

`afiliación` debe ir URL-encoded (`afiliaci%C3%B3n`). Devuelve datasets
como:

- *Afiliación a la Seguridad Social*
- *Afilliados a la Seguridad Social por régimen de cotización* (nótese la
  errata "Afilliados" en el catálogo oficial — no corregir)
- *Afiliaciones a último día del mes según regímenes de cotización y sexos.
  Provincias de Canarias y meses*
- *Afiliaciones en activo a los regímenes agrarios de la Seguridad Social
  según regímenes de cotización y sexos. Lugar de cotización. Municipios de
  Canarias y meses*
- *Afiliaciones en el Régimen General Ordinario según grupos de cotización,
  actividades características del turismo y sexos…*

Muchos de los datasets más desagregados son del ISTAC y cubren solo
Canarias. Para cobertura nacional con desglose por CCAA, los datasets
generales del TGSS (título simple "Afiliación a la Seguridad Social" o
"Afilliados a la Seguridad Social por régimen de cotización") son los más
útiles. El resto suelen ser reportes territoriales.

También existen variantes en euskera (`Gizarte Segurantzak izandako
afiliazioa`) publicadas por EUSTAT para el País Vasco.

### 2. Pensiones contributivas y no contributivas por tipo y CCAA

```
GET https://datos.gob.es/apidata/catalog/dataset/title/pensiones?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Pensiones*
- *Pensiones contributivas por sexo. Municipios*
- *Pensiones contributivas e importes medios según tipos de pensión en
  Canarias por periodos*
- *Esquema de conceptos operacionales de Estadística de Pensiones
  Contributivas (ISTAC: CSO_E58017A)*
- *Esquema de conceptos operacionales de Estadística de Pensiones no
  Contributivas (ISTAC: CSO_E64049A)*
- *Indicadores municipales de sostenibilidad: Población perceptora de
  pensiones contributivas (% habitantes)*

Los datasets "Esquema de conceptos…" son metadatos (vocabularios SDMX del
ISTAC), no datos: útiles para entender cómo se clasifican las pensiones,
pero no devuelven cifras. **Filtrar** y priorizar los datasets de datos
reales.

Para distinguir las cinco grandes clases de pensión contributiva
(jubilación, incapacidad permanente, viudedad, orfandad y a favor de
familiares), el dataset "Pensiones contributivas e importes medios según
tipos de pensión…" del ISTAC es el más explícito.

### 3. Altas y bajas mensuales de afiliación

```
GET https://datos.gob.es/apidata/catalog/dataset/title/altas?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/seguridad%20social?_pageSize=10&_format=json
```

La búsqueda directa por `altas` devuelve datasets heterogéneos (altas de
empresas, altas hospitalarias). Para flujos mensuales de afiliación lo más
robusto es partir de `seguridad social` y filtrar por títulos que contengan
"Afiliaciones a último día del mes", "Afiliaciones en activo" o
"Empresas inscritas".

La búsqueda `title/seguridad%20social` devuelve también datasets como:

- *Afilliados a la Seguridad Social por régimen de cotización*
- *Clasificación de regímenes de cotización a la Seguridad Social
  (ISTAC: CL_REGIMENES_COTIZACION_SEGURIDAD_SOCIAL)*
- *Empresas inscritas en la Seguridad Social según actividades turísticas
  (CNAE-09), intervalos de asalariados y naturaleza jurídica…*
- *Empresas inscritas en la Seguridad Social según agregaciones de
  actividad económica…*
- *Accidentes en jornada de trabajo. Nº de accidentes según grado de lesión
  y régimen de la Seguridad Social. Por provincias*

Estos datasets permiten reconstruir las **altas y bajas mensuales netas**
comparando observaciones consecutivas del mismo dataset a último día de
mes.

### 4. Búsquedas de apoyo

- `title/cotizaci%C3%B3n` → datasets por régimen y grupos de cotización.
- `title/jubilaci%C3%B3n` → datasets específicos de pensiones de jubilación.
- `title/autónomos` → afiliación al RETA y empresas individuales.

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
2. Filtrar result.items[] por títulos realmente de Seguridad Social
   (descartar "Esquema de conceptos", datasets en euskera si se pide
   cobertura nacional, datasets hospitalarios, accidentes laborales salvo
   que se pida explícitamente)
3. Para cada candidato, iterar distribution[]
4. Elegir formato más útil (CSV > JSON > XLSX > PDF)
5. WebFetch a esa accessURL para descargar los datos
6. Si el fichero es grande (byteSize > ~5 MB), avisar antes al usuario
7. Al presentar cifras, distinguir siempre entre:
   - Stock (afiliados a último día del mes)
   - Flujo (altas y bajas del periodo)
   - Promedio (media mensual del ejercicio)
```

## Errores comunes

- **400 Bad Request**: estás usando `?q=` en vez de `/title/`.
- **0 items**: el término es demasiado específico — probar sinónimos
  (`afiliación` → `afiliados`, `pensiones` → `pensionistas`,
  `cotización` → `régimen`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **Confundir stock con flujo**: "afiliación a último día del mes" es un
  stock; las "altas y bajas" son flujos. No sumarlos directamente.
- **Datasets de metadatos**: títulos tipo "Esquema de conceptos…",
  "Clasificación de regímenes…" son vocabularios SDMX del ISTAC, no datos.
- **Falsa errata**: el dataset oficial aparece como "Afilliados" (con doble
  ele). No es un bug — es el título real en el catálogo.

## Cuándo NO usar esta skill

- Si el usuario pregunta por la **tasa de paro** o la EPA → **ine**.
- Si pregunta por el paro registrado, contratos o demandantes → **sepe**.
- Si pregunta por la norma que regula una prestación o una pensión
  concreta → **boe**.
- Si pide hacer un trámite real en la Seguridad Social (solicitar pensión,
  alta de autónomo, vida laboral, cita previa) → no es posible desde esta
  skill: redirigir a `https://sede.seg-social.gob.es` o a la app
  `Import@ss`.
- Si pregunta por la cuantía individual de su pensión o su base reguladora →
  dato protegido, redirigir a `sede.seg-social.gob.es`.
- Si pregunta por un dataset genérico no laboral ni de protección social →
  **datos-gob-es**.
