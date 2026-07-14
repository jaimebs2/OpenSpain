# laboral/contratos — Tipos de contratos de trabajo

Guía completa sobre los tipos de contratos de trabajo en España tras la reforma laboral de 2022: indefinido, temporal, formativo, fijo-discontinuo, periodo de prueba, preaviso e indemnización por despido.

Metadata completa de la skill en [service.yml](../../../skills/laboral/contratos/service.yml).

## Qué puedes consultar

- **Contrato indefinido**: ordinario, fijo-discontinuo, adscrito a obra (construcción).
- **Contratos temporales**: circunstancias de la producción (máx. 6 meses) y sustitución.
- **Contratos formativos**: formación en alternancia y obtención de práctica profesional.
- **Contrato a tiempo parcial**: horas complementarias, igualdad de trato.
- **Periodo de prueba**: duraciones máximas por tipo de contrato y categoría.
- **Preaviso e indemnizaciones**: por despido disciplinario, objetivo, improcedente y fin de temporal.
- **Conversión temporal a indefinido**: encadenamiento (18 meses en 24).
- **Modelos oficiales**: dónde encontrarlos en el SEPE y Contrat@.

**No accesible**: estadísticas de contratos registrados (usar skill `sepe`), contenido de nóminas (usar skill `laboral-nominas`), prestación por desempleo (usar skill `laboral-desempleo`), texto completo del ET (usar skill `boe`).

## Estrategia

Skill de **conocimiento/orientación** centrada en el panorama contractual post-reforma 2022 (RDL 32/2021). No accede a APIs de datos. Redirige a skills hermanas para nóminas, desempleo, ERE/ERTE, convenios e inspección.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/laboral/contratos/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/laboral-contratos/` |

### Opción — Skill

```bash
cp -r skills/laboral/contratos ~/.claude/skills/laboral-contratos
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/laboral/contratos/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/laboral/contratos/tests/prompts.md) para pruebas manuales con el agente.
