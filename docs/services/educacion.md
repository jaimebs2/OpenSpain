# educacion — Ministerio de Educación, FP y Deportes

Descubrimiento y descarga de datasets del sistema educativo español publicados por el Ministerio de Educación, comunidades autónomas y otras administraciones a través del catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/educacion/service.yml).

## Qué puedes consultar

- Directorio y clasificaciones de **centros educativos** (colegios, institutos, universidades)
- Estadísticas de **alumnado** por nivel, etapa, titularidad del centro y provincia
- Datos de **matrícula** por curso académico y comunidad autónoma
- **Becas y ayudas** al estudio del Estado y de las comunidades autónomas
- Datasets universitarios, de FP y de enseñanzas artísticas indexados en el catálogo nacional, con URLs reales de descarga (CSV, JSON, XLS)

**No accesible**: expedientes académicos individuales, calificaciones personales, actas internas de centros ni trámites autenticados (solicitud real de becas, matrícula efectiva).

## Estrategia

El Ministerio de Educación **no publica una API REST pública propia** unificada con sus estadísticas. En su lugar, sus datasets (y los de las consejerías autonómicas) están indexados en el catálogo nacional `datos.gob.es`, que sí ofrece una API abierta bien documentada.

Esta skill busca datasets educativos por título en `datos.gob.es`, extrae la `accessURL` real de cada distribución (CSV, JSON, XLS) y la descarga con `WebFetch`. No scrapea `educacionfpydeportes.gob.es`.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/educacion/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/educacion/` |

### Opción — Skill

```bash
cp -r services/educacion ~/.claude/skills/educacion
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de `datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/educacion/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets y distribuciones para búsquedas educativas. Ver también [tests/prompts.md](../../tests/educacion/prompts.md) para pruebas manuales con el agente.
