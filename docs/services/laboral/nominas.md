# laboral/nominas — Cómo leer una nómina

Guía práctica para entender una nómina española: devengos, deducciones, base de cotización, retención IRPF, SMI, pagas extra, nocturnidad, horas extra y líquido a percibir.

Metadata completa de la skill en [service.yml](../../../skills/laboral/nominas/service.yml).

## Qué puedes consultar

- **Estructura de la nómina**: encabezado, devengos, deducciones, líquido a percibir.
- **Percepciones salariales**: salario base, complementos, pagas extraordinarias.
- **Percepciones no salariales**: dietas, plus transporte.
- **Cotizaciones del trabajador**: contingencias comunes, desempleo, FP, MEI (porcentajes orientativos).
- **Base y grupos de cotización**: cómo se calcula, topes, clasificación.
- **Retención del IRPF**: rangos orientativos según salario y situación familiar.
- **SMI**: Salario Mínimo Interprofesional vigente.
- **Nocturnidad y horas extra**: horario, complemento, límites.
- **IT en nómina**: quién paga y cuánto según el periodo de baja.

**No accesible**: cálculo exacto de nóminas individuales, tablas salariales de convenios concretos (usar skill `laboral-convenios`), tipos de contrato (usar skill `laboral-contratos`).

## Estrategia

Skill de **conocimiento/orientación** que explica cómo interpretar una nómina española. Los porcentajes de cotización se actualizan anualmente por Orden ministerial. No accede a APIs de datos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/laboral/nominas/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/laboral-nominas/` |

### Opción — Skill

```bash
cp -r skills/laboral/nominas ~/.claude/skills/laboral-nominas
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/laboral/nominas/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/laboral/nominas/tests/prompts.md) para pruebas manuales con el agente.
