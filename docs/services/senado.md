# senado — Senado de España: Datos Abiertos

Acceso a la actividad parlamentaria del Senado español: composición del hemiciclo, grupos parlamentarios, sesiones plenarias, votaciones, iniciativas legislativas, mociones, interpelaciones y contratación pública.

Metadata completa de la skill en [service.yml](../../services/senado/service.yml).

## Qué puedes consultar

- **Composición**: senadores activos, grupos parlamentarios, escaños por partido y comunidad autónoma
- **Sesiones y votaciones**: listado de plenos, XML de votaciones de cada sesión
- **Iniciativas**: proyectos de ley, mociones, interpelaciones de la legislatura actual (XV)
- **Histórico**: senadores desde 1977 hasta hoy
- **Contratos**: licitaciones y adjudicaciones del Senado (2017–2025)

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/senado/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/senado/` |

### Skill (única implementación)

```bash
cp -r services/senado ~/.claude/skills/senado
```

Sin instalación, sin dependencias. Hace GET a los ficheros XML estáticos del Senado con `WebFetch`.

## API / Fuente de datos

**No hay REST API.** El Senado publica ficheros XML estáticos accesibles sin autenticación vía un servlet.

Base servlet: `https://www.senado.es/web/ficopendataservlet?tipoFich={N}&legis={L}`

Parámetros clave:
- `tipoFich=20` — composición del hemiciclo
- `tipoFich=14&legis=15` — sesiones plenarias (legislatura XV)
- `tipoFich=9&legis=15` — iniciativas legislativas
- `tipoFich=4&legis=15` — grupos parlamentarios

Catálogo oficial en [datos abiertos del Senado](https://www.senado.es/web/relacionesciudadanos/datosabiertos/catalogodatos/index.html).
