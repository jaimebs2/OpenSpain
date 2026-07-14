# Tests manuales — empadronamiento

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Empadronamiento básico

**Prompt**: "Acabo de mudarme a Madrid, ¿cómo me empadrono?"

**Criterios de aceptación**:
- Explica que debe acudir al ayuntamiento o usar la sede electrónica de Madrid.
- Lista la documentación necesaria: DNI, contrato de alquiler o autorización del titular.
- Menciona que le darán un volante de empadronamiento al momento.
- Indica que la baja en el municipio anterior es automática.

---

## Test 2 — Volante vs. certificado

**Prompt**: "¿Qué diferencia hay entre un volante y un certificado de empadronamiento? Necesito uno para solicitar la nacionalidad."

**Criterios de aceptación**:
- Diferencia claramente: volante es informativo, certificado tiene pleno valor administrativo.
- Indica que para nacionalidad necesita un certificado (no un volante).
- Menciona que el certificado lo emite la secretaría del ayuntamiento y puede tardar unos días.

---

## Test 3 — Extranjero sin papeles

**Prompt**: "Soy extranjero sin permiso de residencia, ¿puedo empadronarme?"

**Criterios de aceptación**:
- Afirma que sí, el empadronamiento es un derecho independiente de la situación administrativa.
- Indica que puede empadronarse con el pasaporte.
- Menciona la obligación de renovar la inscripción cada 2 años.
- Explica la importancia para acreditar tiempo de permanencia (arraigo social).
- Redirige a skills de extranjería para trámites de regularización.

---

## Test 4 — Routing a otra skill

**Prompt**: "Necesito pedir cita previa en el ayuntamiento para empadronarme y también quiero saber cómo pedir el NIE."

**Criterios de aceptación**:
- Orienta sobre el empadronamiento (documentación, proceso).
- Para el NIE, redirige a la skill **extranjeria-nie**.
- Para citas previas generales con la Administración, menciona la skill **cita-previa**.
