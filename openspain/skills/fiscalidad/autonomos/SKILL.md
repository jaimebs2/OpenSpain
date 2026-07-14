---
name: fiscalidad-autonomos
description: "Use when the user asks general questions about fiscal obligations for self-employed workers (autónomos) in Spain: what taxes they pay, filing calendar, how to register (alta en Hacienda, modelo 036/037), invoicing requirements, how much to save for taxes, annual income tax return (Renta), digital access (Cl@ve, certificado digital), or bookkeeping obligations. This is the overview skill — for specific tax details use fiscalidad-iva or fiscalidad-irpf-autonomos. Triggers on: 'obligaciones autónomo', 'fiscalidad autónomo', 'impuestos autónomo', 'alta autónomo Hacienda', 'modelo 036', 'modelo 037', 'calendario fiscal autónomo', 'factura autónomo', 'cómo hacer factura', 'cuánto guardar impuestos', 'declaración renta autónomo', 'Cl@ve', 'certificado digital autónomo', 'libros registro autónomo', 'qué impuestos pago', 'darme de alta autónomo', 'epígrafe IAE'."
---

# Fiscalidad — Guía General para Autónomos

Todo lo que un trabajador autónomo (persona física con actividad económica)
necesita saber sobre sus obligaciones fiscales en España, a vista de pájaro.

Para **detalle** sobre cada impuesto concreto, consulta las skills
específicas: **fiscalidad-iva** (Modelo 303) y
**fiscalidad-irpf-autonomos** (Modelos 130/131).

> Esta skill orienta sobre obligaciones generales. **No sustituye
> asesoramiento fiscal profesional ni presenta declaraciones.**

---

## 1. Alta como autónomo: los pasos fiscales

Antes de empezar a facturar hay que darse de alta en dos sitios:

### Hacienda (AEAT) — Modelo 036 o 037

- **Modelo 037** (simplificado): válido para la mayoría de autónomos
  personas físicas en estimación directa simplificada y régimen general
  de IVA. Es más corto y sencillo.
- **Modelo 036** (completo): obligatorio si tributa en estimación
  directa normal, régimen de módulos, SII, operaciones intracomunitarias
  o tiene más de un local.

Para el detalle de casillas, supuestos de modificación (cambio de
domicilio, alta en ROI, cambio de régimen), y paso a paso por la Sede
Electrónica, consulta la skill **fiscalidad-modelo-036**.

En el alta censal se elige:

1. **Epígrafe del IAE** (Impuesto de Actividades Económicas): código que
   identifica la actividad. Sección 1.ª = actividades empresariales.
   Sección 2.ª = actividades profesionales (estas aplican retención en
   factura). Sección 3.ª = artísticas. Se puede tener más de un
   epígrafe.
2. **Régimen de IRPF**: estimación directa simplificada (por defecto y
   la más habitual), estimación directa normal, o estimación objetiva
   (módulos, solo para actividades incluidas en la Orden de Módulos).
3. **Régimen de IVA**: general (por defecto), simplificado (módulos),
   recargo de equivalencia (comerciantes minoristas) u otros especiales.
4. **Obligaciones periódicas**: qué modelos vas a presentar (303, 130,
   etc.).
5. **Domicilio fiscal y local afecto** (si existe).

El alta se puede hacer por internet (con certificado digital o Cl@ve) o
presencialmente en oficinas de la AEAT.

URL: `https://sede.agenciatributaria.gob.es/Sede/procedimientoini/G322.shtml`

### Seguridad Social — RETA

Además del alta en Hacienda, hay que darse de alta en el Régimen Especial
de Trabajadores Autónomos (RETA) a través de la Seguridad Social.
Consulta la skill **seguridad-social** para detalle sobre cuotas,
tarifa plana y trámites.

---

## 2. Qué impuestos paga un autónomo

Un autónomo persona física tiene dos impuestos principales:

| Impuesto | Qué es | Modelo trimestral | Skill con detalle |
|---|---|---|---|
| **IVA** | Impuesto sobre el consumo. Se cobra al cliente y se ingresa a Hacienda descontando el IVA de los gastos | Modelo 303 | **fiscalidad-iva** |
| **IRPF** | Impuesto sobre la renta personal. Se anticipa trimestralmente y se regulariza con la Renta anual | Modelo 130 (directa) o 131 (módulos) | **fiscalidad-irpf-autonomos** |

Además, según la actividad, pueden existir otras obligaciones:

- **Modelo 111**: si contrata empleados o paga a profesionales con
  retención (trimestral).
- **Modelo 115**: si alquila un local de negocio (trimestral).
- **Modelo 349**: si realiza operaciones con la UE (trimestral). Para
  el detalle (ROI/VIES, reverse charge, autoliquidación en el 303 y
  cumplimentación del 349) → skill **fiscalidad-operaciones-intracomunitarias**.
- **Modelo 347**: operaciones con terceros que superen 3.005,06 €/año
  (anual, febrero).

---

## 3. Calendario fiscal del autónomo

### Presentaciones trimestrales

| Periodo | Plazo | Modelos habituales |
|---|---|---|
| 1T (ene–mar) | 1–20 abril | 303, 130/131, 111*, 115* |
| 2T (abr–jun) | 1–20 julio | 303, 130/131, 111*, 115* |
| 3T (jul–sep) | 1–20 octubre | 303, 130/131, 111*, 115* |
| 4T (oct–dic) | 1–30 enero (año siguiente) | 303, 130/131, 111*, 115* |

*Solo si corresponde según la actividad.

Si el último día cae en sábado o festivo, el plazo se extiende al
siguiente día hábil.

### Presentaciones anuales

| Plazo | Modelo | Qué es |
|---|---|---|
| 1–30 enero | **390** | Resumen anual del IVA (informativo, sin pago). Exonerados si tributan en módulos o SII |
| 1–30 enero | **190** | Resumen anual de retenciones e ingresos a cuenta (si presentó 111) |
| 1–30 enero | **180** | Resumen anual de retenciones por alquileres (si presentó 115) |
| Febrero | **347** | Operaciones con terceros > 3.005,06 €/año |
| Abril–junio | **100** | **Declaración de la Renta** (IRPF anual) — ver sección más abajo |

### Calendario fiscal completo

La AEAT publica cada año el calendario oficial del contribuyente:
`https://sede.agenciatributaria.gob.es/Sede/ayuda/calendario-contribuyente/calendario-contribuyente-2026.html`

---

## 4. Facturación

Todo autónomo está obligado a emitir factura por sus operaciones.
Vista rápida:

- **Factura completa**: documento legal con NIF del emisor y destinatario,
  base, IVA, retención IRPF si aplica, total. Es la única que permite al
  destinatario deducir.
- **Factura simplificada** (antes "ticket"): para importes ≤ 400 € IVA
  incluido (o ≤ 3.000 € en hostelería, taxis, peluquerías, aparcamientos
  y otras actividades autorizadas). No lleva datos completos del
  destinatario.
- **Recibo**: comprobante de pago, **no** sustituye a la factura para
  deducir.
- **Conservación**: 4 años fiscales (hasta 10 si hay bases negativas
  pendientes).
- **Factura electrónica obligatoria**: Ley Crea y Crece (B2B) y
  **VeriFactu** / SIF (RD 1007/2023) — entrada en vigor escalonada desde
  2026.

Para detalle completo (datos obligatorios, rectificativas, VeriFactu,
facturas UE sin IVA, facturas de fuera UE, software homologado) →
skill **fiscalidad-facturacion**.

---

## 5. Cuánto reservar para impuestos

Una regla práctica habitual: **reservar entre el 30 % y el 40 %** de
cada factura cobrada para cubrir impuestos y Seguridad Social.

### Desglose orientativo

| Concepto | Porcentaje aproximado |
|---|---|
| IVA a ingresar (21 % cobrado − IVA deducible de gastos) | Variable, pero suele quedar un 10-15 % neto |
| IRPF pago fraccionado (20 % del beneficio neto) | ~5-10 % de la facturación bruta |
| Cuota de autónomos (Seguridad Social) | Cantidad fija mensual según ingresos reales |

Estos porcentajes son **orientativos** y varían mucho según los gastos
deducibles, el tipo de IVA de la actividad y la cuota de autónomos.

**Consejo práctico**: abrir una cuenta separada y transferir el 30-35 %
de cada cobro. Así nunca falta dinero para los trimestres.

---

## 6. Declaración de la Renta (Modelo 100)

Sí, un autónomo **debe hacer la declaración de la Renta anual**, igual
que un asalariado, pero incluyendo los rendimientos de su actividad
económica.

### Datos clave

- **Plazo**: abril–junio del año siguiente (las fechas exactas varían
  cada año; consulta el calendario fiscal).
- **Obligación**: todo autónomo que haya estado de alta está obligado a
  presentarla, independientemente de sus ingresos.
- **Qué se declara**: los rendimientos de la actividad económica
  (ingresos − gastos deducibles) junto con el resto de rentas
  personales (nóminas, alquileres, inversiones…).
- **Pagos fraccionados**: los modelos 130/131 presentados durante el año
  son **anticipos** del IRPF. Se restan en la Renta. Si has pagado más
  de lo que te corresponde, Hacienda te devuelve la diferencia.
- **Presentación**: Renta Web (`https://sede.agenciatributaria.gob.es/Sede/irpf.html`),
  la app de la AEAT, o en oficinas con cita previa.

### Borrador

La AEAT prepara un borrador, pero para autónomos suele estar
**incompleto** (no incluye los datos de actividad económica). Hay que
revisarlo y completar los apartados de actividad.

---

## 7. Libros y registros obligatorios

Según el régimen, el autónomo debe llevar diferentes libros contables:

### Estimación directa simplificada

- Libro de ventas e ingresos.
- Libro de compras y gastos.
- Libro de bienes de inversión.
- Libro registro de facturas emitidas (IVA).
- Libro registro de facturas recibidas (IVA).

### Estimación directa normal

Contabilidad ajustada al Código de Comercio (como una empresa): libro
diario, libro de inventarios y cuentas anuales.

### Estimación objetiva (módulos)

Solo los libros registros de IVA si la actividad no está exenta.

No hay un formato obligatorio — vale un Excel, un programa de
facturación o incluso un cuaderno. Lo importante es que sea completo,
correlativo y esté disponible ante una inspección.

---

## 8. Accesos digitales: cómo operar con Hacienda

Para presentar modelos y consultar datos fiscales se necesita
identificación electrónica. Hay tres opciones:

### Cl@ve

Sistema de identificación del gobierno español. Dos modalidades:
- **Cl@ve PIN**: código temporal para trámites puntuales. Se solicita
  por app o SMS.
- **Cl@ve permanente**: usuario y contraseña reutilizable.

Registro presencial en oficinas de la AEAT, Seguridad Social o
ayuntamientos adheridos, o por videollamada.

URL: `https://clave.gob.es`

### Certificado digital (FNMT)

Certificado electrónico emitido por la Fábrica Nacional de Moneda y
Timbre. Permite todos los trámites online. Se instala en el navegador.

Solicitud: `https://www.sede.fnmt.gob.es/certificados/persona-fisica`

Pasos: solicitar online → acreditar identidad (oficina presencial o con
DNI electrónico) → descargar e instalar.

### DNI electrónico (DNIe)

El chip del DNI permite identificarse. Necesita un lector de tarjetas.
Menos usado que Cl@ve o el certificado FNMT.

---

## 9. Trámites habituales y dónde hacerlos

| Trámite | Dónde | URL |
|---|---|---|
| Alta censal (036/037) | Sede Electrónica AEAT | `https://sede.agenciatributaria.gob.es/Sede/procedimientoini/G322.shtml` |
| Presentar modelos trimestrales (303, 130…) | Sede Electrónica AEAT | `https://sede.agenciatributaria.gob.es/Sede/todas-gestiones.html` |
| Declaración de la Renta | Renta Web | `https://sede.agenciatributaria.gob.es/Sede/irpf.html` |
| Consultar datos fiscales | Sede Electrónica AEAT | `https://sede.agenciatributaria.gob.es/Sede/irpf/datos-fiscales.html` |
| Alta en Seguridad Social (RETA) | Import@ss | `https://importass.seg-social.es` |
| Registrarse en Cl@ve | Portal Cl@ve | `https://clave.gob.es` |
| Obtener certificado digital | FNMT | `https://www.sede.fnmt.gob.es/certificados/persona-fisica` |
| Calendario fiscal | AEAT | `https://sede.agenciatributaria.gob.es/Sede/ayuda/calendario-contribuyente/calendario-contribuyente-2026.html` |
| Cita previa AEAT | AEAT | `https://sede.agenciatributaria.gob.es/Sede/procedimientoini/GC07.shtml` |

---

## 10. Resumen rápido: las obligaciones del autónomo

```
CADA TRIMESTRE (abril, julio, octubre, enero):
  ├── Modelo 303 → IVA
  ├── Modelo 130/131 → IRPF pago fraccionado
  ├── Modelo 111 → retenciones (si tienes empleados o pagas a profesionales)
  └── Modelo 115 → retenciones alquiler (si alquilas local)

CADA AÑO:
  ├── Enero: Modelos 390, 190, 180 (resúmenes anuales)
  ├── Febrero: Modelo 347 (operaciones con terceros)
  └── Abril–junio: Declaración de la Renta (Modelo 100)

SIEMPRE:
  ├── Emitir facturas con todos los datos obligatorios
  ├── Llevar libros de ingresos, gastos y facturas
  ├── Conservar facturas 4 años
  └── Reservar ~30-35 % de cada factura para impuestos + SS
```

---

## Cuándo NO usar esta skill

- Si necesita **detalle del Modelo 036** (casillas, supuestos de
  modificación, alta en ROI, cambio de domicilio, paso a paso por Sede
  AEAT) → **fiscalidad-modelo-036**.
- Si necesita **detalle sobre el IVA** (cálculo 303, tipos, regímenes,
  exenciones) → **fiscalidad-iva**.
- Si necesita **detalle sobre IRPF pagos fraccionados** (cálculo 130/131,
  retenciones, gastos deducibles) → **fiscalidad-irpf-autonomos**.
- Si pregunta por **operaciones con la UE** (ROI, VIES, reverse charge,
  Modelo 349, facturas SaaS sin IVA) → **fiscalidad-operaciones-intracomunitarias**.
- Si pregunta por **facturación en detalle** (factura vs recibo, datos
  obligatorios, VeriFactu, factura electrónica, rectificativas) →
  **fiscalidad-facturacion**.
- Si pregunta por **cuotas de la Seguridad Social** (tarifa plana, cuota
  por ingresos reales, RETA) → **seguridad-social**.
- Si pregunta por **estadísticas fiscales** (recaudación, datos
  agregados) → **aeat**.
- Si pregunta por el **texto de una ley** fiscal → **boe**.
- Si pregunta por obligaciones de **sociedades** (SL, SA) → esta skill
  es solo para autónomos personas físicas.
