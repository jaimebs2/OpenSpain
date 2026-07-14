# borme — Boletín Oficial del Registro Mercantil

Acceso al sumario diario del BORME: actos inscritos de empresarios (constituciones, nombramientos, ceses, ampliaciones de capital, disoluciones, etc.) y anuncios legales del Registro Mercantil, organizados por provincia.

Metadata completa de la skill en [service.yml](../../services/borme/service.yml).

## Qué puedes consultar

- Sumario diario del BORME por fecha (`YYYYMMDD`)
- Sección A — Empresarios. Actos inscritos (por provincia)
- Sección B — Empresarios. Otros actos publicados en el Registro Mercantil
- Sección C — Anuncios y avisos legales
- Enlaces a los PDF oficiales de cada anuncio publicado

**No accesible** vía esta API: el texto plano de los actos inscritos (la API solo devuelve metadatos y enlaces a PDF), búsqueda por nombre de empresa o NIF, ni datos económicos depositados en el Registro Mercantil.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/borme/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/borme/` |

### Skill (recomendada para Claude)

```bash
cp -r services/borme ~/.claude/skills/borme
```

Eso es todo. La skill usa `WebFetch` directamente contra el endpoint JSON del BORME — sin instalación, sin dependencias, sin scripts.

## API pública

El BORME expone su sumario diario en formato JSON sin autenticación a través del portal de datos abiertos del BOE:

- **Sumario**: `GET https://www.boe.es/datosabiertos/api/borme/sumario/{YYYYMMDD}`

URLs, límites y términos de uso en [service.yml](../../services/borme/service.yml).
