# Prompts de prueba — DGT Accidentes de Tráfico

## Test 1 — Estadísticas anuales recientes

**Pregunta**: "¿Cuántos fallecidos hubo en accidentes de tráfico en España en 2024?"

**Pasa si**:
- El agente descarga o referencia el fichero TABLA_ACCIDENTES_24.XLSX de la DGT.
- Devuelve una cifra concreta de fallecidos (en 24h o en 30 días) extraída del fichero.
- Cita la fuente: DGT / datos.gob.es.

**Falla si**:
- Responde con una cifra de memoria sin consultar el fichero.
- Dice que no tiene acceso a esos datos o que no puede descargar ficheros.
- Confunde los datos de accidentes históricos con los de tiempo real (skill dgt-trafico).

---

## Test 2 — Comparación entre provincias o tipos de vía

**Pregunta**: "¿En qué tipo de vía ocurren más accidentes mortales en España? ¿Autopista, autovía o carretera convencional?"

**Pasa si**:
- El agente descarga el fichero de microdatos del año más reciente disponible.
- Analiza la columna de tipo de vía y la de fallecidos para dar una respuesta comparativa.
- Incluye cifras concretas por categoría de vía.

**Falla si**:
- Responde con una afirmación genérica ("las carreteras convencionales son más peligrosas") sin analizar los datos reales del fichero.
- No menciona el año al que corresponden los datos.
- No advierte al usuario antes de intentar descargar un fichero de ~24 MB.
