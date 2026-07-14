# Tests manuales — clave

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Diferencia entre Cl@ve PIN y Cl@ve Permanente

**Prompt**: "¿Qué diferencia hay entre Cl@ve PIN y Cl@ve Permanente? ¿Cuál me conviene?"

**Criterios de aceptación**:
- Explica que Cl@ve PIN genera un código temporal de un solo uso (10 minutos).
- Explica que Cl@ve Permanente usa contraseña fija + verificación por SMS.
- Indica que Permanente da acceso a más trámites (nivel sustancial).
- Recomienda Permanente para uso frecuente y PIN para consultas puntuales.
- No confunde con el certificado digital FNMT.

---

## Test 2 — Cómo registrarse

**Prompt**: "¿Cómo me registro en Cl@ve? No tengo certificado digital."

**Criterios de aceptación**:
- Explica el registro presencial: ir a una oficina (AEAT, SS, ayuntamiento) con DNI.
- Menciona la opción de registro por videollamada.
- Indica que recibirá una carta/código de activación.
- Explica los pasos de activación (establecer contraseña, instalar app).
- Incluye la URL del portal Cl@ve.

---

## Test 3 — Problemas con el SMS

**Prompt**: "Intento usar Cl@ve PIN pero no me llega el SMS. ¿Qué hago?"

**Criterios de aceptación**:
- Sugiere verificar el número de móvil registrado.
- Recomienda usar la app Cl@ve como alternativa más fiable.
- Menciona posibles retrasos en horas punta.
- Sugiere comprobar si hay bloqueo de SMS de números cortos.

---

## Test 4 — Redireccionamiento a certificado digital

**Prompt**: "Necesito firmar un PDF para presentar en el juzgado. ¿Me sirve Cl@ve?"

**Criterios de aceptación**:
- Indica que Cl@ve no permite firmar documentos locales (PDFs).
- Redirige a la skill **certificado-digital** para obtener un certificado FNMT.
- Redirige a la skill **autofirma** para la herramienta de firma.
- No intenta dar instrucciones detalladas sobre firma electrónica.
