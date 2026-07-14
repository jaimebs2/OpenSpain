---
name: cte
description: "Use when the user asks about Spain's building code (Código Técnico de la Edificación, CTE): which Documento Básico applies to a new build, renovation or change of use; structural safety (DB-SE), fire safety in buildings (DB-SI), safety of use and accessibility (DB-SUA), health requirements including radon protection and the list of affected municipalities (DB-HS / HS6), noise insulation (DB-HR), or energy-efficiency requirements for construction works and climate zones (DB-HE). Triggers on: 'CTE', 'código técnico de la edificación', 'documento básico', 'DB-SE', 'DB-SI', 'DB-SUA', 'DB-HS', 'DB-HR', 'DB-HE', 'normativa edificación', 'normativa construcción España', 'normativa incendios edificio', 'accesibilidad edificio normativa', 'radón municipio', 'zona de radón', 'apéndice B radón', 'zona climática CTE', 'ahorro de energía obra nueva', 'reforma cambio de uso normativa', 'salubridad vivienda', 'aislamiento acústico normativa', 'seguridad estructural'."
license: MIT
---

# CTE — Código Técnico de la Edificación

El **Código Técnico de la Edificación (CTE)** es el marco normativo que
fija las exigencias básicas de calidad que deben cumplir los edificios en
España. Se aprobó por el **Real Decreto 314/2006, de 17 de marzo**, en
desarrollo de la Ley 38/1999 de Ordenación de la Edificación (LOE), y lo
mantiene el **Ministerio de Vivienda y Agenda Urbana** a través del portal
oficial `https://www.codigotecnico.org`.

> Esta skill orienta sobre qué regula el CTE y dónde consultarlo. **No
> sustituye al proyecto técnico ni al criterio de un arquitecto o técnico
> competente.**

---

## 1. Estructura del CTE

| Parte | Contenido |
|---|---|
| **Parte I** | Exigencias básicas y condiciones generales de aplicación |
| **Parte II** | **Documentos Básicos (DB)**: reglas y procedimientos que permiten cumplir las exigencias |

Los Documentos Básicos se actualizan periódicamente (la última gran
revisión del DB-HE fue el RD 732/2019, que también introdujo la sección
HS 6 de radón). Descargar siempre la versión vigente desde
`codigotecnico.org`.

---

## 2. Ámbito de aplicación

El CTE se aplica (art. 2 del RD 314/2006 y Parte I) a:

- **Obra nueva** de edificación.
- **Intervenciones en edificios existentes**: ampliación, modificación,
  reforma y rehabilitación.
- **Cambio de uso característico** del edificio (ej. local a vivienda),
  aunque no haya obras.

En edificios existentes rige el **criterio de flexibilidad y no
empeoramiento**: cuando la aplicación íntegra no sea técnica o
económicamente viable (o sea incompatible con el grado de protección de un
edificio protegido), se aplican las soluciones que más se aproximen,
sin reducir las condiciones preexistentes.

---

## 3. Los seis Documentos Básicos

| DB | Qué regula | PDF oficial |
|---|---|---|
| **DB-SE** Seguridad estructural | Resistencia y estabilidad, aptitud al servicio. Partes: **SE-AE** (acciones en la edificación), **SE-C** (cimientos), **SE-A** (acero), **SE-F** (fábrica), **SE-M** (madera) | `https://www.codigotecnico.org/pdf/Documentos/SE/DBSE.pdf` |
| **DB-SI** Seguridad en caso de incendio | Propagación interior y exterior, evacuación de ocupantes, instalaciones de protección, intervención de bomberos, resistencia al fuego de la estructura (SI 1–SI 6) | `https://www.codigotecnico.org/pdf/Documentos/SI/DBSI.pdf` |
| **DB-SUA** Seguridad de utilización y accesibilidad | Caídas, impacto, aprisionamiento, iluminación, alta ocupación, ahogamiento, vehículos, rayo y **accesibilidad** (SUA 1–SUA 9) | `https://www.codigotecnico.org/pdf/Documentos/SUA/DBSUA.pdf` |
| **DB-HS** Salubridad | Humedad, residuos, calidad del aire interior, suministro y evacuación de agua y **protección frente al radón** (HS 1–HS 6) | `https://www.codigotecnico.org/pdf/Documentos/HS/DBHS.pdf` |
| **DB-HR** Protección frente al ruido | Aislamiento acústico a ruido aéreo y de impactos, ruido de instalaciones, tiempos de reverberación | `https://www.codigotecnico.org/pdf/Documentos/HR/DBHR.pdf` |
| **DB-HE** Ahorro de energía | Limitación del consumo (HE 0), control de la demanda (HE 1), RITE (HE 2), iluminación (HE 3), contribución renovable para ACS (HE 4), generación eléctrica (HE 5) | `https://www.codigotecnico.org/pdf/Documentos/HE/DBHE.pdf` |

Las partes del DB-SE se descargan por separado con el patrón
`https://www.codigotecnico.org/pdf/Documentos/SE/DBSE-AE.pdf` (igual para
`-C`, `-A`, `-F`, `-M`).

> **Nota**: las estructuras de hormigón y las de acero se rigen además por
> el **Código Estructural** (RD 470/2021), norma independiente del CTE.

---

## 4. Texto consolidado del RD 314/2006 (vía BOE)

El texto legal consolidado del CTE está en el BOE con identificador
**`BOE-A-2006-5515`**:

- **Web**: `https://www.boe.es/buscar/act.php?id=BOE-A-2006-5515`
- **API de datos abiertos** (mismo patrón que la skill **boe** — GET con
  header `Accept: application/json`, nunca POST):

```
GET https://www.boe.es/datosabiertos/api/legislacion-consolidada/id/BOE-A-2006-5515/texto/indice
```

Devuelve el índice por bloques; para leer un bloque concreto, hacer GET a
la `url` de cada entrada. Para el articulado siempre es preferible la API
del BOE; para el contenido técnico (tablas, valores, mapas), los PDFs de
los DB en `codigotecnico.org`.

---

## 5. HS 6 — Protección frente al radón

La sección **HS 6** del DB-HS (introducida por el RD 732/2019) obliga a
proteger frente al gas radón los edificios situados en municipios
clasificados como de riesgo:

- El **apéndice B del DB-HS** lista los **municipios afectados**,
  clasificados en **zona I** y **zona II** (mayor exigencia).
- Soluciones exigidas según zona: **barrera de protección** en contacto
  con el terreno, **cámara de aire ventilada** o **despresurización del
  terreno** (zona II combina medidas).

Para responder «¿mi municipio está en zona de radón?»: descargar el PDF
del DB-HS (URL en la tabla anterior) y buscar el municipio en el
apéndice B. Si no aparece, no está clasificado como zona I ni II.

Documento de apoyo oficial: **Guía de rehabilitación frente al radón** en
`https://www.codigotecnico.org/Guias/GuiaRadon.html`.

---

## 6. DB-HE — Zonas climáticas

Las exigencias de ahorro de energía dependen de la **zona climática** de
la localidad, definida en el **Anejo B del DB-HE**:

- Se determina por **provincia y altitud** sobre el nivel del mar.
- Nomenclatura: letra de severidad climática de invierno (**α, A, B, C,
  D, E** — α solo en Canarias) + número de severidad de verano (**1–4**).
  Ejemplos: Madrid capital `D3`, Sevilla `B4`, Burgos `E1`.
- Los **climas de referencia** (.MET) y documentos de apoyo (DA DB-HE/1
  a /3) están en la página del DB-HE:
  `https://www.codigotecnico.org/DocumentosCTE/AhorroEnergia.html`.

---

## 7. Cómo responder consultas típicas

| Consulta | Fuente |
|---|---|
| «¿Qué normativa de incendios aplica a mi edificio?» | DB-SI (PDF), secciones SI 1–SI 6 según uso del edificio |
| «¿Qué exige el CTE en una reforma / cambio de uso?» | Parte I (ámbito de aplicación) + los DB afectados por la intervención |
| «¿Mi municipio está en zona de radón?» | Apéndice B del DB-HS |
| «¿Qué zona climática tiene mi localidad?» | Anejo B del DB-HE (provincia + altitud) |
| «¿Qué dice el artículo N del RD 314/2006?» | API BOE `BOE-A-2006-5515` |

---

## Cuándo NO usar esta skill

- Si pregunta por **licencias municipales** (licencia de obras, apertura,
  actividad, declaración responsable) o **normativa urbanística** del
  ayuntamiento (usos del suelo, planeamiento) -->
  **emprendimiento-licencias-actividad**.
- Si necesita el **texto consolidado de otra norma** o el sumario del BOE
  --> **boe**.
- Si pregunta por el **certificado de eficiencia energética de un inmueble
  concreto** (etiqueta A–G, registro autonómico, RD 390/2021): no hay
  fuente en OpenSpain; el contexto de compraventa lo cubre
  **vivienda-compraventa**.
- Si pregunta por el **proceso de compraventa o alquiler** de una vivienda
  --> **vivienda-compraventa** / **vivienda-alquiler**.
- Si pregunta por **datos catastrales** (referencia, superficie, uso) -->
  **catastro**.
- Si pregunta si una parcela está en **zona inundable** --> **snczi**.
