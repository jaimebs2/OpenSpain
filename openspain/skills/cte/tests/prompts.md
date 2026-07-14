# Tests manuales — cte

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 — Municipio en zona de radón

**Prompt**: "Voy a construir una casa en Ourense. ¿Está mi municipio en zona de radón y qué me obliga a hacer la normativa?"

**Criterios de aceptación**:
- Identifica que la referencia es la sección **HS 6** del DB-HS.
- Explica que los municipios afectados están en el **apéndice B del DB-HS**, clasificados en zona I y zona II.
- Da la URL oficial del PDF del DB-HS (`codigotecnico.org/pdf/Documentos/HS/DBHS.pdf`) para verificar el municipio.
- Describe las soluciones exigidas (barrera de protección, cámara de aire ventilada, despresurización del terreno según zona).
- No inventa la clasificación del municipio sin consultar el apéndice.

---

## Test 2 — Reforma con cambio de uso

**Prompt**: "Quiero convertir un local comercial en vivienda. ¿Qué documentos básicos del CTE me aplican?"

**Criterios de aceptación**:
- Indica que el **cambio de uso característico** entra en el ámbito de aplicación del CTE.
- Menciona los DB relevantes para uso vivienda: DB-HS (salubridad), DB-HR (ruido), DB-SUA (utilización y accesibilidad), DB-HE (ahorro de energía) y DB-SI (incendio).
- Explica el criterio de flexibilidad / no empeoramiento en edificios existentes.
- Aclara que la licencia municipal de cambio de uso es competencia del ayuntamiento y remite a **emprendimiento-licencias-actividad**.

---

## Test 3 — Exigencias de incendio en residencial

**Prompt**: "¿Qué exige el DB-SI para un edificio residencial de viviendas?"

**Criterios de aceptación**:
- Identifica el DB-SI como el documento de seguridad en caso de incendio.
- Describe sus secciones: propagación interior (SI 1), propagación exterior (SI 2), evacuación de ocupantes (SI 3), instalaciones de protección (SI 4), intervención de bomberos (SI 5) y resistencia al fuego de la estructura (SI 6).
- Indica que las exigencias concretas dependen del uso (Residencial Vivienda) y de la altura de evacuación.
- Da la URL oficial del PDF del DB-SI.

---

## Test 4 — Zona climática

**Prompt**: "¿Qué zona climática tiene Burgos para el cálculo de eficiencia energética de una obra nueva?"

**Criterios de aceptación**:
- Remite al **anejo B del DB-HE** (zona por provincia y altitud).
- Explica la nomenclatura (letra de invierno α/A–E + número de verano 1–4).
- No confunde la zona climática del CTE con el certificado energético de un inmueble concreto.

---

## Test 5 — Routing a boe

**Prompt**: "Dame el texto del artículo 2 del Real Decreto 314/2006."

**Criterios de aceptación**:
- Usa el patrón de la API del BOE (`legislacion-consolidada/id/BOE-A-2006-5515`) o remite a la skill **boe**.
- No intenta reproducir el articulado de memoria.
