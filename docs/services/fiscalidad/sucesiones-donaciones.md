# fiscalidad/sucesiones-donaciones -- Impuesto de Sucesiones y Donaciones (ISD)

Guia completa del ISD en Espana: herencias, donaciones, competencia autonomica, grupos de parentesco, calculo del impuesto, modelos 650/651 y plazos.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/sucesiones-donaciones/service.yml).

## Que puedes consultar

- **Hecho imponible**: herencia, donacion, seguro de vida.
- **Competencia autonomica**: que CCAA es competente, ejemplos de bonificaciones.
- **Grupos de parentesco**: I-IV con reducciones estatales.
- **Calculo**: base imponible, reducciones, tarifa, coeficientes multiplicadores, bonificaciones.
- **Modelos y plazos**: 650 (sucesiones, 6 meses) y 651 (donaciones, 30 dias habiles).
- **Reducciones especiales**: empresa familiar, vivienda habitual, discapacidad.
- **Donaciones**: acumulacion, escritura publica, donacion de vivienda y dinero.
- **Aspectos practicos**: pasos tras el fallecimiento, renuncia a la herencia.

**No accesible**: liquidacion real del impuesto, normativa autonomica detallada de cada CCAA, tramites juridicos de herencia, plusvalia municipal (usar `fiscalidad-impuestos-locales`), ITP/AJD (usar `fiscalidad-itp-ajd`).

## Estrategia

Skill de **conocimiento/orientacion** sobre el ISD. Explica el marco estatal y advierte de la variabilidad autonomica. Para consultas concretas, orienta a la normativa de la CCAA correspondiente.

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/sucesiones-donaciones/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-sucesiones-donaciones/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/sucesiones-donaciones ~/.claude/skills/fiscalidad-sucesiones-donaciones
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/sucesiones-donaciones/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/sucesiones-donaciones/tests/prompts.md) para pruebas manuales con el agente.
