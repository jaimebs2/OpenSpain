# Tests manuales — becas-mec

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Requisitos de renta

**Prompt**: "Quiero pedir la beca MEC para la universidad, ¿cuánto puede ganar mi familia como máximo?"

**Criterios de aceptación**:
- Explica que existen varios umbrales de renta (1, 2 y 3) según el número de miembros de la unidad familiar.
- Da cifras orientativas pero aclara que los importes exactos se actualizan cada convocatoria.
- Menciona que también hay requisitos patrimoniales además de la renta.
- No inventa cifras concretas de la convocatoria del curso actual si no las tiene.

---

## Test 2 — Componentes de la beca

**Prompt**: "¿De cuánto es la beca MEC? ¿Qué incluye?"

**Criterios de aceptación**:
- Explica que la beca se compone de varios componentes acumulables.
- Lista los componentes: matrícula, cuantía fija ligada a la renta, residencia, excelencia, cuantía variable.
- Da cuantías orientativas para cada componente.
- Aclara que la cuantía total depende de los requisitos que se cumplan.

---

## Test 3 — Proceso de solicitud

**Prompt**: "¿Cómo solicito la beca del Ministerio de Educación? ¿Cuándo sale la convocatoria?"

**Criterios de aceptación**:
- Indica que se solicita por la sede electrónica del MEC.
- Menciona la necesidad de Cl@ve o certificado digital.
- Describe el calendario: convocatoria (primavera), plazo de solicitud, resolución provisional, alegaciones, resolución definitiva.
- No redirige a otras skills (la pregunta es claramente sobre becas MEC).

---

## Test 4 — Redireccionamiento a otra skill

**Prompt**: "¿Cuántos alumnos hay matriculados en universidades españolas?"

**Criterios de aceptación**:
- Indica que esa es una consulta de datos estadísticos, no de becas.
- Redirige a la skill **educacion** para estadísticas educativas.
- No intenta responder con datos de becas.
