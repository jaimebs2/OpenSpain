# sepe — Servicio Público de Empleo Estatal

Descubrimiento y descarga de datasets de empleo publicados por el SEPE (antes INEM) a través del catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/sepe/service.yml).

## Qué puedes consultar

- **Paro registrado** por municipio, provincia, comunidad autónoma
- Paro registrado por **sexo, grupo de edad y sectores económicos**
- **Contratos registrados** por sector, ocupación y territorio
- **Demandantes de empleo** y colectivos (jóvenes, larga duración, extranjeros)
- Cualquier dataset de empleo indexado en el catálogo nacional, con URLs
  reales de descarga (CSV, JSON, XLSX)

**No accesible**: datos individuales de demandantes, gestión de prestaciones
por desempleo, ni trámites autenticados con certificado/Cl@ve en
`sepe.gob.es`.

## Aviso importante — anonimización SEPE

En los CSV publicados por el SEPE, los valores entre **1 y 4** aparecen como
`<5` para proteger la privacidad. Esto es anonimización estadística oficial.
La skill siempre advierte al usuario de este detalle cuando muestra cifras
desagregadas por municipio pequeño, grupo de edad o sector.

## Estrategia

El SEPE **no publica una API REST pública propia** con sus estadísticas. En
su lugar, publica sus datasets en el catálogo nacional `datos.gob.es`, que sí
ofrece una API abierta bien documentada.

Esta skill busca datasets de empleo por título en `datos.gob.es`, extrae la
`accessURL` real de cada distribución (CSV, JSON, XLSX) y la descarga con
`WebFetch`. No intenta scrapear `sepe.gob.es`.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/sepe/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/sepe/` |

### Opción — Skill

```bash
cp -r services/sepe ~/.claude/skills/sepe
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de
`datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/sepe/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets de paro
registrado y distribuciones reales. Ver también
[tests/prompts.md](../../tests/sepe/prompts.md) para pruebas manuales con el agente.
