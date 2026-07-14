---
name: autofirma
description: "Use when the user asks about AutoFirma (the Spanish government's electronic signing application), electronic signatures in Spain, how to sign documents digitally, types of electronic signature (simple, advanced, qualified under eIDAS), how to download and install AutoFirma on Windows/macOS/Linux, how it integrates with public administration e-services, how to validate signatures with VALIDe, or common installation problems (Java, permissions). This is the detailed skill for AutoFirma and electronic signing — for the FNMT digital certificate use identidad-digital-certificado-digital; for Cl@ve use identidad-digital-clave; for the DNIe use identidad-digital-dnie. Triggers on: 'AutoFirma', 'autofirma', 'firma electrónica', 'firmar documento', 'firmar PDF', 'firma digital', 'firma cualificada', 'firma avanzada', 'eIDAS', 'VALIDe', 'validar firma', 'Client @firma', 'firmar trámite', 'sello electrónico', 'firma en la nube', 'cómo firmar electrónicamente', 'descargar AutoFirma'."
---

# AutoFirma y Firma Electrónica en España — Guía Completa

**AutoFirma** es la aplicación de firma electrónica desarrollada por el
Gobierno de España (Ministerio de Asuntos Económicos y Transformación
Digital). Es la herramienta estándar para firmar documentos y trámites
electrónicos con la Administración Pública española.

> Esta skill es una guía informativa. **No firma documentos ni accede
> a tus certificados.** Para firmar, descarga AutoFirma y usa tu
> certificado digital o DNIe.

---

## 1. Qué es AutoFirma

AutoFirma es una aplicación de escritorio que:

- **Firma documentos electrónicamente** (PDFs, XMLs y otros formatos).
- Se **integra con las sedes electrónicas** de la Administración: cuando
  un trámite online requiere firma, la sede lanza AutoFirma
  automáticamente.
- Funciona con **certificado digital FNMT**, **DNI electrónico** y otros
  certificados reconocidos.
- Es **gratuita y de código abierto**.

### Nombre técnico

El nombre completo del proyecto es **Cliente @firma** (Client @firma).
AutoFirma es el nombre comercial de la versión de escritorio.

URL de descarga: `https://firmaelectronica.gob.es/Home/Descargas.html`

---

## 2. Marco legal: tipos de firma electrónica

La firma electrónica en España se rige por el **Reglamento eIDAS**
(Reglamento UE 910/2014) y la **Ley 6/2020** de servicios electrónicos
de confianza. Existen tres niveles de firma:

### Tipos de firma según eIDAS

| Tipo | Nivel | Descripción | Validez legal |
|---|---|---|---|
| **Firma electrónica simple** | Bajo | Cualquier dato electrónico asociado a otros datos (ej. un nombre al pie de un email) | Admisible como prueba, pero con menor fuerza probatoria |
| **Firma electrónica avanzada** | Medio | Vinculada al firmante de forma única, permite identificarlo, creada con datos bajo control exclusivo del firmante | Plena validez jurídica |
| **Firma electrónica cualificada** | Alto | Firma avanzada creada con un dispositivo cualificado de creación de firma y basada en un certificado cualificado | **Equivalente legal a la firma manuscrita** (art. 25.2 eIDAS) |

### Qué firma produce AutoFirma

AutoFirma genera **firma avanzada** o **cualificada** dependiendo del
certificado utilizado:

| Certificado | Tipo de firma resultante |
|---|---|
| Certificado FNMT de persona física | Cualificada |
| DNI electrónico (DNIe) | Cualificada |
| Certificados de otros prestadores cualificados | Cualificada |
| Certificados no cualificados | Avanzada |

---

## 3. Descarga e instalación

### Requisitos previos

| Requisito | Detalle |
|---|---|
| **Java** | AutoFirma incluye su propio Java embebido desde la versión 1.8. En versiones anteriores necesitabas Java 8+ instalado |
| **Certificado digital** | FNMT, DNIe u otro certificado reconocido instalado en el sistema |
| **Sistema operativo** | Windows 10+, macOS 10.15+, Linux (64 bits) |

### Descarga

Descarga la versión para tu sistema operativo desde:
`https://firmaelectronica.gob.es/Home/Descargas.html`

### Instalación por sistema operativo

#### Windows

1. Descarga el archivo `.exe`.
2. Ejecuta el instalador como administrador.
3. Sigue el asistente de instalación.
4. AutoFirma se instala y queda disponible como aplicación y como
   protocolo del navegador (`afirma://`).

#### macOS

1. Descarga el archivo `.dmg`.
2. Abre el `.dmg` y arrastra AutoFirma a Aplicaciones.
3. La primera vez que la abras, macOS puede bloquearla por ser de un
   "desarrollador no identificado". Ve a *Preferencias del Sistema >
   Seguridad y Privacidad > Abrir igualmente*.
4. AutoFirma necesita permisos de accesibilidad en macOS recientes.

#### Linux

1. Descarga el paquete `.deb` (Debian/Ubuntu) o `.rpm` (Fedora/RHEL).
2. Instala con el gestor de paquetes:
   ```
   sudo dpkg -i AutoFirma_X.Y.Z.deb
   sudo apt-get install -f   # resolver dependencias
   ```
3. O para RPM:
   ```
   sudo rpm -i AutoFirma_X.Y.Z.rpm
   ```

### Verificar la instalación

1. Abre AutoFirma desde el menú de aplicaciones.
2. Debería mostrar la ventana principal con opciones de firma.
3. Si no detecta certificados, revisa la sección de problemas frecuentes.

---

## 4. Cómo firmar documentos con AutoFirma

### Firma local de documentos

Para firmar un archivo (PDF, XML, etc.) directamente:

1. Abre AutoFirma.
2. Pulsa "Seleccionar ficheros a firmar".
3. Elige el documento.
4. AutoFirma detecta los certificados instalados y te pide seleccionar
   uno.
5. Introduce el PIN/contraseña del certificado (o el PIN del DNIe si
   usas lector).
6. Se genera el archivo firmado (`.xsig`, `.csig` o `.pdf` firmado según
   el formato elegido).

### Formatos de firma

| Formato | Extensión | Uso principal |
|---|---|---|
| **XAdES** | `.xsig` | Firma de documentos XML. Formato por defecto en la AGE |
| **CAdES** | `.csig` | Firma binaria genérica. Para cualquier tipo de archivo |
| **PAdES** | `.pdf` | Firma embebida en PDF. El PDF resultante es verificable visualmente |
| **FacturaE** | `.xsig` | Formato específico para facturación electrónica |

### Firma desde sedes electrónicas

Cuando realizas un trámite en una sede electrónica que requiere firma:

1. La sede web detecta que tienes AutoFirma instalado.
2. AutoFirma se lanza automáticamente (protocolo `afirma://`).
3. Muestra el documento a firmar y pide seleccionar certificado.
4. Tras firmar, el resultado se envía de vuelta a la sede.
5. El trámite queda firmado y registrado.

**No necesitas abrir AutoFirma manualmente** — la sede lo invoca.

---

## 5. Validación de firmas — VALIDe

Para verificar que un documento está correctamente firmado, usa
**VALIDe** (Validación de firmas y certificados online):

URL: `https://valide.redsara.es`

### Qué puede validar

| Validación | Descripción |
|---|---|
| **Validar firma** | Comprueba que la firma electrónica de un documento es válida y no ha sido alterado |
| **Validar certificado** | Comprueba que un certificado digital es válido y no está revocado |
| **Generar firma** | Permite firmar un documento desde el navegador (requiere certificado) |

### Cómo validar un documento firmado

1. Accede a `https://valide.redsara.es`.
2. Selecciona "Validar firma".
3. Sube el documento firmado (`.xsig`, `.csig`, `.pdf` firmado).
4. VALIDe muestra el resultado: firmante, fecha, validez del certificado
   y si el documento ha sido modificado.

---

## 6. Firma electrónica en la Administración española

### Cuándo se necesita firma electrónica

| Trámite | ¿Requiere firma? | Alternativas |
|---|---|---|
| Consultar datos (Renta, vida laboral) | No — basta con identificación (Cl@ve, certificado) | — |
| Presentar la declaración de la Renta | Sí | Certificado/DNIe + AutoFirma, Cl@ve Firma, o confirmación del borrador con Cl@ve PIN |
| Presentar modelos trimestrales (IVA, IRPF) | Sí | Certificado + firma automática en sede, Cl@ve Firma |
| Registrar una solicitud/instancia | Sí | AutoFirma, Cl@ve Firma |
| Firmar un contrato con la Administración | Sí | AutoFirma o firma manuscrita presencial |
| Presentar recursos o escritos en juzgados | Sí | Certificado + AutoFirma o DNIe |

### Sede electrónica vs. firma local

- **En sedes electrónicas**: la firma se realiza de forma integrada.
  AutoFirma se lanza automáticamente desde el navegador.
- **Firma local**: firmas un archivo en tu ordenador (ej. PDF para
  adjuntar a un email o subir a un registro). Usas AutoFirma directamente.

---

## 7. Problemas frecuentes y soluciones

### "AutoFirma no se abre desde el navegador"

- Comprueba que AutoFirma está instalado correctamente.
- En Chrome/Edge, el protocolo `afirma://` debe estar registrado. Prueba
  a reinstalar AutoFirma.
- En Firefox, puede pedir permiso para abrir la aplicación externa. Marca
  "Recordar mi elección" y acepta.
- Limpia la caché del navegador.

### "Error de Java" / "No se encuentra la máquina virtual de Java"

- Desde AutoFirma 1.8, Java va embebido. Si usas una versión anterior,
  actualiza a la última versión.
- Si persiste, instala Java 8 o superior manualmente desde
  `https://adoptium.net`.

### "No se detectan certificados"

- Comprueba que el certificado está instalado en el almacén del sistema
  (no solo en el de Firefox, que es independiente).
- Si usas DNIe, asegúrate de que el lector está conectado y los drivers
  instalados.
- Reinicia AutoFirma y el navegador.

### "Permiso denegado en macOS"

- Ve a *Preferencias del Sistema > Seguridad y Privacidad*.
- Permite AutoFirma en "Permitir apps descargadas de".
- Puede requerir permisos de Accesibilidad y Automatización.

### "Error de firma: el certificado no es de confianza"

- Asegúrate de usar un certificado cualificado (FNMT, DNIe u otro
  prestador reconocido).
- Comprueba que el certificado no ha caducado ni está revocado.

---

## 8. Otros clientes de firma

Además de AutoFirma, existen otros clientes de firma usados en España:

| Cliente | Emisor | Uso |
|---|---|---|
| **AutoFirma** | Gobierno de España | Firma local + integración con sedes de la AGE |
| **Cl@ve Firma** | Gobierno de España | Firma en la nube sin certificado local (ver skill **clave**) |
| **PortaFirmas** | AGE | Plataforma de firma de circuitos documentales internos de la Administración |
| **Firmar&** | Comunidades autónomas | Versiones adaptadas para CC.AA. |
| **Adobe Acrobat** | Adobe | Firma de PDFs con certificados instalados (alternativa comercial) |

---

## 9. Requisitos técnicos detallados

| Componente | Requisito |
|---|---|
| **Windows** | Windows 10 o superior (64 bits) |
| **macOS** | macOS 10.15 Catalina o superior |
| **Linux** | Distribuciones con soporte de paquetes .deb o .rpm (64 bits) |
| **Navegadores** | Chrome, Firefox, Edge, Safari (para integración con sedes) |
| **Java** | Embebido desde AutoFirma 1.8. Si usas versión anterior: Java 8+ |
| **Certificado** | FNMT persona física, DNIe, o cualquier certificado X.509 cualificado |

---

## 10. URLs de referencia

| Recurso | URL |
|---|---|
| Descarga de AutoFirma | `https://firmaelectronica.gob.es/Home/Descargas.html` |
| Documentación técnica (@firma) | `https://administracionelectronica.gob.es/ctt/clienteafirma` |
| VALIDe — validación de firmas | `https://valide.redsara.es` |
| Reglamento eIDAS | `https://www.boe.es/buscar/doc.php?id=DOUE-L-2014-81822` |
| Ley 6/2020 de confianza electrónica | `https://www.boe.es/buscar/act.php?id=BOE-A-2020-14046` |

---

## Cuándo NO usar esta skill

- Si pregunta por **obtener el certificado digital FNMT** (solicitar,
  instalar, renovar) → **certificado-digital**.
- Si pregunta por **Cl@ve** (registro, PIN, Permanente, Cl@ve Firma) →
  **clave**.
- Si pregunta por el **DNI electrónico** (chip, lector, activación) →
  **dnie**.
- Si pregunta por **obligaciones fiscales del autónomo** y menciona la
  firma como paso de un trámite → **fiscalidad-autonomos**.
- Si pregunta por **trámites con la Seguridad Social** →
  **seguridad-social**.
