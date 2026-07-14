# placsp — Plataforma de Contratación del Sector Público

Descubrimiento y descarga de datasets de contratación pública del Estado español publicados en la **Plataforma de Contratación del Sector Público (PLACSP)** e indexados en el catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/placsp/service.yml).

## Qué puedes consultar

- **Contratos mayores** publicados en PLACSP, año a año (2018, …, 2025)
- **Contratos menores** publicados en PLACSP por ejercicio
- **Licitaciones** activas, anuncios y adjudicaciones
- Cualquier dataset etiquetado como `PLACSP` en el catálogo nacional, con
  URLs reales de descarga (CSV, JSON, XLSX, ATOM)

**No accesible**: búsqueda en tiempo real de expedientes concretos en
`contrataciondelestado.es`, descarga de pliegos firmados, trámites
autenticados (presentación de ofertas), o datos personales protegidos.

## Diferencia con `transparencia`

Hay **solapamiento intencionado** con la skill `transparencia`, que
también descubre datasets de PLACSP. La diferencia:

| Skill | Alcance |
|---|---|
| `placsp` | Específico de **contratación pública del Estado**: contratos mayores, menores, licitaciones, adjudicaciones |
| `transparencia` | Más genérico: además de PLACSP cubre subvenciones, altos cargos, agendas, registro de transparencia |

Si la pregunta es exclusivamente sobre contratos públicos, `placsp` es la
opción más directa. Si mezcla contratación con otros datos del Portal de
Transparencia, usar `transparencia`.

## Estrategia

PLACSP **no expone una API REST pública con catálogo consultable** desde
`contrataciondelestado.es` (los volcados oficiales son ficheros ATOM
mensuales pesados). En su lugar, los datasets de PLACSP se publican en el
catálogo nacional `datos.gob.es`, que sí ofrece una API abierta bien
documentada.

Esta skill busca datasets de contratación por título en `datos.gob.es`,
extrae la `accessURL` real de cada distribución y la descarga con
`WebFetch`. **No intenta scrapear** `contrataciondelestado.es`.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/placsp/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/placsp/` |

### Opción — Skill

```bash
cp -r services/placsp ~/.claude/skills/placsp
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de
`datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/placsp/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets PLACSP y
distribuciones reales. Ver también [tests/prompts.md](../../tests/placsp/prompts.md)
para pruebas manuales con el agente.
