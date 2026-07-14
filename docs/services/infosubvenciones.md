# infosubvenciones — BDNS / SNPSAP

Consulta la **Base de Datos Nacional de Subvenciones** (BDNS), también conocida como **Sistema Nacional de Publicidad de Subvenciones y Ayudas Públicas** (SNPSAP), gestionada por la IGAE (Ministerio de Hacienda).

Portal oficial: [infosubvenciones.es](https://www.infosubvenciones.es) · Buscador: [pap.hacienda.gob.es/bdnstrans/GE/es/](https://www.pap.hacienda.gob.es/bdnstrans/GE/es/)

Metadata completa de la skill en [service.yml](../../services/infosubvenciones/service.yml).

## Qué puedes consultar

- **Convocatorias** de subvenciones y ayudas públicas: búsqueda por descripción, filtros por organismo, fecha, tipo de administración (estatal/autonómica/local) o si son fondos NextGen (`mrr`).
- **Detalle completo** de una convocatoria por su código BDNS: presupuesto, instrumentos, sectores, regiones NUTS, bases reguladoras, plazos.
- **Concesiones** individuales a beneficiarios: búsqueda por NIF/CIF, convocatoria, fechas o rango de importe.
- **Ayudas de Estado** (reglamentos UE de exención por categorías) con código `SA.xxxxxx` enlazado al caso en la Comisión Europea.
- **Ayudas de minimis** (Reg. UE 2023/2831) con acumulado nacional agrícola y pesca.
- **Grandes beneficiarios** por ejercicio.
- **Planes estratégicos de subvenciones** plurianuales.

**No accesible**: pagos efectivos (la BDNS publica concesiones, no pagos), documentación completa de expedientes, datos personales no anonimizados de particulares.

## Estrategia

A diferencia de muchos servicios del sector público español, la BDNS **sí ofrece una API REST JSON pública directa**, sin autenticación, en `https://www.pap.hacienda.gob.es/bdnstrans/api/`. Esta skill la consume con `WebFetch`.

Como fallback para datasets agregados históricos (CSV/XLS), la skill también sabe buscar en `datos.gob.es` con `title/subvenciones`.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/infosubvenciones/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/infosubvenciones/` |

### Opción — Skill

```bash
cp -r services/infosubvenciones ~/.claude/skills/infosubvenciones
```

La skill usa `WebFetch` directamente contra la API pública de BDNS — sin instalación, sin scripts, sin dependencias externas.

## Tests

```bash
bash tests/infosubvenciones/smoke.sh
```

Verifica que los endpoints principales de la BDNS (`/convocatorias/ultimas`, `/convocatorias/busqueda`, `/convocatorias?numConv=…`, `/concesiones/busqueda`) devuelven JSON con la estructura esperada, y que el fallback de `datos.gob.es` también responde. Ver [tests/prompts.md](../../tests/infosubvenciones/prompts.md) para pruebas manuales con el agente.
