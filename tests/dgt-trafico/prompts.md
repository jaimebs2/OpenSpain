# Tests manuales — skill DGT Tráfico

Pruebas para verificar que el agente usa correctamente la skill `dgt-trafico` en lugar de responder de memoria o con información inventada.

---

## Test 1 — Incidencias en una carretera específica

**Pregunta**: "¿Hay alguna incidencia o retención ahora mismo en la A-6?"

**Pasa si**:
- El agente llama al endpoint `https://infocar.dgt.es/datex2/v3/dgt/SituationPublication/incidencias.xml`.
- Filtra el XML resultante por la carretera A-6.
- Si hay incidencias activas, las lista con tipo (accidente, obras, retención...) y descripción.
- Si no hay incidencias activas para esa vía, lo indica explícitamente.
- Cita a la DGT como fuente y aclara que los datos son en tiempo real.

**Falla si**:
- Responde con información genérica o inventada sin hacer ninguna llamada HTTP.
- No filtra por la carretera A-6 y devuelve todas las incidencias sin distinción.
- Dice que no puede consultar datos en tiempo real sin intentarlo.

---

## Test 2 — Estado general del tráfico en carretera

**Pregunta**: "¿Cómo está el tráfico en las carreteras de salida de Madrid este momento? ¿Hay obras o accidentes?"

**Pasa si**:
- El agente llama al endpoint de incidencias de la DGT.
- Identifica las principales carreteras de salida de Madrid (A-1, A-2, A-3, A-4, A-5, A-6, M-30/M-40/M-50 o similar) y filtra las incidencias relevantes.
- Lista las incidencias activas con carretera, tipo y descripción, o indica que no hay incidencias registradas.
- Menciona que la cobertura no incluye Euskadi ni Cataluña si fuera relevante.
- Cita la DGT como fuente.

**Falla si**:
- Responde sin consultar la API, basándose en conocimiento estático.
- Confunde las siglas de las autovías o inventa nombres de incidentes.
- No indica la fuente de los datos.
