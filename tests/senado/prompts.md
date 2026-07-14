# Tests manuales — skill Senado

Pruebas para verificar que el agente usa correctamente la skill `senado` en lugar de responder de memoria.

## Test 1 — Composición del hemiciclo

**Pregunta**: "¿Cuántos senadores tiene actualmente cada grupo parlamentario en el Senado y quién ocupa el escaño número 1?"

**Pasa si**:
- El agente hace `WebFetch` GET a `https://www.senado.es/web/ficopendataservlet?tipoFich=4&legis=15` (grupos parlamentarios) y/o a `https://www.senado.es/web/ficopendataservlet?tipoFich=20` (composición del hemiciclo).
- Devuelve los grupos reales (GPP, GPS, etc.) con su `<total>` de senadores extraído del XML.
- Para el escaño 1, identifica al senador combinando `<nombre>` + `<apellidos>` del XML de composición del hemiciclo.
- Cita la fecha de informe (`fecha_informe`) o la legislatura (15) como contexto temporal.

**Falla si**:
- Recita números o nombres de memoria sin tocar las URLs del Senado.
- Inventa siglas de grupos que no aparecen en el XML.
- Devuelve datos de otra legislatura sin avisar.
- Confunde el Senado con el Congreso de los Diputados.

---

## Test 2 — Sesiones plenarias e iniciativas legislativas

**Pregunta**: "Dame las últimas sesiones plenarias del Senado de la legislatura actual y dime cuántas iniciativas legislativas hay abiertas."

**Pasa si**:
- El agente llama a `https://www.senado.es/web/ficopendataservlet?tipoFich=14&legis=15` y lista al menos 3 `<sesionPlenaria>` reales con su `<sesionNumero>` y `<sesionFechaInicio>`.
- Llama también a `https://www.senado.es/web/ficopendataservlet?tipoFich=9&legis=15` y cuenta o lista las `<iniciativa>` con su `<tipoExpediente>/<numeroExpediente>` y `<titulo>`.
- Si el usuario lo pide, ofrece descargar el XML de votaciones de una sesión usando `<fichUrlVotaciones>` (anteponiendo `https://www.senado.es` a la ruta relativa).

**Falla si**:
- Devuelve fechas o números de sesión inventados.
- Cita iniciativas con identificadores que no existen en el XML real.
- No distingue entre sesiones plenarias e iniciativas legislativas (son endpoints distintos).
- Intenta usar una API REST inexistente en lugar de descargar el XML directo.
