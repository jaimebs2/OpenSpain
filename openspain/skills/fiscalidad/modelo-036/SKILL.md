---
name: fiscalidad-modelo-036
description: "Use when the user asks about the Spanish census declaration Modelo 036 (or simplified Modelo 037): initial registration as autónomo or company, modifying existing details (address, tax regime, obligations), deregistration, or any ROI (Registro de Operadores Intracomunitarios) alta/baja. Also covers page-by-page structure, key casillas (120 modificación, 122 domicilio, 130 ROI, 150 baja, 510-530 régimen IVA, 582/584 alta ROI), step-by-step navigation through Sede Electrónica AEAT, validation, firma y envío, and what happens after submission. This is the reference skill for all declaración censal topics — other skills link here instead of duplicating. Triggers on: 'modelo 036', 'modelo 037', 'declaración censal', 'modificación censal', 'casilla 130', 'casilla 582', 'casilla 584', '036 vs 037', 'alta censal autónomo', 'alta censal empresa', 'cambio domicilio fiscal Hacienda', 'baja censal', 'alta obligaciones fiscales', 'NIF provisional sociedad', 'sede agencia tributaria 036', 'dónde marcar ROI en 036', 'alta operadores intracomunitarios 036'."
---

# Fiscalidad — Modelo 036 (Declaración Censal)

Skill de referencia sobre la **declaración censal** de la AEAT. El Modelo
036 (y su versión simplificada 037) es el vehículo administrativo para
informar a Hacienda de **todo cambio en tu situación fiscal**: darte de
alta, modificar datos, darte de baja, cambiar régimen de IVA/IRPF, añadir
obligaciones periódicas, entrar o salir del ROI, cambiar domicilio, etc.

Otras skills del repo (`fiscalidad-autonomos`, `fiscalidad-operaciones-intracomunitarias`,
`alta-autonomo`, `crear-empresa`) **enlazan aquí** para el detalle de
casillas y trámites, en vez de duplicar contenido.

> Esta skill orienta sobre cómo se cumplimenta y presenta. **No sustituye
> asesoramiento fiscal profesional ni presenta declaraciones.**

---

## 1. Qué es la declaración censal

Es el registro administrativo donde Hacienda guarda tu perfil fiscal:
quién eres, qué actividad realizas, qué régimen tributas, qué modelos
tienes que presentar y qué registros especiales tienes activos.

El Modelo 036 se usa tanto para **altas**, **modificaciones** como
**bajas** del censo de empresarios, profesionales y retenedores.

---

## 2. Cuándo hay que presentarlo

| Situación | Cuándo |
|---|---|
| **Alta inicial** como autónomo o empresa | Antes de iniciar la actividad (antes de la primera factura) |
| **Modificación** de cualquier dato fiscal | En el plazo de **1 mes** desde que ocurre el cambio |
| **Baja** en el censo | En el plazo de **1 mes** desde el cese efectivo de actividad |
| **Alta en ROI** | Antes de realizar la primera operación intracomunitaria |
| **Cambio de régimen** IVA/IRPF | En diciembre del año anterior al que tendrá efecto (regla general) |

Las modificaciones fuera de plazo pueden generar un pequeño requerimiento
o sanción formal (100–200 €), aunque en la práctica, si no hay ocultación,
suele resolverse sin más.

---

## 3. 036 vs 037: cuál usar

### Modelo 037 (simplificado)

Versión reducida. Válido **solo** si se cumplen todas estas condiciones:

- Persona física (no vale para sociedades).
- Residente en territorio español.
- NIF asignado.
- No figurará como gran empresa.
- No actúa por representante.
- Domicilio fiscal coincide con el de gestión administrativa.
- Tributa en **estimación directa** del IRPF (no módulos).
- Tributa en **régimen general** del IVA (u otros no especiales
  distintos del simplificado, agricultura o recargo de equivalencia).
- **No realiza operaciones intracomunitarias** → el 037 **no vale para
  darse de alta en ROI**.
- No satisface rendimientos de capital mobiliario.
- No está en el SII (Suministro Inmediato de Información).

### Modelo 036 (completo)

Obligatorio en cualquier otro caso. En particular:

- Sociedades (SL, SA, cooperativas…).
- Operaciones intracomunitarias (alta/baja ROI).
- Régimen de módulos (IRPF) o simplificado (IVA).
- Estimación directa normal.
- Recargo de equivalencia.
- SII.
- Varios locales o varias actividades con régimen distinto.

> **Regla práctica**: si tu duda es *"¿y el ROI?"*, la respuesta es
> siempre **036**. El 037 no tiene casilla para eso.

---

## 4. Estructura del Modelo 036 por páginas

| Página | Contenido |
|---|---|
| **P1** | Causas de presentación (alta, modificación, baja, ROI…). Aquí se marca qué vas a declarar |
| **P2A** | Identificación persona física |
| **P2B** | Identificación persona jurídica / entidad |
| **P3** | Representantes |
| **P4** | Domicilio fiscal y domicilio a efectos de notificaciones |
| **P5** | Declaración de actividades económicas y locales. Aquí va la sección **D) Registros** (ROI, REDEME, etc.) |
| **P6** | Impuesto sobre el Valor Añadido (régimen, exenciones, deducciones) |
| **P7** | Impuesto sobre la Renta (régimen de estimación, pagos fraccionados) |
| **P8** | Retenciones e ingresos a cuenta (quién paga a quién) |
| **P9** | Regímenes especiales varios y declaraciones censales previas |
| **P10** | Relación de sucesores, socios, miembros o partícipes |
| **P11** | Últimas páginas — firma, lugar, fecha |

Al cumplimentar el formulario telemático no hace falta ir por orden; el
sistema habilita las páginas relevantes según lo marcado en la P1.

---

## 5. Supuestos típicos y casillas clave

### 5.1 Alta inicial de autónomo (persona física)

**Página 1 — Causas**:
- Casilla **111**: Alta en el Censo de empresarios, profesionales y
  retenedores.
- Casilla **118**: Fecha de inicio de actividad.
- Si hay operaciones intracomunitarias desde el principio: casilla
  **130** (ver §5.4).

**Página 2A**: datos personales (NIF, nombre, apellidos, estado civil,
domicilio).

**Página 4**: domicilio fiscal.

**Página 5**: epígrafe del IAE, tipo de actividad, local afecto.

**Página 6**: régimen de IVA (casillas 510–530).

**Página 7**: régimen de IRPF (estimación directa simplificada por
defecto, casillas 600–614).

### 5.2 Modificación de datos

**Página 1**:
- Casilla **120**: Solicitud de modificación.
- Marcar además las casillas específicas de lo que cambia (ej. 122 si
  cambia el domicilio fiscal, 131 si cambia una obligación periódica).

Luego rellenar **solo** las páginas y campos del dato que cambia.

### 5.3 Baja en el censo

**Página 1**:
- Casilla **150**: Solicitud de baja en el Censo.
- Casilla **151**: Fecha de cese efectivo.
- Casilla **152**: Causa de la baja (fallecimiento, cese, disolución…).

### 5.4 Alta en el ROI (Registro de Operadores Intracomunitarios)

Es el supuesto más habitual de modificación censal para un autónomo que
empieza a comprar servicios SaaS de proveedores UE (Anthropic, AWS,
Stripe…).

**Página 1**:
- Casilla **120**: Modificación (si ya estabas de alta).
- Casilla **130**: Solicitud de alta/baja en el Registro de Operadores
  Intracomunitarios.

**Página 5 — bloque D) Registros**:
- Casilla **582**: Alta.
- Casilla **584**: Fecha solicitada del alta.

> **Ojo con la fecha de la 584**: pon la fecha del día que presentas el
> modelo, no una fecha retroactiva. El VIES no es retroactivo y Hacienda
> lo detecta. La deducción del IVA de facturas UE recibidas antes de
> tener el ROI sigue siendo defendible por jurisprudencia europea siempre
> que seas empresario real y el gasto esté vinculado a la actividad.

**Qué pasa después**: el alta en ROI **no es automática**. Hacienda
tiene hasta **3 meses** para resolver y puede enviar un requerimiento
pidiendo justificación (correos con proveedores, facturas previas,
presupuestos). Si no contesta en 3 meses, se entiende concedida por
silencio positivo.

Verifica tu alta efectiva en VIES:
`https://ec.europa.eu/taxation_customs/vies/` (introduce "ES-España" +
tu NIF sin guiones ni espacios).

Para la operativa trimestral (Modelo 303 autoimputación, Modelo 349):
ver **fiscalidad-operaciones-intracomunitarias**.

### 5.5 Baja en el ROI

**Página 1**: casilla **120** + casilla **130**.
**Página 5 — D) Registros**: casilla **583** (Baja).

### 5.6 Cambio de domicilio fiscal

**Página 1**:
- Casilla **120**: Modificación.
- Casilla **122**: Cambio de domicilio fiscal.

**Página 4**: nuevo domicilio fiscal.

Plazo: 1 mes desde el cambio.

### 5.7 Alta de nuevas obligaciones periódicas

Ejemplos: empiezas a contratar empleados (retenciones 111), alquilas un
local y empiezas a pagar retención al arrendador (115), te conviertes en
gran empresa (declaración mensual).

**Página 1**:
- Casilla **120**: Modificación.
- Casilla **131**: Alta de obligaciones periódicas.

**Página 7 u 8**: marcar la obligación concreta (modelo 111, 115, 180,
190, 303, 390, etc.) y fecha de alta.

### 5.8 Cambio de régimen de IVA

**Página 1**: casilla **120** + casilla marcada en la sección de IVA.
**Página 6**: régimen nuevo (general 510, simplificado 511, recargo de
equivalencia 514, REAGYP 518, etc.) y fecha de efectos.

La mayoría de cambios de régimen surten efecto desde el 1 de enero
siguiente. Plazo de presentación: durante diciembre del año anterior.

### 5.9 Cambio de régimen de IRPF

**Página 1**: casilla **120**.
**Página 7**: régimen nuevo (estimación directa normal 600, directa
simplificada 601, estimación objetiva/módulos 602, renuncia a estimación
objetiva 610, etc.).

---

## 6. Paso a paso por la Sede Electrónica de la AEAT

1. Entrar en `https://sede.agenciatributaria.gob.es` con **certificado
   digital** o **Cl@ve**.
2. En la pantalla principal, **no usar el buscador general** (lleva a
   manuales). Hacer clic en el recuadro **"Censos, NIF y domicilio
   fiscal"**.
3. Dentro, abrir la sección **"Gestiones destacadas"** → hacer clic en
   **"Modelo 036. Cumplimentación y presentación telemática"**.

   > **Evita el enlace "Censos WEB"**: es un asistente simplificado y no
   > muestra las opciones de ROI ni de modificaciones complejas.

4. Cuando el sistema pregunte *"¿Quieres acceder al Modelo 036
   simplificado?"* → responder **NO** si el trámite implica ROI,
   operaciones intracomunitarias, módulos o cualquier cosa fuera del
   supuesto del 037.
5. Cumplimentar el formulario siguiendo los supuestos de §5.
6. Usar **Validar declaración** antes de firmar para detectar campos
   obligatorios sin rellenar.
7. En la pantalla de firma (normalmente P11) rellenar:
   - **Lugar**: municipio del domicilio fiscal.
   - **Fecha**: la del día de presentación (normalmente autocompletada).
   - **Firma en calidad de**: seleccionar **Titular** (o
     **Interesado**) si presenta el propio contribuyente; **Representante**
     si lo hace un tercero autorizado.
   - **Firmado D./Dª.**: nombre y apellidos completos.
8. Clic en **Firmar y Enviar** → ventana de confirmación → marcar
   **Conforme** → **Firmar y Enviar** de nuevo.
9. Descargar el **PDF del justificante** con el sello electrónico. Es el
   comprobante oficial de presentación.

---

## 7. Qué pasa después de presentar

- **Alta/modificación genéricas**: el cambio normalmente surte efecto
  de inmediato en el censo interno de la AEAT.
- **Alta en ROI**: puede tardar hasta **3 meses**. Hacienda puede pedir
  documentación justificativa (facturas UE, correos con proveedores,
  presupuestos, URL del servicio contratado). Si no responden en 3
  meses, silencio positivo.
- **Notificaciones**: la AEAT manda cualquier requerimiento a la
  **dirección electrónica habilitada (DEHú)** si estás obligado, o a
  tu domicilio fiscal en otro caso. Revisar periódicamente el apartado
  "Notificaciones" de la Sede.

---

## 8. Enlaces oficiales

| Recurso | URL |
|---|---|
| Ficha procedimiento Modelo 036/037 | `https://sede.agenciatributaria.gob.es/Sede/procedimientoini/G322.shtml` |
| Portal Censos, NIF y domicilio fiscal | `https://sede.agenciatributaria.gob.es/Sede/censos-nif-domicilio-fiscal.html` |
| Sede Electrónica AEAT | `https://sede.agenciatributaria.gob.es` |
| VIES (verificación NIF-IVA) | `https://ec.europa.eu/taxation_customs/vies/` |
| Cita previa AEAT | `https://sede.agenciatributaria.gob.es/Sede/procedimientoini/GC07.shtml` |

---

## 9. Resumen rápido

```
SUPUESTO                         →  CASILLAS CLAVE              →  PÁGINAS
─────────────────────────────────────────────────────────────────────────
Alta inicial autónomo            →  111, 118                    →  P1 + P2A + P4 + P5 + P6 + P7
Alta inicial sociedad            →  111, 118                    →  P1 + P2B + P3 + P4 + P5 + P6
Modificación (genérica)          →  120                         →  P1 + páginas afectadas
Cambio domicilio fiscal          →  120, 122                    →  P1 + P4
Alta ROI                         →  120, 130 + 582, 584         →  P1 + P5 bloque D
Baja ROI                         →  120, 130 + 583              →  P1 + P5 bloque D
Alta obligaciones periódicas     →  120, 131                    →  P1 + P7/P8
Cambio régimen IVA               →  120, 510–530                →  P1 + P6
Cambio régimen IRPF              →  120, 600–614                →  P1 + P7
Baja en el censo                 →  150, 151, 152               →  P1 + P11
```

---

## Cuándo NO usar esta skill

- Si preguntan por el **proceso completo** de convertirse en autónomo
  (Hacienda + RETA + ayuntamiento) → **alta-autonomo**.
- Si preguntan por **obligaciones fiscales continuas** tras el alta
  (calendario, modelos trimestrales, facturación) → **fiscalidad-autonomos**.
- Si preguntan por **crear una sociedad** (SL, SA) → **crear-empresa**.
- Si preguntan por qué hay que **declarar el IVA de una factura UE**
  (autoimputación, Modelo 349, reverse charge) → **fiscalidad-operaciones-intracomunitarias**.
- Si preguntan por el **Modelo 303** en general (casillas, regímenes,
  tipos de IVA) → **fiscalidad-iva**.
- Si preguntan por **certificado digital** o **Cl@ve** →
  **certificado-digital** / **clave**.
