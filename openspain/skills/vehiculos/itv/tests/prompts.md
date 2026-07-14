# Tests manuales — itv

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Cuándo pasar la ITV

**Prompt**: "Mi coche tiene 5 años, ¿cuándo me toca pasar la ITV?"

**Criterios de aceptación**:
- Indica que un turismo de 4 a 10 años debe pasar la ITV cada 2 años.
- Explica que la primera ITV se pasa a los 4 años desde la primera matriculación.
- No confunde la periodicidad con la de vehículos pesados o furgonetas.

---

## Test 2 — ITV desfavorable

**Prompt**: "He pasado la ITV y me ha salido desfavorable. ¿Qué hago ahora?"

**Criterios de aceptación**:
- Explica que debe reparar los defectos señalados en el informe.
- Indica el plazo de 2 meses para volver a la reinspección.
- Aclara que la reinspección solo revisa los defectos señalados.
- Distingue entre desfavorable (puede ir al taller conduciendo) y negativa (necesita grúa).

---

## Test 3 — Circular sin ITV

**Prompt**: "Se me ha pasado la fecha de la ITV, ¿qué me puede pasar si conduzco?"

**Criterios de aceptación**:
- Indica multa de 200 € por ITV caducada.
- Menciona la posible inmovilización si es desfavorable/negativa.
- Advierte sobre problemas con el seguro (derecho de repetición).
- No confunde con otras sanciones de tráfico.

---

## Test 4 — Documentación necesaria

**Prompt**: "Tengo cita para la ITV mañana. ¿Qué documentos tengo que llevar?"

**Criterios de aceptación**:
- Lista: permiso de circulación, ficha técnica, seguro en vigor, DNI/NIE.
- Menciona que no es obligatorio el recibo físico del seguro (se consulta FIVA).
- No pide documentos innecesarios.
