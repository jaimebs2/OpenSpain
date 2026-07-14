# Tests manuales — skill BOE

Pruebas para verificar que el agente usa correctamente la skill `boe` en lugar de responder de memoria.

## Test 1 — Sumario diario

**Pregunta**: "¿Qué se ha publicado hoy en el BOE? Dame los titulares más importantes de la sección I."

**Pasa si**:
- El agente consulta `https://www.boe.es/datosabiertos/api/boe/sumario/{YYYYMMDD}` con `Accept: application/json`.
- Devuelve disposiciones reales con su identificador (`BOE-A-2026-XXXX`), departamento y título.
- Si hoy no hay BOE (domingo/festivo), lo indica y prueba con la fecha del último día laborable.

**Falla si**:
- Responde con información genérica o inventada sin llamar a la API.
- Usa POST en lugar de GET (devolvería 403).
- Omite el header `Accept: application/json`.
- Inventa identificadores con formato `BOE-A-...`.

---

## Test 2 — Índice de ley consolidada (Constitución)

**Pregunta**: "Dame el índice de la Constitución Española y léeme el texto del Artículo 14."

**Pasa si**:
- El agente identifica `BOE-A-1978-31229` como el ID de la Constitución.
- Llama a `https://www.boe.es/datosabiertos/api/legislacion-consolidada/id/BOE-A-1978-31229/texto/indice` con `Accept: application/json`.
- Lista bloques reales del índice (preámbulo, títulos, artículos) con sus títulos legibles.
- Para el Artículo 14, hace una segunda llamada GET a la `url` que devuelve ese bloque del índice y muestra el texto literal sobre el principio de igualdad ante la ley.

**Falla si**:
- Recita la Constitución de memoria sin tocar la API.
- Inventa el ID de la norma o usa un ID erróneo.
- No hace la segunda llamada para obtener el texto del artículo y se limita al título del bloque.
