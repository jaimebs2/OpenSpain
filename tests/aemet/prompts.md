# Tests manuales — skill AEMET

Pruebas para verificar que el agente usa correctamente la skill `aemet` en lugar de responder de memoria o de datos cacheados.

> Requisito previo: exportar `AEMET_API_KEY` antes de lanzar al agente.

## Test 1 — Predicción diaria por municipio

**Pregunta**: "¿Qué tiempo va a hacer en Madrid los próximos 3 días según AEMET? Dame máximas, mínimas y probabilidad de lluvia."

**Pasa si**:
- El agente identifica el código INE `28079` para Madrid.
- Hace el **primer salto** a `https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/28079?api_key=...` usando la clave de la variable de entorno `AEMET_API_KEY`.
- Extrae el campo `datos` de la respuesta y hace un **segundo GET** a esa URL temporal.
- Lista las temperaturas máximas y mínimas por día junto con la probabilidad de precipitación y el estado del cielo, citando a AEMET como fuente.

**Falla si**:
- Responde con temperaturas genéricas o inventadas sin llamar a la API.
- Se queda en el primer salto y devuelve literalmente el objeto `{"datos": "...", "metadatos": "..."}` al usuario.
- Pide la API key al usuario en vez de leerla de `AEMET_API_KEY`.
- Inventa un código de municipio distinto al INE.

---

## Test 2 — Observación actual de estación

**Pregunta**: "¿Qué temperatura hace ahora mismo en la estación de Madrid-Retiro (3195)? Dame también humedad y viento."

**Pasa si**:
- El agente llama a `https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/3195?api_key=...` (primer salto).
- Sigue el segundo salto a la URL de `datos`.
- Devuelve la observación más reciente (`fint`, `ta`, `hr`, `vv`, `dv`) indicando la hora del dato y la estación.
- Cita a AEMET y aclara que es una observación convencional, no una medición en tiempo real estricto.

**Falla si**:
- Omite el doble salto o inventa valores.
- Se equivoca en el `idema` de la estación.
- No indica la hora (`fint`) del dato mostrado.
- Si `AEMET_API_KEY` no estuviera definida, falla si intenta la llamada igualmente en lugar de avisar al usuario.

---

## Test 3 — Avisos meteorológicos CAP

**Pregunta**: "¿Hay algún aviso meteorológico activo de AEMET para la Comunidad de Madrid? Dame el nivel y el fenómeno."

**Pasa si**:
- El agente llama a `https://opendata.aemet.es/opendata/api/avisos_cmas/ultimoelaborado/area/77` (77 = Madrid) usando la `AEMET_API_KEY` del entorno.
- Sigue el **doble salto** al campo `datos` para descargar el contenido real (TAR/XML en formato CAP).
- Si hay avisos activos, los presenta indicando nivel (verde/amarillo/naranja/rojo), fenómeno (viento, lluvia, nieve…) y vigencia.
- Si no hay avisos activos para el área, lo indica explícitamente en lugar de inventarlos.
- Cita a AEMET como fuente.

**Falla si**:
- Responde con avisos genéricos sin llamar a la API.
- Usa un código de área distinto al del CCAA correspondiente (p. ej. provincia INE en lugar del código AEMET de CCAA).
- Omite el doble salto y devuelve el objeto `{"datos": "...", "metadatos": "..."}` al usuario.
- Confunde predicción con aviso meteorológico (son productos distintos).
