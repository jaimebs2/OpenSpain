# cnig — Centro Nacional de Información Geográfica (IGN / CartoCiudad)

Geocodificación y búsqueda de topónimos en España a través de CartoCiudad, el servicio del Instituto Geográfico Nacional (IGN).

Metadata completa de la skill en [service.yml](../../services/cnig/service.yml).

## Qué puedes consultar

- Convertir una dirección postal española en coordenadas (lat/lon) y referencia catastral.
- Convertir unas coordenadas (lat/lon) en la dirección más cercana.
- Buscar candidatos por nombre: municipios, poblaciones, calles y topónimos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/cnig/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/cnig/` |

### Skill (única implementación)

```bash
cp -r services/cnig ~/.claude/skills/cnig
```

La skill usa `WebFetch` directamente contra la API pública de CartoCiudad — sin instalación, sin dependencias, sin scripts.

## API pública

CartoCiudad expone una API REST-JSON sin autenticación bajo `https://www.cartociudad.es/geocoder/api/geocoder`:

- **Geocodificación directa**: `GET /find?q={direccion}&limit=5`
- **Geocodificación inversa**: `GET /reverseGeocode?lon={lon}&lat={lat}`
- **Búsqueda de candidatos / topónimos**: `GET /candidates?q={texto}&limit=10`

> Existen variantes `findJsonp` y `candidatesJsonp` que envuelven la respuesta en `callback(...)`. Para uso desde WebFetch o `curl`, usar siempre las versiones sin `Jsonp`, que devuelven JSON puro.

URLs, licencia (CC BY 4.0 ign.es) y términos de uso en [service.yml](../../services/cnig/service.yml).
