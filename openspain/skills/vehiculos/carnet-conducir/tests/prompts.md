# Tests manuales — carnet-conducir

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Obtener el carnet B

**Prompt**: "Quiero sacarme el carnet de conducir B en España. ¿Qué proceso tengo que seguir y cuánto cuesta?"

**Criterios de aceptación**:
- Describe el proceso: autoescuela, examen teórico (30 preguntas, máx. 3 fallos), examen práctico.
- Da un rango de coste orientativo (800–1.300 €).
- Menciona las tasas DGT.
- Indica que se necesita reconocimiento médico.
- No confunde con permisos profesionales (C, D).

---

## Test 2 — Canje de permiso extranjero

**Prompt**: "Soy colombiano con residencia en España y quiero canjear mi carnet de conducir. ¿Es posible?"

**Criterios de aceptación**:
- Indica que Colombia tiene convenio bilateral con España, por lo que se puede canjear sin examen.
- Lista los requisitos: residencia legal, permiso en vigor, reconocimiento médico, tasa DGT.
- Menciona que el permiso extranjero se retiene.
- Para países sin convenio, indica que habría que examinarse.
- Puede remitir a la skill `extranjeria-nie` para temas de residencia/NIE.

---

## Test 3 — Puntos del carnet

**Prompt**: "Me han quitado 6 puntos del carnet por exceso de velocidad. ¿Cómo los recupero?"

**Criterios de aceptación**:
- Explica las dos vías: curso de recuperación parcial (hasta 6 puntos, cada 2 años) y/o esperar 2-3 años sin infracciones graves.
- Indica cómo consultar el saldo de puntos online (Sede DGT con Cl@ve/certificado).
- Menciona qué pasa si se llega a 0 puntos.
- No se confunde con la pérdida total de vigencia del permiso.

---

## Test 4 — Renovación del carnet

**Prompt**: "Mi carnet de conducir caduca el mes que viene. ¿Qué tengo que hacer?"

**Criterios de aceptación**:
- Indica que debe acudir a un Centro de Reconocimiento de Conductores.
- Explica que solo necesita pasar el reconocimiento médico (no hay examen).
- Menciona el coste (20-60 €) y que el centro tramita la renovación telemáticamente.
- Indica los plazos de vigencia (10 años hasta 65, 5 años después).
