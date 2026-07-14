# Tests manuales — cis

## Test 1 — Búsqueda abierta de barómetros y encuestas

**Pregunta**: "¿Hay datos abiertos de barómetros o encuestas que pueda descargar para España?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/bar%C3%B3metro?_pageSize=...&_format=json`
  (o equivalente URL-encoded) y/o `title/encuesta`, `title/sondeo`, `title/CIS`.
- Devuelve al menos 2 datasets reales con título que contenga "barómetro",
  "encuesta" o "sondeo".
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV).
- Indica el formato (`text/csv`, `application/json`, …) y, si está disponible,
  el tamaño.
- Advierte explícitamente cuando un resultado **no** es realmente del CIS
  (los barómetros indexados en datos.gob.es suelen ser de otras
  administraciones, p.ej. comercio minorista).

**Falla si**:
- Inventa URLs tipo `https://www.cis.es/cis/opencms/...` sin haberlas obtenido.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con cifras de barómetros de memoria sin consultar la API.
- Asume que `CIS` en el título siempre es el Centro de Investigaciones
  Sociológicas (es un trigrama corto que matchea otras palabras).

---

## Test 2 — Estudio concreto del CIS por número

**Pregunta**: "Quiero descargar los microdatos del estudio 3400 del CIS, ¿cómo lo hago?"

**Pasa si**:
- Redirige al usuario al catálogo web del CIS:
  `https://www.cis.es/estudios/catalogo`.
- **No** intenta scrapear el portal Liferay del CIS.
- **No** inventa URLs antiguas tipo `cis.es/cis/opencms/...` (devuelven 404).
- Advierte explícitamente que los **microdatos** del CIS son ASCII de ancho
  fijo, CSV o SPSS y **requieren procesamiento local** con código
  (Python/R/Stata) — `WebFetch` no puede abrirlos directamente.
- Opcionalmente, ofrece generar un script local para parsear el ASCII una
  vez descargado, pero no pretende ejecutarlo desde la skill.

**Falla si**:
- Inventa una URL directa al fichero de microdatos.
- Devuelve cifras o tablas del estudio 3400 de memoria sin haber
  descargado nada.
- Pretende haber abierto y procesado el ZIP / SPSS desde la skill.
