# seguridad-social-guia/jubilacion — Pensión de Jubilación

Guía completa sobre la pensión de jubilación en España: requisitos de edad y cotización, cálculo de la base reguladora y porcentaje, modalidades (anticipada, activa, demorada, parcial), complementos y cómo solicitarla.

Metadata completa de la skill en [service.yml](../../../skills/seguridad-social-guia/jubilacion/service.yml).

## Qué puedes consultar

- **Requisitos**: edad ordinaria (67 o 65 años), periodo mínimo de cotización (15 años), calendario transitorio hasta 2027.
- **Cálculo**: base reguladora (media últimos 25 años / 350) y porcentaje según años cotizados (50 %–100 %).
- **Jubilación anticipada**: involuntaria (-4 años, 33 cotizados) y voluntaria (-2 años, 35 cotizados), coeficientes reductores.
- **Jubilación parcial**: compatibilizar pensión parcial con trabajo a tiempo parcial, contrato de relevo.
- **Jubilación activa**: 50 % de la pensión + trabajo (100 % si autónomo con empleados).
- **Jubilación demorada**: incentivos (+4 % por año, tanto alzado o combinación).
- **Complementos**: brecha de género (~33 EUR/mes por hijo), a mínimos.
- **Pensión máxima y mínima**: importes vigentes orientativos.
- **Cómo solicitar**: Import@ss, sede electrónica, CAISS presencial.
- **Pensión no contributiva**: para mayores de 65 sin cotización suficiente.

**No accesible**: datos personales de cotización (requiere Import@ss), cálculo exacto personalizado (usar simulador de Import@ss), datos estadísticos agregados de pensiones (usar skill `seguridad-social`), detalle de cotizaciones (usar skill `cotizaciones`).

## Estrategia

Skill de **conocimiento/orientación** sobre la principal prestación del sistema de Seguridad Social. No accede a APIs de datos. Redirige a skills específicas para cotizaciones, vida laboral y datos estadísticos. Indica el calendario transitorio hasta 2027.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/seguridad-social-guia/jubilacion/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/jubilacion/` |

### Opción — Skill

```bash
cp -r skills/seguridad-social-guia/jubilacion ~/.claude/skills/jubilacion
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/seguridad-social-guia/jubilacion/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/seguridad-social-guia/jubilacion/tests/prompts.md) para pruebas manuales con el agente.
