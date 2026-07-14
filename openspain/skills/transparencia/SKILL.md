---
name: transparencia
description: "Use when the user asks about Spanish public sector transparency data — state contracts and tenders (contratación pública, licitaciones, contratos mayores, PLACSP), public subsidies (subvenciones, ayudas), appointments and salaries of senior officials (altos cargos, nombramientos, ceses, retribuciones), or official agendas of Spanish government members. The Portal de Transparencia does not publish a direct REST API with a queryable catalog; instead, discover and download its datasets (and those of other Spanish public administrations) through the national open data catalog datos.gob.es. Triggers on: 'transparencia', 'portal transparencia', 'contratos Estado', 'contratos sector público', 'licitaciones', 'contratos mayores', 'PLACSP', 'subvenciones', 'ayudas públicas', 'altos cargos', 'nombramientos', 'retribuciones altos cargos', 'agendas Gobierno'."
license: MIT
---

# Transparencia — Datos del Portal de Transparencia vía datos.gob.es

El Portal de Transparencia de la Administración General del Estado
(`transparencia.gob.es`) **no publica una API REST pública propia** con un
catálogo consultable de sus publicaciones. En su lugar, los datasets de
transparencia (contratos, subvenciones, altos cargos, agendas) se publican
a través del catálogo nacional `datos.gob.es`, que sí ofrece una API
abierta.

Esta skill sigue siempre el mismo patrón:

1. Buscar por título en `datos.gob.es` con la ruta `/title/{texto}`.
2. Revisar los `items[].distribution[]` devueltos.
3. Elegir la distribución con formato útil (CSV > JSON > XLSX).
4. Descargar con `WebFetch` la `accessURL` real.

**Nunca** inventar URLs de `transparencia.gob.es` ni scrapear el portal
web. Solo usar `accessURL` extraídas de la respuesta del catálogo.

## Base URL

```
https://datos.gob.es/apidata/catalog/dataset
```

Siempre añadir `?_format=json`. WebFetch con GET y header
`Accept: application/json`.

> ⚠️ El parámetro `?q={texto}` **NO** funciona — devuelve 400. Hay que usar
> la ruta `/title/{texto}`.

## Operaciones

### 1. Contratos del sector público (PLACSP, licitaciones)

La **Plataforma de Contratación del Sector Público** (PLACSP) es el canal
oficial donde se publican los contratos del Estado y otras administraciones.
Muchos publishers etiquetan sus datasets con la abreviatura `PLACSP` en el
título.

```
GET https://datos.gob.es/apidata/catalog/dataset/title/PLACSP?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/contratos%20mayores?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/licitaciones?_pageSize=10&_format=json
```

Devuelve datasets con nombres como:

- *Contratos Mayores. 2024 - (PLACSP)*
- *Contratos Mayores. 2025 - (PLACSP)*
- *Estadística del número de contratos mayores por tipo y ejercicio*
- *UCM-Licitaciones de Contratos Mayores*
- *Licitaciones Publicadas 2021 / 2022 / ...*
- *Licitaciones de los organismos públicos del proyecto NextProcurement*
- *Anuncios licitaciones* / *Adjudicaciones licitaciones*

> Muchos datasets de PLACSP los publican administraciones locales o
> autonómicas (ayuntamientos, universidades, diputaciones) como volcados de
> sus propios contratos. Avisar siempre al usuario del publisher concreto
> (`items[i].publisher`) para que entienda el alcance territorial del
> dataset.

> ⚠️ Para contratos **realmente estatales (AGE)** vía los volcados oficiales
> mensuales de la Plataforma de Contratación del Sector Público, **no usar
> esta skill**: usar la skill **placsp**, que accede directamente a los
> ficheros ATOM/ZIP publicados en `contrataciondelestado.es`. Esta skill
> (`transparencia`) solo cubre lo que esté indexado en `datos.gob.es`.

#### Identificar el ámbito del publisher (códigos DIR3)

El campo `items[i].publisher` es una URL que termina en un código **DIR3**.
La primera letra indica el ámbito administrativo:

| Prefijo | Ámbito                              | Ejemplo                          |
|---------|-------------------------------------|----------------------------------|
| `E0`    | Administración General del Estado   | ministerios, organismos estatales|
| `A`     | Comunidad Autónoma                  | Junta, Generalitat, Gobierno CCAA|
| `L01`   | Entidad Local — municipio           | ayuntamientos                    |
| `L02`   | Entidad Local — provincia           | diputaciones, cabildos, consejos |
| `L03`   | Entidad Local — comarca / mancomun. |                                  |
| `U`     | Universidad pública                 | UCM, UAM, UPM, ...               |
| `EA`    | Entidad del sector público estatal  | empresas y entes públicos AGE    |

> Si el usuario pide "contratos del Gobierno" / "del Estado", filtrar
> `publisher` por prefijo **`E0`** (o `EA` para entes públicos estatales)
> antes de presentar resultados. Un dataset etiquetado *PLACSP* publicado
> por `L01...` es un ayuntamiento, no la AGE.

### 2. Subvenciones y ayudas públicas

```
GET https://datos.gob.es/apidata/catalog/dataset/title/subvenciones?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Periodo medio de pago a beneficiarios de subvenciones desde 2024*
- *Subvenciones, premios y becas del Gobierno de Canarias* (histórico y
  corriente)
- *Subvenciones concedidas por la Administración de la Junta de Comunidades
  de Castilla-La Mancha y su sector público vinculado o dependiente*
- *Ayudas y Subvenciones en materia de vivienda en Castilla-La Mancha*
- *Subvenciones a EELL por proyectos de Igualdad entre mujeres y hombres*

> El catálogo nacional no indexa siempre datos completos de la **BDNS**
> (Base de Datos Nacional de Subvenciones). Si el usuario necesita la BDNS
> completa, redirigir a `https://www.infosubvenciones.es` como fuente
> oficial complementaria.

### 3. Altos cargos: nombramientos, ceses, retribuciones

```
GET https://datos.gob.es/apidata/catalog/dataset/title/altos%20cargos?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/nombramientos?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/retribuciones?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Nombramientos y ceses de Altos Cargos*
- *Retribuciones y Relaciones de altos cargos de la Administración Regional
  de Castilla-La Mancha*
- *Retribuciones de personas que ocupan cargos públicos en la
  Administración Pública de Canarias*
- *Retribuciones altos cargos: Cesantías abonadas*
- *Regalos a Miembros del Gobierno y Altos Cargos*

> Algunos títulos vienen también en euskera (`Goi-kargudunen ordainsariak`).
> Si `title` es una lista, preferir el elemento con `_lang == "es"`.

### 4. Agendas institucionales

```
GET https://datos.gob.es/apidata/catalog/dataset/title/agenda?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Agenda de Gobierno*
- *Agenda del gobierno de la Comunidad autónoma de Castilla-La Mancha*
- *Agenda cultural de Castilla-La Mancha / IVC*
- *Agenda de la Oficina de Congresos*

> La búsqueda por `agenda` mezcla agendas institucionales (las de
> transparencia) con agendas culturales y turísticas. Filtrar por título
> antes de presentar resultados al usuario.

### 5. Registro de transparencia y reclamaciones

```
GET https://datos.gob.es/apidata/catalog/dataset/title/transparencia?_pageSize=10&_format=json
```

Devuelve datasets como:

- *Registro de solicitudes y reclamaciones en el ámbito de transparencia*
- *Registro de transparencia*
- *Índice de Transparencia de las Comunidades Autónomas*
- *Índice de transparencia dinámica*

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
2. Filtrar result.items[] por títulos realmente relevantes al ámbito de
   transparencia (contratos, subvenciones, altos cargos, agendas)
3. Para cada candidato, iterar distribution[]
4. Elegir formato más útil (CSV > JSON > XLSX > PDF)
5. WebFetch a esa accessURL para descargar los datos
6. Si el fichero es grande (byteSize > ~5 MB), avisar antes al usuario
7. Indicar siempre al usuario el publisher del dataset (ayto, CCAA,
   ministerio, universidad) para que entienda el alcance
```

## Errores comunes

- **400 Bad Request**: estás usando `?q=` en vez de `/title/`.
- **0 items**: el término es demasiado específico — probar sinónimos
  (`contratos` → `licitaciones`, `subvenciones` → `ayudas`, `altos cargos`
  → `retribuciones`).
- **HTML en vez de JSON**: olvidaste `?_format=json`.
- **404 al descargar una `accessURL`**: el catálogo `datos.gob.es` solo
  indexa metadatos; los ficheros viven en el portal del publisher y pueden
  haber sido renombrados, reubicados o reemplazados por una versión nueva
  con otro UUID entre cosechas. No es un bug del catálogo, es una
  limitación estructural del modelo federado. Estrategia de recuperación:
  (1) probar otra `distribution[]` del mismo dataset (si el JSON está roto,
  el CSV puede estar vivo); (2) recargar metadatos pidiendo el dataset por
  su `_about`; (3) caer al dataset del año anterior; (4) avisar al usuario
  del enlace roto.
- **Falsos positivos con `agenda`**: la búsqueda mezcla agendas culturales
  con agendas institucionales. Filtrar manualmente.
- **Confundir ámbito estatal con autonómico/local**: muchos datasets de
  transparencia los publica una CCAA, ayuntamiento o universidad concreta.
  Leer siempre el `publisher` antes de generalizar.

## Cuándo NO usar esta skill

- Si el usuario pide **contratos estatales (AGE) desde el volcado oficial
  de PLACSP** (ATOM/ZIP mensuales en `contrataciondelestado.es`) →
  **placsp**. Esta skill solo cubre lo indexado en `datos.gob.es`.
- Si el usuario pregunta por la **ley de transparencia** o una norma
  concreta → **boe**.
- Si pregunta por estadísticas fiscales o recaudación → **aeat**.
- Si pregunta por paro registrado o contratos laborales del SEPE →
  **sepe** (ojo: "contratos registrados" del SEPE ≠ "contratos del sector
  público" de transparencia).
- Si necesita presentar una **solicitud de acceso a la información
  pública** real → no es posible desde esta skill: redirigir a
  `https://transparencia.gob.es`.
- Si pregunta por un dataset genérico no relacionado con transparencia →
  **datos-gob-es**.
