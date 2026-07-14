# 0003 — Crear la librería compartida `openspain-core` desde el primer MCP

- **Estado**: aceptado
- **Decisión vinculada**: [ROADMAP.md](../../ROADMAP.md) — infraestructura compartida

## Contexto

La normalización (`NIF`, `CIF`, `RefCat`, `CodigoINE`, `FechaISO`, `Importe`, validadores, mapeo de errores) debe vivir junto a cada MCP que la aplica, no en un gateway. La pregunta es **cuándo** se crea la librería compartida:

- **Opción A**: aplazarla; cada MCP normaliza ad-hoc y se factoriza cuando haya varios MCPs operativos.
- **Opción B**: crearla desde el primer MCP, importada por cada uno desde su primer commit.

## Decisión

Crear `openspain-core` (Python + TypeScript) **desde el primer MCP**, con superficie mínima y expandible.

Estructura:
- `packages/openspain-core-py/` — paquete Python instalable como `openspain-core` vía pip / uv.
- `packages/openspain-core-ts/` — paquete TypeScript publicable en npm.

Contenido inicial:
- Tipos: `NIF`, `CIF`, `NIE`, `RefCat`, `CodigoINE`, `FechaISO`, `Importe`.
- Validadores correspondientes (formato, dígito de control donde aplique).
- Mapeo de errores: un enum compartido (`OpenSpainError`) que cada MCP traduce desde el error específico de la fuente.

Se mantienen **Python y TypeScript en paridad de API pública**, para que los MCPs y los clientes en ambos lenguajes compartan los mismos tipos y validadores.

## Consecuencias

**Positivas**
- Evita un refactor posterior cuando lleguen nuevos MCPs.
- Cada MCP queda más simple (menos código de normalización propio).
- Los tests de validación viven en un sitio único, no replicados por MCP.
- Versionado independiente: `openspain-core` evoluciona sin tocar cada MCP en cada cambio.

**Negativas**
- Requiere diseñar el API público antes de tener muchos usos reales — riesgo de abstracciones equivocadas. Mitigación: empezar con la superficie mínima que el primer MCP realmente usa y expandir con cada nuevo MCP.
- Añade dos paquetes a mantener (Python + TS) desde el principio.

## Alternativas consideradas

- **Opción A — aplazar**: defendible si la superficie inicial se mantiene pequeña, pero obliga a un refactor de des-duplicación en cuanto hay un segundo MCP. Se prefiere evitar ese refactor.
- **Solo Python, sin TS**: descartada porque la integración con clientes y agentes en TypeScript exige una versión TS coherente con la Python.
