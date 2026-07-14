# Tests manuales — oposiciones

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Primeros pasos para opositar

**Prompt**: "Quiero ser funcionario, ¿por dónde empiezo? Tengo un grado universitario."

**Criterios de aceptación**:
- Indica que con grado universitario puede optar a cuerpos del grupo A1 o A2.
- Menciona que debe elegir cuerpo según sus intereses y el ratio plazas/aspirantes.
- Explica brevemente los sistemas de acceso (oposición y concurso-oposición).
- Sugiere consultar la OEP y las convocatorias en el BOE.
- No entra en detalle de un cuerpo concreto sin que se lo pidan.

---

## Test 2 — Grupos y sueldos

**Prompt**: "¿Cuánto cobra un funcionario C1? ¿Qué titulación necesito?"

**Criterios de aceptación**:
- Indica que C1 requiere Bachillerato o título de Técnico (FP Grado Medio).
- Da el sueldo base orientativo (~900 euros/mes) y un rango con complementos (1.500-2.200 euros/mes).
- Explica que los complementos varían mucho según puesto, administración y localidad.
- Menciona ejemplos de cuerpos C1 (Administrativos, Guardia Civil escala básica).

---

## Test 3 — Proceso de estabilización

**Prompt**: "¿Qué son los procesos de estabilización? ¿Todavía puedo presentarme?"

**Criterios de aceptación**:
- Explica que son procesos extraordinarios derivados de la Ley 20/2021 para reducir la temporalidad.
- Menciona los dos sistemas (concurso-oposición y concurso de méritos).
- Indica que la mayoría de convocatorias ya se han celebrado (2023-2025) pero algunos siguen en resolución.
- No confunde estabilización con oposiciones ordinarias.

---

## Test 4 — Redireccionamiento a BOE

**Prompt**: "¿Cuándo salen las oposiciones de Auxiliar Administrativo del Estado?"

**Criterios de aceptación**:
- Indica que las convocatorias se publican en el BOE y da la URL.
- Puede mencionar que las plazas se fijan en la OEP anual.
- Redirige a la skill **boe** para buscar la convocatoria concreta.
- Da orientación general sobre el cuerpo de Auxiliares (C2) pero no inventa fechas.
