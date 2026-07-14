---
name: fiscalidad-irpf-asalariados
description: "Use when the user asks about personal income tax for salaried workers in Spain (Declaracion de la Renta, IRPF asalariados): tax brackets (tramos), filing obligation thresholds, Renta Web / borrador, deductions (housing, maternity, large family, disability, pension plans, donations), income types (trabajo, capital, ganancias patrimoniales), minimum personal/family allowance, two-payer rule, Renta campaign deadlines, or how to get a refund. Triggers on: 'declaracion de la renta', 'renta 2025', 'renta 2026', 'IRPF asalariado', 'borrador renta', 'Renta Web', 'tramos IRPF', 'hacer la renta', 'confirmar borrador', 'deduccion vivienda', 'deduccion maternidad', 'dos pagadores', 'obligado a declarar', 'devolucion renta', 'resultado renta', 'minimo personal', 'familia numerosa deduccion', 'campaña renta', 'tipo marginal', 'rendimientos del trabajo', 'ganancias patrimoniales IRPF'."
---

# Fiscalidad -- IRPF para Asalariados (Declaracion de la Renta)

Todo lo que un trabajador por cuenta ajena necesita saber sobre la
Declaracion de la Renta anual: quien esta obligado, tramos, deducciones,
como funciona el borrador y Renta Web, y los plazos de la campana.

> Esta skill cubre el IRPF desde la perspectiva del **asalariado**. Si
> eres autonomo, consulta **fiscalidad-irpf-autonomos** para pagos
> fraccionados y **fiscalidad-autonomos** para la vision general.

> **No sustituye asesoramiento fiscal profesional.**

---

## 1. Quien esta obligado a presentar la Declaracion de la Renta

### Limites generales (rendimientos del trabajo)

| Situacion | Limite |
|---|---|
| **Un solo pagador** | No obligado si ingresos <= **22.000 EUR** brutos anuales |
| **Dos o mas pagadores** y el 2.o y siguientes suman > 1.500 EUR | No obligado si ingresos <= **15.876 EUR** brutos anuales |
| **Dos o mas pagadores** y el 2.o y siguientes suman <= 1.500 EUR | Se aplica el limite de 22.000 EUR |

### Otros rendimientos con obligacion de declarar

- Rendimientos del capital mobiliario / ganancias patrimoniales
  sujetos a retencion: si superan **1.600 EUR** anuales.
- Rentas inmobiliarias imputadas, rendimientos de letras del Tesoro,
  subvenciones para vivienda: si superan **1.000 EUR** anuales.
- Rendimientos del trabajo no sujetos a retencion: si superan
  **15.876 EUR** (pensiones compensatorias, etc.).

### Cuando conviene declarar aunque no estes obligado

Si te han retenido mas IRPF del que te corresponde (frecuente con dos
pagadores), la Renta te saldra **a devolver**. Merece la pena presentarla
aunque no estes obligado.

---

## 2. Tramos del IRPF (escala estatal)

El IRPF es un impuesto **progresivo**: se paga mas porcentaje a medida
que aumenta la renta. La escala tiene una parte estatal y otra
autonomica.

### Escala estatal (2024-2025, vigente)

| Base liquidable (EUR) | Tipo estatal |
|---|---|
| 0 -- 12.450 | 9,50 % |
| 12.450 -- 20.200 | 12,00 % |
| 20.200 -- 35.200 | 15,00 % |
| 35.200 -- 60.000 | 18,50 % |
| 60.000 -- 300.000 | 22,50 % |
| Mas de 300.000 | 24,50 % |

### Escala autonomica

Cada comunidad autonoma fija su propia escala (generalmente entre el
9 % y el 25,5 % en su tramo maximo). El tipo total es la **suma** del
estatal + autonomico.

**Ejemplo**: para los primeros 12.450 EUR, el tipo estatal es 9,50 % y
el autonomico tipicamente ~9,50 %, dando un tipo efectivo de ~19 %.
El tipo marginal maximo total puede llegar al **47-54 %** segun la
comunidad autonoma.

### Escala del ahorro (rendimientos del capital y ganancias patrimoniales)

| Base del ahorro (EUR) | Tipo |
|---|---|
| 0 -- 6.000 | 19 % |
| 6.000 -- 50.000 | 21 % |
| 50.000 -- 200.000 | 23 % |
| 200.000 -- 300.000 | 27 % |
| Mas de 300.000 | 28 % |

---

## 3. Tipos de rendimientos en el IRPF

### Rendimientos del trabajo

- Salarios, pagas extra, complementos.
- Prestaciones por desempleo.
- Pensiones publicas (jubilacion, viudedad, incapacidad).
- Retribuciones en especie (coche de empresa, seguro medico,
  cheques guarderia...).
- Indemnizaciones por despido: **exentas** hasta el limite legal
  (33 dias/ano con tope de 24 mensualidades para despido
  improcedente; 20 dias/ano para despido objetivo).

### Rendimientos del capital mobiliario

- Intereses de cuentas bancarias y depositos.
- Dividendos.
- Rendimiento de seguros de vida.
- Tributan por la escala del ahorro (19-28 %).

### Rendimientos del capital inmobiliario

- Alquiler de inmuebles. Reduccion del 50-90 % para vivienda
  habitual del inquilino (segun contrato y normativa vigente).
- Imputacion de rentas inmobiliarias: inmuebles no alquilados
  (excluida vivienda habitual): 1,1-2 % del valor catastral.

### Ganancias y perdidas patrimoniales

- Venta de acciones, fondos de inversion, criptomonedas, inmuebles.
- Tributan por la escala del ahorro.
- Se pueden compensar perdidas con ganancias del mismo tipo.

---

## 4. Minimo personal y familiar

Antes de aplicar la escala, se resta el **minimo personal y familiar**,
que es la parte de renta que se considera necesaria para cubrir
necesidades basicas:

| Concepto | Importe (EUR) |
|---|---|
| Minimo del contribuyente | 5.550 (+ 1.150 si > 65 anos; + 1.400 si > 75) |
| 1er descendiente < 25 anos | 2.400 |
| 2.o descendiente | 2.700 |
| 3er descendiente | 4.000 |
| 4.o y siguientes | 4.500 |
| Descendiente < 3 anos | + 2.800 adicional |
| Ascendiente > 65 anos conviviente | 1.150 (+ 1.400 si > 75 anos) |
| Discapacidad (33-65 %) | 3.000 |
| Discapacidad >= 65 % | 12.000 |

---

## 5. Principales deducciones

### Deducciones estatales

| Deduccion | Detalle |
|---|---|
| **Inversion en vivienda habitual** | Solo para compras anteriores al 1/1/2013 (regimen transitorio). 15 % sobre max. 9.040 EUR/ano |
| **Donativos** | 80 % sobre los primeros 250 EUR; 40 % sobre el resto (45 % si fidelizacion >= 3 anos) |
| **Planes de pensiones** | Reduccion en base imponible: max. 1.500 EUR/ano (o 8.500 EUR con aportaciones de empresa) |
| **Maternidad** | 1.200 EUR/ano por hijo < 3 anos (madre trabajadora); ampliacion por guarderia hasta 1.000 EUR |
| **Familia numerosa** | 1.200 EUR/ano (general) o 2.400 EUR (especial); acumulable con discapacidad |
| **Ascendiente/descendiente con discapacidad** | 1.200 EUR/ano por cada uno |

### Deducciones autonomicas

Cada comunidad autonoma tiene sus propias deducciones adicionales.
Ejemplos habituales:
- Alquiler de vivienda habitual (jovenes, rentas bajas).
- Gastos educativos (uniformes, material, idiomas).
- Nacimiento o adopcion.
- Eficiencia energetica en vivienda.
- Inversiones en empresas de nueva creacion.

**Importante**: consultar siempre las deducciones de tu comunidad autonoma.

---

## 6. El borrador y Renta Web

### Como funciona el borrador

La AEAT elabora un **borrador** de la declaracion con los datos que
tiene: retenciones comunicadas por la empresa, datos bancarios,
informacion catastral, etc.

- **Acceso**: desde Renta Web con Cl@ve, certificado digital o
  numero de referencia (RENNO).
- **Revision**: es fundamental revisar el borrador. Puede estar
  incompleto (especialmente deducciones autonomicas, alquileres,
  ganancias patrimoniales de cripto, etc.).
- **Confirmar o modificar**: si esta correcto, se confirma. Si no,
  se modifica antes de presentar.

### Renta Web

Es la herramienta online de la AEAT para hacer la declaracion:

URL: `https://sede.agenciatributaria.gob.es/Sede/irpf.html`

Permite:
- Consultar datos fiscales.
- Ver y modificar el borrador.
- Simular el resultado antes de presentar.
- Presentar la declaracion (individual o conjunta).
- Descargar el PDF de la declaracion.

### App AEAT

La AEAT tambien tiene app movil para consultar datos fiscales y
presentar declaraciones sencillas.

---

## 7. Campaña de la Renta: plazos

| Fase | Plazo habitual |
|---|---|
| Inicio campana (online) | Principios de **abril** |
| Atencion telefonica | Desde **mayo** (con cita previa) |
| Atencion presencial en oficinas | Desde **junio** (con cita previa) |
| Fin de campana | **30 de junio** |
| Resultado a devolver: domiciliacion bancaria | Hasta ~25 junio |
| Resultado a pagar: posibilidad de fraccionar en dos plazos (60 % + 40 %) | 60 % al presentar; 40 % en noviembre |

Las fechas exactas varian cada ano. Consultar:
`https://sede.agenciatributaria.gob.es/Sede/irpf.html`

### Numero de referencia (RENNO)

Si no tienes Cl@ve ni certificado digital, puedes obtener un numero
de referencia con:
- La casilla 505 de la Renta del ano anterior (importe de la casilla).
- O con el IBAN de una cuenta bancaria a tu nombre.

---

## 8. Dos pagadores: que implica

Si has cambiado de empleo durante el ano (o has cobrado prestacion
por desempleo + salario), tienes **dos pagadores**.

### Consecuencias

- El limite de obligacion de declarar baja de 22.000 a **15.876 EUR**
  (si el segundo y siguientes pagadores suman > 1.500 EUR).
- Cada pagador retiene como si fuera el unico, aplicando el minimo
  exento. Resultado: te han retenido **menos** de lo que corresponde.
- La Renta probablemente saldra **a pagar**.

### Como evitar sorpresas

- Pedir al segundo pagador que aplique un tipo de retencion mas alto
  (comunicando tu situacion real).
- Usar el simulador de Renta Web para estimar el resultado antes de
  que acabe el ano.

---

## 9. Resultado: a pagar o a devolver

```
Cuota integra (escala sobre base liquidable)
- Deducciones
- Minimo personal y familiar
= Cuota liquida
- Retenciones ya practicadas por la empresa
- Pagos a cuenta
= RESULTADO

Si resultado < 0 → A DEVOLVER (Hacienda te devuelve)
Si resultado > 0 → A PAGAR (debes ingresar la diferencia)
```

### Fraccionamiento del pago

Si sale a pagar, puedes fraccionar en **dos plazos sin intereses**:
- **60 %** al presentar la declaracion.
- **40 %** en noviembre (domiciliacion bancaria).

### Plazo de devolucion

Hacienda tiene **6 meses** desde el fin de la campana para devolver.
Pasado ese plazo, la cantidad devenga intereses de demora a tu favor.

---

## 10. Rectificacion de autoliquidacion

Si despues de presentar la Renta descubres un error:

- **A tu favor** (te corresponde pagar menos o recibir mas): solicitud
  de rectificacion de autoliquidacion (desde 2024 se puede hacer
  directamente desde Renta Web, sin necesidad de un procedimiento
  separado).
- **En contra** (debes pagar mas): declaracion complementaria.

---

## 11. Resumen rapido

```
IRPF ASALARIADOS -- DECLARACION DE LA RENTA:
  Campana: abril-junio
  Herramienta: Renta Web (sede.agenciatributaria.gob.es/Sede/irpf.html)

OBLIGACION DE DECLARAR:
  1 pagador: ingresos > 22.000 EUR
  2+ pagadores (>1.500 EUR el 2.o+): ingresos > 15.876 EUR

ESCALA ESTATAL:
  19 % (hasta 12.450) ... hasta ~47-54 % (tipo total con autonomica)

DEDUCCIONES PRINCIPALES:
  Vivienda (pre-2013): 15 % hasta 9.040 EUR
  Planes de pensiones: hasta 1.500 EUR
  Maternidad: 1.200 EUR/hijo < 3 anos
  Donativos: 80 % primeros 250 EUR

SI SALE A PAGAR:
  Fraccionamiento: 60 % + 40 % (noviembre), sin intereses
```

---

## Cuando NO usar esta skill

- Si es **autonomo** y pregunta por pagos fraccionados trimestrales
  (modelos 130/131) -> **fiscalidad-irpf-autonomos**.
- Si pregunta por obligaciones generales del **autonomo** (alta censal,
  calendario, facturacion) -> **fiscalidad-autonomos**.
- Si pregunta por **IVA** -> **fiscalidad-iva**.
- Si pregunta por el **Impuesto de Sociedades** (SL, SA) ->
  **fiscalidad-sociedades**.
- Si pregunta por **retenciones** que practica como pagador (modelos
  111, 115) -> **fiscalidad-retenciones**.
- Si pregunta por fiscalidad de **no residentes** -> **fiscalidad-no-residentes**.
- Si pregunta por **herencias o donaciones** -> **fiscalidad-sucesiones-donaciones**.
- Si pregunta por **estadisticas de recaudacion** de la AEAT -> **aeat**.
