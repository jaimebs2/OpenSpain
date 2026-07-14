# Tests manuales — jec

## Test 1 — Resultados Congreso julio 2023

**Pregunta**: "¿Dónde puedo descargar los resultados oficiales por mesa de
las elecciones generales al Congreso del 23 de julio de 2023?"

**Pasa si**:
- Llama a `https://infoelectoral.interior.gob.es/min/convocatorias/tipos/`
  con header `Authorization: Basic ...` (credenciales
  `apiInfoelectoral:apiInfoelectoralPro`).
- Identifica `Congreso` (cod=2) y luego llama a
  `/min/convocatorias?tipoConvocatoria=2` para localizar la convocatoria
  `202307` (Julio 2023).
- Llama a
  `/min/archivos/extraccion?tipoConvocatoria=2&idConvocatoria=202307` y
  obtiene la `url` real del fichero `02202307_MESA.zip`.
- Devuelve al usuario la URL real del ZIP (no una URL inventada).
- Aclara que el contenido son ficheros DAT de **ancho fijo** (no CSV con
  comas) y enlaza al PDF de metodología oficial para los layouts.

**Falla si**:
- Inventa URLs como `infoelectoral.interior.gob.es/datos/2023/...` sin
  haberlas confirmado vía la API `/min/archivos/extraccion`.
- Asume que los DAT son CSVs separados por comas e intenta parsearlos
  directamente sin consultar la metodología.
- Confunde el Ministerio del Interior con la JEC y dice que los datos los
  publica la Junta Electoral Central.
- Olvida el header `Authorization` y obtiene 401.

---

## Test 2 — Elecciones autonómicas vía datos.gob.es

**Pregunta**: "¿Hay datos abiertos de elecciones autonómicas o municipales
en algún catálogo público?"

**Pasa si**:
- Reconoce que las elecciones autonómicas **no están en Infoelectoral** (el
  Ministerio del Interior solo publica las que organiza: Congreso, Senado,
  Municipales, Cabildos, Europeas, Referéndum).
- Cae a la Vía 2 y llama a
  `https://datos.gob.es/apidata/catalog/dataset/title/elecciones?_pageSize=...&_format=json`.
- Devuelve al menos 2 datasets reales con sus `distribution[].accessURL`,
  indicando publisher (ayuntamiento / CCAA) y formato (CSV / JSON / XLS).
- Aclara qué administración publica cada dataset.

**Falla si**:
- Insiste en buscar elecciones autonómicas en Infoelectoral y dice que no
  hay datos.
- Usa el parámetro `?q=` en datos.gob.es (devuelve 400) en vez de la ruta
  `/title/`.
- Da cifras electorales de memoria sin haber consultado ninguna API.
