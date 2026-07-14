# Tests manuales — sanidad

## Test 1 — Catálogo Nacional de Hospitales

**Pregunta**: "¿Hay un listado oficial de todos los hospitales de España que pueda descargar?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/hospitales?_pageSize=...&_format=json`.
- Devuelve al menos 2 datasets con título real que contenga "hospital"
  (idealmente el *Catálogo Nacional de Hospitales*).
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV o XLS).
- Indica el formato (`text/csv`, `application/vnd.ms-excel`, …) y el tamaño
  si está disponible.

**Falla si**:
- Inventa URLs de `sanidad.gob.es` sin haberlas obtenido de la API de
  datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con una lista genérica de hospitales de memoria sin consultar la
  API.

---

## Test 2 — Mortalidad por causa

**Pregunta**: "Quiero las tasas de mortalidad por causa de muerte en España, ¿dónde están los datos abiertos?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/mortalidad?...&_format=json`.
- Identifica al menos un dataset relevante (por ejemplo, *Tasas de mortalidad
  por causas (lista reducida), sexo y edad* o *Tasa de Mortalidad Infantil
  por provincia*).
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Si el dataset pertenece al INE en vez de al Ministerio de Sanidad, lo
  indica y menciona que la skill **ine** podría ser más directa.

**Falla si**:
- Da tasas inventadas de memoria sin haber descargado ningún fichero.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la `accessURL`
  real de la distribución.
- Recomienda ir manualmente a la web del Ministerio de Sanidad sin intentar
  antes la API del catálogo.
