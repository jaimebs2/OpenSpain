# Tests manuales — sepe

## Test 1 — Paro registrado por provincia

**Pregunta**: "¿Cuántas personas en paro registrado hay por provincia en España? ¿Hay un CSV oficial del SEPE que pueda descargar?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/paro%20registrado?_pageSize=...&_format=json`
  (o equivalente URL-encoded).
- Devuelve al menos 2 datasets cuyo título empiece por "Paro registrado"
  (p.ej. "Paro registrado según sexos y grupos de edad. Provincias de España
  por meses").
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV).
- Indica el formato (`text/csv`, `application/json`, …) y el tamaño si está
  disponible.
- **Menciona explícitamente** la anonimización del SEPE: los valores entre
  1 y 4 aparecen como `<5` en los CSV.

**Falla si**:
- Inventa URLs de `sepe.es` o `sepe.gob.es` sin haberlas obtenido de la API
  de datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con cifras de paro de memoria sin consultar la API.
- Omite el aviso de anonimización `<5` al mostrar datos desagregados.

---

## Test 2 — Contratos registrados por sexo y ocupación

**Pregunta**: "Quiero analizar los contratos registrados por grandes grupos de ocupación y sexo en España. ¿Dónde encuentro los datos?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/contratos?...&_format=json`.
- Identifica al menos un dataset relevante del SEPE (por ejemplo, "Contratos
  registrados. Según grandes grupos de ocupación y sexo. Por provincias" o
  "Contratos Registrados por municipios").
- Filtra explícitamente los datasets ruido ("Contratos menores", "Contratos
  del Senado") indicando que son de contratación pública, no del mercado
  laboral.
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Advierte de la anonimización `<5` si sugiere bajar a nivel municipio.

**Falla si**:
- Devuelve datasets de contratación administrativa del Senado sin filtrar.
- Inventa cifras o URLs sin haber descargado ningún fichero.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la
  `accessURL` real de la distribución.
- Recomienda ir manualmente a la web del SEPE sin intentar antes la API.
