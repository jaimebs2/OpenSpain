# congreso — Congreso de los Diputados

Acceso a los datos abiertos del Congreso de los Diputados español: votaciones plenarias, diputados, iniciativas legislativas e intervenciones.

Metadata completa de la skill en [service.yml](../../services/congreso/service.yml).

## Qué puedes consultar

- Votaciones plenarias por legislatura, sesión y fecha (con voto individual de cada diputado)
- Diputados en activo, de baja e histórico por legislatura
- Iniciativas legislativas: proyectos de ley, proposiciones de ley, leyes aprobadas
- Intervenciones parlamentarias por iniciativa y cronológicas

**No accesible vía API**:
- Búsqueda libre por texto (el portal sólo expone descargas estáticas)
- Datos de órganos parlamentarios (sólo vía portlet Liferay dinámico)
- Diario de Sesiones en texto plano (sólo PDF)

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/congreso/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/congreso/` |

### Skill (recomendada)

```bash
cp -r services/congreso ~/.claude/skills/congreso
```

La skill usa `WebFetch` directamente. Para evitar respuestas 403 del servidor, fija un `User-Agent` de navegador en cada petición.

## API pública — particularidades

El portal de datos abiertos del Congreso **no expone una API REST estable**. Lo que hay son **ficheros estáticos** (CSV, JSON, XML) que se regeneran cada día con un timestamp en el nombre, por ejemplo:

```
/webpublica/opendata/diputados/DiputadosActivos__20260407050007.json
```

Por eso, antes de descargar un dataset hay que **parsear primero la página HTML índice** (`https://www.congreso.es/es/opendata/<sección>`) para extraer la URL definitiva del día. La skill explica el procedimiento paso a paso.

URLs base, formatos y limitaciones en [service.yml](../../services/congreso/service.yml).
