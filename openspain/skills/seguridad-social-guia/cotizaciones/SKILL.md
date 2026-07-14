---
name: cotizaciones
description: "Use when the user asks about Social Security contributions (cotizaciones) in Spain: contribution bases (minimum, maximum), contribution rates, breakdown between employer and employee, self-employed contributions (cuota de autónomos), flat rate (tarifa plana), special agreements (convenio especial), or contribution groups. Triggers on: 'cotizaciones Seguridad Social', 'bases de cotización', 'tipos de cotización', 'cuota autónomos', 'tarifa plana autónomos', 'cuánto paga empresa Seguridad Social', 'cuánto paga trabajador Seguridad Social', 'contingencias comunes', 'desempleo cotización', 'FOGASA', 'MEI', 'formación profesional cotización', 'grupo de cotización', 'base mínima cotización', 'base máxima cotización', 'convenio especial', 'pluriactividad', 'cotización tiempo parcial', 'ingresos reales autónomos'."
---

# Cotizaciones a la Seguridad Social

Guía completa sobre las cotizaciones al sistema de Seguridad Social español:
bases de cotización, tipos, reparto entre empresa y trabajador, cotización de
autónomos por ingresos reales, tarifa plana, convenio especial y situaciones
especiales.

Para **nóminas** y cómo se refleja la cotización en la nómina consulta
**laboral-nominas**. Para **pensión de jubilación** consulta
**jubilacion**. Para **vida laboral** consulta **vida-laboral**.
Para **datos estadísticos** de la Seguridad Social consulta
**seguridad-social**.

> Esta skill orienta sobre el sistema de cotización.
> **Los tipos y bases se actualizan anualmente por Orden ministerial.**
> Los datos reflejan la normativa vigente a fecha de la última actualización.
> **No sustituye asesoramiento profesional.**

---

## 1. Qué son las cotizaciones

Las cotizaciones a la Seguridad Social son las **aportaciones económicas
obligatorias** que realizan empresas y trabajadores para financiar el sistema
de protección social (pensiones, desempleo, sanidad, etc.).

### Quién cotiza

| Sujeto | Cotiza por |
|---|---|
| **Empresa** | Su parte + la del trabajador (ingresa ambas) |
| **Trabajador por cuenta ajena** | Su parte (la empresa se la descuenta de la nómina) |
| **Autónomo** | Su propia cuota íntegra |
| **Desempleado** | El SEPE cotiza durante la prestación de desempleo |
| **Convenio especial** | El propio interesado cotiza para no perder cotización |

---

## 2. Base de cotización del Régimen General

La base de cotización es la **cantidad sobre la que se calculan las cuotas**.
Se determina a partir de la remuneración bruta mensual del trabajador,
incluyendo la prorrata de pagas extraordinarias.

### Límites (actualizados anualmente)

Las bases tienen un **mínimo y un máximo** según el grupo de cotización:

| Grupo | Categorías profesionales | Base mínima 2025 (EUR/mes) | Base máxima 2025 (EUR/mes) |
|---|---|---|---|
| 1 | Ingenieros y licenciados | 1.847,40 | 4.909,50 |
| 2 | Ingenieros técnicos, peritos, ayudantes titulados | 1.532,10 | 4.909,50 |
| 3 | Jefes administrativos y de taller | 1.332,90 | 4.909,50 |
| 4 | Ayudantes no titulados | 1.323,00 | 4.909,50 |
| 5 | Oficiales administrativos | 1.323,00 | 4.909,50 |
| 6 | Subalternos | 1.323,00 | 4.909,50 |
| 7 | Auxiliares administrativos | 1.323,00 | 4.909,50 |
| 8–11 | Oficiales, especialistas, peones | 44,10/día | 163,65/día |

**Nota**: los importes exactos se publican cada año en la Orden de cotización
(BOE, normalmente en enero-febrero). Consultar la vigente.

### Base máxima general

En 2025, la base máxima de cotización para todos los grupos es
**4.909,50 EUR/mes**.

---

## 3. Tipos de cotización del Régimen General

Los tipos son los **porcentajes** que se aplican sobre la base de cotización.
Se reparten entre empresa y trabajador:

### Contingencias comunes

| Concepto | Empresa | Trabajador | Total |
|---|---|---|---|
| Contingencias comunes | 23,60 % | 4,70 % | **28,30 %** |

Financia: jubilación, incapacidad temporal (a partir del día 16),
maternidad/paternidad, incapacidad permanente, muerte y supervivencia.

### Desempleo

| Tipo de contrato | Empresa | Trabajador | Total |
|---|---|---|---|
| Indefinido, incluidos a tiempo parcial | 5,50 % | 1,55 % | 7,05 % |
| Temporal a tiempo completo | 6,70 % | 1,60 % | 8,30 % |
| Temporal a tiempo parcial | 6,70 % | 1,60 % | 8,30 % |

### Otras cotizaciones

| Concepto | Empresa | Trabajador | Total |
|---|---|---|---|
| **Formación profesional (FP)** | 0,60 % | 0,10 % | 0,70 % |
| **FOGASA** (Fondo de Garantía Salarial) | 0,20 % | — | 0,20 % |
| **MEI** (Mecanismo de Equidad Intergeneracional) | 0,58 % | 0,12 % | 0,70 % |

El MEI se creó en 2023 (RDL 2/2023) para reforzar el Fondo de Reserva de
la Seguridad Social. Su tipo va aumentando progresivamente:

| Año | Empresa | Trabajador | Total |
|---|---|---|---|
| 2024 | 0,58 % | 0,12 % | 0,70 % |
| 2025 | 0,67 % | 0,13 % | 0,80 % |
| 2026 | 0,75 % | 0,15 % | 0,90 % |
| 2027 | 0,83 % | 0,17 % | 1,00 % |
| 2028 | 0,92 % | 0,18 % | 1,10 % |
| 2029 | 1,00 % | 0,20 % | 1,20 % |

### Accidentes de trabajo y enfermedades profesionales (AT/EP)

Los tipos de AT/EP dependen de la actividad económica de la empresa (CNAE)
y se fijan en la tarifa de primas (Disposición adicional cuarta de la Ley
42/2006). Los paga **íntegramente la empresa**.

Ejemplos orientativos:

| Actividad (CNAE) | Tipo AT/EP |
|---|---|
| Oficinas / servicios profesionales | ~1,50 % |
| Comercio | ~1,80 % |
| Construcción | ~6,70 % |
| Hostelería | ~2,15 % |
| Industria manufacturera | ~3,00-5,00 % |

---

## 4. Resumen: coste total para la empresa

Para un trabajador con contrato indefinido y salario bruto de 2.000 EUR/mes
(base de cotización = 2.000 EUR):

| Concepto | Empresa | Trabajador |
|---|---|---|
| Contingencias comunes | 472,00 | 94,00 |
| Desempleo | 110,00 | 31,00 |
| Formación profesional | 12,00 | 2,00 |
| FOGASA | 4,00 | — |
| MEI (2025) | 13,40 | 2,60 |
| AT/EP (estimado ~1,50 %) | 30,00 | — |
| **Total** | **~641,40** | **~129,60** |
| **% sobre base** | **~32,07 %** | **~6,48 %** |

Es decir, el **coste laboral total** para la empresa es aproximadamente
un 32 % más que el salario bruto del trabajador.

---

## 5. Cotización de autónomos (RETA)

Desde enero de 2023, los autónomos cotizan por un **sistema de ingresos
reales**: la cuota depende de los rendimientos netos de la actividad.

### Tabla de cuotas por tramos de rendimientos (2025)

| Tramo de rendimientos netos mensuales | Base mínima (EUR) | Base máxima (EUR) | Cuota mínima (EUR/mes) |
|---|---|---|---|
| ≤ 670 EUR | 653,59 | 718,95 | ~200 |
| 670,01 – 900 EUR | 718,95 | 900,00 | ~220 |
| 900,01 – 1.166,70 EUR | 872,55 | 1.166,70 | ~267 |
| 1.166,71 – 1.300 EUR | 950,98 | 1.300,00 | ~291 |
| 1.300,01 – 1.500 EUR | 960,78 | 1.500,00 | ~294 |
| 1.500,01 – 1.700 EUR | 960,78 | 1.700,00 | ~294 |
| 1.700,01 – 1.850 EUR | 1.143,79 | 1.850,00 | ~350 |
| 1.850,01 – 2.030 EUR | 1.209,15 | 2.030,00 | ~370 |
| 2.030,01 – 2.330 EUR | 1.274,51 | 2.330,00 | ~390 |
| 2.330,01 – 2.760 EUR | 1.356,21 | 2.760,00 | ~415 |
| 2.760,01 – 3.190 EUR | 1.437,91 | 3.190,00 | ~440 |
| 3.190,01 – 3.620 EUR | 1.519,61 | 3.620,00 | ~465 |
| 3.620,01 – 4.050 EUR | 1.601,31 | 4.050,00 | ~490 |
| 4.050,01 – 6.000 EUR | 1.732,03 | 4.909,50 | ~530 |
| > 6.000 EUR | 1.928,10 | 4.909,50 | ~590 |

**Nota**: las cuotas son orientativas y dependen del tipo total aplicado
(~30,6 % sobre la base elegida). Los tramos y cuotas se actualizan
anualmente.

### Tipo de cotización de autónomos

| Concepto | Tipo (%) |
|---|---|
| Contingencias comunes | 28,30 |
| Contingencias profesionales (AT/EP) | ~1,30 |
| Cese de actividad | 0,90 |
| Formación profesional | 0,10 |
| **Total aproximado** | **~30,60** |

### Regularización anual

Al final de cada ejercicio, la Seguridad Social compara las cuotas pagadas
con los rendimientos netos reales (declarados a Hacienda en la Renta).
Si se ha cotizado de más, se devuelve la diferencia. Si se ha cotizado de
menos, se reclama el complemento.

---

## 6. Tarifa plana para nuevos autónomos

Los nuevos autónomos (primera alta o que no hayan estado de alta en los
2 años anteriores) pueden acogerse a una cuota reducida:

| Periodo | Cuota (2025) |
|---|---|
| Primeros 12 meses | **80 EUR/mes** |
| Meses 13–24 | **80 EUR/mes** (si los rendimientos netos < SMI) |

Si los rendimientos superan el SMI en el segundo año, se aplica la cuota
que corresponda por tramo de ingresos.

**Requisitos**: no haber sido autónomo en los últimos 2 años (3 si disfrutó
de tarifa plana anteriormente), y no ser autónomo colaborador familiar.

---

## 7. Convenio especial

Permite a un trabajador seguir cotizando voluntariamente cuando deja de
estar en alta, para no perder periodos de cotización (especialmente de
cara a la jubilación).

### Cuándo se usa

- **Excedencia** voluntaria.
- **Desempleo agotado** (si quedan pocos años para la jubilación).
- **Emigrantes retornados**.
- **Cuidado de hijos** o familiares.
- **Personas que dejan de trabajar** antes de la edad de jubilación.

### Coste

Se cotiza sobre una base elegida (entre la mínima y la que se tenía antes
del cese), aplicando un tipo reducido (**~28,30 %** solo por contingencias
comunes, sin desempleo ni AT/EP).

Ejemplo: base mínima 2025 (1.323 EUR) × 28,30 % = ~374 EUR/mes.

### Solicitud

Dentro de los **90 días** siguientes a la baja en la Seguridad Social.
Se solicita en Import@ss o en el CAISS.

---

## 8. Cotización durante el desempleo

Mientras se cobra la prestación contributiva de desempleo:

- El **SEPE cotiza por el trabajador** a la Seguridad Social.
- La base de cotización es la **base reguladora del desempleo** durante los
  primeros 180 días, y después se reduce.
- Ese periodo computa para jubilación y otras prestaciones.

Durante el subsidio de desempleo (prestación no contributiva):
- Se cotiza por la **base mínima** de cotización.

---

## 9. Pluriactividad y pluriempleo

### Pluriactividad

Cuando se trabaja simultáneamente por cuenta ajena y por cuenta propia
(Régimen General + RETA):

- Se cotiza en ambos regímenes.
- Si la cotización total supera ciertos límites, se puede solicitar la
  **devolución del 50 % del exceso** de cotización por contingencias
  comunes.
- Tope: la suma de ambas aportaciones no debe superar el doble de la base
  máxima.

### Pluriempleo

Cuando se trabaja para **dos o más empresas** en el Régimen General:

- Cada empresa cotiza por la parte proporcional de la base según el
  salario que paga.
- La suma de todas las bases no puede superar la base máxima.
- La TGSS reparte la base máxima entre las empresas proporcionalmente.

---

## 10. Grupos de cotización

Los trabajadores se clasifican en **grupos de cotización** según su categoría
profesional, que determinan la base mínima de cotización:

| Grupo | Categorías | Periodo de cotización |
|---|---|---|
| 1 | Ingenieros y licenciados, alta dirección | Mensual |
| 2 | Ingenieros técnicos, peritos, ayudantes titulados | Mensual |
| 3 | Jefes administrativos y de taller | Mensual |
| 4 | Ayudantes no titulados | Mensual |
| 5 | Oficiales administrativos | Mensual |
| 6 | Subalternos | Mensual |
| 7 | Auxiliares administrativos | Mensual |
| 8 | Oficiales de primera y segunda | Diario |
| 9 | Oficiales de tercera y especialistas | Diario |
| 10 | Peones | Diario |
| 11 | Menores de 18 años | Diario |

Los grupos 8–11 cotizan por bases diarias (se multiplica por los días
del mes para obtener la base mensual).

---

## Resumen rápido

```
COTIZACIONES A LA SEGURIDAD SOCIAL
  ├── RÉGIMEN GENERAL (cuenta ajena)
  │   ├── Contingencias comunes: 23,60 % empresa + 4,70 % trabajador
  │   ├── Desempleo: 5,50 % empresa + 1,55 % trabajador (indefinido)
  │   ├── FP: 0,60 % empresa + 0,10 % trabajador
  │   ├── FOGASA: 0,20 % empresa
  │   ├── MEI: 0,67 % empresa + 0,13 % trabajador (2025)
  │   ├── AT/EP: variable según CNAE (solo empresa)
  │   └── Coste total empresa: ~32 % sobre el salario bruto
  │
  ├── AUTÓNOMOS (RETA)
  │   ├── Sistema de ingresos reales (desde 2023)
  │   ├── Cuota según tramo de rendimientos netos
  │   ├── Tipo total: ~30,60 %
  │   ├── Tarifa plana: 80 EUR/mes (12-24 meses)
  │   └── Regularización anual con Hacienda
  │
  ├── CONVENIO ESPECIAL: ~374 EUR/mes (base mínima 2025)
  │
  └── BASES
      ├── Mínima (grupo 7): 1.323,00 EUR/mes (2025)
      └── Máxima: 4.909,50 EUR/mes (2025)
```

---

## Cuándo NO usar esta skill

- Si pregunta por la **pensión de jubilación** (cálculo, requisitos,
  anticipada) → **jubilacion**.
- Si pregunta por **cómo obtener la vida laboral** → **vida-laboral**.
- Si pregunta por **incapacidad temporal o permanente** →
  **incapacidad**.
- Si pregunta por **prestación de maternidad/paternidad** →
  **maternidad-paternidad**.
- Si necesita **datos estadísticos** de la Seguridad Social (afiliación
  agregada, pensiones medias) → **seguridad-social**.
- Si pregunta por **cómo se refleja la cotización en la nómina** →
  **laboral-nominas**.
- Si pregunta por **obligaciones fiscales del autónomo** (IVA, IRPF,
  modelos) → **fiscalidad-autonomos**.
- Si pregunta por **contratos laborales** → **laboral-contratos**.
- Si pregunta por el **texto de una ley** → **boe**.
