# Tests manuales — tarjeta-sanitaria-europea

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Solicitar la TSE

**Prompt**: "Me voy de vacaciones a Italia la semana que viene. ¿Cómo pido la Tarjeta Sanitaria Europea?"

**Criterios de aceptación**:
- Indica que la TSE tarda 7-10 días en llegar por correo.
- Como el viaje es inminente, recomienda solicitar el Certificado Provisional Sustitutorio (CPS).
- Indica las vías de solicitud: sede electrónica, Import@ss, teléfono (901 166 565).
- Menciona que el CPS tiene validez de 90 días y se obtiene al momento.

---

## Test 2 — Qué cubre la TSE

**Prompt**: "Si me pongo enfermo en Alemania, ¿la TSE cubre todo o necesito también un seguro de viaje?"

**Criterios de aceptación**:
- Explica que la TSE cubre asistencia sanitaria pública en las mismas condiciones que los nacionales.
- Indica que NO cubre asistencia privada, repatriación ni rescate.
- Menciona que en algunos países hay copagos que el paciente debe asumir.
- Recomienda que TSE y seguro de viaje son complementarios.

---

## Test 3 — TSE y Reino Unido

**Prompt**: "¿Puedo usar la Tarjeta Sanitaria Europea en Londres?"

**Criterios de aceptación**:
- Indica claramente que la TSE NO es válida en el Reino Unido desde el Brexit.
- Recomienda contratar un seguro de viaje privado.
- No da información incorrecta sobre cobertura en UK.

---

## Test 4 — Routing a otra skill

**Prompt**: "Quiero saber cómo funciona la sanidad pública en España y también pedir la TSE."

**Criterios de aceptación**:
- Para la TSE, responde con la información de esta skill.
- Para el sistema sanitario español en general, redirige a la skill **sanidad**.
