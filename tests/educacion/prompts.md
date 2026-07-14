# Tests manuales — educacion

## Test 1 — Directorio de centros educativos

**Pregunta**: "¿Hay un listado oficial de centros educativos en España que pueda descargar?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/centros%20educativos?_pageSize=...&_format=json`.
- Devuelve al menos 2 datasets con título real que contenga "centros
  educativos" o una clasificación relacionada (p.ej. "Clasificación de
  tipos de centros educativos").
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV).
- Indica el formato (`text/csv`, `application/json`, …) y, si el dataset
  es de una consejería autonómica, lo advierte explícitamente.

**Falla si**:
- Inventa URLs de `educacionfpydeportes.gob.es` o `educacionyfp.gob.es`
  sin haberlas obtenido de la API de datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con información genérica sobre centros educativos de memoria
  sin consultar la API.

---

## Test 2 — Becas y ayudas al estudio

**Pregunta**: "Quiero datos oficiales de becas y ayudas al estudio en España, ¿dónde los encuentro?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/becas?_pageSize=...&_format=json`.
- Identifica al menos un dataset relevante (por ejemplo, "Enseñanzas
  postobligatorias no universitarias. Becas y ayudas por tipo de
  beca/ayuda, administración educativa financiadora y provincia del
  becario" o "Número de beneficiarios de becas generales de la AGE y del
  País Vasco").
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Si el dataset solo cubre una comunidad autónoma, lo aclara.

**Falla si**:
- Da cifras inventadas de memoria sin haber descargado ningún fichero.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la
  `accessURL` real.
- Recomienda ir manualmente a la sede electrónica del Ministerio de
  Educación sin intentar antes la API.
