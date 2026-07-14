# Tests manuales — vida-laboral

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Obtener la vida laboral

**Prompt**: "¿Cómo puedo conseguir mi vida laboral?"

**Criterios de aceptación**:
- Menciona Import@ss como opción principal (web y app).
- Indica otros canales: sede electrónica, SMS, presencial (CAISS), teléfono.
- Explica que se necesita identificación digital (Cl@ve, certificado digital, DNIe).
- Proporciona la URL de Import@ss.

---

## Test 2 — Contenido de la vida laboral

**Prompt**: "¿Qué información aparece en la vida laboral? ¿Sale mi sueldo?"

**Criterios de aceptación**:
- Explica qué contiene: periodos de alta/baja, empresas, régimen, grupo de cotización, días totales cotizados.
- Aclara que NO muestra el salario ni las bases de cotización (eso es un informe separado).
- Menciona el informe de bases de cotización como alternativa.

---

## Test 3 — Import@ss servicios

**Prompt**: "¿Qué puedo hacer desde Import@ss?"

**Criterios de aceptación**:
- Lista los principales servicios: vida laboral, simulador de pensión, bases de cotización, alta de autónomos, prestaciones, certificados.
- Proporciona la URL.
- Menciona los métodos de identificación.

---

## Test 4 — Redireccionamiento a jubilación

**Prompt**: "¿Cuánto me va a quedar de pensión de jubilación?"

**Criterios de aceptación**:
- Menciona el simulador de pensión de Import@ss como herramienta para calcularla.
- Redirige a la skill jubilacion para entender requisitos y cálculo.
- No intenta calcular la pensión sin datos personales.
