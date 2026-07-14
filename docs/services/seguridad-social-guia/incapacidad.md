# seguridad-social-guia/incapacidad — Incapacidad Temporal y Permanente

Guía completa sobre incapacidad temporal (baja médica) e incapacidad permanente en el sistema de Seguridad Social: quién paga, cuánto se cobra, duración, grados de IP, procedimiento y compatibilidad con trabajo.

Metadata completa de la skill en [service.yml](../../../skills/seguridad-social-guia/incapacidad/service.yml).

## Qué puedes consultar

- **Incapacidad temporal (IT)**: tipos de contingencia (común vs. profesional), requisitos de cotización, cuánto se cobra (0 %/60 %/75 % según periodo y contingencia), quién paga (empresa, mutua, INSS).
- **Duración máxima**: 365 + 180 días (hasta 730 con demora en calificación IP).
- **Partes**: baja, confirmación, alta. Quién puede dar el alta y cómo recurrir.
- **Incapacidad permanente**: 4 grados (parcial, total, absoluta, gran invalidez) con prestación económica de cada uno.
- **Procedimiento IP**: INSS, EVI (Equipo de Valoración de Incapacidades), dictamen-propuesta, resolución, recursos.
- **Revisión de grado**: mejoría, agravamiento, plazos.
- **Compatibilidad con trabajo**: qué grados permiten trabajar y en qué condiciones.
- **Casos especiales**: recaída, baja durante desempleo, baja durante maternidad.

**No accesible**: datos personales de prestaciones (requiere identificación), trámites reales (requiere certificado digital/Cl@ve), cómo afecta a la nómina (usar skill `laboral-nominas`), cotizaciones (usar skill `cotizaciones`).

## Estrategia

Skill de **conocimiento/orientación** sobre un tema complejo y muy demandado. No accede a APIs de datos. Redirige a skills específicas para nóminas, cotizaciones y datos estadísticos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/seguridad-social-guia/incapacidad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/incapacidad/` |

### Opción — Skill

```bash
cp -r skills/seguridad-social-guia/incapacidad ~/.claude/skills/incapacidad
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/seguridad-social-guia/incapacidad/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/seguridad-social-guia/incapacidad/tests/prompts.md) para pruebas manuales con el agente.
