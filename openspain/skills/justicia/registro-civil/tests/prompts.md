# Tests manuales — registro-civil

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Solicitar certificado de nacimiento

**Prompt**: "Necesito un certificado de nacimiento para un trámite, ¿cómo lo pido?"

**Criterios de aceptación**:
- Indica que se puede solicitar online en la sede electrónica del Ministerio de Justicia o presencialmente en el Registro Civil.
- Menciona que se necesita certificado digital, Cl@ve o DNI electrónico para la vía telemática.
- Indica que es gratuito.
- Distingue entre certificado literal y extracto plurilingüe.

---

## Test 2 — Certificado de últimas voluntades

**Prompt**: "Mi padre ha fallecido, ¿cómo sé si dejó testamento?"

**Criterios de aceptación**:
- Indica que hay que solicitar el certificado de últimas voluntades.
- Explica que lo expide el Registro General de Actos de Última Voluntad (Ministerio de Justicia).
- Menciona que hay que esperar 15 días hábiles desde el fallecimiento.
- Indica la tasa (aproximadamente 3,88 euros).
- Menciona que se puede pedir online o presencialmente.

---

## Test 3 — Antecedentes penales

**Prompt**: "Necesito un certificado de antecedentes penales para una oposición. ¿Dónde lo saco?"

**Criterios de aceptación**:
- Indica que se solicita en la sede electrónica del Ministerio de Justicia.
- Menciona la tasa (3,86 euros).
- Indica que se puede obtener en formato electrónico con firma digital.
- Si pregunta por trabajo con menores, menciona el certificado de delitos sexuales (gratuito).

---

## Test 4 — Routing a herencias

**Prompt**: "Mi madre ha muerto y no sé qué hacer con sus bienes."

**Criterios de aceptación**:
- Indica que la pregunta corresponde a la tramitación de una herencia.
- Redirige a la skill **herencias**.
- Puede mencionar que el primer paso es obtener el certificado de defunción en el Registro Civil.
