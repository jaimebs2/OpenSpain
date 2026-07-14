# vivienda/registro-propiedad --- Registro de la Propiedad

Guía completa sobre el Registro de la Propiedad en España: qué es, nota simple, inscripción de escrituras, principios registrales, diferencias con el Catastro y servicios online.

Metadata completa de la skill en [service.yml](../../../skills/vivienda/registro-propiedad/service.yml).

## Qué puedes consultar

- **Qué es el Registro de la Propiedad**: finalidad, organización, registradores.
- **Nota simple**: qué contiene (titular, descripción, cargas), cómo solicitarla, coste, diferencia con la certificación registral.
- **Inscripción de escrituras**: qué se inscribe, proceso, plazos, aranceles.
- **Principios registrales**: fe pública, prioridad, tracto sucesivo, legalidad, legitimación, especialidad.
- **Catastro vs. Registro**: diferencias y discrepancias habituales.
- **Servicios online**: sede.registradores.org.

**No accesible**: solicitud real de nota simple (requiere sede.registradores.org con pago), datos catastrales (usar skill `catastro`), proceso completo de compraventa (usar skill `vivienda-compraventa`), detalle de ITP/AJD (usar skill `fiscalidad-itp-ajd`).

## Estrategia

Skill de **conocimiento/orientación** breve centrada en el Registro de la Propiedad. La nota simple es el trámite más demandado. No accede a APIs de datos. Redirige a skills específicas para compraventa, datos catastrales y fiscalidad.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vivienda/registro-propiedad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/vivienda-registro-propiedad/` |

### Opción --- Skill

```bash
cp -r skills/vivienda/registro-propiedad ~/.claude/skills/vivienda-registro-propiedad
```

Skill puramente informativa --- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vivienda/registro-propiedad/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vivienda/registro-propiedad/tests/prompts.md) para pruebas manuales con el agente.
