# Tests manuales — skill Aena

Pruebas para verificar que el agente usa correctamente la skill `aena` en lugar de responder de memoria.

## Test 1 — Ranking de aeropuertos por pasajeros

**Pregunta**: "¿Cuáles fueron los 5 aeropuertos españoles con más pasajeros en 2024?"

**Pasa si**:
- El agente descarga el informe anual 2024 desde `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576871820226&ssbinary=true`
- Extrae datos reales del XLS y lista los 5 aeropuertos con sus cifras de pasajeros.
- Los aeropuertos top coinciden con los esperados (Madrid, Barcelona, Palma, Málaga, Gran Canaria aproximadamente).

**Falla si**:
- Responde de memoria con cifras genéricas sin descargar ningún fichero.
- Cita aeropuertos incorrectos o en orden incorrecto sin soporte de datos.
- No descarga el XLS o devuelve error sin intentar la URL alternativa.

---

## Test 2 — Estadísticas mensuales recientes

**Pregunta**: "¿Cuántos pasajeros pasaron por el aeropuerto de Barcelona en febrero de 2026?"

**Pasa si**:
- El agente descarga el informe mensual de febrero 2026 desde `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576873491064&ssbinary=true`
- Extrae la cifra de pasajeros para Barcelona (BCN / El Prat) del XLS.
- Devuelve un número concreto con la fuente indicada (informe mensual febrero 2026 de Aena).

**Falla si**:
- Responde con estimaciones de memoria sin consultar el XLS.
- No identifica la URL del informe mensual de febrero 2026.
- Confunde el aeropuerto de Barcelona con otro.
