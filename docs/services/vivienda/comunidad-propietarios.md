# vivienda/comunidad-propietarios --- Comunidad de propietarios

Guía completa sobre la comunidad de propietarios en España: Ley de Propiedad Horizontal (LPH), juntas, cuotas, obras, morosos, derramas y alquiler turístico.

Metadata completa de la skill en [service.yml](../../../skills/vivienda/comunidad-propietarios/service.yml).

## Qué puedes consultar

- **Regulación**: Ley 49/1960 de Propiedad Horizontal y sus reformas.
- **Juntas**: ordinarias y extraordinarias, convocatoria, quórums, actas, impugnación de acuerdos.
- **Cuotas**: de participación, gastos comunes, fondo de reserva.
- **Organos**: presidente, secretario, administrador de fincas.
- **Obras**: necesarias (conservación, mayoría simple), de mejora (3/5), accesibilidad (obligatoria si < 12 mensualidades).
- **Morosos**: requerimiento, procedimiento monitorio (art. 21 LPH), afección real del inmueble.
- **Derramas**: cuotas extraordinarias, urgentes y no urgentes.
- **Alquiler turístico**: limitación por acuerdo de 3/5 de propietarios.

**No accesible**: gestión real de comunidades (requiere administrador), procedimientos judiciales, proceso de compraventa (usar skill `vivienda-compraventa`), contratos de alquiler (usar skill `vivienda-alquiler`), IBI y plusvalía (usar skill `fiscalidad-impuestos-locales`).

## Estrategia

Skill de **conocimiento/orientación** muy práctica para propietarios de vivienda. No accede a APIs de datos. Redirige a skills de compraventa, alquiler y fiscalidad local para temas relacionados.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vivienda/comunidad-propietarios/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/vivienda-comunidad-propietarios/` |

### Opción --- Skill

```bash
cp -r skills/vivienda/comunidad-propietarios ~/.claude/skills/vivienda-comunidad-propietarios
```

Skill puramente informativa --- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vivienda/comunidad-propietarios/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vivienda/comunidad-propietarios/tests/prompts.md) para pruebas manuales con el agente.
