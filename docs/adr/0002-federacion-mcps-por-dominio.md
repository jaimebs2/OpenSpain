# 0002 — Federación de MCPs por dominio + meta-router en lugar de MCP monolítico

- **Estado**: aceptado
- **Fecha**: 2026-05-19
- **Decisión nuclear vinculada**: arquitectura de federación de MCPs

## Contexto

OpenSpain expone hoy ~33 skills con API real (rest-json / rest-xml / SOAP / CKAN / SPARQL) más 64 skills de conocimiento. Sin estructura adicional, hay dos extremos posibles para servirlas a un agente del cliente:

1. **Un único MCP monolítico** que exponga todas las tools (potencialmente 96 tools cargadas en el manifest del agente). Carga un manifest de ~1 MB por sesión, satura el descubrimiento, mata la latencia.
2. **N MCPs sueltos** (uno por servicio) que el cliente integra uno por uno. Obliga a configurar auth N veces y multiplica el descubrimiento.

Ninguno de los dos extremos es operable a escala.

## Decisión

Adoptar una topología de **cuatro planos federados detrás de un router**:

1. **`openspain/router` (meta-MCP)** — único endpoint que el agente del cliente conecta. Tool principal `discover(query, budget)` devuelve dominios relevantes + token efímero. Evoluciona desde la meta-skill `openspain` actual.
2. **MCPs de datos por dominio** (Niveles 1–2) — ~12–15 MCPs agrupando los servicios con API real, alineados con `service.yml::organization`. Cada uno con rate-limit, caché y SLA propios.
3. **MCPs de tools deterministas** (Nivel 4) — pocos, agrupados por vertical (ej. `<vertical>-tools`). Exponen tools que el agente del cliente llama (cálculo, validación, propuesta).
4. **Knowledge plane** (Nivel 3) — las 64 skills informativas no son tools MCP: se exponen como MCP Resources desde el router, o se distribuyen standalone vía `npx skills add`.

Normalización (NIF/CIF/RefCat/FechaISO/Importe, validadores, mapeo de errores) vive en la librería compartida `openspain-core` (ver [ADR-0003](0003-openspain-core-desde-el-primer-mcp.md)) importada por cada MCP, no en el router.

## Consecuencias

**Positivas**
- El agente del cliente ve ~15 dominios + bundle de conocimiento, expande bajo demanda. Descubrimiento manejable.
- Agrupar por dominio da granularidad sensata para versionado, caché y rotación de claves.
- Mantener ~15 MCPs es viable; mantener casi 100 tools en un único MCP no.
- Cada MCP puede tener su rate-limit, caché y SLA específicos sin acoplarse al resto.

**Negativas**
- Primer hop al router añade ~50 ms de latencia. Aceptable.
- Hay que mantener el router como pieza propia, distinta de los MCPs de dominio.
- La separación entre "MCP de datos" y "MCP de tools" tiene casos límite (¿una tool que sólo consulta una API es Nivel 1 o Nivel 4?). Se resuelve caso a caso: si añade lógica de negocio determinista, va a tools; si es proxy puro, va a MCP de datos.

## Alternativas consideradas

- **MCP monolítico**: descartado por saturación del manifest y por imposibilidad de evolucionar rate-limits/SLAs independientes por fuente.
- **N MCPs sueltos sin router**: descartado por fricción de integración (N auths, N descubrimientos).
- **Router + un único MCP "datos" + un único MCP "tools"**: probado mentalmente. Pierde la granularidad por dominio que permite SLAs específicos y rotación de keys por API.
