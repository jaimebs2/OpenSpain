# seguridad-social-guia/maternidad-paternidad — Prestación por Nacimiento y Cuidado de Menor

Guía completa sobre la prestación por nacimiento y cuidado de menor (antes maternidad/paternidad): 16 semanas para cada progenitor, cuantía, requisitos, autónomos, riesgo durante embarazo/lactancia y cómo solicitarla.

Metadata completa de la skill en [service.yml](../../../skills/seguridad-social-guia/maternidad-paternidad/service.yml).

## Qué puedes consultar

- **Duración**: 16 semanas por progenitor (6 obligatorias + 10 voluntarias hasta los 12 meses del menor).
- **Cuantía**: 100 % de la base reguladora, sin tope de pensión máxima.
- **Requisitos de cotización**: según edad (< 21: sin mínimo; 21-25: 90/180 días; >= 26: 180/360 días).
- **Prestación no contributiva**: 42 días al 100 % del IPREM para quienes no alcanzan cotización mínima.
- **Autónomos**: mismos derechos, bonificación 100 % de cuota durante descanso, tarifa plana tras reincorporación.
- **Riesgo durante embarazo**: 100 % base contingencias profesionales hasta inicio del descanso.
- **Riesgo durante lactancia natural**: hasta que el hijo cumpla 9 meses.
- **Adopción y acogimiento**: misma prestación que por parto.
- **Efectos laborales**: suspensión del contrato, reserva de puesto, nulidad del despido.
- **Cómo solicitarla**: Import@ss, sede electrónica, CAISS presencial.

**No accesible**: datos personales de prestaciones (requiere identificación), trámites reales (requiere certificado digital/Cl@ve), tipos de contratos (usar skill `laboral-contratos`), cotizaciones (usar skill `cotizaciones`).

## Estrategia

Skill de **conocimiento/orientación** con altísima demanda entre futuros padres y madres. No accede a APIs de datos. Redirige a skills específicas para vida laboral, contratos y cotizaciones.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/seguridad-social-guia/maternidad-paternidad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/maternidad-paternidad/` |

### Opción — Skill

```bash
cp -r skills/seguridad-social-guia/maternidad-paternidad ~/.claude/skills/maternidad-paternidad
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/seguridad-social-guia/maternidad-paternidad/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/seguridad-social-guia/maternidad-paternidad/tests/prompts.md) para pruebas manuales con el agente.
