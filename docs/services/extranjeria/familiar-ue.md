# extranjeria/familiar-ue — Tarjeta de Familiar de Ciudadano UE

Guía completa sobre la tarjeta de familiar de ciudadano de la Unión Europea en España: régimen comunitario, derechos, procedimiento, derecho a trabajar y residencia permanente.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/familiar-ue/service.yml).

## Qué puedes consultar

- **Régimen comunitario**: qué es, RD 240/2007, diferencia con el régimen general.
- **Quién tiene derecho**: cónyuge, pareja de hecho, descendientes, ascendientes de ciudadano UE.
- **Tarjeta de familiar**: qué es, vigencia (5 años), derechos.
- **Procedimiento**: paso a paso, documentación, plazos.
- **Derecho a trabajar**: sin necesidad de permiso independiente.
- **Residencia permanente**: tras 5 años.
- **Situaciones especiales**: divorcio, fallecimiento, parejas de hecho.

**No accesible**: tramitación real de la tarjeta (requiere Oficina de Extranjería), reagrupación familiar del régimen general (usar skill `extranjeria-reagrupacion`), detalle sobre el NIE (usar skill `extranjeria-nie`).

## Estrategia

Skill de **conocimiento/orientación** importante para parejas y familias mixtas UE-no UE. No accede a APIs de datos. Redirige a `extranjeria-reagrupacion` para el régimen general y a `extranjeria-nie` para el NIE.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/familiar-ue/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-familiar-ue/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/familiar-ue ~/.claude/skills/extranjeria-familiar-ue
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/familiar-ue/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/familiar-ue/tests/prompts.md) para pruebas manuales con el agente.
