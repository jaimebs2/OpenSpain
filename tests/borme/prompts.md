# Tests manuales — BORME

## Test 1 — Sumario diario por fecha
**Pregunta**: "¿Qué se publicó en el BORME el 6 de abril de 2026?"
**Pasa si**: el agente llama al endpoint `https://www.boe.es/datosabiertos/api/borme/sumario/20260406`, indica el número del BORME (`BORME-S-2026-64`), describe las secciones (A, B y/o C) y lista las provincias publicadas con sus enlaces a PDF.
**Falla si**: responde con información genérica sobre el BORME sin consultar la API, o se inventa empresas/actos sin abrir los PDF.

## Test 2 — Actos inscritos por provincia
**Pregunta**: "Dame los actos inscritos en el Registro Mercantil de Madrid del último día hábil."
**Pasa si**: el agente calcula el último día hábil, llama al sumario del BORME para esa fecha, localiza el item de la Sección A cuyo `titulo` es `MADRID` y proporciona el enlace al PDF (`url_pdf.texto`) explicando que el detalle de los actos individuales solo está disponible en el PDF.
**Falla si**: pretende listar nombres de empresas o tipos concretos de acto sin admitir que la API solo da metadatos y enlace al PDF, o consulta una fecha sin publicación (fin de semana) sin reintentar con un día hábil.
