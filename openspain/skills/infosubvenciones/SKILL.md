---
name: infosubvenciones
description: "Use when the user asks about Spanish public subsidies, grants, or aid (subvenciones, ayudas públicas) — calls for proposals (convocatorias), individual awards (concesiones) by beneficiary, NIF or organism, state aid (ayudas de Estado), de minimis aid, large beneficiaries, or strategic subsidy plans. Queries the official BDNS / SNPSAP REST API of the Spanish Treasury (IGAE), covering state, regional and local administrations. Triggers on: 'BDNS', 'subvenciones', 'subvención', 'ayudas públicas', 'ayuda pública', 'infosubvenciones', 'convocatoria subvención', 'convocatorias de ayudas', 'concesión subvención', 'beneficiario subvención', 'ayudas de Estado', 'ayudas de minimis', 'SNPSAP', 'grandes beneficiarios subvenciones'."
license: MIT
---

# infosubvenciones — BDNS / SNPSAP

La **Base de Datos Nacional de Subvenciones (BDNS)**, también conocida como
**Sistema Nacional de Publicidad de Subvenciones y Ayudas Públicas (SNPSAP)**,
es el portal oficial donde se publican todas las convocatorias y concesiones
de subvenciones de las administraciones públicas españolas (Estado, CCAA,
entidades locales, universidades).

Está gestionada por la **IGAE** (Intervención General de la Administración del
Estado) y expone una **API REST JSON pública** sin autenticación, además de
estar también indexada en `datos.gob.es` como fallback.

## Base URL principal (BDNS)

```
https://www.pap.hacienda.gob.es/bdnstrans/api
```

Sin necesidad de header `Accept`. Todos los endpoints devuelven JSON. Usar
`WebFetch` con GET.

> ⚠️ La respuesta siempre incluye un campo `advertencia` con el aviso legal de
> reutilización. Es informativo, ignorar al procesar los datos.

## Paginación común

La mayoría de endpoints `/busqueda` y `/ultimas` devuelven una estructura
estándar Spring `Page`:

```json
{
  "content": [ ... ],
  "pageable": { "pageNumber": 0, "pageSize": 50, ... },
  "totalElements": 10000,
  "totalPages": 200,
  "first": true,
  "last": false,
  "numberOfElements": 50
}
```

Parámetros de paginación: `page` (0-indexed) y `pageSize` (máx. observado 50).

license: MIT
---

## Operaciones

### 1. Últimas convocatorias publicadas

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/convocatorias/ultimas
```

Devuelve las últimas ~50 convocatorias recibidas por la BDNS. Útil cuando el
usuario pregunta "¿qué subvenciones se han publicado hoy / esta semana?".

Cada item trae:
- `id` — id interno de la BDNS
- `numeroConvocatoria` — código BDNS público
- `descripcion` — título de la convocatoria
- `fechaRecepcion` — fecha de alta en el sistema
- `nivel1` / `nivel2` / `nivel3` — jerarquía organizativa
  (`ESTADO|AUTONOMICA|LOCAL|OTROS` → CCAA o entidad → órgano)
- `mrr` — booleano, si está financiada por el Mecanismo de Recuperación y
  Resiliencia (fondos Next Generation EU)

### 2. Búsqueda de convocatorias

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/convocatorias/busqueda
```

Parámetros principales (todos opcionales, combinables, query string):

- `descripcion` — texto libre en el título de la convocatoria
- `numConv` — número BDNS exacto (atajo para localizar una concreta)
- `fechaDesde` / `fechaHasta` — formato `dd/MM/yyyy`
- `tipoAdmin` — `C` (estatal), `A` (autonómica), `L` (local), `O` (otros)
- `mrr` — `true` / `false` (filtrar por fondos Next Generation)
- `pageSize` — tamaño de página (máx. 50)
- `page` — página (0-indexed)

Ejemplos:

```
# Convocatorias con "cultura" en el título
.../convocatorias/busqueda?descripcion=cultura&pageSize=10

# Una convocatoria concreta por número BDNS
.../convocatorias/busqueda?numConv=897038
```

### 3. Detalle completo de una convocatoria

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/convocatorias?numConv={numConv}
```

Devuelve un único objeto (no `Page`) con todos los detalles de la convocatoria:
órgano convocante, presupuesto total, instrumentos, sectores, regiones,
finalidad, bases reguladoras (texto + URL), fechas de solicitud, ayuda de
Estado asociada, fondos europeos, documentos, anuncios, etc.

Es el endpoint más rico — usarlo cuando el usuario pida "más información sobre
una convocatoria concreta".

### 4. Últimas concesiones publicadas

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/concesiones/busqueda?pageSize=50
```

No existe un endpoint `/concesiones/ultimas` equivalente al de convocatorias;
en su lugar, `/concesiones/busqueda` sin filtros devuelve las concesiones
ordenadas por fecha de alta descendente, que es lo más reciente publicado.

Cada item incluye:
- `codConcesion` — código BDNS de la concesión (formato `SB...`)
- `beneficiario` — NIF + razón social (o nombre anonimizado para particulares)
- `importe` / `ayudaEquivalente` — importes en euros
- `instrumento` — tipo (subvención, préstamo, etc.)
- `convocatoria` — título de la convocatoria de origen
- `numeroConvocatoria` / `idConvocatoria` — referencias cruzadas
- `urlBR` — URL del boletín oficial donde se publicó la base reguladora
- `fechaConcesion`, `fechaAlta`
- `nivel1` / `nivel2` / `nivel3` — jerarquía del organismo concedente

### 5. Búsqueda de concesiones

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/concesiones/busqueda
```

Parámetros opcionales:

- `descripcion` — texto libre en la descripción de la convocatoria de origen
- `nifBeneficiario` — NIF/CIF exacto del beneficiario (recomendado)
- `numConv` — limitar a las concesiones de una convocatoria concreta
- `fechaDesde` / `fechaHasta` — `dd/MM/yyyy`
- `importeDesde` / `importeHasta` — en euros
- `tipoAdmin` — `C` / `A` / `L` / `O`
- `pageSize` (máx. 50), `page`

> ⚠️ El parámetro `beneficiario` con texto libre **devuelve 400** — solo se
> admite `nifBeneficiario` con NIF/CIF exacto. Si el usuario solo da el nombre,
> hay que buscar primero su NIF (por ejemplo en INE, BORME o el propio BOE).

### 6. Ayudas de Estado

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/ayudasestado/busqueda
```

Concesiones acogidas a alguno de los reglamentos UE de exención por categorías
(RGEC, agrícolas, pesca, etc.). Cada item añade respecto a `concesiones`:

- `reglamento` — reglamento UE aplicable
- `objetivo` — finalidad concreta dentro del reglamento
- `tipoBeneficiario` — PYME, gran empresa, persona física, etc.
- `region` — código NUTS-3
- `sectores` — código y descripción CNAE
- `ayudaEstado` — código `SA.xxxxxx` de la Comisión Europea
- `urlAyudaEstado` — enlace al caso en `competition-cases.ec.europa.eu`

### 7. Ayudas de minimis

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/minimis/busqueda
```

Concesiones acogidas al régimen de minimis (Reg. UE 2023/2831, agrícola,
pesca). Estructura similar a `ayudasestado`, con `sectorActividad` (CNAE) y un
campo a nivel de respuesta:

- `acumuladoNacionalAgricola` — acumulado de minimis agrícola
- `acumuladoNacionalPesca` — acumulado de minimis pesca

### 8. Grandes beneficiarios

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/grandesbeneficiarios/busqueda
```

Beneficiarios con concesiones acumuladas grandes en un ejercicio. Parámetros:

- `ejercicio` — año (4 dígitos)
- `pageSize`, `page`

Cada item devuelve `beneficiario`, `ejercicio` y `ayudaETotal` (importe
acumulado del ejercicio).

### 9. Planes estratégicos de subvenciones

```
GET https://www.pap.hacienda.gob.es/bdnstrans/api/planesestrategicos/busqueda
```

Planes plurianuales de subvenciones aprobados por las administraciones.
Devuelve `descripcion`, `tipoPlan`, `vigenciaDesde`, `vigenciaHasta`,
`ambitos`.

license: MIT
---

## Fallback: datos.gob.es

Si la API directa de BDNS falla o el usuario quiere descargar datasets
agregados (CSV/XLS) con estadísticas históricas, usar el catálogo nacional:

```
GET https://datos.gob.es/apidata/catalog/dataset/title/subvenciones?_pageSize=10&_format=json
```

Estructura `result.items[].distribution[]` con `accessURL` reales (CSV, JSON,
XLS). Sigue el mismo patrón que la skill `aeat` o `datos-gob-es`. Útil para:

- Datasets autonómicos consolidados (Generalitat Valenciana, Canarias, etc.)
- Series históricas anuales que la API en vivo no expone
- Periodo medio de pago a beneficiarios

license: MIT
---

## Workflow recomendado

```
1. Identificar qué quiere el usuario:
   - Una convocatoria concreta → /convocatorias?numConv=XXX
   - Convocatorias por tema → /convocatorias/busqueda?descripcion=...
   - Lo último publicado → /convocatorias/ultimas o /concesiones/ultimas
   - Beneficiarios de una empresa → /concesiones/busqueda?nifBeneficiario=...
   - Análisis agregado → fallback datos.gob.es

2. Hacer la llamada con WebFetch (GET, sin auth, JSON nativo).

3. Procesar `content[]` y, si totalElements > pageSize, decidir si paginar
   más páginas o resumir.

4. Citar siempre el código BDNS (`numeroConvocatoria` o `codConcesion`) para
   que el usuario pueda verificar en https://www.infosubvenciones.es .
```

## Errores comunes

- **400 con `beneficiario=...`**: el parámetro de texto libre no existe; usar
  `nifBeneficiario` con NIF/CIF exacto.
- **404 sobre `/convocatoria/{id}`**: el endpoint correcto es
  `/convocatorias?numConv=XXX` (plural, query string, no path param).
- **`pageSize` > 50**: el servidor lo trunca silenciosamente a 50.
- **Datos parecen "del futuro"**: la BDNS publica convocatorias con fecha de
  recepción muy reciente; es normal ver hoy mismo. No confundir con error.
- **Beneficiarios con `***`**: las personas físicas se anonimizan parcialmente
  (LOPD) — el NIF aparece como `***1234**`. No es un bug.

## Cuándo NO usar esta skill

- Si el usuario pide el **texto literal** del extracto publicado en el BOE →
  **boe** (la BDNS solo da el resumen y la URL al boletín original).
- Si pregunta por **contratos públicos** (no subvenciones) → no es BDNS;
  redirigir al *Portal de Contratación del Sector Público* (PLACSP).
- Si pregunta por **fondos europeos NextGen como tal** (PRTR), la skill puede
  filtrar por `mrr=true`, pero el seguimiento global del PRTR está en otros
  portales (`fondoseuropeos.hacienda.gob.es`).
- Si el usuario quiere **estadísticas agregadas históricas** en CSV → usar el
  fallback `datos.gob.es` o la skill `datos-gob-es`.
