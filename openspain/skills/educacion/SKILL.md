---
name: educacion
description: "Use when the user asks about the Spanish education system — escuelas, colegios, institutos, universidades, formación profesional (FP), alumnado, matrícula, tasas de escolarización, becas y ayudas al estudio, o cualquier estadística educativa oficial. El Ministerio de Educación, FP y Deportes no publica una API REST unificada: en su lugar, sus datasets (y los de las consejerías autonómicas) se descubren a través del catálogo nacional datos.gob.es. Triggers: 'educación', 'colegio', 'instituto', 'universidad España', 'becas estudio', 'matrícula escolar', 'alumnado', 'centros educativos', 'FP', 'formación profesional', 'Ministerio de Educación'."
license: MIT
---

# educacion — Datos educativos vía datos.gob.es

El Ministerio de Educación, FP y Deportes **no publica una API REST pública
propia** con sus estadísticas del sistema educativo. En su lugar, sus
datasets (y los de las consejerías autonómicas y otros organismos con datos
educativos) están indexados en el catálogo nacional `datos.gob.es`, que sí
ofrece una API abierta.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLS).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `educacionfpydeportes.gob.es`,
`educacionyfp.gob.es` o de las sedes autonómicas. Solo usar `accessURL`
extraídas de la respuesta del catálogo.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header
`Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. Directorio de centros educativos

```
GET https://datos.gob.es/apidata/catalog/dataset/title/centros%20educativos?_pageSize=10&_format=json
```

Devuelve datasets con nombres como:

- *Centros educativos*
- *Clasificación de los centros educativos según enseñanzas (ISTAC)*
- *Clasificación de tipos de centros educativos*
- *Población escolarizada según tipos de centros*

Útil para localizar directorios oficiales de colegios, institutos y otros
centros con código, dirección y tipo de enseñanza.

### 2. Alumnado y matrícula por nivel / CCAA

```
GET https://datos.gob.es/apidata/catalog/dataset/title/alumnado?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/matr%C3%ADcula?_pageSize=10&_format=json
```

`matrícula` debe ir URL-encoded (`matr%C3%ADcula`). La búsqueda por
`alumnado` suele ser más productiva para estadísticas agregadas. Devuelve
datasets como:

- *Bachillerato nocturno. Alumnado extranjero matriculado por continente
  de origen y titularidad del centro. Provincias*
- *Educación Infantil 1º Ciclo (0-3 años). Alumnado extranjero matriculado
  por país de origen*
- *Ciclos Formativos nocturnos. Procedencia del alumnado por sexo.
  Provincias*
- *Alumnado por nivel educativo, red y modelo lingüístico. Datos de
  matrícula para el curso 20XX-20YY*

Muchos de estos datasets vienen de consejerías autonómicas (Canarias,
Euskadi, etc.) — avisar al usuario si los datos no son de cobertura
estatal.

### 3. Becas y ayudas al estudio

```
GET https://datos.gob.es/apidata/catalog/dataset/title/becas?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Becas*
- *Enseñanzas postobligatorias no universitarias. Becas y ayudas por tipo
  de beca/ayuda, administración educativa financiadora y provincia del
  becario*
- *Número de beneficiarios de becas generales de la Administración
  General del Estado (AGE) y del País Vasco según niveles de estudios*
- *Subvenciones, premios y becas del Gobierno de Canarias*

### 4. Universidades y formación profesional

```
GET https://datos.gob.es/apidata/catalog/dataset/title/universidad?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/formaci%C3%B3n%20profesional?_pageSize=10&_format=json
```

Útil como fallback cuando `alumnado` o `matrícula` no devuelven nada
específico. Encuentra datasets como *Clasificación de universidades
españolas según RUCT*, rendimientos académicos por titulación y
estadísticas de ingreso.

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
  (`matrícula` → `alumnado`, `colegio` → `centros educativos`,
  `FP` → `formación profesional`, `beca` → `ayuda estudio`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **Datos autonómicos presentados como estatales**: muchos datasets
  provienen de consejerías (Canarias, Euskadi, Aragón…). Leer el `publisher`
  y advertir al usuario del ámbito real.

## Cuándo NO usar esta skill

- Si el usuario pregunta por una ley educativa concreta (LOMLOE, etc.) →
  **boe**.
- Si pregunta por indicadores macro del sistema educativo junto con PIB,
  empleo u otras series del INE → **ine**.
- Si pregunta por un dataset genérico no educativo → **datos-gob-es**.
- Si pide hacer un trámite real (solicitar una beca, formalizar matrícula,
  pedir un título) → no es posible desde esta skill: redirigir a
  `https://www.educacionfpydeportes.gob.es` o a la sede electrónica de la
  comunidad autónoma correspondiente.
