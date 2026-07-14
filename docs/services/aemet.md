# aemet — Agencia Estatal de Meteorología

Acceso a la API OpenData de AEMET: predicción meteorológica municipal, observación de estaciones y avisos meteorológicos oficiales.

Metadata completa de la skill en [service.yml](../../services/aemet/service.yml).

## Qué puedes consultar

- Predicción diaria por municipio (código INE de 5 dígitos, por ejemplo `28079` para Madrid)
- Observación convencional de estaciones meteorológicas (última hora disponible)
- Avisos meteorológicos CAP en vigor (último boletín elaborado)

**No cubre** (por ahora): datos climatológicos históricos masivos, radar/satélite y salidas numéricas de modelos globales.

## Requisitos

AEMET OpenData exige una **API key gratuita**. Solicítala en:

https://opendata.aemet.es/centrodedescargas/altaUsuario

Exporta la clave en el entorno antes de usar la skill:

```bash
export AEMET_API_KEY="tu_clave_jwt_larga_aqui"
```

La skill lee la variable de entorno `AEMET_API_KEY` y nunca la pide como parámetro.

## Implementación disponible

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/aemet/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/aemet/` |

```bash
cp -r services/aemet ~/.claude/skills/aemet
export AEMET_API_KEY="..."
```

## Particularidades de la API

AEMET OpenData usa un patrón de **doble salto**:

1. Primera GET al endpoint de la operación → devuelve JSON con `{"datos": "<url_temporal>", "metadatos": "<url>"}`.
2. Segunda GET a la URL de `datos` → devuelve los datos reales. Estas URLs caducan en ~5 minutos.

Ante respuesta `429 Too Many Requests` hay que esperar y reintentar una vez.

## Tests

```bash
bash tests/aemet/smoke.sh
```

Si `AEMET_API_KEY` no está definida, el smoke test sale con código 0 imprimiendo `SKIP`.
