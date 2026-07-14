---
name: clave
description: "Use when the user asks about the Spanish Cl@ve identification system: what it is, differences between Cl@ve PIN and Cl@ve Permanente, how to register (presencial, videollamada, certificado digital), how to activate Cl@ve PIN via app or SMS, how to use Cl@ve Permanente with password + SMS, which public administration services accept Cl@ve, Cl@ve Firma, or comparing Cl@ve with the FNMT digital certificate and DNIe. This is the detailed skill for Cl@ve — for the FNMT digital certificate use identidad-digital-certificado-digital; for the DNIe use identidad-digital-dnie; for AutoFirma use identidad-digital-autofirma. Triggers on: 'Cl@ve', 'Clave PIN', 'Clave permanente', 'sistema Clave', 'registrarse en Clave', 'alta en Clave', 'cómo usar Clave', 'Clave firma', 'PIN 24 horas', 'identificación electrónica', 'acceder sede electrónica', 'Clave app', 'código SMS Clave', 'contraseña Clave', 'Cl@ve para Hacienda', 'Cl@ve Seguridad Social'."
---

# Sistema Cl@ve — Guía Completa

**Cl@ve** es el sistema de identificación electrónica del Gobierno de
España para acceder a los servicios de la Administración General del
Estado (AGE) por internet. Es la forma más sencilla y rápida de
identificarse — no requiere instalar certificados ni disponer de
hardware especial.

> Esta skill es una guía informativa. **No gestiona tu cuenta Cl@ve
> ni accede a tus datos personales.** Para registrarte o gestionar
> tu cuenta, accede al portal oficial.

URL: `https://clave.gob.es`

---

## 1. Qué es Cl@ve

Cl@ve es una plataforma común de identificación electrónica que permite
a los ciudadanos acceder a los servicios electrónicos de la AGE con un
sistema unificado. En lugar de necesitar un certificado digital diferente
para cada organismo, con Cl@ve puedes identificarte en todas las sedes
electrónicas que estén integradas.

### Modalidades de Cl@ve

| Modalidad | Cómo funciona | Validez | Nivel eIDAS |
|---|---|---|---|
| **Cl@ve PIN** | Código de un solo uso (OTP) generado por app o SMS | 10 minutos | Bajo |
| **Cl@ve Permanente** | Usuario + contraseña + código SMS | Indefinida (contraseña renovable) | Sustancial |
| **Cl@ve Firma** | Firma electrónica en la nube | Por operación | Avanzada |

---

## 2. Cl@ve PIN — Identificación temporal

Cl@ve PIN genera un **código de un solo uso** válido durante 10 minutos.
Ideal para trámites puntuales y rápidos.

### Cómo funciona

1. Accedes a un servicio que pide identificación (ej. Renta Web).
2. Seleccionas "Cl@ve PIN".
3. Introduces tu DNI/NIE y fecha de nacimiento.
4. La app Cl@ve o un SMS te proporciona un código temporal.
5. Introduces el código y accedes al servicio.

### Cómo obtener el código PIN

| Método | Requisito |
|---|---|
| **App Cl@ve** (recomendado) | Smartphone con la app Cl@ve instalada (iOS/Android) |
| **SMS** | Número de móvil registrado en Cl@ve |

La app es más rápida y fiable que el SMS.

### Trámites que admite Cl@ve PIN

Cl@ve PIN es válido para la mayoría de **consultas y trámites sencillos**:
- Consultar datos fiscales en la AEAT.
- Acceder al borrador de la Renta.
- Consultar la vida laboral en la Seguridad Social.
- Consultar puntos del carné de conducir (DGT).
- Solicitar certificados.

**Limitación**: algunos trámites que requieren firma (presentar
declaraciones de IVA/IRPF, firmar solicitudes) pueden requerir
Cl@ve Permanente, Cl@ve Firma o certificado digital.

---

## 3. Cl@ve Permanente — Contraseña reutilizable

Cl@ve Permanente es un sistema de **usuario y contraseña** que se puede
usar repetidamente, complementado con un código de verificación por SMS
para mayor seguridad.

### Cómo funciona

1. Accedes a un servicio que pide identificación.
2. Seleccionas "Cl@ve Permanente" o "Cl@ve".
3. Introduces tu DNI/NIE + contraseña de Cl@ve.
4. Recibes un código por SMS que introduces como segundo factor.
5. Accedes al servicio.

### Ventajas sobre Cl@ve PIN

- Más trámites disponibles (incluidos algunos que requieren nivel
  sustancial de seguridad).
- No necesitas la app Cl@ve para generar el PIN.
- Contraseña personalizada y reutilizable.

### Gestión de la contraseña

- **Cambiar contraseña**: `https://clave.gob.es` > Gestión de contraseña.
- **Olvidé mi contraseña**: se puede restablecer con la app Cl@ve, por
  SMS o presencialmente.
- La contraseña caduca periódicamente y el sistema avisa para renovarla.

---

## 4. Cl@ve Firma — Firma en la nube

Cl@ve Firma permite firmar electrónicamente documentos y trámites sin
necesidad de tener un certificado instalado en el navegador. La firma
se realiza "en la nube" con certificados custodiados por la
Administración.

### Cómo funciona

1. Al realizar un trámite que requiere firma, la sede te ofrece
   "Cl@ve Firma".
2. Te identificas con Cl@ve Permanente (contraseña + SMS).
3. Autorizas la firma con un código adicional por SMS.

### Disponibilidad

Cl@ve Firma no está disponible en todas las sedes electrónicas.
Las que más la utilizan:
- AEAT (presentación de determinados modelos tributarios).
- Seguridad Social (algunas solicitudes).
- Sedes de la AGE integradas.

Para firmar documentos localmente (PDFs, escritos) sigue siendo
necesario el certificado digital FNMT + AutoFirma.

---

## 5. Cómo registrarse en Cl@ve

El registro en Cl@ve es obligatorio y requiere verificación de
identidad. Hay varias formas:

### Opción 1 — Registro presencial (la más habitual)

1. Solicita cita o acude a una oficina de registro habilitada:
   - Oficinas de la AEAT.
   - Oficinas de la Seguridad Social.
   - Ayuntamientos adheridos.
   - Oficinas de atención al ciudadano (060).
2. Lleva tu **DNI/NIE** original y tu **número de móvil**.
3. El funcionario te registra y te proporciona una **carta de
   activación** con un código.
4. Activa tu cuenta en `https://clave.gob.es` con el código de la carta.

### Opción 2 — Registro por videollamada

1. Accede a `https://clave.gob.es` > Registro > Videollamada.
2. Solicita cita para videollamada.
3. Muestra tu DNI/NIE original ante la cámara.
4. Recibes el código de activación por correo electrónico.

### Opción 3 — Registro con certificado digital o DNIe

Si ya tienes un certificado digital FNMT o DNIe activo:
1. Accede a `https://clave.gob.es` > Registro.
2. Identifícate con tu certificado o DNIe.
3. El registro es inmediato — no necesitas ir a una oficina.

### Activación tras el registro

Una vez registrado, debes:
1. Establecer tu contraseña de Cl@ve Permanente.
2. Instalar la app Cl@ve en tu móvil (si quieres usar Cl@ve PIN por app).
3. Vincular tu número de teléfono móvil.

---

## 6. La App Cl@ve

Aplicación oficial gratuita disponible en iOS y Android.

### Funciones

- Generar códigos Cl@ve PIN con un toque.
- Recibir notificaciones push en lugar de SMS.
- Gestionar tu cuenta Cl@ve.

### Instalación

| Plataforma | Descarga |
|---|---|
| Android | Google Play: buscar "Cl@ve" (editor: Gobierno de España) |
| iOS | App Store: buscar "Cl@ve" (editor: Gobierno de España) |

### Activación de la app

1. Abre la app tras instalarla.
2. Introduce tu DNI/NIE y fecha de caducidad del DNI.
3. Recibes un código de activación por SMS.
4. Introduce el código en la app.
5. La app queda vinculada a tu identidad.

---

## 7. Qué trámites admite Cl@ve

Cl@ve está integrado en más de **5.000 trámites** de la AGE y otras
administraciones adheridas:

| Organismo | Trámites habituales | Modalidades |
|---|---|---|
| **AEAT (Hacienda)** | Renta, datos fiscales, certificados tributarios, modelos trimestrales | PIN, Permanente, Firma |
| **Seguridad Social** | Vida laboral, prestaciones, Import@ss | PIN, Permanente |
| **DGT** | Puntos del carné, informes de vehículos, multas | PIN, Permanente |
| **SEPE** | Demanda de empleo, prestaciones por desempleo | PIN, Permanente |
| **Justicia** | Consulta de procedimientos | Permanente |
| **Registro Civil** | Certificados | Permanente |
| **Universidades** | Matrícula, becas | Varía |
| **Ayuntamientos adheridos** | Padrón, tributos | Varía |

---

## 8. Problemas frecuentes y soluciones

### "No me llega el SMS con el código"

- Comprueba que el número de móvil registrado en Cl@ve es el correcto.
- Espera unos minutos — en horas punta puede haber retraso.
- Si no llega, usa la app Cl@ve como alternativa.
- Comprueba que no tienes bloqueados los SMS de números cortos.

### "Mi contraseña de Cl@ve Permanente no funciona"

- Las contraseñas caducan periódicamente. Restablécela en
  `https://clave.gob.es`.
- Recuerda que Cl@ve Permanente tiene **usuario (DNI/NIE) + contraseña
  + SMS**. Si introduces el PIN temporal en vez de la contraseña, fallará.

### "No consigo activar la app Cl@ve"

- Asegúrate de tener el registro de Cl@ve completado (no solo solicitado).
- Introduce la fecha de caducidad del DNI exactamente como aparece en el
  documento.
- Si cambiaste de teléfono, necesitas reactivar la app.

### "¿Puedo usar Cl@ve para trámites de mi comunidad autónoma?"

- Cl@ve es un sistema de la AGE, pero muchas comunidades autónomas y
  ayuntamientos se han adherido. Consulta la sede electrónica del
  organismo concreto para verificar si acepta Cl@ve.

---

## 9. Comparativa de métodos de identificación

| Característica | Cl@ve PIN | Cl@ve Permanente | Certificado FNMT | DNIe |
|---|---|---|---|---|
| **Complejidad** | Muy baja | Baja | Media | Media-alta |
| **Hardware** | Móvil | Móvil (SMS) | Ninguno | Lector de tarjetas |
| **Permite firma** | No | Limitada (Cl@ve Firma) | Sí | Sí |
| **Nivel eIDAS** | Bajo | Sustancial | Cualificado | Cualificado |
| **Ideal para** | Consultas rápidas | Trámites frecuentes | Todo tipo | Usuarios con lector |

---

## 10. URLs de referencia

| Recurso | URL |
|---|---|
| Portal Cl@ve | `https://clave.gob.es` |
| Qué es Cl@ve | `https://clave.gob.es/clave_Home/clave.html` |
| Registro en Cl@ve | `https://clave.gob.es/clave_Home/registro.html` |
| App Cl@ve (información) | `https://clave.gob.es/clave_Home/dnielec/Apps.html` |

---

## Cuándo NO usar esta skill

- Si pregunta por el **certificado digital FNMT** (solicitud, instalación,
  renovación) → **certificado-digital**.
- Si pregunta por el **DNI electrónico** (chip, lector, activación) →
  **dnie**.
- Si pregunta por **firmar documentos** con AutoFirma o sobre firma
  electrónica → **autofirma**.
- Si pregunta por **obligaciones fiscales del autónomo** y menciona Cl@ve
  como medio de acceso → **fiscalidad-autonomos**.
- Si pregunta por **trámites con la Seguridad Social** → **seguridad-social**.
