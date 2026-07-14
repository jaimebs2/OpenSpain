# Tests manuales — cotizaciones

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Reparto empresa/trabajador

**Prompt**: "¿Cuánto paga la empresa a la Seguridad Social por un trabajador y cuánto paga el trabajador?"

**Criterios de aceptación**:
- Indica el reparto de contingencias comunes: 23,60 % empresa + 4,70 % trabajador.
- Menciona los otros conceptos: desempleo, FP, FOGASA, MEI, AT/EP.
- Da la cifra aproximada del coste total para la empresa (~32 % sobre el salario bruto).
- Aclara que el AT/EP varía según la actividad económica.

---

## Test 2 — Cuota de autónomos

**Prompt**: "¿Cuánto pago de cuota de autónomos si gano 1.500 euros al mes?"

**Criterios de aceptación**:
- Explica el sistema de cotización por ingresos reales.
- Ubica el tramo correspondiente (1.300,01 - 1.500 EUR).
- Indica la cuota mínima aproximada del tramo.
- Menciona la regularización anual con Hacienda.

---

## Test 3 — Tarifa plana

**Prompt**: "Voy a darme de alta como autónomo por primera vez. ¿Existe alguna cuota reducida?"

**Criterios de aceptación**:
- Indica la tarifa plana: 80 EUR/mes durante 12 meses (ampliable a 24 si rendimientos < SMI).
- Menciona el requisito de no haber sido autónomo en los últimos 2 años (3 si ya disfrutó tarifa plana).
- Excluye al autónomo colaborador familiar.

---

## Test 4 — Redireccionamiento a nóminas

**Prompt**: "¿Cómo se ve la cotización en mi nómina?"

**Criterios de aceptación**:
- Indica que para entender la nómina y sus deducciones se debe usar la skill laboral-nominas.
- No intenta explicar la estructura completa de la nómina.
