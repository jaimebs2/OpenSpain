# Tests manuales — skill CNMC

Pruebas para verificar que el agente usa correctamente la skill `cnmc` en lugar de responder de memoria.

## Test 1 — Búsqueda de datasets de telecomunicaciones

**Pregunta**: "¿Qué datos tiene la CNMC sobre telecomunicaciones? Dame un listado de los datasets disponibles."

**Pasa si**:
- El agente llama a `https://catalogodatos.cnmc.es/api/3/action/package_search` con `q=telecomunicaciones` o `fq=groups:grupo_telco`.
- Devuelve títulos reales de datasets (p. ej. "Telecomunicaciones Mensual") con sus IDs o nombres.
- Indica el número total de datasets encontrados.

**Falla si**:
- Responde con información genérica sobre la CNMC sin consultar el portal CKAN.
- Inventa nombres de datasets o URLs que no existen.
- No menciona ningún identificador o título real de dataset.

---

## Test 2 — Obtener URL de descarga de datos del mercado eléctrico

**Pregunta**: "Necesito descargar datos del mercado minorista de electricidad de la CNMC. ¿Qué datasets hay disponibles y cómo los descargo?"

**Pasa si**:
- El agente llama a `package_search` con un término como "electricidad" o filtra por `grupo_energia_electrica`.
- Para al menos un dataset, hace una segunda llamada a `package_show` para obtener los recursos.
- Proporciona una URL de descarga real en formato CSV o JSON del tipo `https://catalogodatos.cnmc.es/dataset/.../download/...` o `https://catalogodatos.cnmc.es/datastore/dump/...`.
- Indica el formato del archivo (CSV, JSON, XML).

**Falla si**:
- Responde de memoria con datos genéricos sobre el mercado eléctrico sin consultar la API.
- No proporciona ninguna URL de descarga real.
- Inventa URLs que no siguen el patrón del portal CKAN de la CNMC.
