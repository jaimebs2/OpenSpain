# seguridad-social — Tesorería General de la Seguridad Social

Descubrimiento y descarga de datasets de la Seguridad Social española (afiliación, pensiones, altas y bajas, empresas inscritas) a través del catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/seguridad-social/service.yml).

## Qué puedes consultar

- **Afiliación a la Seguridad Social** por régimen de cotización (General, Autónomos, Agrario, Mar, Hogar) y CCAA/provincia/municipio
- **Pensiones contributivas** por tipo (jubilación, viudedad, incapacidad, orfandad) e importes medios por territorio
- **Pensiones no contributivas** por territorio
- **Altas y bajas mensuales** de afiliación por régimen y sexo
- **Empresas inscritas** en la Seguridad Social por actividad económica y tamaño
- Cualquier dataset de Seguridad Social indexado en el catálogo nacional, con
  URLs reales de descarga (CSV, JSON, XLSX)

**No accesible**: datos individuales de afiliados o pensionistas, gestión de
trámites (alta, baja, vida laboral), ni operaciones autenticadas con
certificado/Cl@ve en `sede.seg-social.gob.es`.

## Estrategia

La Tesorería General de la Seguridad Social **no publica una API REST pública
propia** con sus estadísticas mensuales. En su lugar, publica sus datasets (y
los de otros organismos como el ISTAC para Canarias) en el catálogo nacional
`datos.gob.es`, que sí ofrece una API abierta bien documentada.

Esta skill busca datasets por título en `datos.gob.es`, extrae la `accessURL`
real de cada distribución (CSV, JSON, XLSX) y la descarga con `WebFetch`. No
intenta scrapear `seg-social.es`.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/seguridad-social/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/seguridad-social/` |

### Opción — Skill

```bash
cp -r services/seguridad-social ~/.claude/skills/seguridad-social
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de
`datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/seguridad-social/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets de afiliación a
la Seguridad Social y distribuciones reales. Ver también
[tests/prompts.md](../../tests/seguridad-social/prompts.md) para pruebas manuales con el agente.
