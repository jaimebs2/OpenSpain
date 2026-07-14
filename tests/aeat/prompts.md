# Tests manuales — aeat

## Test 1 — Estadísticas de IRPF por municipio

**Pregunta**: "¿Hay datos abiertos del IRPF por municipio que pueda descargar en CSV?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/IRPF?_pageSize=...&_format=json`.
- Devuelve al menos 2 datasets con título real que contenga "IRPF"
  (p.ej. "Base imponible del ahorro del IRPF. Municipios").
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV).
- Indica el formato (`text/csv`, `application/json`, …) y el tamaño si está
  disponible.

**Falla si**:
- Inventa URLs de `sede.agenciatributaria.gob.es` o `aeat.es` sin haberlas
  obtenido de la API de datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con datos generales del IRPF de memoria sin consultar la API.

---

## Test 2 — Recaudación tributaria

**Pregunta**: "Quiero ver la recaudación tributaria del Estado en los últimos años, ¿dónde encuentro los datos oficiales?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/recaudaci%C3%B3n?...&_format=json`
  (o equivalente URL-encoded).
- Identifica al menos un dataset relevante (por ejemplo, "Recaudación
  Tributaria del Estado acumulada. Comunidades autónomas y provincias por
  periodos").
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Si el dataset pertenece a una comunidad autónoma y no al Estado, lo
  advierte explícitamente.

**Falla si**:
- Da cifras inventadas de memoria sin haber descargado ningún fichero.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la
  `accessURL` real.
- Recomienda ir manualmente a la web de la AEAT sin intentar antes la API.
