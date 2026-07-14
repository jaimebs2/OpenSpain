---
name: certificado-digital
description: "Use when the user asks about the Spanish digital certificate (certificado digital) issued by the FNMT: how to request it, install it, renew it, export/import the .pfx file, what it is used for, browser compatibility, common troubleshooting, or differences with Cl@ve and DNIe. This is the detailed skill for the FNMT certificate — for the Cl@ve identification system use identidad-digital-clave; for the DNI electrónico use identidad-digital-dnie; for signing documents with AutoFirma use identidad-digital-autofirma. Triggers on: 'certificado digital', 'certificado FNMT', 'certificado electrónico', 'solicitar certificado digital', 'instalar certificado', 'renovar certificado digital', 'exportar certificado', '.pfx', '.p12', 'copia de seguridad certificado', 'certificado persona física', 'FNMT', 'Fábrica Nacional de Moneda y Timbre', 'certificado caducado', 'no me aparece el certificado', 'certificado navegador', 'identificación electrónica España'."
---

# Certificado Digital FNMT — Guía Completa

El certificado digital de persona física emitido por la **Fábrica Nacional
de Moneda y Timbre (FNMT-RCM)** es el medio de identificación electrónica
más versátil en España. Permite realizar prácticamente cualquier trámite
con la Administración Pública por internet: declaraciones de impuestos,
consultas en la Seguridad Social, firma de documentos, acceso a historiales
clínicos y mucho más.

> Esta skill es una guía informativa. **No gestiona el certificado ni
> accede a tus datos personales.** Para el trámite real, accede a la
> sede de la FNMT.

---

## 1. Qué es el certificado digital

Un certificado digital es un documento electrónico emitido por una
**autoridad de certificación** (en este caso, la FNMT) que vincula una
clave criptográfica con la identidad de una persona. Equivale
funcionalmente a una firma manuscrita y a la presentación del DNI.

### Tipos de certificado FNMT

| Tipo | Para quién | Uso principal |
|---|---|---|
| **Persona física** | Ciudadanos | Trámites personales con la Administración |
| **Representante** | Apoderados de empresas | Actuar en nombre de una entidad jurídica |
| **Componente (servidor)** | Servidores web | Identificar sitios web (SSL/TLS) |
| **Sede electrónica** | Administraciones Públicas | Identificar sedes electrónicas oficiales |
| **AP (Administración Pública)** | Empleados públicos | Actuación administrativa automatizada |

Para ciudadanos, el más habitual es el **certificado de persona física**.

URL: `https://www.sede.fnmt.gob.es/certificados/persona-fisica`

---

## 2. Cómo obtener el certificado de persona física

El proceso tiene **tres pasos** obligatorios:

### Paso 1 — Solicitud online

1. Entra en `https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software`.
2. Introduce tu NIF/NIE y tu primer apellido.
3. Envía la solicitud. Recibirás un **código de solicitud** en tu correo
   electrónico.

**Importante**: haz la solicitud **desde el mismo navegador y equipo**
donde luego descargarás el certificado. El navegador genera un par de
claves y almacena la clave privada localmente.

### Paso 2 — Acreditación de identidad

Debes demostrar presencialmente que eres quien dices ser. Hay tres
opciones:

| Método | Dónde | Qué necesitas |
|---|---|---|
| **Oficina presencial** | Oficinas de la AEAT, Seguridad Social, ayuntamientos y otros registradores habilitados | DNI/NIE original + código de solicitud |
| **Con DNI electrónico (DNIe)** | Desde tu ordenador con lector de tarjetas | DNIe activado + PIN del DNIe |
| **Por videollamada** | Servicio de acreditación por vídeo de la FNMT | DNI/NIE original + código de solicitud |

Listado de oficinas de registro:
`https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/oficinas-registro`

### Paso 3 — Descarga e instalación

Una vez acreditada tu identidad (normalmente en minutos u horas):

1. Entra en `https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/descarga-certificado`.
2. Introduce tu NIF/NIE y tu primer apellido.
3. Descarga el certificado. Se instala automáticamente en el almacén de
   certificados del navegador/sistema operativo.

**Usa el mismo navegador y equipo** de la solicitud.

---

## 3. Instalación según navegador y sistema operativo

### Windows

- **Edge / Chrome / Brave**: el certificado se instala en el almacén de
  Windows. Accede desde *Configuración > Privacidad > Seguridad >
  Certificados* o ejecuta `certmgr.msc`.
- **Firefox**: usa su propio almacén. Ve a *Ajustes > Privacidad y
  seguridad > Certificados > Ver certificados > Sus certificados*.

### macOS

- **Safari / Chrome**: el certificado se instala en el **Llavero**
  (Keychain Access). Abre *Acceso a Llaveros > Mis certificados*.
- **Firefox**: almacén propio, igual que en Windows.

### Linux

- **Chrome/Chromium**: usa el almacén NSS del sistema. Se configura con
  `certutil`.
- **Firefox**: almacén propio.

### Verificar la instalación

Para comprobar que el certificado está bien instalado, accede a:
`https://valide.redsara.es`

Selecciona *Validar certificado* y el sistema detectará automáticamente tu
certificado instalado.

---

## 4. Copia de seguridad — Exportar e importar

Es **fundamental** hacer una copia de seguridad del certificado. Si
formateas el equipo o cambias de navegador, perderás el certificado sin
copia.

### Exportar (copia de seguridad)

El resultado es un archivo `.pfx` o `.p12` protegido con contraseña.

**Windows** (almacén del sistema):
1. `certmgr.msc` > Personal > Certificados.
2. Clic derecho sobre el certificado > Todas las tareas > Exportar.
3. Selecciona "Exportar la clave privada" > formato `.pfx`.
4. Establece una contraseña segura.

**macOS** (Llavero):
1. Acceso a Llaveros > Mis certificados.
2. Clic derecho > Exportar.
3. Formato `.p12`, establece contraseña.

**Firefox** (todos los SO):
1. Ajustes > Privacidad > Certificados > Ver certificados.
2. Selecciona el certificado > Hacer copia.
3. Guarda el `.p12` con contraseña.

### Importar (restaurar)

Doble clic en el `.pfx/.p12` y seguir el asistente, o importar desde el
gestor de certificados del navegador/SO.

---

## 5. Renovación

El certificado FNMT tiene una **validez de 4 años** (desde 2023; antes
eran 2 años).

### Cuándo renovar

- Se puede renovar **desde 60 días antes** del vencimiento.
- Si caduca, hay que solicitar uno nuevo desde cero (incluyendo
  acreditación presencial).

### Cómo renovar

1. Accede a `https://www.sede.fnmt.gob.es/certificados/persona-fisica/renovar`
   **con el certificado actual** (aún vigente).
2. El sistema te identifica con el certificado que quieres renovar.
3. Descarga el nuevo certificado.

**No requiere acreditación presencial** si se hace antes de que caduque.

---

## 6. Revocación

Si pierdes el control del certificado (robo del equipo, compromiso de la
clave privada), puedes revocarlo:

- Online: `https://www.sede.fnmt.gob.es/certificados/persona-fisica/anular`
  (necesitas otro certificado o Cl@ve para identificarte).
- Presencialmente en una oficina de registro.
- Por teléfono: 902 200 616 / 917 406 816.

---

## 7. Para qué se usa el certificado digital

El certificado es aceptado en prácticamente todas las sedes electrónicas
de la Administración española:

| Organismo | Trámites habituales |
|---|---|
| **AEAT (Hacienda)** | Declaración de la Renta, IVA trimestral, consulta de datos fiscales, obtener certificados tributarios |
| **Seguridad Social** | Consultar vida laboral, gestionar prestaciones, altas/bajas |
| **DGT** | Consultar puntos del carné, pagar multas, informes de vehículos |
| **Justicia** | Consultar procedimientos, firma de escritos judiciales |
| **Registro Civil** | Solicitar certificados de nacimiento, matrimonio, defunción |
| **Catastro** | Consultar datos catastrales, descargar certificaciones |
| **Ayuntamientos** | Padrón, tributos locales, licencias |
| **Universidades** | Matrícula, expediente académico |

También permite:

- **Firmar documentos electrónicamente** (con AutoFirma — ver skill
  **autofirma**).
- **Facturación electrónica** con la Administración.
- **Acceder a notificaciones electrónicas** (DEHú, Notific@).

---

## 8. Problemas frecuentes y soluciones

### "No me aparece el certificado al intentar identificarme"

- Comprueba que el certificado está instalado en el almacén correcto del
  navegador que usas.
- En Firefox, el almacén es independiente del sistema.
- Cierra y reabre el navegador tras instalar.
- Comprueba la fecha de caducidad del certificado.

### "Error al descargar el certificado"

- Debes usar el **mismo navegador y equipo** donde hiciste la solicitud.
- Si cambiaste de navegador o formateaste, deberás solicitar uno nuevo.
- En Chrome/Edge, asegúrate de no tener activado un proxy o VPN.

### "El certificado ha caducado"

- No se puede renovar un certificado caducado. Hay que solicitar uno
  nuevo desde el paso 1.
- Recomendación: pon un recordatorio 60 días antes del vencimiento.

### "Error de navegador no compatible"

- Desde 2021 la FNMT ya no requiere applets de Java. La solicitud y
  descarga funcionan en cualquier navegador moderno.
- Si usas un navegador muy antiguo, actualízalo.

### "¿Puedo tener el certificado en el móvil?"

- No directamente en el navegador móvil. Pero puedes importar el `.pfx`
  en apps como la de la AEAT o en el almacén del dispositivo Android
  (Ajustes > Seguridad > Credenciales).
- En iOS, se puede instalar el `.p12` como perfil de configuración.

---

## 9. Requisitos técnicos

| Requisito | Detalle |
|---|---|
| **Navegadores soportados** | Chrome, Firefox, Edge, Safari, Brave, Opera |
| **Java** | Ya no es necesario (desde 2021) |
| **Sistema operativo** | Windows 10+, macOS 10.15+, Linux (con NSS), Android, iOS |
| **Conexión** | Acceso a internet para solicitud, acreditación y descarga |

---

## 10. Comparativa: certificado digital vs. Cl@ve vs. DNIe

| Característica | Certificado FNMT | Cl@ve | DNIe |
|---|---|---|---|
| **Formato** | Software (en navegador) | Usuario + contraseña/PIN | Chip en tarjeta física |
| **Obtención** | Online + acreditación | Registro presencial/vídeo | Al renovar el DNI |
| **Validez** | 4 años | Indefinida (PIN temporal) | Hasta caducidad del DNI |
| **Hardware extra** | No | No | Lector de tarjetas |
| **Firma documentos** | Sí (con AutoFirma) | No (Cl@ve solo identifica*) | Sí |
| **Nivel eIDAS** | Cualificado | Sustancial | Cualificado |

*Cl@ve Firma permite firma en la nube en algunas sedes, pero no firma
local de documentos como el certificado FNMT o el DNIe.

---

## 11. URLs de referencia

| Recurso | URL |
|---|---|
| Portal certificados FNMT | `https://www.sede.fnmt.gob.es/certificados/persona-fisica` |
| Solicitar certificado | `https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software` |
| Renovar certificado | `https://www.sede.fnmt.gob.es/certificados/persona-fisica/renovar` |
| Revocar certificado | `https://www.sede.fnmt.gob.es/certificados/persona-fisica/anular` |
| Oficinas de registro | `https://www.sede.fnmt.gob.es/certificados/persona-fisica/obtener-certificado-software/oficinas-registro` |
| Validar certificado (VALIDe) | `https://valide.redsara.es` |
| Portal Cl@ve | `https://clave.gob.es` |

---

## Cuándo NO usar esta skill

- Si pregunta por **Cl@ve** (registro, PIN, permanente) → **clave**.
- Si pregunta por el **DNI electrónico** (chip, lector, activación) → **dnie**.
- Si pregunta por **firmar documentos** con AutoFirma → **autofirma**.
- Si pregunta por **obligaciones fiscales del autónomo** y menciona el
  certificado como medio de acceso → **fiscalidad-autonomos** (esta skill
  solo explica el certificado, no la fiscalidad).
- Si pregunta por **trámites con la Seguridad Social** → **seguridad-social**.
