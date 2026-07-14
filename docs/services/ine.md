# ine — Instituto Nacional de Estadística

Acceso a las estadísticas oficiales de España publicadas por el INE: IPC, EPA (paro), demografía, censo, comercio, industria y todas las operaciones estadísticas del organismo.

Metadata completa de la skill en [service.yml](../../services/ine/service.yml).

## Qué puedes consultar

- Listado completo de operaciones estadísticas disponibles
- Series temporales asociadas a una operación (con paginación)
- Datos históricos de una serie por su código (últimos N valores)

**No accesible**: microdatos individuales protegidos y datos sometidos a secreto estadístico.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/ine/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/ine/` |

### Skill (recomendada para Claude)

```bash
cp -r services/ine ~/.claude/skills/ine
```

Sin dependencias, sin scripts. La skill usa `WebFetch` directamente contra los endpoints JSON del INE (Wstempus).

## API pública

El INE expone Wstempus, una API REST sin autenticación que devuelve JSON:

- **OPERACIONES_DISPONIBLES**: catálogo de operaciones estadísticas
- **SERIES_OPERACION/{id}**: series ligadas a una operación (paginado)
- **DATOS_SERIE/{cod}**: valores de una serie temporal

URLs, límites y términos de uso en [service.yml](../../services/ine/service.yml).
