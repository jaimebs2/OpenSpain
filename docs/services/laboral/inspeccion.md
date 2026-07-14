# laboral/inspeccion — Inspección de Trabajo

Guía completa sobre la Inspección de Trabajo y Seguridad Social (ITSS): cómo denunciar irregularidades laborales, motivos habituales, proceso inspector, sanciones y protección del denunciante.

Metadata completa de la skill en [service.yml](../../../skills/laboral/inspeccion/service.yml).

## Qué puedes consultar

- **Qué es la ITSS**: funciones, organismo competente.
- **Motivos de denuncia**: impago, contratación irregular, jornada, prevención de riesgos, acoso, economía sumergida.
- **Cómo denunciar**: buzón electrónico online, presencial, correo postal; qué datos incluir.
- **Confidencialidad**: la ITSS no revela la identidad del denunciante; buzón de fraude para comunicaciones anónimas.
- **Garantía de indemnidad**: represalias contra el denunciante = despido nulo.
- **Proceso inspector**: visita sin previo aviso, actuaciones, resultados posibles.
- **Sanciones**: leves (70-750 €), graves (751-7.500 €), muy graves (7.501-1.000.000 €).
- **Registro de jornada**: obligación desde 2019, conservación 4 años.
- **Otras vías**: Juzgado de lo Social, SMAC, sindicatos.

**No accesible**: presentación real de denuncias (requiere identificación digital), expedientes en curso, tipos de contrato (usar skill `laboral-contratos`), convenios (usar skill `laboral-convenios`).

## Estrategia

Skill de **conocimiento/orientación** de alto valor social. Puramente informativa — no automatiza ni tramita denuncias. Redirige a skills hermanas para contratos, convenios, nóminas.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/laboral/inspeccion/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/laboral-inspeccion/` |

### Opción — Skill

```bash
cp -r skills/laboral/inspeccion ~/.claude/skills/laboral-inspeccion
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/laboral/inspeccion/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/laboral/inspeccion/tests/prompts.md) para pruebas manuales con el agente.
