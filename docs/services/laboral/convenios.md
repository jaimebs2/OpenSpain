# laboral/convenios — Convenios colectivos

Guía completa sobre los convenios colectivos en España: qué son, cómo encontrar el que te aplica (REGCON), jerarquía, ultraactividad, contenido habitual e inaplicación (descuelgue).

Metadata completa de la skill en [service.yml](../../../skills/laboral/convenios/service.yml).

## Qué puedes consultar

- **Qué es un convenio colectivo**: acuerdo con fuerza de ley entre empresa/sindicatos.
- **Tipos por ámbito**: empresa, sectorial estatal, autonómico, provincial.
- **REGCON**: buscador público del Ministerio de Trabajo para encontrar tu convenio.
- **Jerarquía**: prioridad del convenio de empresa en determinadas materias (reforma 2012), refuerzo del sectorial en subcontratación (reforma 2022).
- **Contenido habitual**: salarios, jornada, vacaciones, permisos, clasificación profesional.
- **Ultraactividad**: convenio caducado sigue vigente indefinidamente (reforma 2022).
- **Inaplicación (descuelgue)**: causas ETOP, procedimiento, mediación.
- **Comisión paritaria**: funciones e intervención.

**No accesible**: texto completo de convenios específicos (consultar REGCON o BOE), tablas salariales actualizadas, tipos de contrato (usar skill `laboral-contratos`), detalle de nóminas (usar skill `laboral-nominas`).

## Estrategia

Skill de **conocimiento/orientación** sobre el sistema de negociación colectiva español. Orienta sobre cómo buscar el convenio aplicable en REGCON (buscador web, no API). No accede a APIs de datos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/laboral/convenios/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/laboral-convenios/` |

### Opción — Skill

```bash
cp -r skills/laboral/convenios ~/.claude/skills/laboral-convenios
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/laboral/convenios/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/laboral/convenios/tests/prompts.md) para pruebas manuales con el agente.
