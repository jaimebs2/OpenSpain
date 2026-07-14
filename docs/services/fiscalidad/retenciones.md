# fiscalidad/retenciones -- Retenciones e Ingresos a Cuenta

Guia completa sobre retenciones e ingresos a cuenta en Espana: tipos de retencion, modelos 111/115/190/180, tablas orientativas de retencion IRPF sobre nominas, y calendario de presentacion.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/retenciones/service.yml).

## Que puedes consultar

- **Tipos de retencion**: profesionales 15 %/7 %, alquileres 19 %, capital 19 %, administradores 35 %, premios 19 %.
- **Modelo 111**: retenciones trimestrales sobre trabajo y profesionales.
- **Modelo 115**: retenciones trimestrales sobre alquileres.
- **Modelo 190**: resumen anual de retenciones (enero).
- **Modelo 180**: resumen anual de retenciones alquileres (enero).
- **Tablas de nomina**: orientacion sobre retenciones IRPF segun salario y situacion personal.
- **Obligacion de retener**: quien retiene, cuando no se retiene.
- **Calendario**: plazos trimestrales y anuales.

**No accesible**: calculo preciso de retencion sobre nomina (usar simulador AEAT), presentacion real de declaraciones, aspectos laborales de nominas (usar `laboral-nominas`), retenciones a no residentes (usar `fiscalidad-no-residentes`).

## Estrategia

Skill de **conocimiento/orientacion** sobre retenciones desde la perspectiva del pagador/retenedor. Complementa `fiscalidad-irpf-autonomos` (perspectiva del autonomo) y `fiscalidad-irpf-asalariados` (impacto en la Renta).

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/retenciones/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-retenciones/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/retenciones ~/.claude/skills/fiscalidad-retenciones
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/retenciones/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/retenciones/tests/prompts.md) para pruebas manuales con el agente.
