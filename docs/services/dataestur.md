# dataestur — Estadísticas de Turismo (SEGITTUR)

Acceso a las estadísticas oficiales de turismo de España publicadas por SEGITTUR a través del portal DataEstur: turistas extranjeros (FRONTUR), gasto turístico (EGATUR), ocupación hotelera, actividades de ocio y más.

Metadata completa de la skill en [service.yml](../../services/dataestur/service.yml).

## Qué puedes consultar

- **FRONTUR**: número de turistas y excursionistas extranjeros por país de residencia, comunidad autónoma de destino y tipo de visitante (mes a mes)
- **EGATUR**: gasto turístico de los visitantes internacionales por país y CCAA
- **Alojamiento**: ocupación hotelera, campings, turismo rural, apartamentos turísticos
- **Transporte**: estadísticas de transporte turístico
- **Ocio**: entradas vendidas y gasto en actividades de ocio
- **Sostenibilidad**: indicadores de sostenibilidad turística

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/dataestur/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/dataestur/` |

### Skill (única implementación)

```bash
cp -r services/dataestur ~/.claude/skills/dataestur
```

Sin instalación, sin dependencias.

## API pública

Base: `https://dataestur.azure-api.net/API-SEGITTUR-v1`

Sin autenticación. Todos los endpoints devuelven ficheros **XLSX** directamente (no JSON).

Endpoints principales:
- `GET /FRONTUR_DL` — turistas extranjeros
- `GET /EGATUR_DL` — gasto turístico
- `GET /ACTIVIDADES_OCIO_DL` — actividades de ocio

Parámetros de fecha (todos opcionales):
- `desde (año)` — año inicio (ej: `2024`)
- `desde (mes)` — mes inicio (ej: `1`)
- `hasta (año)` / `hasta (mes)` — rango fin

Especificación OpenAPI disponible en [dataestur.es/API-SEGITTURv2.json](https://dataestur.es/API-SEGITTURv2.json).
