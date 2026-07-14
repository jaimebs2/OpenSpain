# seguridad-social-guia/cotizaciones — Cotizaciones a la Seguridad Social

Guía completa sobre las cotizaciones al sistema de Seguridad Social español: bases, tipos, reparto empresa/trabajador, autónomos por ingresos reales, tarifa plana, convenio especial y situaciones especiales.

Metadata completa de la skill en [service.yml](../../../skills/seguridad-social-guia/cotizaciones/service.yml).

## Qué puedes consultar

- **Bases de cotización**: mínima y máxima por grupo de cotización, base máxima general.
- **Tipos de cotización**: contingencias comunes (23,60 % + 4,70 %), desempleo, FP, FOGASA, MEI, AT/EP.
- **Reparto empresa/trabajador**: desglose completo con ejemplo numérico.
- **Coste laboral total**: ~32 % sobre el salario bruto para la empresa.
- **Autónomos (RETA)**: sistema de ingresos reales, tramos y cuotas, tipo total (~30,60 %), regularización anual.
- **Tarifa plana**: 80 EUR/mes para nuevos autónomos (12-24 meses).
- **Convenio especial**: coste, cuándo se usa, cómo solicitarlo.
- **Cotización durante el desempleo**: quién cotiza y por cuánto.
- **Pluriactividad y pluriempleo**: cómo funcionan las cotizaciones simultáneas.
- **Grupos de cotización**: 11 grupos, categorías profesionales, cotización mensual/diaria.

**No accesible**: bases de cotización individuales (requiere Import@ss), cálculo personalizado de cuotas, cómo se refleja en la nómina (usar skill `laboral-nominas`), pensión de jubilación (usar skill `jubilacion`), obligaciones fiscales del autónomo (usar skill `fiscalidad-autonomos`).

## Estrategia

Skill de **conocimiento/orientación** fundamental para entender la nómina y la pensión futura. No accede a APIs de datos. Los tipos y bases se actualizan anualmente por Orden ministerial. Redirige a skills específicas para nóminas, jubilación y fiscalidad de autónomos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/seguridad-social-guia/cotizaciones/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/cotizaciones/` |

### Opción — Skill

```bash
cp -r skills/seguridad-social-guia/cotizaciones ~/.claude/skills/cotizaciones
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/seguridad-social-guia/cotizaciones/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/seguridad-social-guia/cotizaciones/tests/prompts.md) para pruebas manuales con el agente.
