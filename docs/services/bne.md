# bne — Biblioteca Nacional de España (Linked Open Data)

Acceso al catálogo de autoridades y registros bibliográficos de la BNE publicado como Linked Open Data en `datos.bne.es`: endpoint SPARQL público y dereferenciación JSON-LD de recursos.

Metadata completa de la skill en [service.yml](../../services/bne/service.yml).

## Qué puedes consultar

- Autores, obras, entidades y materias de la BNE mediante SPARQL
- Ficha completa de un recurso (persona, obra) en JSON-LD por su URI
- Enlaces a autoridades externas (VIAF, Wikidata) cuando existen
- Búsqueda por etiqueta (`rdfs:label`) con filtros SPARQL

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/bne/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/bne/` |

### Skill (única implementación)

```bash
cp -r services/bne ~/.claude/skills/bne
```

La skill usa `WebFetch` directamente contra el endpoint SPARQL y la dereferenciación de URIs de `datos.bne.es` — sin instalación, sin dependencias, sin scripts.

## API pública

La BNE expone Linked Open Data servidos por un Virtuoso:

- **SPARQL (GET)**: `GET https://datos.bne.es/sparql?query={sparql}&format=application/sparql-results+json`
- **Dereferenciación de recurso**: `GET https://datos.bne.es/resource/{id}` con `Accept: application/ld+json`

El endpoint SPARQL acepta GET con la consulta URL-encoded. El POST también funciona si no se envía header `Accept` y se incluye `format` en el cuerpo, pero el GET es más fiable desde `WebFetch`.

URLs y términos de uso en [service.yml](../../services/bne/service.yml).
