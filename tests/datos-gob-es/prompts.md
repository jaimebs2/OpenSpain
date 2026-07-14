# Tests manuales — datos-gob-es

## Test 1 — Descubrir datasets por título

**Pregunta**: "¿Qué datasets hay en datos.gob.es sobre contaminación del aire en Madrid?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/...` con un texto razonable (por ejemplo, "calidad aire" o "contaminación").
- Devuelve al menos 2 datasets con título real, publisher y al menos una `accessURL` de descarga.
- Indica el formato de cada distribución (CSV, JSON, etc.).

**Falla si**:
- Inventa nombres o URLs de datasets sin haber consultado la API.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con información genérica de memoria sobre calidad del aire.

---

## Test 2 — Encadenar con descarga real

**Pregunta**: "Encuéntrame el dataset del IPC del INE en datos.gob.es y dame la URL de descarga del CSV."

**Pasa si**:
- Busca por título "IPC" en `datos.gob.es/apidata`.
- Identifica un dataset cuyo publisher sea el INE.
- Extrae `distribution[].accessURL` y muestra al usuario una URL concreta (preferiblemente de formato CSV/JSON).
- Si no hay CSV directo, indica que la distribución apunta a una tabla del INE y sugiere usar la skill `ine` en su lugar.

**Falla si**:
- Devuelve la URL de la página HTML de datos.gob.es en vez de la `accessURL` real.
- Inventa una URL del estilo `https://www.ine.es/...` sin haberla obtenido del JSON.
