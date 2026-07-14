# boe — Boletín Oficial del Estado

Acceso al BOE español: sumario diario por fecha, disposiciones por sección y departamento, e índice de legislación consolidada.

Metadata completa de la skill en [service.yml](../../services/boe/service.yml).

## Qué puedes consultar

- Sumario de cualquier día: secciones, departamentos, epígrafes y títulos de cada disposición
- Índice de una ley consolidada por su identificador BOE (títulos, capítulos, artículos)
- Texto completo de un bloque concreto de una ley consolidada

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/boe/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/boe/` |

### Skill (única implementación)

```bash
cp -r services/boe ~/.claude/skills/boe
```

La skill usa `WebFetch` directamente contra la API de datos abiertos del BOE — sin instalación, sin dependencias, sin scripts.

## API pública

El BOE expone una API REST-JSON sin autenticación:

- **Sumario diario**: `GET /datosabiertos/api/boe/sumario/YYYYMMDD`
- **Índice consolidado**: `GET /datosabiertos/api/legislacion-consolidada/id/{id}/texto/indice`

Siempre enviar el header `Accept: application/json`. La API solo acepta GET — el POST devuelve 403.

URLs y términos de uso en [service.yml](../../services/boe/service.yml).
