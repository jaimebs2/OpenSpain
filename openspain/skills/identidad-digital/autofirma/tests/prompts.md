# Tests manuales — autofirma

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Instalar AutoFirma

**Prompt**: "¿Cómo instalo AutoFirma en mi Mac?"

**Criterios de aceptación**:
- Indica la URL de descarga oficial.
- Explica los pasos para macOS: descargar .dmg, arrastrar a Aplicaciones, permitir en Seguridad y Privacidad.
- Menciona que puede requerir permisos de accesibilidad.
- Indica que necesita un certificado digital o DNIe instalado para firmar.
- No confunde AutoFirma con el certificado digital (son cosas distintas).

---

## Test 2 — Tipos de firma electrónica

**Prompt**: "¿Qué tipos de firma electrónica existen en España y cuál tiene validez legal?"

**Criterios de aceptación**:
- Explica los tres niveles: simple, avanzada y cualificada.
- Menciona el Reglamento eIDAS como marco legal.
- Indica que la firma cualificada equivale legalmente a la firma manuscrita.
- Menciona que el certificado FNMT y el DNIe producen firma cualificada.
- Referencia la Ley 6/2020.

---

## Test 3 — Validar un documento firmado

**Prompt**: "Me han enviado un documento firmado electrónicamente. ¿Cómo puedo verificar que la firma es válida?"

**Criterios de aceptación**:
- Indica usar VALIDe (https://valide.redsara.es).
- Explica los pasos: acceder, seleccionar "Validar firma", subir el documento.
- Indica qué información muestra (firmante, fecha, validez, integridad).
- No sugiere instalar software para validar (VALIDe es online).

---

## Test 4 — Redireccionamiento a certificado digital

**Prompt**: "Quiero firmar documentos pero no tengo certificado digital. ¿Qué hago?"

**Criterios de aceptación**:
- Indica que necesita un certificado digital o DNIe para usar AutoFirma.
- Redirige a la skill **certificado-digital** para obtener el certificado FNMT.
- Redirige a la skill **dnie** como alternativa si ya tiene DNI electrónico.
- Menciona Cl@ve Firma como alternativa limitada para algunos trámites.
