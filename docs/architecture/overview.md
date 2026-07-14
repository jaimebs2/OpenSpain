# Arquitectura — visión de conjunto

Resumen de la estructura del repo y el sentido de cada directorio. Para decisiones específicas, ver los [ADRs](../adr/). Para el plan de ejecución, ver [ROADMAP.md](../../ROADMAP.md).

## Estructura

```
/
├── ROADMAP.md                   ← fases técnicas de evolución del proyecto
├── README.md / README.en.md     ← propuesta de valor y tabla de skills
├── CLAUDE.md / AGENTS.md        ← convenciones para asistentes IA contribuyendo al repo
├── CONTRIBUTING.md              ← cómo contribuir
├── LICENSE                      ← MIT (código); datos según fuente declarada en service.yml
│
├── openspain/skills/            ← Knowledge plane (Nivel 3)
│   └── <nombre>/                  97 skills con SKILL.md + service.yml + tests/
│                                  Markdown puro orientativo, no son tools MCP.
│
├── mcps/                        ← Data plane (Niveles 1–2)
│   ├── catastro/                  Cada MCP es un paquete Python independiente
│   ├── snczi/                     con pyproject.toml + src/<name>/ + tests/.
│   └── ...                        Proxy de APIs públicas con caché + procedencia.
│
├── tools/                       ← Tools plane (Nivel 4 — cálculo determinista)
│   └── <vertical>-tools/           MCPs con tools deterministas por vertical
│                                  (simular_*, validar_*, calcular_*).
│                                  No son UI ni copilotos: tools que Claude/ChatGPT llaman.
│
├── packages/                    ← Librerías compartidas
│   ├── openspain-core-py/         Tipos, validadores, errores (Python)
│   └── openspain-core-ts/         Tipos, validadores, errores (TypeScript)
│
├── docs/
│   ├── README.md                  Índice de fichas técnicas
│   ├── services/                  Ficha técnica por skill
│   ├── adr/                       Architecture Decision Records
│   └── architecture/              Schemas y visión de conjunto (este archivo)
│
├── data/
│   └── schemas/                   JSON Schemas (service.schema.json)
│                                  (Futuros: volatile-manifest.yml, normativa-manifest.yml)
│
├── tests/                       ← Smoke tests legacy paralelos por skill (deuda heredada)
│                                  Cada smoke.sh comprueba HTTP 200 en URLs documentadas.
│                                  Migración a openspain/skills/<nombre>/tests/ es incremental.
│
└── .github/
    ├── workflows/                 smoke-all.yml + validate-services.yml activos
    ├── ISSUE_TEMPLATE/
    └── PULL_REQUEST_TEMPLATE.md
```

## Cuatro planos federados detrás del router

La meta-arquitectura (ver [ADR-0002](../adr/0002-federacion-mcps-por-dominio.md) y [ADR-0004](../adr/0004-knowledge-data-tools-planes-separados.md)):

```
[Cliente agente]
      │
      ▼
[openspain/router]                  ← evoluciona desde la meta-skill openspain/SKILL.md
      │
      ├── Data plane (mcps/)        ← Niveles 1–2: catastro_mcp, boe_mcp, ...
      │
      ├── Tools plane (tools/)      ← Nivel 4: <vertical>-tools, ...
      │
      └── Knowledge plane           ← Nivel 3: openspain/skills/*
            (MCP Resources o
             distribución standalone vía npx skills add)

cada MCP de datos ──> packages/openspain-core (normalización)
                   ──> edge cache (TTL declarado en service.yml)
                   ──> origen oficial
```

El router como pieza propia se construye cuando hay varios MCPs operativos (ver [ROADMAP.md](../../ROADMAP.md)). En el estado actual no existe; la meta-skill [`openspain/SKILL.md`](../../openspain/SKILL.md) desempeña el papel de enrutador conceptual.

## Granularidad de cada artefacto

| Artefacto | Granularidad | Versionado | Distribución |
|---|---|---|---|
| Skills (`openspain/skills/<n>/`) | Una por servicio público o sub-dominio | Git tags por release del bundle | `npx skills add jaimebs2/OpenSpain` |
| MCPs (`mcps/<n>/`) | Uno por organismo o cluster afín | Semver en `pyproject.toml`; PyPI cuando haya release | PyPI (`openspain-<n>-mcp`) |
| Tools (`tools/<vertical>-tools/`) | Uno por vertical (fiscal, laboral, …) | Semver en `pyproject.toml`; PyPI cuando haya release | PyPI (`openspain-<vertical>-tools`) |
| Librerías (`packages/openspain-core-*`) | Una por lenguaje (Python, TS) | Semver; pin desde cada MCP/tool | PyPI + npm |

## Estado actual (snapshot)

- 97 skills (30 top-level + 67 sub-skills) en `openspain/skills/`, más la meta-skill `openspain`.
- 2 MCPs Python en producción (`catastro`, `snczi`).
- 0 tools en `tools/` (plano descrito en `tools/README.md`; se añaden por demanda real).
- 0 paquetes publicados (`openspain-core` en esqueleto, se rellena con el primer MCP que lo importe).
- 2 workflows CI activos (`smoke-all.yml`, `validate-services.yml`).
- 5 ADRs documentando las decisiones de la reestructuración.

## Por qué tres planos top-level y no un único `src/`

Ver [ADR-0004](../adr/0004-knowledge-data-tools-planes-separados.md). Resumen: la distribución y la naturaleza técnica son distintas por plano (markdown portable vs proxy con caché vs cálculo determinista). Mezclar todo bajo un único árbol oculta esas diferencias.
