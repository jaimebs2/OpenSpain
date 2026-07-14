# miteco — Ministerio para la Transición Ecológica y el Reto Demográfico

Descubrimiento y descarga de datasets ambientales publicados por MITECO y otras administraciones públicas españolas a través del catálogo nacional [datos.gob.es](https://datos.gob.es).

Metadata completa de la skill en [service.yml](../../services/miteco/service.yml).

## Qué puedes consultar

- Estado de **embalses** y reservas hidráulicas (confederaciones hidrográficas)
- **Calidad del aire** y estaciones de medición (RVCA)
- **Red Natura 2000**: ZEPA, ZEC, LIC y otros espacios protegidos
- **Biodiversidad**, especies protegidas y hábitats
- Cualquier dataset ambiental indexado en el catálogo nacional, con URLs
  reales de descarga (CSV, JSON, XLS, SHP)

**No accesible**: SAIH en tiempo real vía API propia, servicios WMS/WFS
geoespaciales (requieren cliente GIS) ni trámites autenticados con la sede
electrónica del ministerio.

## Estrategia

MITECO **no publica una API REST unificada** para sus datos. Los datasets
están dispersos entre confederaciones hidrográficas, redes de vigilancia,
el Inventario Español del Patrimonio Natural y la Biodiversidad, etc. Todos
ellos (directa o indirectamente) están indexados en el catálogo nacional
`datos.gob.es`, que sí ofrece una API abierta bien documentada.

Esta skill busca datasets ambientales por título en `datos.gob.es`, extrae
la `accessURL` real de cada distribución (CSV, JSON, XLS, SHP) y la descarga
con `WebFetch`. No intenta implementar clientes WMS/WFS ni scrapear las
webs de las confederaciones.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/miteco/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/miteco/` |

### Opción — Skill

```bash
cp -r services/miteco ~/.claude/skills/miteco
```

Eso es todo. La skill usa `WebFetch` directamente contra la API de
`datos.gob.es` — sin instalación, sin dependencias, sin scripts.

## Tests

```bash
bash tests/miteco/smoke.sh
```

Verifica que la API de `datos.gob.es` responde con datasets y distribuciones
para búsquedas ambientales. Ver también [tests/prompts.md](../../tests/miteco/prompts.md)
para pruebas manuales con el agente.
