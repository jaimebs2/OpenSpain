# Tests manuales — permiso-internacional

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Necesidad del PIC

**Prompt**: "Voy a conducir en Estados Unidos este verano. ¿Necesito algún permiso especial?"

**Criterios de aceptación**:
- Recomienda obtener el Permiso Internacional de Conducción (PIC).
- Indica que el PIC es un complemento al permiso español (hay que llevar ambos).
- Explica que se solicita presencialmente en una Jefatura de Tráfico con cita previa.
- Menciona la validez de 1 año y el coste (~10,51 €).
- No confunde con el canje de permisos ni con trámites online.

---

## Test 2 — Conducir en la UE

**Prompt**: "¿Necesito permiso internacional para conducir en Francia e Italia?"

**Criterios de aceptación**:
- Indica claramente que NO es necesario para países de la UE/EEE.
- Explica que el permiso español es directamente válido (Directiva 2006/126/CE).
- No recomienda tramitar el PIC innecesariamente.

---

## Test 3 — Cómo solicitarlo

**Prompt**: "¿Cómo pido el carnet internacional de conducir? ¿Se puede hacer por internet?"

**Criterios de aceptación**:
- Indica que NO se puede solicitar online.
- Explica que es presencial en Jefatura Provincial de Tráfico con cita previa.
- Lista la documentación: DNI/pasaporte, permiso español, foto, tasa.
- Indica que se expide en el acto.
- Proporciona la URL de cita previa de la DGT.

---

## Test 4 — Caso especial: Japón

**Prompt**: "¿Puedo conducir en Japón con el permiso internacional español?"

**Criterios de aceptación**:
- Explica la particularidad: Japón reconoce el Convenio de Ginebra (1949) pero no el de Viena (1968).
- Indica que el PIC español (modelo Viena) puede no ser suficiente.
- Sugiere obtener una traducción oficial del permiso a través de la JAF o la embajada.
- No da una respuesta incorrecta de "sí, vale sin problema".
