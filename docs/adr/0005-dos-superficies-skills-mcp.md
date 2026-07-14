# 0005 — Dos superficies de distribución (Skills + MCP) y regla de tres capas

- **Estado**: aceptado
- **Decisión vinculada**: [ROADMAP.md](../../ROADMAP.md) — organización del catálogo

## Contexto

OpenSpain tiene dos naturalezas de contenido: **conocimiento** (orientación normativa/procedimental, markdown) y **datos/ejecución** (proxy de APIs públicas, cálculo determinista). La pregunta es cómo se distribuyen sin duplicar catálogo ni obligar al usuario a elegir entre "solo lo ligero" y "solo lo potente".

Dos malas respuestas:

1. **Todo como skills** — el conocimiento viaja bien, pero hay fuentes que un LLM no consume de forma fiable vía `WebFetch`: geometría, parsing SOAP/WMS/XML/SPARQL, APIs con clave, o encadenamiento multi-fuente. Una skill que le pide al modelo reimplementar eso cada vez es frágil.
2. **Todo como MCP** — obliga a levantar infraestructura para consultar una ley o un plazo, cuando un markdown portable basta y funciona en cualquier agente.

## Decisión

**Un solo catálogo, dos superficies de distribución, donde el MCP es un superconjunto de las skills.**

- **OpenSpain Skills** (`npx skills add`): las skills como markdown portable. Capa ligera, cero infraestructura, cualquier agente compatible con Agent Skills.
- **OpenSpain MCP**: un servidor que expone **tools** deterministas (para las fuentes que lo requieren) **y** las skills de conocimiento como **MCP Resources**. Contiene todo lo que tienen las skills, más la ejecución.

Qué se convierte en tool lo decide una **regla de tres capas**:

| Capa | Criterio | Vive como |
|---|---|---|
| **A — Conocimiento** | Orientación normativa/procedimental, sin ejecución | Skill, siempre |
| **B — Datos REST-JSON limpio** | JSON que un `WebFetch` lee de una pasada | Skill basta; MCP solo si escala/caché |
| **C — Datos con fricción** | Formato no trivial, auth con clave, geometría o encadenamiento | Skill fina + tool en el MCP |

Una fuente de capa C **no deja de tener skill**: la skill queda como entrada de catálogo (qué es, cuándo usarla, a qué tool llamar). El conocimiento y la ejecución conviven; no se excluyen.

## Consecuencias

**Positivas**
- El usuario elige superficie, no funcionalidad partida: skills = portable; MCP = completo.
- Evita construir MCPs para las ~80 fuentes de capa A/B que no los necesitan.
- El criterio de las tres capas hace objetivo qué merece código y qué no, y guía las contribuciones.
- El knowledge plane se sirve una vez y se consume por las dos superficies.

**Negativas**
- Hay que mantener la coherencia entre la skill y su tool cuando una fuente es de capa C (la skill apunta a la tool). Se mitiga manteniendo la skill fina en esos casos.
- El MCP como superconjunto exige exponer las skills como Resources, no solo las tools.

## Alternativas consideradas

- **Todo skills**: descartado por las fuentes de capa C que un LLM no ejecuta fiable por WebFetch.
- **Todo MCP**: descartado por el coste de infraestructura para consultar conocimiento que un markdown resuelve.
- **Dos catálogos divergentes (Skills y MCP con sets distintos)**: descartado por duplicación y por obligar al usuario a elegir. El MCP superconjunto evita ambos problemas.
