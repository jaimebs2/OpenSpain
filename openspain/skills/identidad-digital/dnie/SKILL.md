---
name: dnie
description: "Use when the user asks about the Spanish electronic national ID card (DNI electrónico / DNIe): what is the chip for, how to activate the certificates, what PIN is needed, what card reader to buy, what software to install, how to use it for online identification and digital signing, renewal of the DNI and reactivation of the chip, or comparing it with the FNMT digital certificate and Cl@ve. This is the detailed skill for the DNIe — for the FNMT digital certificate use identidad-digital-certificado-digital; for Cl@ve use identidad-digital-clave; for AutoFirma use identidad-digital-autofirma. Triggers on: 'DNI electrónico', 'DNIe', 'chip del DNI', 'lector de tarjetas DNI', 'certificados del DNI', 'PIN del DNI', 'usar DNI para identificarme online', 'firma con DNI', 'activar DNI electrónico', 'renovar DNI electrónico', 'lector DNIe', 'módulo criptográfico DNI', 'DNI 3.0', 'NFC DNI'."
---

# DNI Electrónico (DNIe) — Guía Completa

El **DNI electrónico** (DNIe) es el Documento Nacional de Identidad
español con un chip criptográfico integrado que permite la
identificación electrónica y la firma digital. Desde 2006, todos los
DNI expedidos en España incluyen este chip.

> Esta skill es una guía informativa. **No accede a los certificados
> de tu DNIe ni a tus datos personales.** Para gestionar tu DNIe,
> acude a una comisaría de Policía Nacional.

---

## 1. Qué es el DNIe y qué permite

El DNI electrónico combina dos funciones:

1. **Documento físico de identidad** — como siempre, acredita tu
   identidad presencialmente.
2. **Tarjeta inteligente (smartcard)** — el chip contiene dos
   certificados digitales que permiten:
   - **Identificarte electrónicamente** en sedes de la Administración
     Pública (equivalente a presentar el DNI en ventanilla).
   - **Firmar documentos digitalmente** con la misma validez legal que
     una firma manuscrita.

### Generaciones del DNIe

| Generación | Año | Características |
|---|---|---|
| **DNIe 1.0** | 2006–2015 | Chip de contacto, requiere lector USB |
| **DNIe 3.0** | 2015–presente | Chip dual: contacto (lector USB) + **NFC** (sin contacto) |

El DNIe 3.0 puede usarse con lector USB tradicional o mediante NFC con
un smartphone compatible.

---

## 2. Certificados del chip

El chip del DNI contiene dos certificados X.509:

| Certificado | Función | OID |
|---|---|---|
| **Autenticación** | Identificarte electrónicamente ante servicios online | 2.16.724.1.2.2.1.2 |
| **Firma** | Firmar documentos digitalmente con validez legal | 2.16.724.1.2.2.1.1 |

Ambos son emitidos por la **Dirección General de la Policía** como
autoridad de certificación.

### Activación del PIN

Los certificados del chip están protegidos por un **PIN** que se
establece en el momento de la expedición del DNI en la comisaría.

- El PIN tiene entre 8 y 16 caracteres alfanuméricos.
- **Si no recuerdas el PIN** o nunca lo activaste, debes acudir a una
  comisaría de Policía Nacional con tu DNI para restablecerlo en los
  Puntos de Actualización del DNIe (PAD).
- El PIN se puede cambiar en los mismos puntos PAD.

**Importante**: tras 3 intentos fallidos de PIN, los certificados se
bloquean y solo se pueden desbloquear presencialmente en comisaría.

---

## 3. Hardware necesario

### Lector de tarjetas inteligentes (USB)

Para usar el DNIe con un ordenador necesitas un **lector de tarjetas
smartcard** compatible con el estándar ISO 7816.

| Tipo | Precio orientativo | Ejemplos |
|---|---|---|
| **Lector USB básico** | 8–15 EUR | Bit4id miniLector EVO, ACR38U |
| **Teclado con lector integrado** | 25–50 EUR | Cherry KC 1000 SC |
| **Lector contactless (NFC)** | 20–40 EUR | ACR122U (para DNIe 3.0) |

**Recomendación**: cualquier lector USB certificado por la DGP (Dirección
General de la Policía) funciona. Los más comunes y baratos son los de
la marca Bit4id.

### NFC con smartphone (DNIe 3.0)

El DNIe 3.0 puede leerse con un smartphone con **NFC**:

- **Android**: compatible con la mayoría de teléfonos con NFC.
  App oficial: "DNIe" (Google Play).
- **iOS**: compatible desde iPhone 7. Soporte más limitado que Android.

---

## 4. Software necesario

### Módulos criptográficos

Para que el sistema operativo y los navegadores reconozcan el DNIe, hay
que instalar los controladores (módulos PKCS#11):

| Sistema operativo | Software | Descarga |
|---|---|---|
| **Windows** | Paquete integrado en Windows Update (desde Windows 10) | Automático |
| **macOS** | Instalador de la DGP | `https://www.dnielectronico.es/PortalDNIe/PRF1_Cons02.action?pag=REF_1100` |
| **Linux** | opensc + libpkcs11-helper | `sudo apt install opensc pcsc-tools` (Debian/Ubuntu) |

### Verificar que funciona

1. Inserta el DNIe en el lector.
2. Abre el navegador y accede a una sede que pida certificado.
3. Debe aparecer una ventana pidiendo el PIN del DNIe.
4. También puedes verificar en: `https://valide.redsara.es`

### Navegadores

| Navegador | Compatibilidad |
|---|---|
| **Firefox** | Necesita configurar el módulo PKCS#11 manualmente (*Ajustes > Privacidad > Dispositivos de seguridad*) |
| **Chrome / Edge** | Usa el almacén del sistema operativo; funciona automáticamente si los drivers están instalados |
| **Safari** | Funciona con el módulo de macOS instalado |

---

## 5. Uso del DNIe para identificación online

Una vez que tienes el lector, los drivers y el PIN:

1. Accede a una sede electrónica (ej. AEAT, Seguridad Social).
2. Selecciona "DNI electrónico" o "Certificado digital" como método de
   identificación.
3. Inserta el DNIe en el lector.
4. El navegador muestra los certificados del chip.
5. Selecciona el certificado de **Autenticación**.
6. Introduce tu PIN.
7. Accedes al servicio.

### Trámites disponibles

El DNIe es aceptado en todas las sedes electrónicas que aceptan
certificado digital, ya que técnicamente funciona igual. Incluye:
- AEAT (Hacienda).
- Seguridad Social / Import@ss.
- DGT.
- Justicia.
- Registro Civil.
- Catastro.
- Ayuntamientos y comunidades autónomas.

---

## 6. Uso del DNIe para firma electrónica

Para firmar documentos digitalmente con el DNIe:

1. Necesitas la aplicación **AutoFirma** del Gobierno (ver skill
   **autofirma**).
2. Al firmar, AutoFirma detecta el DNIe en el lector.
3. Selecciona el certificado de **Firma**.
4. Introduce tu PIN.
5. El documento queda firmado con validez legal.

La firma con DNIe tiene nivel **cualificado** según el Reglamento eIDAS
(el máximo nivel de confianza).

---

## 7. Renovación del DNI y los certificados

### Renovación del DNI

El DNI se renueva en comisaría de Policía Nacional. Al renovar el
documento físico, se generan **nuevos certificados** en el chip.

**Plazos de renovación**:
- Cada 5 años (menores de 30 y mayores de 70: 10 años).
- O antes si cambian datos personales, deterioro, robo o pérdida.

Cita previa: `https://www.citapreviadnie.es`

### Renovación solo de los certificados

Si el DNI físico sigue vigente pero los certificados del chip han
caducado o se han bloqueado:
- Acude a un **Punto de Actualización del DNIe (PAD)** en una comisaría.
- Son terminales de autoservicio donde puedes renovar certificados y
  cambiar el PIN en minutos.
- No necesitas cita previa para el PAD.

---

## 8. Limitaciones prácticas del DNIe

A pesar de ser técnicamente potente, el DNIe tiene menor adopción que
Cl@ve y el certificado FNMT:

| Limitación | Detalle |
|---|---|
| **Requiere hardware** | Necesitas comprar un lector de tarjetas USB (o tener NFC) |
| **Instalación de drivers** | En macOS y Linux puede requerir configuración manual |
| **PIN olvidado** | Solo se restablece presencialmente en comisaría |
| **Firefox** | Requiere configuración manual del módulo PKCS#11 |
| **Compatibilidad NFC** | Funciona bien en Android, limitada en iOS |

**Alternativas más prácticas**:
- **Cl@ve**: no necesita hardware ni instalación. Ideal para la mayoría
  de trámites. Ver skill **clave**.
- **Certificado FNMT**: se instala en el navegador sin hardware extra.
  Igual de potente que el DNIe. Ver skill **certificado-digital**.

---

## 9. Comparativa: DNIe vs. certificado FNMT vs. Cl@ve

| Característica | DNIe | Certificado FNMT | Cl@ve |
|---|---|---|---|
| **Formato** | Chip en tarjeta física | Software en navegador | Usuario + contraseña |
| **Hardware** | Lector USB o NFC | Ninguno | Ninguno (solo móvil) |
| **Obtención** | Al expedirse el DNI | Solicitud online + acreditación | Registro presencial/vídeo |
| **Firma documentos** | Sí | Sí (con AutoFirma) | Limitada (Cl@ve Firma) |
| **Nivel eIDAS** | Cualificado | Cualificado | Sustancial |
| **Adopción** | Baja | Alta | Muy alta |

---

## 10. URLs de referencia

| Recurso | URL |
|---|---|
| Portal del DNI electrónico | `https://www.dnielectronico.es` |
| Cita previa DNI/Pasaporte | `https://www.citapreviadnie.es` |
| Validar certificados (VALIDe) | `https://valide.redsara.es` |

---

## Cuándo NO usar esta skill

- Si pregunta por el **certificado digital FNMT** (solicitar, instalar,
  renovar) → **certificado-digital**.
- Si pregunta por **Cl@ve** (registro, PIN, Permanente) → **clave**.
- Si pregunta por **firmar documentos** con AutoFirma → **autofirma**.
- Si pregunta por **obligaciones fiscales del autónomo** y menciona el
  DNIe como medio de acceso → **fiscalidad-autonomos**.
- Si pregunta por **trámites con la Seguridad Social** → **seguridad-social**.
