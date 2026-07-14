# vehiculos/itv — Inspección Técnica de Vehículos

Guía práctica sobre la ITV en España: periodicidad, documentación, resultados posibles, consecuencias de circular sin ITV, vehículos importados y reformados.

Metadata completa de la skill en [service.yml](../../../skills/vehiculos/itv/service.yml).

## Qué puedes consultar

- **Periodicidad**: tablas completas según tipo de vehículo (turismo, moto, furgoneta, pesado) y antigüedad.
- **Documentación**: qué llevar a la estación de ITV.
- **Qué se inspecciona**: frenos, luces, emisiones, carrocería, dirección, neumáticos, etc.
- **Resultados**: favorable, favorable con defectos leves, desfavorable, negativa. Qué hacer en cada caso.
- **Reinspección**: plazo de 2 meses para resultado desfavorable o negativo.
- **Sanciones**: multas por circular sin ITV (200 € o 500 €), inmovilización, problemas con el seguro.
- **Vehículos importados**: ITV previa a matriculación, homologación.
- **Vehículos reformados**: proyecto técnico, ITV de reformas, actualización de ficha técnica.
- **Cita y precio**: orientación general (la gestión es autonómica).

**No accesible**: sistemas de cita de las estaciones (gestionados por CCAA), precios exactos por comunidad, resultados de inspección individual, datos del vehículo.

## Estrategia

Skill de **conocimiento/orientación** sobre la ITV. No accede a APIs ni a sistemas de cita. Proporciona la normativa general y enlaza a la página oficial de la DGT. La gestión de estaciones corresponde a las comunidades autónomas.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vehiculos/itv/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/itv/` |

### Opción — Skill

```bash
cp -r skills/vehiculos/itv ~/.claude/skills/itv
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vehiculos/itv/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vehiculos/itv/tests/prompts.md) para pruebas manuales con el agente.
