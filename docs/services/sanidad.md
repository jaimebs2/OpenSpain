# sanidad — Ministerio de Sanidad

Descubrimiento y descarga de datasets sanitarios publicados por el Ministerio de Sanidad, comunidades autónomas y otras administraciones españolas a través del catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/sanidad/service.yml).

## Qué puedes consultar

- **Catálogo Nacional de Hospitales** del Sistema Nacional de Salud
- Tasas de **mortalidad** por causa, sexo, grupo de edad y comunidad autónoma
- **Centros de atención primaria** y zonas básicas de salud
- Cualquier dataset sanitario indexado en el catálogo nacional, con URLs
  reales de descarga (CSV, JSON, XLS)

**No accesible**: historias clínicas o datos individuales de pacientes, citas
médicas, y cualquier trámite autenticado con certificado digital o Cl@ve.

## Estrategia

El Ministerio de Sanidad **no publica una única API REST pública** con todas
sus estadísticas. En su lugar, publica (directa o indirectamente) sus datasets
en el catálogo nacional `datos.gob.es`, que sí ofrece una API abierta bien
documentada.

Esta skill busca datasets sanitarios por título en `datos.gob.es`, extrae la
`accessURL` real de cada distribución (CSV, JSON, XLS) y la descarga con
`WebFetch`. No intenta scrapear `sanidad.gob.es`.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/sanidad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/sanidad/` |

### Opción — Skill

```bash
cp -r services/sanidad ~/.claude/skills/sanidad
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de
`datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/sanidad/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets y distribuciones
para búsquedas sanitarias. Ver también [tests/prompts.md](../../tests/sanidad/prompts.md)
para pruebas manuales con el agente.
