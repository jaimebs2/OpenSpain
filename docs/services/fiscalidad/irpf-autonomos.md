# fiscalidad/irpf-autonomos — IRPF Pagos Fraccionados para Autónomos

Orientación sobre los pagos fraccionados trimestrales del IRPF para trabajadores autónomos (personas físicas) en España: Modelo 130 (estimación directa), Modelo 131 (módulos), retenciones en factura y gastos deducibles.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/irpf-autonomos/service.yml).

## Qué puedes consultar

- **Modelo 130**: cálculo del pago fraccionado en estimación directa (20 % del rendimiento neto acumulado), excepciones.
- **Modelo 131**: cálculo en estimación objetiva (módulos), porcentajes según empleados.
- **Retenciones en factura**: 15 % general para profesionales, 7 % para nuevos autónomos (3 primeros años).
- **Gastos deducibles**: cuota de autónomos, alquiler, suministros (30 % proporcional del hogar), dietas, formación, servicios profesionales, amortizaciones.
- **Plazos de presentación** trimestrales.
- **Modelos relacionados**: 111, 115, 349, 100 (Renta anual).

**No accesible**: presentación real de declaraciones (requiere certificado digital/Cl@ve), obligaciones de sociedades (Impuesto de Sociedades, Modelo 200/202), cuotas de la Seguridad Social (usar skill `seguridad-social`).

## Estrategia

Skill de **conocimiento/orientación** exclusiva para autónomos (personas físicas). Las sociedades (SL, SA) no tributan por IRPF sino por Impuesto de Sociedades. No accede a APIs de datos; proporciona guía basada en la normativa vigente y puede enlazar a páginas informativas oficiales de la AEAT.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/irpf-autonomos/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-irpf-autonomos/` |

### Opción — Skill

```bash
cp -r skills/fiscalidad/irpf-autonomos ~/.claude/skills/fiscalidad-irpf-autonomos
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/irpf-autonomos/tests/smoke.sh
```

Verifica que las páginas informativas de la AEAT referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/fiscalidad/irpf-autonomos/tests/prompts.md) para pruebas manuales con el agente.
