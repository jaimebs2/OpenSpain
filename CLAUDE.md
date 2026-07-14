# OpenSpain — Instrucciones para Claude

Convenciones para contribuir al repo. Antes de empezar, ver el contexto:

- [docs/architecture/overview.md](docs/architecture/overview.md) — visión de conjunto de la estructura del repo.
- [ROADMAP.md](ROADMAP.md) — fases técnicas de evolución del proyecto.
- [docs/adr/](docs/adr/) — Architecture Decision Records con las decisiones nucleares.

## Cuatro planos del repo

| Plano | Directorio | Naturaleza |
|---|---|---|
| Knowledge (Nivel 3) | `openspain/skills/` | Skills `knowledge` con SKILL.md + service.yml + tests/ |
| Data (Niveles 1–2) | `mcps/` | MCPs Python proxy de APIs públicas con caché + procedencia |
| Tools (Nivel 4) | `tools/` | MCPs Python con tools deterministas por vertical |
| Librerías | `packages/` | `openspain-core` Python + TypeScript |

Antes de añadir algo nuevo, decidir en qué plano vive. Si no encaja claramente, abrir issue para discutir antes de empezar.

## Al añadir o modificar una skill (knowledge plane)

Cuando se cree una skill nueva o se modifique una existente, actualizar **todos** los archivos afectados:

### Archivos de la skill (`openspain/skills/<nombre>/`)

- `SKILL.md` — frontmatter YAML (`name`, `description`, `license`) + instrucciones markdown.
- `service.yml` — metadata según [schema canónico](docs/architecture/service-yml-schema.md), validado en CI contra [data/schemas/service.schema.json](data/schemas/service.schema.json). Obligatorio declarar el **origen** (`links` con URLs oficiales) y la **licencia de los datos** (`license.data`), para que cualquier agente pueda verificar y actualizar la skill. Campos adicionales cuando apliquen: `agent_accessibility`, `auth_owner`, `cache_ttl_seconds`, `reuse_commercial` (sólo Nivel 2), `proxy_of`.
- `tests/smoke.sh` — script bash que verifica las URLs referenciadas (HTTP 200). Hacerlo ejecutable (`chmod +x`). Usar `PASS=$((PASS + 1))` en vez de `((PASS++))` para compatibilidad con `set -e`.
- `tests/prompts.md` — al menos 3 preguntas de prueba con criterios de aceptación.

### Documentación

- `docs/services/<nombre>.md` — ficha técnica de la skill. Para sub-skills usar subdirectorio (ej. `docs/services/fiscalidad/iva.md`).
- `docs/README.md` — añadir entrada al índice, mantener orden alfabético.

### READMEs

- `README.md` — actualizar la tabla de skills (español) y el conteo si cambia.
- `README.en.md` — actualizar la tabla de services (inglés) y el conteo si cambia.

### Routing entre skills

Si la nueva skill se solapa temáticamente con otra existente, añadir en ambas una sección "Cuándo NO usar esta skill" con routing cruzado (ej. `aeat` ↔ `fiscalidad-iva`).

### Verificación

Ejecutar `bash openspain/skills/<nombre>/tests/smoke.sh` y confirmar que pasa antes de dar la tarea por terminada.

## Al añadir o modificar un MCP de datos (data plane)

Cada MCP vive en `mcps/<nombre>/` siguiendo el patrón de `mcps/catastro/` y `mcps/snczi/`:

- `pyproject.toml` — paquete Python instalable. Nombre `openspain-<nombre>`. Script `openspain-<nombre>-mcp`. Depender de `openspain-core` (instalable como editable desde `packages/openspain-core-py/` en desarrollo).
- `src/<nombre>/server.py` — entry point del MCP.
- `src/<nombre>/service.py` — lógica de proxy contra el origen oficial.
- `tests/` — al menos un test de smoke + tests de integración con `httpx.MockTransport`.
- `README.md` — qué fuente cubre, qué tools expone, ejemplos de uso.
- `service.yml` (opcional pero recomendado) — siguiendo el schema canónico, con `agent_accessibility: 1|2` y `auth_owner` correspondiente.

Cada MCP **respeta el `cache_ttl_seconds` declarado** y añade procedencia plana a cada respuesta: `source_url`, `fetched_at`, `cache_hit`, `license`.

Si descubres fricción operativa (double-hop, paginación rota, rate limit no documentado, agujero regional), documentarla en el README del MCP afectado y abrir un issue con la etiqueta `operational-friction` para que quede rastreable.

## Al añadir o modificar un MCP de tools (tools plane)

Cada MCP de tools vive en `tools/<vertical>-tools/`:

- Estructura idéntica a los MCPs de datos (`pyproject.toml` + `src/<vertical>_tools/` + `tests/` + `README.md`).
- Una tool puede consultar varios MCPs de datos del repo + lógica determinista. Si la tool sólo hace proxy de una API, vive en `mcps/`, no en `tools/`.
- Tests con casos reales (lo que la fuente acepta de verdad, no la teoría). Coverage objetivo: tests por cada rama lógica de decisión.

## Al añadir o modificar una librería compartida (`packages/`)

- `openspain-core-py` y `openspain-core-ts` mantienen **paridad de API pública**. Si añades un tipo en una, añádelo también en la otra.
- Mantener la superficie mínima: sólo lo que algún MCP del repo usa hoy.
- Cambios breaking incrementan el major version.

## Al tomar una decisión arquitectónica

Si la decisión cumple las tres condiciones (difícil de revertir, sorprendente sin contexto, resultado de trade-off real), abrir un ADR en [`docs/adr/`](docs/adr/) siguiendo el formato del README de ese directorio. Numerar secuencialmente.

## Convenciones generales

- **Naming**: kebab-case en directorios y `name` del frontmatter. Coincidencia obligatoria entre `name` y nombre de directorio (ej. `fiscalidad-iva`, `dgt-trafico`).
- **Sub-skills**: agrupadas bajo directorio padre (ej. `openspain/skills/fiscalidad/iva/`, `openspain/skills/dgt/dgt-trafico/`).
- **API type en `service.yml`**: `knowledge` para skills de orientación, `rest-json`/`rest-xml`/`soap`/`ckan`/`sparql`/etc. para skills con datos.
- **Idioma**: español. El contenido es sobre España y para usuarios hispanohablantes.
- **Dos superficies**: OpenSpain se distribuye como Skills portables y como un MCP superconjunto; una fuente se convierte en tool MCP solo si cae en la capa C (fricción real). Ver [ROADMAP.md](ROADMAP.md) y [ADR-0005](docs/adr/0005-dos-superficies-skills-mcp.md). Las skills de conocimiento son bienvenidas en cualquier dominio y sector.

## Deuda heredada conocida

- `/tests/` paralelo: directorio top-level con smoke tests de 33 skills heredados de la convención anterior. La convención actual los pone bajo `openspain/skills/<nombre>/tests/`. La migración es incremental: cuando se toca una skill, su smoke.sh se mueve dentro de la skill y se borra del directorio top-level.
- `AGENTS.md`: archivo análogo a CLAUDE.md para Codex/otros asistentes. Mantenerlo en sincronía manual; en algún momento converger.

## Verificación general antes de cerrar tarea

- Smoke tests pasan: `bash openspain/skills/<nombre>/tests/smoke.sh`.
- Si tocas un MCP, sus tests pasan: `cd mcps/<nombre> && pytest`.
- `git status` no muestra archivos sin trackear que deberían commitearse.
