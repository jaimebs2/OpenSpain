# Architecture Decision Records (ADRs)

Este directorio captura decisiones arquitectónicas con suficiente coste de reversión como para que un futuro lector necesite saber **por qué** se tomaron, no sólo cuáles fueron.

## Cuándo añadir un ADR

Sólo cuando se cumplen las tres condiciones a la vez:

1. **Difícil de revertir** — cambiar la decisión más tarde tendría un coste significativo (refactor amplio, breaking change público, migración de datos).
2. **Sorprendente sin contexto** — un futuro lector se preguntaría "¿por qué hicieron esto así?".
3. **Resultado de un trade-off real** — existían alternativas genuinas y se eligió una por razones específicas.

Si alguna falta, no abrir ADR. Documentarlo en el README del módulo o en un comentario en el código.

## Formato

Cada ADR sigue este esqueleto:

```markdown
# NNNN — Título corto en imperativo

- **Estado**: propuesto | aceptado | reemplazado por ADR-XXXX | rechazado
- **Fecha**: YYYY-MM-DD (fecha de aceptación, no de propuesta)
- **Decisión vinculada**: enlace al documento o discusión relacionada si aplica

## Contexto

Qué situación obligó a tomar esta decisión. Restricciones, opciones consideradas.

## Decisión

Una frase que cualquiera pueda entender en frío.

## Consecuencias

Qué cambia a partir de ahora (positivas y negativas, no sólo lo bueno).

## Alternativas consideradas

Las opciones que se descartaron y por qué.
```

## Numeración

Secuencial empezando en `0001-`. Cuando un ADR se reemplaza, el nuevo cita el anterior; el antiguo se actualiza con `Estado: reemplazado por ADR-NNNN` pero no se borra.

## Índice

| ADR | Título | Estado |
|---|---|---|
| [0001](0001-tipologia-agent-accessibility.md) | Tipología de niveles `agent_accessibility` en `service.yml` | aceptado |
| [0002](0002-federacion-mcps-por-dominio.md) | Federación de MCPs por dominio + meta-router en lugar de MCP monolítico | aceptado |
| [0003](0003-openspain-core-desde-el-primer-mcp.md) | Crear la librería compartida `openspain-core` desde el primer MCP | aceptado |
| [0004](0004-knowledge-data-tools-planes-separados.md) | Separación knowledge plane / data plane / tools deterministas N4 | aceptado |
| [0005](0005-dos-superficies-skills-mcp.md) | Dos superficies de distribución (Skills + MCP) y regla de tres capas | aceptado |
