# rtve — Radio Televisión Española

Acceso de solo lectura al catálogo público de RTVE: noticias, programas de TV y radio, vídeos del archivo a la carta, y cadenas (TVE, La 1, La 2, 24H, Clan, Teledeporte, RNE, Radio Clásica, etc.).

Metadata completa de la skill en [service.yml](../../services/rtve/service.yml).

## Qué puedes consultar

- Listado paginado de **noticias** publicadas en rtve.es
- Listado paginado de **programas** (TV y radio) del catálogo RTVE
- Listado paginado de **vídeos** del archivo a la carta
- Listado de **cadenas** (canales TV y emisoras de radio)
- **Ficha individual** de una noticia, programa o vídeo a partir de su id

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/rtve/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/rtve/` |

### Skill (única implementación)

```bash
cp -r services/rtve ~/.claude/skills/rtve
```

La skill usa `WebFetch` directamente contra la API de RTVE — sin instalación, sin scripts.

## Aviso importante: API no oficial

CRTVE **no publica un contrato de API** ni términos de reutilización. La base `https://api.rtve.es/api/` es la que alimenta el portal `www.rtve.es` y ha sido documentada por la comunidad mediante observación. En consecuencia:

- Endpoints, parámetros y campos del JSON **pueden cambiar sin aviso**.
- Los parámetros de filtro/búsqueda (`text=`, `name=`, `permalink=`, etc.) suelen **ser ignorados** por el backend; la API se comporta como un listado paginado por fecha.
- Si la skill empieza a recibir `404` o `5xx`, asumir que el endpoint se ha movido y avisar al usuario.

## API pública

```
GET https://api.rtve.es/api/noticias.json?size=10
GET https://api.rtve.es/api/programas.json?size=10
GET https://api.rtve.es/api/videos.json?size=10
GET https://api.rtve.es/api/cadenas.json?size=10
GET https://api.rtve.es/api/noticias/{id}.json
GET https://api.rtve.es/api/programas/{id}.json
GET https://api.rtve.es/api/videos/{id}.json
```

Todas las respuestas envuelven los resultados en `.page.items[]`. Siempre enviar el header `Accept: application/json`.
