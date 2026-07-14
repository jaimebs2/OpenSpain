# Tests manuales — certificado-digital

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Obtener el certificado desde cero

**Prompt**: "Quiero sacar el certificado digital de la FNMT. ¿Cómo lo hago paso a paso?"

**Criterios de aceptación**:
- Explica los tres pasos: solicitud online, acreditación de identidad y descarga.
- Menciona que se necesita usar el mismo navegador y equipo para solicitud y descarga.
- Indica las opciones de acreditación: oficina presencial, DNIe o videollamada.
- Incluye la URL de la FNMT para la solicitud.
- No confunde el certificado FNMT con el DNI electrónico.

---

## Test 2 — Copia de seguridad y exportación

**Prompt**: "¿Cómo hago una copia de seguridad de mi certificado digital? He formateado el ordenador y no lo tengo."

**Criterios de aceptación**:
- Explica cómo exportar el certificado a un archivo .pfx/.p12.
- Da instrucciones diferenciadas para Windows, macOS y Firefox.
- Si ya formateó sin copia, indica que debe solicitar uno nuevo.
- Recomienda hacer siempre copia de seguridad al obtener el certificado.

---

## Test 3 — Renovación del certificado

**Prompt**: "Mi certificado digital caduca el mes que viene, ¿qué tengo que hacer?"

**Criterios de aceptación**:
- Indica que puede renovar online sin acreditación presencial (si aún no ha caducado).
- Menciona el plazo de 60 días antes del vencimiento.
- Incluye la URL de renovación de la FNMT.
- Advierte que si caduca hay que solicitar uno nuevo desde cero.

---

## Test 4 — Redireccionamiento a Cl@ve

**Prompt**: "Quiero acceder a la sede de Hacienda. ¿Necesito certificado digital o me vale con Cl@ve?"

**Criterios de aceptación**:
- Indica que ambos son válidos para la mayoría de trámites en la AEAT.
- Explica brevemente la diferencia (certificado = firma, Cl@ve = identificación).
- Redirige a la skill **clave** para más detalle sobre el sistema Cl@ve.
- No intenta dar una guía completa de Cl@ve (eso corresponde a la otra skill).
