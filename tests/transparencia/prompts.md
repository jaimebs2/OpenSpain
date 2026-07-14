# Tests manuales — skill transparencia

## Test 1 — Contratos del sector público (PLACSP)

**Pregunta**: "¿Qué datasets hay publicados sobre contratos mayores del sector público en España? Dame alguno reciente de 2024."

**Pasa si**: el agente realiza una consulta a `datos.gob.es` con `title/PLACSP` o `title/contratos%20mayores`, devuelve títulos reales como "Contratos Mayores. 2024 - (PLACSP)" o similares, menciona el publisher del dataset (ayuntamiento, universidad, ministerio…) y, si se le pide descargar, usa una `accessURL` obtenida de la respuesta del catálogo.

**Falla si**: inventa URLs de `transparencia.gob.es` o `contrataciondelestado.es`, responde con información genérica de memoria, o confunde estos contratos con los "Contratos registrados" del SEPE (que son contratos laborales, no contratación pública).

## Test 2 — Retribuciones y nombramientos de altos cargos

**Pregunta**: "¿Hay datos abiertos sobre retribuciones o nombramientos de altos cargos en España?"

**Pasa si**: el agente consulta `datos.gob.es` con `title/altos%20cargos`, `title/nombramientos` o `title/retribuciones`, devuelve datasets reales como "Nombramientos y ceses de Altos Cargos" o "Retribuciones altos cargos", indica claramente qué publisher (AGE, CCAA, ayuntamiento) ha publicado cada uno y filtra los resultados irrelevantes (p. ej. los titulados sólo en euskera cuando el usuario ha preguntado en castellano).

**Falla si**: responde que "el Portal de Transparencia no tiene API", no intenta descubrir datasets en `datos.gob.es`, o da cifras concretas sin descargar ninguna distribución real.
