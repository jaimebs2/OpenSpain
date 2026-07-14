# Roadmap técnico

OpenSpain conecta la información y los datos públicos de España con agentes de IA. Es un proyecto **abierto y colaborativo**: cualquiera puede aportar skills y MCPs para cualquier fuente pública, de **cualquier sector** (normativa, ayudas, estadística, movilidad, energía, educación, sanidad, cultura…). Este documento describe cómo está organizado el catálogo y cómo crece. Las decisiones de fondo están en los [ADRs](docs/adr/).

## Dos superficies de distribución

Un mismo catálogo se distribuye de dos formas, y el MCP es un **superconjunto** de las skills (ver [ADR-0002](docs/adr/0002-federacion-mcps-por-dominio.md) y [ADR-0005](docs/adr/0005-dos-superficies-skills-mcp.md)):

- **OpenSpain Skills** (`npx skills add jaimebs2/OpenSpain`) — las skills como markdown portable. Cero infraestructura; funciona en cualquier agente compatible con [Agent Skills](https://agentskills.io) (Claude, Cursor, GitHub Copilot, Codex…). Es la capa ligera: conocimiento + guía de uso de cada fuente.
- **OpenSpain MCP** — un servidor MCP que expone dos cosas a la vez:
  - **Tools** deterministas para las fuentes que lo requieren (parsing complejo, geometría, autenticación, encadenamiento multi-fuente).
  - **Resources**: las skills de conocimiento, para que un agente conectado al MCP **también** lea toda la guía sin instalarlas por separado.

Quien quiere lo ligero instala las skills; quien quiere la versión completa conecta el MCP y tiene conocimiento y ejecución en un único sitio. El MCP no divide el catálogo: lo engloba.

## Tres capas: qué vive como skill y qué como tool MCP

No toda fuente necesita un MCP. La regla que decide (ver [ADR-0005](docs/adr/0005-dos-superficies-skills-mcp.md)):

| Capa | Qué es | Vive como |
|---|---|---|
| **A — Conocimiento** | Orientación normativa o procedimental (fiscalidad, laboral, extranjería, justicia, trámites, vivienda…) | Skill, siempre. Nunca necesita MCP. |
| **B — Datos REST-JSON limpio** | API que devuelve JSON que un `WebFetch` lee de una pasada | La skill basta. Pasa a MCP solo si aparece volumen o necesidad de caché. |
| **C — Datos con fricción** | Formato no trivial (XML, SPARQL, CKAN, XLSX, THREDDS), autenticación con clave hospedada, geometría o encadenamiento de varias fuentes | Skill fina (puntero) **+ tool en el MCP** |

Estado actual del catálogo (97 skills): **~65 en capa A**, **~16 en capa B**, **~15 en capa C**. De la capa C, 2 ya tienen MCP (`catastro`, `snczi`); el resto son candidatas.

## Fuentes candidatas a tool MCP (capa C)

Por tipo de fricción:

- **Formato que un LLM no parsea fiable por WebFetch**: `puertos` (THREDDS/OPeNDAP), `aena` y `dataestur` (XLSX), `bne` (SPARQL), `cnmc` (CKAN), `dgt-trafico` y `dgt-zbe` (XML), `senado` y `congreso` (XML/ficheros), `dgt-accidentes`.
- **Autenticación (clave que alguien debe hospedar)**: `aemet` (clave + *double-hop* con URLs temporales), `esios` (clave de REE), `jec`.
- **Cálculo o encadenamiento multi-fuente**: `catastro` ✅, `snczi` ✅, `cnig` (geocodificación, se empareja con catastro).

## Cómo crece el proyecto

- **Por contribución de la comunidad.** Cualquiera abre un PR con una skill nueva de cualquier sector siguiendo [CONTRIBUTING.md](CONTRIBUTING.md). Las skills de conocimiento son bienvenidas en cualquier dominio y sin orden preestablecido.
- **Los MCPs se añaden por fricción real + demanda de uso**, no por completismo: una fuente pasa a tener tool cuando cae en la capa C y alguien la consume de verdad.
- **Cada fuente se completa de punta a punta** (`SKILL.md` → `service.yml` → `tests/` → ficha en `docs/`; y además tool + tests si es capa C) antes de darla por lista.

## Infraestructura compartida

- [`packages/openspain-core`](packages/) (Python + TypeScript): tipos comunes (`NIF`, `RefCat`, `CodigoINE`, `FechaISO`, `Importe`…), validadores y mapeo de errores, importados por cada MCP. Ver [ADR-0003](docs/adr/0003-openspain-core-desde-el-primer-mcp.md).
- **CI**: [`validate-services`](.github/workflows/validate-services.yml) valida todos los `service.yml` contra el schema canónico en cada PR (gate bloqueante); [`smoke-all`](.github/workflows/smoke-all.yml) verifica la liveness de las URLs oficiales (advisory, semanal).
- **Router MCP** (futuro): cuando haya varios MCPs operativos, un endpoint único que federe data plane, tools plane y knowledge plane (ver [ADR-0002](docs/adr/0002-federacion-mcps-por-dominio.md)).
