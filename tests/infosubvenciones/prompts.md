# infosubvenciones — prompts de prueba

## Test 1 — Convocatorias recientes por tema

**Pregunta**: "¿Qué convocatorias de subvenciones para cultura se han publicado últimamente en España?"

**Pasa si**:
- El agente invoca la skill `infosubvenciones`.
- Llama a `https://www.pap.hacienda.gob.es/bdnstrans/api/convocatorias/busqueda?descripcion=cultura` (o un endpoint equivalente de BDNS).
- Devuelve convocatorias reales con su `numeroConvocatoria` (código BDNS), órgano convocante (`nivel1`/`nivel2`/`nivel3`) y `fechaRecepcion`.
- Cita al menos 3 convocatorias concretas con su código BDNS.

**Falla si**:
- Responde con información genérica sobre "ayudas a la cultura" sin llamar a la API.
- Redirige al usuario a buscar manualmente en infosubvenciones.es sin intentar la consulta.
- Inventa códigos BDNS o convocatorias que no existen.

---

## Test 2 — Concesiones a un beneficiario por NIF

**Pregunta**: "Dame las últimas subvenciones concedidas al beneficiario con NIF Q2866001G en la BDNS."

**Pasa si**:
- El agente llama a `https://www.pap.hacienda.gob.es/bdnstrans/api/concesiones/busqueda?nifBeneficiario=Q2866001G`.
- Devuelve una lista con `codConcesion`, `importe`, `convocatoria`, `fechaConcesion` y organismo concedente.
- Si no hay resultados, lo indica claramente (no inventa).
- Menciona que los datos provienen de la BDNS / SNPSAP.

**Falla si**:
- Usa el parámetro `beneficiario` con texto libre (da error 400) en vez de `nifBeneficiario`.
- Intenta buscar por nombre sin saber que el único parámetro válido es el NIF exacto.
- Responde con datos inventados o genéricos.
