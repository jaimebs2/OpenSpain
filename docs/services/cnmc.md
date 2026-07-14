# cnmc — CNMC Catálogo de Datos Abiertos

Acceso al portal CKAN de la Comisión Nacional de Mercados y la Competencia: búsqueda de datasets regulatorios sobre electricidad, gas, telecomunicaciones, audiovisual, transporte y postal.

Metadata completa de la skill en [service.yml](../../services/cnmc/service.yml).

## Qué puedes consultar

- Datasets por texto libre: busca por término (p. ej. "electricidad", "gas", "operadores")
- Datasets por sector: filtra por grupo temático (energía eléctrica, gas natural, telecomunicaciones, postal, transporte, petróleo, comercio electrónico)
- Detalle de un dataset: metadatos completos y URLs de descarga en CSV, JSON o XML
- Descarga directa de recursos mediante las URLs incluidas en cada dataset

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/cnmc/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/cnmc/` |

### Skill (única implementación)

```bash
cp -r services/cnmc ~/.claude/skills/cnmc
```

La skill usa `WebFetch` directamente contra la API CKAN del portal — sin instalación, sin dependencias, sin scripts.

## API pública

El portal CNMC expone la API estándar CKAN sin autenticación:

- **Búsqueda de datasets**: `GET /api/3/action/package_search?q={texto}&rows=10`
- **Filtrar por grupo**: `GET /api/3/action/package_search?fq=groups:{grupo}&rows=10`
- **Detalle de dataset**: `GET /api/3/action/package_show?id={id}`

### Grupos disponibles

| Sector | Nombre del grupo (fq) |
|---|---|
| Energía eléctrica | `grupo_energia_electrica` |
| Gas natural | `grupo_gas_natural` |
| Telecomunicaciones | `grupo_telco` |
| Petróleo | `grupo_petroleo` |
| Transporte | `grupo_transporte` |
| Postal | `grupo_postal` |
| Comercio electrónico | `grupo_comercio_electronico` |
| Panel de hogares | `panel-de-hogares` |

URLs y términos de uso en [service.yml](../../services/cnmc/service.yml).
