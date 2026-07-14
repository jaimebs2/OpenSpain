# aeat — Agencia Estatal de Administración Tributaria

Descubrimiento y descarga de datasets fiscales publicados por la AEAT y otras administraciones públicas españolas a través del catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/aeat/service.yml).

## Qué puedes consultar

- Estadísticas de **IRPF** (base imponible, liquidable, por tramos, por municipios…)
- **Recaudación tributaria** del Estado y comunidades autónomas
- Estadísticas del **IVA** y otros impuestos (Patrimonio, IAE, ITP/AJD…)
- Cualquier dataset fiscal indexado en el catálogo nacional, con URLs reales
  de descarga (CSV, JSON, XLS)

**No accesible**: datos fiscales individuales de contribuyentes, trámites
autenticados con certificado digital/Cl@ve, o consultas en tiempo real a la
Sede Electrónica de la AEAT.

## Estrategia

La AEAT **no publica una API REST pública propia** con sus estadísticas. En su
lugar, publica (directa o indirectamente) sus datasets en el catálogo nacional
`datos.gob.es`, que sí ofrece una API abierta bien documentada.

Esta skill busca datasets fiscales por título en `datos.gob.es`, extrae la
`accessURL` real de cada distribución (CSV, JSON, XLS) y la descarga con
`WebFetch`. No intenta scrapear la sede electrónica.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/aeat/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/aeat/` |

### Opción — Skill

```bash
cp -r services/aeat ~/.claude/skills/aeat
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de
`datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/aeat/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets y distribuciones
para búsquedas fiscales. Ver también [tests/prompts.md](../../tests/aeat/prompts.md)
para pruebas manuales con el agente.
