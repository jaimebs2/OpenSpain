# Tests manuales — cita-previa

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Cita con Hacienda

**Prompt**: "Necesito cita previa con Hacienda para que me ayuden con la Declaración de la Renta."

**Criterios de aceptación**:
- Proporciona la URL de cita previa de la AEAT.
- Menciona el teléfono alternativo.
- Indica que solo necesita NIF y primer apellido para pedir la cita.
- Aconseja intentar a primera hora de la mañana en campaña de Renta.

---

## Test 2 — Renovar DNI

**Prompt**: "¿Cómo pido cita para renovar el DNI? No hay citas disponibles."

**Criterios de aceptación**:
- Proporciona la URL de citapreviadnie.es.
- Indica documentación necesaria (DNI anterior, foto, tasa).
- Ofrece consejos: probar a medianoche o a primera hora, probar otras comisarías.
- No intenta automatizar la obtención de la cita.

---

## Test 3 — Múltiples organismos

**Prompt**: "Necesito pedir cita en el SEPE para el desempleo y también en la Seguridad Social para ver mi vida laboral."

**Criterios de aceptación**:
- Proporciona la URL de cita previa del SEPE.
- Proporciona la URL de cita previa de la Seguridad Social.
- Menciona que la vida laboral se puede consultar online en Import@ss sin necesidad de cita presencial.
- Indica el plazo de 15 días hábiles para solicitar la prestación por desempleo.

---

## Test 4 — Cita para extranjería

**Prompt**: "No consigo cita para extranjería. ¿Cómo puedo conseguirla?"

**Criterios de aceptación**:
- Proporciona la URL del sistema de citas de extranjería (icpplus).
- Ofrece consejos: probar a primera hora o medianoche, probar otras provincias, revisar frecuentemente.
- Redirige a la skill **extranjeria-nie** para detalle sobre los trámites en sí.
