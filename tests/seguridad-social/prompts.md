# Tests manuales — seguridad-social

## Test 1 — Afiliación por régimen y CCAA

**Pregunta**: "¿Cuántos afiliados a la Seguridad Social hay por régimen de cotización y comunidad autónoma? ¿Hay un dataset oficial que pueda descargar?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/afiliaci%C3%B3n?_pageSize=...&_format=json`
  (o equivalente URL-encoded).
- Devuelve al menos 2 datasets cuyo título contenga "Afiliación" o
  "Afilliados" a la Seguridad Social (por ejemplo, *Afilliados a la
  Seguridad Social por régimen de cotización*, *Afiliaciones a último día
  del mes según regímenes de cotización y sexos*).
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV).
- Indica el formato (`text/csv`, `application/json`, `application/vnd.ms-excel`…)
  y el tamaño si está disponible.
- Distingue explícitamente entre **stock** (afiliados a último día del mes)
  y **flujo** (altas y bajas).

**Falla si**:
- Inventa URLs de `seg-social.es` o `sede.seg-social.gob.es` sin haberlas
  obtenido de la API de datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con cifras de afiliación de memoria sin consultar la API.
- Confunde el stock con el flujo de altas/bajas al presentar las cifras.

---

## Test 2 — Pensiones contributivas por tipo

**Pregunta**: "Quiero comparar las pensiones contributivas por tipo (jubilación, viudedad, incapacidad) y su importe medio. ¿Dónde encuentro los datos?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/pensiones?...&_format=json`.
- Identifica al menos un dataset relevante de pensiones contributivas (por
  ejemplo, *Pensiones contributivas e importes medios según tipos de
  pensión en Canarias por periodos* o *Pensiones contributivas por sexo.
  Municipios*).
- **Filtra explícitamente** los datasets de tipo "Esquema de conceptos…" o
  "Clasificación…" explicando que son vocabularios SDMX del ISTAC, no
  datos reales.
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Señala si el dataset está limitado territorialmente (p. ej. solo Canarias
  o solo País Vasco) y sugiere buscar el equivalente nacional si procede.

**Falla si**:
- Devuelve datasets en euskera o de metadatos ISTAC como si fueran datos
  nacionales.
- Inventa cifras de pensiones medias sin haber descargado ningún fichero.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la
  `accessURL` real de la distribución.
- Recomienda ir manualmente a `seg-social.es` sin intentar antes la API.
