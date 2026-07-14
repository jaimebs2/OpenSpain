---
name: openspain
description: "Use when the user asks anything about Spanish public data, government APIs, official statistics, legislation, weather, traffic, taxes (VAT, income tax, corporate tax, invoicing, censal declarations, EU operations, inheritance tax), employment, immigration (NIE, residence, nationality, asylum), housing, mortgages, building code (CTE), vehicles (driving licence, ITV inspection, ownership transfer), inheritance, wills, digital identity (FNMT, Cl@ve, DNIe), real estate, energy, health, education (scholarships, Selectividad, FP, civil service), elections, public contracts, citizen procedures (empadronamiento, criminal record, apostille, appointments), flood zones, or any other open data or official guidance from Spain. This is the master skill for OpenSpain — a curated directory of 97 skills (42 categories, many with sub-skills) that wrap every major Spanish public data source and regulated procedure into ready-to-use agent capabilities. Triggers on: 'datos públicos España', 'API gobierno España', 'OpenSpain', 'datos abiertos España', 'información pública española', 'gobierno España datos', 'open data Spain', 'trámite España', or any mention of a specific Spanish public institution or dataset."
license: MIT
---

# OpenSpain — Todos los datos públicos de España en una skill

OpenSpain conecta a tu agente de IA con las APIs, datasets e información oficial del sector público español. 42 categorías (97 skills contando las variantes), cero servidores, cero SDKs, sin API key en la mayoría de los casos.

Esta skill es el **punto de entrada**. Úsala para identificar qué skill específica necesita el usuario y guiarle a instalarla.

---

## Catálogo de skills

### Legislación y registro mercantil

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `boe` | BOE: sumarios diarios, disposiciones, leyes consolidadas | — |
| `borme` | Registro Mercantil: constitución y cambios de empresas | — |

**Instalar**: `npx skills add jaimebs2/OpenSpain --skill boe`

### Parlamento

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `congreso` | Votaciones, iniciativas, intervenciones, vídeos de plenos | — |
| `senado` | Actividad parlamentaria, comisiones, textos legislativos | — |

### Justicia (orientación ciudadana)

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `justicia-gratuita` | Requisitos, umbrales de renta, colegios de abogados, solicitud | — |
| `testamento` | Tipos de testamento, registro de últimas voluntades, costes | — |
| `herencias` | Aceptación, Impuesto de Sucesiones, partición, legítima | — |
| `poder-notarial` | Poderes generales/especiales/preventivos, apud acta, revocación | — |
| `registro-civil` | Nacimientos, matrimonios, defunciones, fe de vida, cambio de nombre | — |
| `proteccion-datos` | RGPD, LOPDGDD, ejercicio de derechos ARCO-POL, AEPD | — |

### Estadística y macroeconomía

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `ine` | INE: IPC, inflación, paro EPA, demografía, censos, PIB | — |
| `sepe` | Paro registrado por municipio, sexo, edad, sector (SEPE/INEM) | — |
| `seguridad-social` | Afiliación, altas/bajas, pensiones | — |
| `bde` | Banco de España: tipos de interés, balanza de pagos, macroeconomía | — |
| `aeat` | Estadísticas fiscales: IRPF, IVA, Sociedades | — |
| `cis` | Barómetros y encuestas sociológicas del CIS desde 1963 | — |

### Fiscalidad (skills de orientación — no presentan declaraciones)

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `fiscalidad-iva` | IVA: tipos impositivos, Modelos 303/390, regímenes, cálculo | — |
| `fiscalidad-irpf-autonomos` | IRPF autónomos: Modelos 130/131, pagos fraccionados, retenciones | — |
| `fiscalidad-irpf-asalariados` | IRPF asalariados: tramos, Renta Web, deducciones, obligación de declarar | — |
| `fiscalidad-autonomos` | Visión general de obligaciones fiscales del autónomo, alta, calendario | — |
| `fiscalidad-facturacion` | Facturas: requisitos, simplificada, rectificativa, electrónica (VeriFactu, Facturae) | — |
| `fiscalidad-modelo-036` | Declaración censal: Modelo 036/037, altas, ROI, casillas clave | — |
| `fiscalidad-operaciones-intracomunitarias` | Operaciones UE: ROI/VIES, inversión del sujeto pasivo, Modelos 303/349 | — |
| `fiscalidad-retenciones` | Retenciones e ingresos a cuenta: profesionales, alquileres, Modelos 111/115/190 | — |
| `fiscalidad-sociedades` | Impuesto de Sociedades: tipos, Modelo 200/202, deducciones | — |
| `fiscalidad-itp-ajd` | ITP-AJD: vivienda usada, hipotecas, tipos por CCAA, Modelos 600/620 | — |
| `fiscalidad-impuestos-locales` | Impuestos locales: IBI, IAE, plusvalía municipal, IVTM | — |
| `fiscalidad-sucesiones-donaciones` | Sucesiones y Donaciones: reducciones por CCAA, Modelos 650/651 | — |
| `fiscalidad-no-residentes` | No residentes: IRNR, Modelo 210, Ley Beckham, convenios de doble imposición | — |

### Laboral (derechos y obligaciones)

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `laboral-contratos` | Tipos de contrato, cláusulas, periodo de prueba, extinción | — |
| `laboral-nominas` | Componentes de la nómina, cálculo neto/bruto, retenciones, cotizaciones | — |
| `laboral-desempleo` | Prestación contributiva, subsidio, requisitos, cálculo de cuantía | — |
| `laboral-ere-erte` | Expedientes de regulación de empleo temporales y definitivos | — |
| `laboral-convenios` | Convenios colectivos sectoriales y de empresa, salarios, jornada | — |
| `laboral-inspeccion` | Inspección de Trabajo: denuncias, sanciones, actuaciones | — |

### Seguridad Social (guías ciudadano)

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `jubilacion` | Edad legal, años cotizados, cálculo de base reguladora, jubilación anticipada/activa | — |
| `vida-laboral` | Informe de vida laboral, periodos cotizados, tramitación | — |
| `incapacidad` | Incapacidad temporal y permanente, grados, cuantías, tribunal médico | — |
| `maternidad-paternidad` | Permiso por nacimiento, requisitos, duración, prestación | — |
| `cotizaciones` | Bases de cotización, tarifa plana autónomos, grupos, cuotas | — |

### Transporte y movilidad

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `dgt-trafico` | Tráfico en tiempo real: incidencias, retenciones, cortes de carretera | — |
| `dgt-zbe` | Zonas de bajas emisiones: restricciones por etiqueta DGT | — |
| `dgt-accidentes` | Estadísticas de siniestralidad vial por año y provincia | — |
| `aena` | Estadísticas aeroportuarias: pasajeros, operaciones, carga | — |
| `puertos` | Oceanografía (mareógrafos, oleaje) y estadísticas portuarias | — |

### Territorio y medio ambiente

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `catastro` | Inmuebles, parcelas, referencias catastrales | — |
| `cnig` | Geocodificación y topónimos vía CartoCiudad (IGN/CNIG) | — |
| `miteco` | Embalses, calidad del aire, biodiversidad | — |
| `snczi` | SNCZI: zonas inundables (T=10/100/500), DPH, zona policía/servidumbre | — |

### Vivienda (guías ciudadano)

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `vivienda-compraventa` | Proceso de compra, ITP/IVA, gastos, nota simple, arras | — |
| `vivienda-hipotecas` | Tipos de hipoteca, TIN/TAE, subrogación, novación, amortización | — |
| `vivienda-registro-propiedad` | Nota simple, inscripción, certificación, cargas | — |
| `vivienda-comunidad-propietarios` | LPH, cuotas, juntas, acuerdos, obras | — |
| `vivienda-alquiler` | LAU, contratos, fianza, índice de referencia, desahucio | — |

### Construcción y edificación

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `cte` | Código Técnico de la Edificación: Documentos Básicos (SE, SI, SUA, HS, HR, HE), radón, zonas climáticas | — |

### Vehículos y conductores

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `carnet-conducir` | Permisos de conducir: tipos, obtención, renovación, canje, puntos | — |
| `itv` | ITV: periodicidad por tipo de vehículo, documentación, resultados, sanciones | — |
| `permiso-internacional` | Permiso Internacional de Conducción: cuándo hace falta, solicitud | — |
| `transferencia-vehiculos` | Compraventa de vehículos usados: transferencia en DGT, documentación, ITP | — |

### Energía y telecomunicaciones

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `esios` | Sistema eléctrico: precio horario, demanda, generación por tecnología | 🔑 |
| `cnmc` | Energía, telecomunicaciones, audiovisual, transporte (CNMC) | — |

### Meteorología

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `aemet` | Predicción, climatología, alertas meteorológicas | 🔑 |

### Sanidad

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `sanidad` | Centros de salud, hospitales, datos de mortalidad | — |

### Educación

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `educacion` | Centros educativos, matrículas, estadísticas educativas | — |
| `becas-mec` | Becas MEC: umbrales, plazos, cuantías, solicitud | — |
| `selectividad` | EBAU/EvAU: estructura, calificación, ponderaciones, nota de admisión | — |
| `fp` | Formación Profesional: Grado Medio, Superior, Dual, titulaciones | — |
| `oposiciones` | Procesos selectivos, temarios, requisitos, convocatorias | — |

### Cultura y medios

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `bne` | Biblioteca Nacional: bibliografía, fondo sonoro, patrimonio | — |
| `rtve` | Archivo RTVE: noticias, programas, vídeos | — |

### Elecciones

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `jec` | Resultados electorales, censo electoral, votos por partido | — |

### Transparencia y contratación pública

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `transparencia` | Contratos del Estado, subvenciones, altos cargos | — |
| `placsp` | Licitaciones y contratos del sector público (PLACSP) | — |
| `infosubvenciones` | Convocatorias y concesiones de subvenciones públicas | — |

### Turismo y datos abiertos

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `dataestur` | Turismo: FRONTUR, EGATUR, ocupación hotelera | — |
| `datos-gob-es` | Catálogo nacional datos.gob.es: +90.000 datasets públicos | — |

### Emprendimiento

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `alta-autonomo` | Alta RETA y AEAT: Modelo 036/037, tarifa plana, CIRCE | — |
| `crear-empresa` | SL, SA, SLU: constitución, CIRCE, PAE, capital mínimo, estatutos | — |
| `licencias-actividad` | Apertura, obra, actividades clasificadas, responsable/comunicación previa | — |

### Identidad digital

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `certificado-digital` | FNMT: solicitud, verificación presencial, descarga, renovación | — |
| `clave` | Cl@ve PIN, Cl@ve permanente, registro, nivel de seguridad | — |
| `dnie` | DNI electrónico: lectores, PIN, firma, caducidad certificados | — |
| `autofirma` | AutoFirma: instalación, firma de documentos PDF/XML, integración sede | — |

### Extranjería

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `extranjeria-nie` | Número de Identidad de Extranjero: solicitud, documentación, cita previa | — |
| `extranjeria-residencia` | Autorización de residencia (temporal, larga duración, UE) | — |
| `extranjeria-trabajo` | Autorización de trabajo por cuenta ajena/propia, cambios, renovación | — |
| `extranjeria-nacionalidad` | Nacionalidad por residencia, origen, opción, carta naturaleza, examen DELE/CCSE | — |
| `extranjeria-arraigo` | Arraigo social, laboral, familiar, formativo, para la formación | — |
| `extranjeria-reagrupacion` | Reagrupación familiar: cónyuge, hijos, ascendientes, requisitos económicos | — |
| `extranjeria-familiar-ue` | Tarjeta de familiar de ciudadano de la UE, derechos, residencia | — |
| `extranjeria-asilo` | Protección internacional: asilo, protección subsidiaria, tramitación | — |

### Trámites ciudadanos

| Skill | Qué cubre | Auth |
|-------|-----------|:----:|
| `empadronamiento` | Alta/baja/cambio, volantes, certificados, empadronamiento sin domicilio | — |
| `antecedentes-penales` | Certificado de antecedentes penales, solicitud sede, apostilla | — |
| `apostilla` | Apostilla de La Haya: documentos públicos para uso internacional | — |
| `cita-previa` | Sistema CITA PREVIA de las AAPP: Seg. Social, AEAT, extranjería, DNI | — |
| `tarjeta-sanitaria-europea` | TSE: emisión, validez, cobertura por país, renovación | — |
| `legalizacion-documentos` | Legalización consular y diplomática cuando no aplica apostilla | — |

🔑 = requiere API key gratuita (ver instrucciones en cada skill).

---

## Cómo usar esta skill

Cuando el usuario pregunte sobre datos públicos españoles:

1. **Identifica** qué skill del catálogo cubre su consulta.
2. **Si la skill está instalada**, delega a ella directamente.
3. **Si no está instalada**, indica al usuario cómo instalarla:

```
npx skills add jaimebs2/OpenSpain --skill <nombre>
```

### Instalar todas las skills de una vez

```
npx skills add jaimebs2/OpenSpain
```

### Ejemplos de routing

| Pregunta del usuario | Skill recomendada |
|----------------------|-------------------|
| "¿Qué se publicó hoy en el BOE?" | `boe` |
| "¿Cuál es el IPC de marzo?" | `ine` |
| "Precio de la luz ahora" | `esios` (🔑) |
| "¿Hay retenciones en la A-6?" | `dgt-trafico` |
| "¿Llueve mañana en Sevilla?" | `aemet` (🔑) |
| "Referencia catastral de Calle Mayor 1, Madrid" | `catastro` |
| "¿Mi parcela está en zona inundable?" | `snczi` |
| "Paro registrado en Málaga" | `sepe` |
| "Resultados electorales 2023" | `jec` |
| "¿Cuánto IVA aplico a servicios digitales?" | `fiscalidad-iva` |
| "Obligaciones fiscales de un autónomo" | `fiscalidad-autonomos` |
| "Cómo calcular mi nómina neta" | `laboral-nominas` |
| "Cuándo puedo jubilarme con 35 años cotizados" | `jubilacion` |
| "Requisitos para pedir el NIE" | `extranjeria-nie` |
| "Cómo conseguir la nacionalidad española por residencia" | `extranjeria-nacionalidad` |
| "Pasos para darme de alta como autónomo" | `alta-autonomo` |
| "Cómo obtener el certificado digital FNMT" | `certificado-digital` |
| "Cómo empadronarme sin contrato de alquiler" | `empadronamiento` |
| "Apostillar un título universitario" | `apostilla` |
| "Impuesto de sucesiones en Madrid" | `herencias` |
| "ITP al comprar vivienda de segunda mano" | `vivienda-compraventa` |
| "Qué becas MEC puedo pedir" | `becas-mec` |
| "Ponderaciones EBAU para medicina" | `selectividad` |
| "Licitaciones del Ministerio de Defensa" | `placsp` |
| "¿Cada cuánto pasa la ITV mi furgoneta?" | `itv` |
| "Cómo transferir un coche de segunda mano" | `transferencia-vehiculos` |
| "¿Qué exige el CTE sobre el radón?" | `cte` |
| "Factura a un cliente de Francia sin IVA" | `fiscalidad-operaciones-intracomunitarias` |
| "Qué casillas del Modelo 036 marco para alta en ROI" | `fiscalidad-modelo-036` |

---

## Sobre OpenSpain

- **Repositorio**: github.com/jaimebs2/OpenSpain
- **Licencia código**: MIT
- **Licencia datos**: cada organismo define la suya (mayoritariamente reutilización libre según Ley 37/2007)
- **Sin servidores**: las skills usan WebFetch directamente contra las APIs públicas
- **Estándar abierto**: compatible con Agent Skills (agentskills.io)
