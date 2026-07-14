# cis — Centro de Investigaciones Sociológicas

Descubrimiento de estudios, barómetros y encuestas del Centro de Investigaciones Sociológicas (CIS) a través del catálogo nacional [datos.gob.es](https://datos.gob.es) y referencias al catálogo web del CIS.

Metadata completa de la skill en [service.yml](../../services/cis/service.yml).

## Qué puedes consultar

- Datasets sobre **CIS**, **barómetros**, **encuestas** y **sondeos** indexados en el catálogo nacional, con URLs reales de descarga (CSV, JSON, XLS)
- Referencia a fichas concretas del **catálogo web del CIS** por número de estudio (3400, 3480…) cuando el usuario lo cita

**No accesible**: el CIS **no publica una API REST pública** propia. Los microdatos individuales (ASCII / CSV / SPSS) viven en la ficha del estudio en `cis.es` y requieren descarga manual y procesamiento local con código — `WebFetch` no puede abrir directamente esos ficheros.

## Estrategia

Dos rutas complementarias:

1. **Descubrimiento vía datos.gob.es** — para preguntas abiertas tipo "¿hay datos del CIS sobre X?". Busca por título usando los términos `CIS`, `barómetro`, `encuesta`, `sondeo` y extrae las `accessURL` reales.
2. **Catálogo web del CIS** — cuando el usuario menciona un número de estudio concreto, redirige al catálogo `https://www.cis.es/estudios/catalogo` y advierte que la descarga real (cuestionario, resultados, microdatos) hay que hacerla desde la ficha.

No se intenta scrapear ni parsear el portal Liferay del CIS desde la skill.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/cis/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/cis/` |

### Opción — Skill

```bash
cp -r services/cis ~/.claude/skills/cis
```

La skill usa `WebFetch` directamente contra la API de `datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/cis/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets y distribuciones para búsquedas de barómetros. Ver también [tests/prompts.md](../../tests/cis/prompts.md) para pruebas manuales con el agente.
