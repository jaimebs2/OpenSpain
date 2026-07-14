# laboral/ere-erte — ERE y ERTE

Guía completa sobre los Expedientes de Regulación de Empleo (ERE) y los Expedientes de Regulación Temporal de Empleo (ERTE): despido colectivo, suspensión temporal, Mecanismo RED y derechos del trabajador.

Metadata completa de la skill en [service.yml](../../../skills/laboral/ere-erte/service.yml).

## Qué puedes consultar

- **ERE (extinción)**: despido colectivo, causas ETOP, procedimiento, indemnización (20 días/año), impugnación.
- **ERTE (temporal)**: suspensión y reducción de jornada, causas ETOP y fuerza mayor.
- **Mecanismo RED**: modalidad cíclica y sectorial (reforma 2022), activación por Consejo de Ministros.
- **Derechos del trabajador en ERTE**: prestación por desempleo (no consume paro), mantenimiento de empleo, antigüedad, cotización.
- **Diferencias ERE vs. ERTE**: tabla comparativa completa.
- **Infracciones**: fraude en ERE/ERTE, consecuencias.

**No accesible**: prestación por desempleo individual (usar skill `laboral-desempleo`), tipos de contrato (usar skill `laboral-contratos`), estadísticas de paro (usar skill `sepe`).

## Estrategia

Skill de **conocimiento/orientación** sobre procedimientos de regulación de empleo. Incluye las novedades del Mecanismo RED de la reforma laboral 2022. No accede a APIs de datos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/laboral/ere-erte/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/laboral-ere-erte/` |

### Opción — Skill

```bash
cp -r skills/laboral/ere-erte ~/.claude/skills/laboral-ere-erte
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/laboral/ere-erte/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/laboral/ere-erte/tests/prompts.md) para pruebas manuales con el agente.
