# Tests manuales — congreso

## Test 1 — Diputados activos por grupo parlamentario

**Pregunta**: «¿Cuántos diputados tiene actualmente cada grupo parlamentario en el Congreso?»

**Pasa si**:
- El agente hace `WebFetch` a `https://www.congreso.es/es/opendata/diputados`, extrae la URL JSON real cuyo nombre empieza por `DiputadosActivos__` y luego la descarga.
- Devuelve un recuento por `GRUPOPARLAMENTARIO` con totales coherentes (la suma debe rondar 350).
- Cita al menos 3 grupos por su nombre real (Popular, Socialista, VOX, SUMAR, etc.).

**Falla si**:
- Inventa una URL con timestamp sin parsear primero la página índice.
- Responde con cifras genéricas «de memoria» sin ejecutar `WebFetch`.
- Devuelve un total muy distinto de 350 sin justificar.

## Test 2 — Voto individual en una votación reciente

**Pregunta**: «Coge una votación reciente del Pleno del Congreso y dime cuántos diputados del PSOE votaron a favor.»

**Pasa si**:
- El agente hace `WebFetch` a `https://www.congreso.es/es/opendata/votaciones`, identifica una sesión reciente y extrae la URL JSON de una `Votacion<NNN>/VOT_<TS>.json` real.
- Tras descargar ese JSON, filtra `votaciones[]` por `grupo == "GS"` y `voto == "Si"` (o equivalente) y devuelve un número concreto.
- Cita el `titulo` y la `fecha` de la votación tomados del bloque `informacion`.

**Falla si**:
- Inventa el path de la votación (legislatura/sesión/fecha) sin haber visto enlaces reales en la página índice.
- Confunde `grupo` (sigla parlamentaria GS/GP/...) con `FORMACIONELECTORAL` del fichero de diputados.
- Responde sin descargar ningún JSON o sin citar los totales del bloque `totales`.
