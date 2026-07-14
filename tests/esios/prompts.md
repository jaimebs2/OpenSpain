# Tests manuales — skill ESIOS

Pruebas para verificar que el agente usa correctamente la skill `esios` en lugar de responder de memoria o de datos cacheados.

> Requisito previo para el Test 1: exportar `ESIOS_TOKEN` antes de lanzar al agente.
> El Test 2 funciona sin token (usa el indicador 10211, público).

---

## Test 1 — Precio PVPC de hoy hora a hora

**Pregunta**: "¿Cuánto cuesta la electricidad en tarifa PVPC hoy, hora a hora? Dime las horas más baratas y más caras."

**Pasa si**:
- El agente lee `ESIOS_TOKEN` del entorno (no la pide al usuario).
- Llama a `https://api.esios.ree.es/indicators/1001` con los parámetros `start_date` y `end_date` del día actual en formato ISO 8601 (`YYYY-MM-DDT00:00:00` / `YYYY-MM-DDT23:59:59`).
- Incluye la cabecera `Authorization: Token token=<ESIOS_TOKEN>`.
- Devuelve una lista de 24 valores horarios con hora y precio en €/MWh (o ct€/kWh).
- Identifica correctamente las horas más baratas y más caras del día.
- Cita a ESIOS / Red Eléctrica de España como fuente.

**Falla si**:
- Responde con precios inventados o genéricos sin llamar a la API.
- Pide el token al usuario en vez de leerlo de `ESIOS_TOKEN`.
- No incluye la cabecera de autenticación y obtiene un 403.
- Devuelve menos de 20 horas o no menciona las más baratas/caras.
- Si `ESIOS_TOKEN` no está definida, falla si intenta la llamada igualmente en lugar de avisar al usuario con la URL para obtener el token.

---

## Test 2 — Precio del mercado eléctrico mayorista comparando España y Francia

**Pregunta**: "¿A cuánto está el mercado eléctrico mayorista hoy en España y en Francia? ¿Cuál está más caro?"

**Pasa si**:
- El agente llama a `https://api.esios.ree.es/indicators/600` con los parámetros de fecha del día actual.
- No necesita token para este indicador (funciona sin `ESIOS_TOKEN`).
- Filtra los valores por `geo_name` para mostrar datos de España y Francia por separado.
- Compara los precios y concluye cuál es más alto en el momento consultado o en media diaria.
- Indica las unidades (€/MWh) y cita la fuente (ESIOS / REE).

**Falla si**:
- Responde con precios inventados o de memoria sin consultar la API.
- Confunde el indicador 600 (SPOT mercado) con el 1001 (PVPC consumidor).
- No distingue entre los valores de España y Francia en la respuesta.
- No menciona las unidades del precio.
