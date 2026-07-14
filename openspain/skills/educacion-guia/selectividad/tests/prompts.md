# Tests manuales — selectividad

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Cálculo de la nota de acceso

**Prompt**: "¿Cómo se calcula la nota de Selectividad? Tengo un 8,5 de media de Bachillerato."

**Criterios de aceptación**:
- Explica la fórmula: 0,6 × media Bachillerato + 0,4 × media fase obligatoria.
- Con el dato del 8,5, indica que aporta 5,1 puntos (0,6 × 8,5) y que la fase obligatoria aportará hasta 4 puntos.
- Menciona que el máximo de la nota de acceso es 10.
- Distingue la nota de acceso (sobre 10) de la nota de admisión (sobre 14).

---

## Test 2 — Notas de corte

**Prompt**: "¿Qué nota necesito para entrar en Medicina?"

**Criterios de aceptación**:
- Indica que la nota de corte de Medicina suele estar entre 13,0 y 13,5 (orientativo).
- Explica que la nota de corte varía cada año y entre universidades.
- Aclara que se necesita la nota de admisión (sobre 14), no solo la de acceso.
- Menciona las ponderaciones de la fase voluntaria (Biología y Química suelen ponderar 0,2 para Medicina).
- Sugiere consultar el portal de la universidad concreta para datos actualizados.

---

## Test 3 — Diferencias entre comunidades

**Prompt**: "¿Puedo hacer la Selectividad en Andalucía y pedir plaza en una universidad de Barcelona?"

**Criterios de aceptación**:
- Confirma que sí, existe distrito único (movilidad entre CCAA).
- Explica que las ponderaciones se aplican según la tabla de la universidad de destino.
- Puede mencionar que en Cataluña la prueba se llama PAU y hay examen de lengua cooficial, pero eso no afecta al estudiante que viene de otra CCAA.

---

## Test 4 — Redireccionamiento a becas

**Prompt**: "¿Me pueden dar una beca para la universidad? ¿Cuáles son los requisitos?"

**Criterios de aceptación**:
- Indica que la pregunta es sobre becas, no sobre Selectividad.
- Redirige a la skill **becas-mec**.
- No intenta responder con información de Selectividad.
