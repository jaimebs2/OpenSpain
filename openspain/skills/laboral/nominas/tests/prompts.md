# Tests manuales — laboral-nominas

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Entender la nómina

**Prompt**: "No entiendo mi nómina. ¿Qué es la base de cotización y por qué me descuentan tanto?"

**Criterios de aceptación**:
- Explica que la base de cotización es la cantidad sobre la que se aplican los porcentajes de cotización a la Seguridad Social.
- Indica los componentes (salario base + complementos + prorrata pagas extras).
- Menciona los porcentajes del trabajador (contingencias comunes ~4,70 %, desempleo, FP, MEI).
- Explica que la retención de IRPF depende de la situación personal.
- Diferencia entre bruto y neto.

---

## Test 2 — Salario mínimo

**Prompt**: "¿Cuánto es el salario mínimo en España?"

**Criterios de aceptación**:
- Indica el SMI vigente (1.134 €/mes en 14 pagas en 2025, orientativo).
- Aclara que se actualiza anualmente por Real Decreto.
- Menciona que es inembargable salvo para pensiones alimenticias.

---

## Test 3 — Pagas extra

**Prompt**: "¿Cuántas pagas extra me corresponden? ¿Me las pueden prorratear?"

**Criterios de aceptación**:
- Indica que el mínimo legal son 2 pagas extraordinarias al año.
- Explica que el convenio puede fijar más y que normalmente son en junio y diciembre.
- Confirma que pueden prorratearse en 12 meses si lo permite el convenio o se acuerda.
- Menciona que la cuantía mínima es 30 días de salario base.

---

## Test 4 — Routing a convenios

**Prompt**: "¿Cuánto debería cobrar como camarero en Madrid?"

**Criterios de aceptación**:
- Indica que el salario concreto depende del convenio colectivo aplicable.
- Redirige a la skill laboral-convenios para buscar el convenio de hostelería de Madrid.
- No inventa tablas salariales.
