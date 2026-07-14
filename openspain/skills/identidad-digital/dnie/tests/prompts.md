# Tests manuales — dnie

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Qué necesito para usar el DNI electrónico

**Prompt**: "Quiero usar mi DNI electrónico para hacer trámites online. ¿Qué necesito?"

**Criterios de aceptación**:
- Indica que necesita un lector de tarjetas inteligentes USB (o NFC si tiene DNIe 3.0).
- Menciona la necesidad de instalar los drivers/módulos criptográficos.
- Explica que necesita el PIN del DNIe (establecido en comisaría).
- Da ejemplos de lectores compatibles con precios orientativos.
- Menciona la alternativa de Cl@ve o certificado FNMT como opciones más sencillas.

---

## Test 2 — PIN del DNIe olvidado

**Prompt**: "No recuerdo el PIN de mi DNI electrónico. ¿Cómo lo recupero?"

**Criterios de aceptación**:
- Indica que el PIN solo se puede restablecer presencialmente en comisaría.
- Menciona los Puntos de Actualización del DNIe (PAD) como terminales de autoservicio.
- Indica que no necesita cita previa para el PAD.
- Advierte que tras 3 intentos fallidos los certificados se bloquean.

---

## Test 3 — DNIe con NFC en el móvil

**Prompt**: "¿Puedo usar el DNI con el móvil por NFC?"

**Criterios de aceptación**:
- Indica que solo es posible con el DNIe 3.0 (expedido desde 2015).
- Explica que funciona bien en Android con la app oficial "DNIe".
- Menciona que en iOS el soporte es más limitado.
- Indica que el teléfono debe tener NFC.

---

## Test 4 — Redireccionamiento a certificado FNMT

**Prompt**: "No quiero comprar un lector de tarjetas. ¿Hay otra forma de identificarme online con la Administración?"

**Criterios de aceptación**:
- Recomienda el certificado digital FNMT (no necesita hardware) → skill **certificado-digital**.
- Recomienda Cl@ve como opción más sencilla → skill **clave**.
- No insiste en el DNIe si el usuario ha expresado que no quiere comprar hardware.
