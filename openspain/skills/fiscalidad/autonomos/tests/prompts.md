# Tests manuales — fiscalidad-autonomos

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Nuevo autónomo: primeros pasos

**Prompt**: "Quiero hacerme autónomo como diseñador freelance. ¿Qué tengo que hacer con Hacienda?"

**Criterios de aceptación**:
- Menciona el alta censal con Modelo 036 o 037.
- Explica que debe elegir un epígrafe del IAE (sección 2.ª para profesionales).
- Indica que también debe darse de alta en la Seguridad Social (RETA).
- Menciona que necesitará Cl@ve o certificado digital para operar online.
- No entra en detalle profundo sobre cálculo del IVA o IRPF (remite a las skills específicas).

---

## Test 2 — Calendario y cuánto reservar

**Prompt**: "¿Cada cuánto tengo que presentar impuestos como autónomo y cuánto dinero debería guardar?"

**Criterios de aceptación**:
- Indica presentación trimestral (abril, julio, octubre, enero) con modelos 303, 130/131.
- Menciona la declaración de la Renta anual (abril-junio).
- Recomienda reservar entre el 30 % y el 40 % de cada factura.
- Menciona que incluye IVA, IRPF y cuota de autónomos.

---

## Test 3 — Facturación

**Prompt**: "¿Cómo tengo que hacer las facturas como autónomo? ¿Qué datos deben llevar?"

**Criterios de aceptación**:
- Lista los datos obligatorios: número correlativo, fecha, datos emisor/receptor con NIF, descripción, base imponible, IVA, retención IRPF (si aplica), total.
- Menciona la factura simplificada y sus límites (400 € o 3.000 €).
- Indica la obligación de conservar facturas 4 años.
- No profundiza en tipos de IVA ni cálculo de retenciones (remite a skills específicas).

---

## Test 4 — Redireccionamiento a sociedades

**Prompt**: "Tengo una SL, ¿qué impuestos trimestrales tengo que presentar?"

**Criterios de aceptación**:
- Indica que esta skill es solo para autónomos personas físicas.
- Aclara que las sociedades tributan por Impuesto de Sociedades (no IRPF).
- No intenta responder con información de autónomos.
