---
name: laboral-nominas
description: "Use when the user asks about how to read a Spanish payslip (nómina), salary components, gross vs net pay, Social Security deductions, income tax withholding on payroll, minimum wage (SMI), overtime pay, night shift bonus, extra payments (pagas extraordinarias), or payroll calculation basics. Triggers on: 'nómina', 'leer nómina', 'entender nómina', 'salario bruto', 'salario neto', 'líquido a percibir', 'devengos', 'deducciones nómina', 'base de cotización', 'grupo de cotización', 'retención IRPF nómina', 'salario mínimo', 'SMI', 'paga extra', 'paga extraordinaria', 'horas extra', 'nocturnidad', 'complemento salarial', 'cotización Seguridad Social trabajador'."
---

# Cómo leer una nómina en España

Guía práctica para entender una nómina española: qué es cada concepto,
cómo se calcula el salario neto, qué se deduce y por qué.

> Esta skill es orientativa. Las cifras exactas dependen del convenio
> colectivo aplicable, la categoría profesional y la situación personal
> del trabajador. **No sustituye asesoramiento laboral profesional.**

---

## 1. Estructura general de una nómina

Toda nómina tiene tres grandes bloques:

```
NÓMINA
├── ENCABEZADO (datos empresa + trabajador)
├── DEVENGOS (lo que ganas — bruto)
│   ├── Percepciones salariales
│   └── Percepciones no salariales
├── DEDUCCIONES (lo que te descuentan)
│   ├── Cotizaciones a la Seguridad Social
│   ├── Retención del IRPF
│   └── Otras deducciones
└── LÍQUIDO A PERCIBIR (lo que cobras — neto)
```

**Fórmula básica**:

Líquido a percibir = Total devengado − Total deducciones

---

## 2. Encabezado

### Datos de la empresa

- Nombre o razón social.
- CIF y código de cuenta de cotización (CCC).
- Domicilio.

### Datos del trabajador

- Nombre, NIF, número de afiliación a la Seguridad Social.
- Categoría profesional / grupo de cotización.
- Puesto de trabajo.
- Fecha de antigüedad.
- Periodo de liquidación (mes al que corresponde la nómina).

---

## 3. Devengos (percepciones)

Son todas las cantidades que el trabajador tiene derecho a percibir.
Se dividen en **salariales** y **no salariales**.

### 3.1 Percepciones salariales

Cotizan a la Seguridad Social y tributan en IRPF.

| Concepto | Descripción |
|---|---|
| **Salario base** | Retribución fijada por unidad de tiempo o de obra, según convenio y categoría |
| **Complemento de antigüedad** | Trienios, bienios o quinquenios según convenio |
| **Complemento de puesto** | Peligrosidad, toxicidad, penosidad, turnicidad |
| **Complemento de nocturnidad** | Trabajo entre las 22:00 y las 06:00. Porcentaje sobre salario base (según convenio, suele ser 20-30 %) |
| **Complemento de idiomas / titulación** | Si el convenio lo prevé |
| **Horas extraordinarias** | Máximo 80 al año. Se pagan al precio del convenio o se compensan con descanso |
| **Comisiones / incentivos** | Retribución variable por objetivos |
| **Pagas extraordinarias** | Mínimo 2 al año (normalmente junio y diciembre). Pueden estar prorrateadas en 12 meses |
| **Salario en especie** | Uso de vivienda, vehículo, seguro médico, etc. |

### 3.2 Percepciones no salariales

No cotizan a la Seguridad Social (hasta ciertos límites) ni tributan.

| Concepto | Descripción |
|---|---|
| **Dietas y gastos de viaje** | Compensación por desplazamiento (exentas hasta límites del IRPF) |
| **Plus de transporte** | Compensación por desplazamiento al trabajo |
| **Indemnizaciones por traslado** | Si la empresa traslada al trabajador |
| **Prestaciones de la Seguridad Social** | IT (incapacidad temporal) pagada como pago delegado |

---

## 4. Deducciones

Son las cantidades que se restan del bruto para obtener el neto.

### 4.1 Cotizaciones del trabajador a la Seguridad Social

El trabajador paga una parte de la cotización social (la empresa paga
otra parte mayor, que no aparece en el neto pero sí en el coste total).

**Porcentajes del trabajador (2025–2026, orientativos)**:

| Concepto | % sobre base de cotización |
|---|---|
| Contingencias comunes | 4,70 % |
| Desempleo (contrato indefinido) | 1,55 % |
| Desempleo (contrato temporal) | 1,60 % |
| Formación profesional | 0,10 % |
| Mecanismo de Equidad Intergeneracional (MEI) | 0,13 % |
| **Total trabajador (aprox.)** | **~6,48 %** (indefinido) |

> **Atención**: estos porcentajes se actualizan anualmente mediante
> Orden ministerial (Orden de Cotización). Consultar siempre los valores
> vigentes en la web de la Seguridad Social.

### 4.2 Base de cotización

Es la cantidad sobre la que se aplican los porcentajes anteriores.

- **Se calcula**: salario base + complementos salariales + prorrata de
  pagas extras (si no están prorrateadas).
- **Tiene topes**: existe una base mínima y una base máxima para cada
  grupo de cotización. En 2025, la base máxima general es 4.720,50 €/mes
  (se actualiza anualmente).

### 4.3 Grupos de cotización

| Grupo | Categoría profesional | Base mínima (2025, aprox.) |
|---|---|---|
| 1 | Ingenieros y Licenciados | 1.847,40 € |
| 2 | Ingenieros Técnicos, Peritos | 1.532,10 € |
| 3 | Jefes Administrativos y de Taller | 1.332,90 € |
| 4 | Ayudantes no Titulados | 1.323,00 € |
| 5 | Oficiales Administrativos | 1.323,00 € |
| 6 | Subalternos | 1.323,00 € |
| 7 | Auxiliares Administrativos | 1.323,00 € |
| 8-11 | Oficiales, peones, menores | Bases diarias |

> Las bases mínimas se actualizan anualmente. Consultar la Orden de
> Cotización vigente.

### 4.4 Retención del IRPF

La empresa retiene una parte del salario a cuenta del IRPF del
trabajador. El porcentaje depende de:

- Salario bruto anual.
- Situación familiar (hijos, cónyuge, discapacidad).
- Tipo de contrato.
- Comunidad autónoma (por los tramos autonómicos).

El trabajador puede consultar y solicitar un porcentaje distinto
mediante el **modelo 145** (comunicación de datos al pagador).

**Rangos orientativos** (varían mucho según situación personal):

| Salario bruto anual | Retención aprox. |
|---|---|
| Hasta SMI (≈15.876 €) | 0 % – 2 % |
| 20.000 € | 10 % – 14 % |
| 30.000 € | 15 % – 18 % |
| 45.000 € | 20 % – 24 % |
| 60.000 € | 24 % – 28 % |

### 4.5 Otras deducciones

- **Anticipos**: si el trabajador ha recibido un adelanto de nómina.
- **Embargo de salario**: por orden judicial. Inembargable hasta el SMI.
- **Cuota sindical**: si el trabajador está afiliado y autoriza el
  descuento.
- **Aportación a plan de pensiones de empresa**: si existe.

---

## 5. Salario Mínimo Interprofesional (SMI)

El SMI es la retribución mínima legal para cualquier trabajador.

### Valores vigentes (2025)

| Periodo | Importe |
|---|---|
| **Mensual (14 pagas)** | 1.134 € |
| **Anual** | 15.876 € |
| **Diario** | 37,80 € |

> El SMI se aprueba cada año por Real Decreto (suele publicarse en el
> BOE en el primer trimestre). Consultar siempre el valor vigente.

El SMI es **inembargable**, salvo para pensiones alimenticias.

---

## 6. Pagas extraordinarias

- **Mínimo legal**: 2 al año (ET art. 31).
- **Cuándo**: lo que fije el convenio. Normalmente junio y diciembre.
- **Cuantía**: lo que fije el convenio. Como mínimo, 30 días de salario
  base (no necesariamente de salario total).
- **Prorrateo**: muchos convenios permiten (o el trabajador puede
  solicitar) prorratear las pagas en 12 meses. En ese caso, la nómina
  mensual es mayor pero no hay paga aparte.

---

## 7. Nocturnidad y horas extraordinarias

### Nocturnidad

- **Horario**: entre las 22:00 y las 06:00.
- **Trabajador nocturno**: quien trabaje al menos 3 horas diarias en
  horario nocturno, o un tercio de su jornada anual.
- **Complemento**: lo que fije el convenio. Si no dice nada, el ET
  establece un incremento específico.
- **Prohibiciones**: menores de 18 años no pueden trabajar en horario
  nocturno.

### Horas extraordinarias

- **Máximo**: 80 horas al año (no computan las compensadas con descanso
  en los 4 meses siguientes ni las de fuerza mayor).
- **Retribución**: como mínimo, igual que la hora ordinaria. El convenio
  puede fijar un importe superior.
- **Voluntarias**: salvo pacto en convenio o contrato, son voluntarias.
- **Prohibidas**: para menores de 18, durante el periodo nocturno
  (salvo actividades especiales), y en contratos a tiempo parcial.

---

## 8. Incapacidad temporal (IT) en la nómina

Cuando un trabajador está de baja médica, la nómina refleja la
prestación de IT como **pago delegado** de la Seguridad Social:

| Periodo | Quién paga | Cuantía |
|---|---|---|
| Días 1-3 (enfermedad común) | Empresa | Según convenio (puede ser 0 o 100 %) |
| Días 4-15 | Empresa | 60 % de la base reguladora |
| Días 16-20 | Seguridad Social (pago delegado) | 60 % de la base reguladora |
| Día 21 en adelante | Seguridad Social (pago delegado) | 75 % de la base reguladora |
| Accidente de trabajo / enfermedad profesional | Desde día 1: Seguridad Social | 75 % de la base reguladora |

Muchos convenios mejoran estos porcentajes hasta el 100 % del salario.

---

## 9. Ejemplo práctico simplificado

```
DEVENGOS
  Salario base .......................... 1.500,00 €
  Complemento antigüedad ...............   100,00 €
  Plus transporte (no salarial) ........    80,00 €
  Prorrata pagas extras ................   266,67 €
                                         ----------
  TOTAL DEVENGADO ....................... 1.946,67 €

DEDUCCIONES
  Contingencias comunes (4,70 %) ........   87,73 €
  Desempleo (1,55 %) ....................   28,94 €
  Formación profesional (0,10 %) .........   1,87 €
  MEI (0,13 %) ...........................   2,42 €
  Retención IRPF (14 %) ................  272,53 €
                                         ----------
  TOTAL DEDUCCIONES ..................... 393,49 €

LÍQUIDO A PERCIBIR ................... 1.553,18 €
```

*Nota: ejemplo simplificado con fines didácticos. Las bases de cotización
y la retención de IRPF reales dependen de la situación concreta.*

---

## 10. Resumen rápido: conceptos clave de la nómina

```
BRUTO (devengos)
  ├── Salario base (según convenio y categoría)
  ├── Complementos salariales (antigüedad, nocturnidad, etc.)
  ├── Pagas extras (2 mínimo, prorrateadas o no)
  └── Percepciones no salariales (dietas, transporte)

DEDUCCIONES
  ├── Cotización SS trabajador (~6,5 % del bruto)
  ├── Retención IRPF (variable, 0 %-45 %)
  └── Otras (anticipos, embargos, sindicato)

NETO = BRUTO − DEDUCCIONES
```

---

## Cuándo NO usar esta skill

- Si pregunta por **tipos de contrato** o despido → **laboral-contratos**.
- Si pregunta por **prestación por desempleo** → **laboral-desempleo**.
- Si pregunta por **ERE o ERTE** → **laboral-ere-erte**.
- Si pregunta por **convenios colectivos** → **laboral-convenios**.
- Si pregunta por **Inspección de Trabajo** o denuncias →
  **laboral-inspeccion**.
- Si pregunta por **estadísticas de paro** registrado → **sepe**.
- Si pregunta por **afiliación y cuotas empresariales** a la Seguridad
  Social → **seguridad-social**.
- Si pregunta por **obligaciones fiscales del autónomo** →
  **fiscalidad-autonomos**.
- Si pregunta por el **texto de una ley** concreta → **boe**.
