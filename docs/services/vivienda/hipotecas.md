# vivienda/hipotecas --- Hipotecas

Guía completa sobre hipotecas en España: tipos (fija, variable, mixta), TAE vs. TIN, Euribor, gastos de constitución, FEIN/FiAE, amortización anticipada, subrogación, novación y Código de Buenas Prácticas Bancarias.

Metadata completa de la skill en [service.yml](../../../skills/vivienda/hipotecas/service.yml).

## Qué puedes consultar

- **Tipos de hipoteca**: fija, variable, mixta --- características y cuándo conviene cada una.
- **TAE vs. TIN**: diferencia y cómo comparar ofertas correctamente.
- **Euribor**: qué es, cómo afecta a la cuota, dónde consultarlo.
- **Gastos de constitución**: quién paga qué desde la Ley 5/2019.
- **Vinculaciones y bonificaciones**: productos bancarios asociados.
- **FEIN y FiAE**: documentos precontractuales obligatorios, plazos.
- **Amortización anticipada**: parcial y total, comisiones máximas legales.
- **Subrogación y novación**: cambiar de banco o renegociar condiciones.
- **Código de Buenas Prácticas**: medidas para deudores vulnerables.
- **Simuladores**: enlace al simulador del Banco de España.

**No accesible**: ofertas concretas de bancos, Euribor actual y series históricas (usar skill `bde`), proceso de compraventa (usar skill `vivienda-compraventa`), fiscalidad ITP/AJD (usar skill `fiscalidad-itp-ajd`).

## Estrategia

Skill de **conocimiento/orientación** que cubre la normativa y conceptos hipotecarios. No accede a APIs de datos. Redirige a skills específicas para Euribor (bde), compraventa (vivienda-compraventa) y fiscalidad (fiscalidad-itp-ajd). Puede enlazar a páginas del Banco de España.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vivienda/hipotecas/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/vivienda-hipotecas/` |

### Opción --- Skill

```bash
cp -r skills/vivienda/hipotecas ~/.claude/skills/vivienda-hipotecas
```

Skill puramente informativa --- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vivienda/hipotecas/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vivienda/hipotecas/tests/prompts.md) para pruebas manuales con el agente.
