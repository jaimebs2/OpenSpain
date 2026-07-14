---
name: jec
description: "Use when the user asks about Spanish election results — Congreso, Senado, municipales, autonómicas, europeas, referéndum, votos por partido, escaños, participación, o cualquier convocatoria electoral en España. Aunque la skill se llame 'jec', los resultados oficiales los publica el Ministerio del Interior en el portal Infoelectoral, no la Junta Electoral Central. Los datos se descargan como ZIPs por convocatoria con CSVs de ancho fijo. Como complemento, datos.gob.es indexa datasets electorales autonómicos y municipales. Triggers on: 'elecciones', 'resultados electorales', 'votos España', 'generales', 'autonómicas', 'municipales', 'europeas', 'referéndum', 'JEC', 'Junta Electoral', 'infoelectoral', 'escaños', 'participación electoral', 'escrutinio'."
license: MIT
---

# jec — Resultados electorales (Ministerio del Interior / Infoelectoral)

> **Importante**: aunque la skill se llame `jec`, la **Junta Electoral
> Central no publica los datos**. Los resultados oficiales los publica el
> **Ministerio del Interior** a través del portal Infoelectoral. La JEC solo
> organiza el proceso electoral.

Hay dos vías complementarias:

1. **Infoelectoral** (preferida para resultados nacionales): API JSON
   interna + ZIPs estáticos por convocatoria.
2. **datos.gob.es** (fallback / autonómicos / municipales): catálogo
   nacional con datasets electorales publicados por otros organismos.

## Vía 1 — Infoelectoral (preferida)

### Autenticación

La API JSON interna usa **HTTP Basic** con credenciales **públicas**
embebidas en el JavaScript del propio portal:

```
usuario:    apiInfoelectoral
contraseña: apiInfoelectoralPro
```

WebFetch debe enviar el header:
`Authorization: Basic YXBpSW5mb2VsZWN0b3JhbDphcGlJbmZvZWxlY3RvcmFsUHJv`

(Es `base64("apiInfoelectoral:apiInfoelectoralPro")`.)

Las URLs de los ZIPs (`/estaticos/...`) **no requieren autenticación**.

### Operaciones

#### 1. Listar tipos de convocatoria

```
GET https://infoelectoral.interior.gob.es/min/convocatorias/tipos/
```

Devuelve:

```json
{"cod":"200","data":[
  {"cod":"1","descripcion":"Referéndum"},
  {"cod":"2","descripcion":"Congreso"},
  {"cod":"3","descripcion":"Senado"},
  {"cod":"4","descripcion":"Municipales"},
  {"cod":"6","descripcion":"Cabildos"},
  {"cod":"7","descripcion":"Parlamento Europeo"}
]}
```

> Nota: las elecciones autonómicas no aparecen en este listado — las
> gestionan las propias comunidades autónomas. Para autonómicas usar la
> Vía 2 (datos.gob.es).

#### 2. Listar convocatorias de un tipo

```
GET https://infoelectoral.interior.gob.es/min/convocatorias?tipoConvocatoria={cod}
```

Ejemplo (`Congreso`, cod=2):

```json
{"cod":"200","data":[
  {"cod":"202307","fecha":"202307","descripcion":"Julio 2023","tipoConvocatoria":2,"ambitoTerritorio":"Nacional"},
  {"cod":"201911","fecha":"201911","descripcion":"Noviembre 2019","tipoConvocatoria":2,...},
  ...
  {"cod":"197706","fecha":"197706","descripcion":"Junio 1977",...}
]}
```

`cod` (= `fecha`) es `YYYYMM` y se usa luego como `idConvocatoria`.

#### 3. Listar ZIPs descargables de una convocatoria

```
GET https://infoelectoral.interior.gob.es/min/archivos/extraccion?tipoConvocatoria={tipo}&idConvocatoria={fecha}
```

Ejemplo (Congreso Julio 2023):

```json
{"cod":"200","data":[
  {"convocatoria":{...},
   "url":"https://infoelectoral.interior.gob.es/estaticos/docxl/apliextr/02202307_MESA.zip",
   "nombreDoc":"02202307_MESA.zip",
   "descripcion":"23 de Julio de 2023 (Mesa)"},
  {"...","url":".../02202307_MUNI.zip","descripcion":"... (Municipio)"},
  {"...","url":".../02202307_TOTA.zip","descripcion":"... (Superior al municipio)"}
]}
```

#### 4. Patrón de URL de los ZIPs

Las URLs siguen un patrón fijo y predecible (verificado para Congreso 2023
y Municipales 2023):

```
https://infoelectoral.interior.gob.es/estaticos/docxl/apliextr/{TT}{YYYYMM}_{AMBITO}.zip
```

- `TT` = código de tipo de convocatoria con cero a la izquierda (`02`,
  `03`, `04`, `06`, `07`, `01`).
- `YYYYMM` = año y mes de la convocatoria.
- `AMBITO` ∈ `MESA` (resultados por mesa electoral), `MUNI` (por
  municipio), `TOTA` (superior al municipio: provincia, CCAA, nacional).

> ⚠️ **No inventar URLs**: este patrón sirve para entender la nomenclatura,
> pero antes de descargar **siempre** confirmar la URL real consultando
> primero `/min/archivos/extraccion?...`. Algunas convocatorias antiguas no
> tienen los tres ámbitos.

#### 5. Descarga del ZIP

```
GET https://infoelectoral.interior.gob.es/estaticos/docxl/apliextr/{nombre}.zip
```

Devuelve `application/zip`. Tamaños típicos:

- `MESA`: varios MB (resultados detalle por mesa, fichero más grande).
- `MUNI`: cientos de KB a algunos MB.
- `TOTA`: decenas/cientos de KB.

### Estructura de los CSVs dentro del ZIP

Los ZIPs contienen ficheros **DAT** (texto plano) de **ancho fijo** (no
CSV separado por comas). El nombre de cada fichero codifica su contenido:

```
{TT}{NN}{YYYYMM}.DAT
```

Donde `NN` indica el tipo de fichero. Los principales son:

- `01` — Control (cabecera del fichero global)
- `02` — Identificación del proceso electoral
- `03` — Candidaturas (partidos / coaliciones)
- `04` — Candidatos (personas)
- `05` — Datos globales de la convocatoria a nivel nacional
- `06` — Datos globales de la convocatoria a nivel CCAA
- `07` — Datos globales a nivel provincia
- `08` — Datos globales a nivel municipio (>250 hab)
- `09` — Datos por candidatura a nivel municipio
- `10` — Datos a nivel mesa electoral (solo `_MESA.zip`)
- `11` — Datos a nivel municipio menor de 250 habitantes

> El número de ficheros y los layouts exactos están documentados en el
> documento oficial de metodología:
> `https://infoelectoral.interior.gob.es/export/sites/default/pdf/metodologia/Metodologia.pdf`
>
> **Antes de parsear ningún CSV**, descarga ese PDF y consulta el layout
> exacto del fichero que necesitas (cada campo tiene posición y longitud
> fijas). No intentes adivinarlos.

### Workflow recomendado (vía Infoelectoral)

```
1. GET /min/convocatorias/tipos/                    → elegir tipo
2. GET /min/convocatorias?tipoConvocatoria={cod}    → elegir fecha
3. GET /min/archivos/extraccion?tipoConvocatoria={tipo}&idConvocatoria={fecha}
4. WebFetch a la url del ZIP que interese (MESA / MUNI / TOTA)
5. (Opcional) descargar Metodologia.pdf para entender layouts
6. Descomprimir y parsear los DAT de ancho fijo
```

## Vía 2 — datos.gob.es (fallback / autonómicas / municipales)

Para elecciones autonómicas, datasets municipales históricos, o búsquedas
genéricas, usar el catálogo nacional:

```
GET https://datos.gob.es/apidata/catalog/dataset/title/elecciones?_pageSize=10&_format=json
```

Sigue el mismo patrón que la skill `datos-gob-es` / `aeat`:

- Devuelve `result.items[]` con `distribution[].accessURL`.
- `title` puede ser string o `[{_value, _lang}]` — si es lista, preferir
  `_lang == "es"`.
- `distribution` puede venir como objeto único o lista — tratar siempre
  como lista.
- Elegir formato: CSV > JSON > XLS > PDF.

Otras búsquedas útiles:

```
GET https://datos.gob.es/apidata/catalog/dataset/title/resultados%20electorales?_pageSize=10&_format=json
GET https://datos.gob.es/apidata/catalog/dataset/title/escrutinio?_pageSize=10&_format=json
```

> ⚠️ El parámetro `?q=` **no funciona** (devuelve 400). Hay que usar la
> ruta `/title/{texto}`.

## Errores comunes

- **401 en `/min/...`**: olvidaste el header `Authorization: Basic ...`.
- **404 al descargar ZIP**: el patrón inferido no existe — vuelve a
  consultar `/min/archivos/extraccion?...` para obtener la URL correcta.
- **Intentar parsear los DAT como CSV con comas**: son **ancho fijo**.
  Consulta el PDF de metodología.
- **Buscar autonómicas en Infoelectoral**: no están — el Ministerio del
  Interior no organiza autonómicas. Usar datos.gob.es o la skill regional.
- **Confundir JEC con Ministerio del Interior**: la JEC organiza/supervisa,
  el Ministerio publica los datos.

## Cuándo NO usar esta skill

- Si el usuario pregunta por una **norma electoral** (LOREG, etc.) → **boe**.
- Si pregunta por **debates parlamentarios** o composición actual del
  Congreso → **congreso** / **senado**.
- Si pregunta por **encuestas / sondeos / pre-electorales** (CIS, etc.) →
  no es competencia de Infoelectoral; redirigir a CIS o a **datos-gob-es**.
- Si pregunta por **datos demográficos / censo** → **ine**.
