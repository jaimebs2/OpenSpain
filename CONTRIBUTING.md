# Contribuir a OpenSpain

Gracias por tu interés en mejorar OpenSpain. La misión del proyecto es **democratizar el acceso a la información pública española**: conectar todas las fuentes de datos e información oficiales (normativas, ayudas, estadísticas, trámites…) en un mismo sitio, consumible por cualquier agente de IA. Cualquier contribución es bienvenida: nuevas skills, nuevos MCPs, correcciones, mejoras de documentación o reportes de errores.

Antes de empezar, lee la [visión de conjunto de la arquitectura](docs/architecture/overview.md) y el [ROADMAP](ROADMAP.md). Al participar aceptas el [código de conducta](CODE_OF_CONDUCT.md).

## Los cuatro planos del repo

Antes de añadir algo nuevo, decide en qué plano vive. Si no encaja claramente, abre un issue para discutirlo antes de empezar.

| Plano | Directorio | Naturaleza |
|---|---|---|
| Knowledge | `openspain/skills/` | Skills markdown con orientación e información curada |
| Data | `mcps/` | MCPs Python que hacen proxy de APIs públicas con caché + procedencia |
| Tools | `tools/` | MCPs Python con tools deterministas por vertical (cálculo, validación) |
| Librerías | `packages/` | `openspain-core` Python + TypeScript |

## El modelo estricto: origen, licencia y actualizabilidad

Toda contribución de contenido (skill, MCP o tool) debe cumplir tres reglas no negociables, verificadas en CI:

1. **Origen declarado.** El `service.yml` debe listar en `links` las URLs oficiales de las que procede la información. Sin origen consultable, ni un humano ni un agente pueden verificar o actualizar el contenido.
2. **Licencia declarada.** `license.data` indica la licencia o condiciones de reutilización de los datos de origen (ej. `CC-BY 4.0`, `Ley 37/2007 — reutilización libre con cita`, condiciones propias del organismo). `license.code` es MIT (la del repo). Si la fuente requiere API key (Nivel 2), declarar además `reuse_commercial: yes|conditions|no` tras leer sus términos de servicio.
3. **Actualizable por agentes.** El contenido debe poder regenerarse desde las fuentes declaradas: las cifras, plazos y requisitos citados en un `SKILL.md` deben tener su URL de origen cerca (misma sección o tabla de fuentes), de forma que un agente pueda re-verificar cada dato contra la fuente oficial y proponer la actualización.

El schema canónico está en [`data/schemas/service.schema.json`](data/schemas/service.schema.json), documentado en [`docs/architecture/service-yml-schema.md`](docs/architecture/service-yml-schema.md). Se valida en cada PR con `python3 scripts/validate_services.py`.

## Cómo contribuir

### Reportar un problema

1. Comprueba que no exista ya un [issue abierto](https://github.com/jaimebs2/OpenSpain/issues) similar.
2. Abre un nuevo issue usando la plantilla adecuada (bug, feature o nueva skill).
3. Un dato desactualizado en una skill (un tipo impositivo que cambió, un plazo, una URL rota) es un bug: repórtalo con la fuente oficial que lo desmiente.

### Proponer una nueva skill

¿Falta un organismo, una API o un área de información pública? Abre un issue con la plantilla **Nueva skill** indicando:

- Nombre del organismo o fuente de datos.
- URL oficial de la API, dataset o página de referencia.
- Qué tipo de datos o conocimiento ofrece.
- Si requiere autenticación.
- Licencia o condiciones de reutilización de los datos, si las conoces.

### Enviar un Pull Request

1. Haz un fork del repositorio.
2. Crea una rama descriptiva: `git checkout -b add-skill-nombre` o `git checkout -b fix-descripcion`.
3. Realiza los cambios siguiendo la estructura del proyecto (ver más abajo).
4. Ejecuta `python3 scripts/validate_services.py` y los smoke tests de las skills afectadas.
5. Abre un PR contra `main` con una descripción clara de los cambios.

## Estructura de una skill (knowledge plane)

Cada skill vive en `openspain/skills/<nombre>/` (o `openspain/skills/<padre>/<nombre>/` para sub-skills):

```
openspain/skills/<nombre>/
├── SKILL.md             # frontmatter YAML (name, description, license) + instrucciones markdown
├── service.yml          # metadata: organismo, origen (links), licencia, auth, rate limits
└── tests/
    ├── smoke.sh         # test real contra las URLs de origen (curl + jq), ejecutable
    └── prompts.md       # al menos 3 preguntas de prueba con criterios de aceptación
```

Además, actualizar:

- `docs/services/<nombre>.md` — ficha técnica de la skill (subdirectorio para sub-skills, ej. `docs/services/fiscalidad/iva.md`).
- `docs/README.md` — añadir entrada al índice (orden alfabético).
- `README.md` y `README.en.md` — tabla de skills y conteo.
- `openspain/SKILL.md` — añadir la skill al catálogo de la meta-skill (es el punto de entrada que enruta a todas las demás).

Si la nueva skill se solapa temáticamente con otra existente, añadir en ambas una sección "Cuándo NO usar esta skill" con routing cruzado (ej. `aeat` ↔ `fiscalidad-iva`).

## Estructura de un MCP (data plane)

Cada MCP vive en `mcps/<nombre>/` siguiendo el patrón de [`mcps/catastro/`](mcps/catastro/) y [`mcps/snczi/`](mcps/snczi/):

```
mcps/<nombre>/
├── pyproject.toml       # paquete openspain-<nombre>, script openspain-<nombre>-mcp
├── service.yml          # mismo schema canónico que las skills
├── src/<nombre>/
│   ├── server.py        # entry point MCP
│   └── service.py       # lógica de proxy contra el origen oficial
├── tests/               # smoke + integración con httpx.MockTransport
└── README.md            # qué fuente cubre, qué tools expone, ejemplos
```

Reglas del data plane:

- Cada MCP **respeta el `cache_ttl_seconds`** declarado en su `service.yml`.
- Cada respuesta lleva **procedencia plana**: `source_url`, `fetched_at`, `cache_hit`, `license`.
- Si la tool sólo hace proxy de una API, vive en `mcps/`; si combina fuentes con lógica determinista, vive en `tools/`.
- Si descubres fricción operativa (double-hop, paginación rota, rate limit no documentado, agujero regional), documéntala en el README del MCP y abre un issue con la etiqueta `operational-friction`.

## Convenciones

- **Idioma**: español. El contenido es sobre España y para usuarios hispanohablantes.
- **Naming**: kebab-case; el `name` del frontmatter y del `service.yml` coincide con el directorio (ej. `fiscalidad-iva` para `fiscalidad/iva/`).
- **Smoke tests**: sin dependencias más allá de `curl` y `jq`. Ejecutables (`chmod +x`). Código de salida `0` si todo pasa. Usar `PASS=$((PASS + 1))` en vez de `((PASS++))` para compatibilidad con `set -e`.
- **Commits**: mensajes claros y concisos, enfocados en el "por qué".
- **Decisiones arquitectónicas**: si tu cambio implica una decisión difícil de revertir, propón un ADR en [`docs/adr/`](docs/adr/).

## Criterios de calidad antes de dar una contribución por lista

1. `python3 scripts/validate_services.py` pasa (schema, origen y licencia declarados).
2. `bash openspain/skills/<nombre>/tests/smoke.sh` pasa (las URLs de origen responden).
3. Al menos 3 pruebas manuales con el agente usando los prompts de `tests/prompts.md`.
4. Si tocas un MCP: `cd mcps/<nombre> && pytest` pasa.
5. Índices actualizados (docs, READMEs, catálogo de la meta-skill).

## Licencia

Al contribuir aceptas que tu aportación se publique bajo la [licencia MIT](LICENSE) del proyecto. Los datos públicos referenciados pertenecen a sus organismos emisores y se rigen por sus respectivas condiciones de reutilización, declaradas en el `service.yml` de cada skill.
