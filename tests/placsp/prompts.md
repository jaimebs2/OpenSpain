# Tests manuales — placsp

## Test 1 — Contratos mayores de un año concreto

**Pregunta**: "¿Puedes darme los contratos mayores publicados en PLACSP durante 2024?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/PLACSP?_pageSize=...&_format=json`
  o `.../title/contratos%20mayores?...&_format=json`.
- Devuelve al menos 1 dataset cuyo título contenga "Contratos Mayores. 2024"
  (o equivalente con el año pedido).
- Extrae `distribution[].accessURL` y muestra una URL concreta de descarga
  (preferentemente CSV o JSON).
- Indica el formato (`text/csv`, `application/json`, …) y, si está
  disponible, el `byteSize` y el `publisher`.

**Falla si**:
- Inventa URLs de `contrataciondelestado.es` sin haberlas obtenido de la
  API de datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con cifras de memoria sobre contratos públicos sin descargar
  ningún dataset.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la
  `accessURL` real.

---

## Test 2 — Licitaciones activas

**Pregunta**: "Quiero ver licitaciones publicadas por organismos del Estado, ¿hay algún dataset abierto con eso?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/licitaciones?...&_format=json`.
- Identifica al menos un dataset relevante (por ejemplo, "Licitaciones
  Publicadas 2022", "Anuncios licitaciones" o
  "Licitaciones de los organismos públicos del proyecto NextProcurement").
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Si el dataset pertenece a una CCAA, ayuntamiento o universidad concreta
  (no al Estado), lo advierte explícitamente leyendo el `publisher`.
- Si el formato disponible es ATOM mensual muy pesado, avisa al usuario
  antes de intentar descargarlo.

**Falla si**:
- Recomienda ir manualmente a `contrataciondelestado.es` sin intentar
  antes la API de datos.gob.es.
- Confunde "licitaciones" del sector público con "contratos registrados"
  del SEPE.
- Usa esta skill cuando el usuario en realidad pregunta por subvenciones,
  altos cargos o agendas (debería redirigir a `transparencia`).
