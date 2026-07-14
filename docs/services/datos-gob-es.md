# datos-gob-es — Catálogo Nacional de Datos Abiertos

Punto de entrada al catálogo público español de +90.000 datasets de toda la Administración (ministerios, CCAA, ayuntamientos, universidades).

Metadata completa de la skill en [service.yml](../../services/datos-gob-es/service.yml).

## Qué puedes consultar

- Búsqueda de datasets por título (texto libre)
- Filtrado por publisher (organismo emisor) o por tema DCAT-AP-ES
- Detalle de un dataset y sus distribuciones (URLs de descarga reales en CSV/XLS/JSON/etc.)

Esta skill es la **puerta de entrada** a cualquier dato público español que no tenga skill propia en OpenSpain. Si el usuario pregunta por algo que no encaja con ninguna otra skill, empieza por aquí.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/datos-gob-es/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/datos-gob-es/` |

### Skill (única implementación)

```bash
cp -r services/datos-gob-es ~/.claude/skills/datos-gob-es
```

Sin instalación, sin dependencias. Llama a la API REST pública directamente vía `WebFetch`.

## API pública

Base: `https://datos.gob.es/apidata/catalog/dataset`

Sin autenticación. Devuelve JSON con la convención **Linked Data API** (campos en `result.items[]`). Endpoints clave:

- `GET /apidata/catalog/dataset/title/{texto}?_format=json` — búsqueda por título
- `GET /apidata/catalog/dataset/publisher/{id}?_format=json` — datasets de un publisher
- `GET /apidata/catalog/dataset/theme/{tema}?_format=json` — datasets por tema DCAT-AP-ES

URLs y términos de uso en [service.yml](../../services/datos-gob-es/service.yml).
