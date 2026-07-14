# vehiculos/permiso-internacional — Permiso Internacional de Conducción

Guía sobre el Permiso Internacional de Conducción (PIC) expedido en España: qué es, cuándo se necesita, cómo solicitarlo, documentación, validez y consejos para conducir en el extranjero.

Metadata completa de la skill en [service.yml](../../../skills/vehiculos/permiso-internacional/service.yml).

## Qué puedes consultar

- **Qué es el PIC**: traducción oficial del permiso español para conducir fuera de la UE.
- **Cuándo es necesario**: países que lo exigen (EE.UU., Brasil, Japón, Tailandia, etc.) vs UE/EEE (no necesario).
- **Convenios internacionales**: Viena (1968) y Ginebra (1949), diferencias y países firmantes.
- **Cómo solicitarlo**: presencial en Jefatura de Tráfico, cita previa, documentación (DNI, permiso, foto, tasa).
- **Validez**: 1 año, renovable, siempre junto con el permiso español.
- **Consejos prácticos**: alquiler de coches, seguro, normativa local, estancias largas.
- **Preguntas frecuentes**: EE.UU., Latinoamérica, Japón (caso especial Ginebra vs Viena).

**No accesible**: tramitación online (no existe), normativa interna de cada país de destino, permisos de conducir españoles (usar `carnet-conducir`).

## Estrategia

Skill de **conocimiento/orientación** breve y práctica. No accede a APIs ni tramita solicitudes. El PIC solo se expide presencialmente, por lo que la skill se centra en informar sobre requisitos, documentación y cuándo es necesario.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vehiculos/permiso-internacional/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/permiso-internacional/` |

### Opción — Skill

```bash
cp -r skills/vehiculos/permiso-internacional ~/.claude/skills/permiso-internacional
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vehiculos/permiso-internacional/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vehiculos/permiso-internacional/tests/prompts.md) para pruebas manuales con el agente.
