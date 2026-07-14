# fiscalidad/no-residentes -- Fiscalidad para No Residentes (IRNR)

Guia completa de la fiscalidad para no residentes en Espana: IRNR, modelos 210 y 720, convenios de doble imposicion, Ley Beckham, y no residentes con inmuebles en Espana.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/no-residentes/service.yml).

## Que puedes consultar

- **Residencia fiscal**: regla de los 183 dias, centro de intereses economicos.
- **IRNR**: tipos impositivos (24 % general, 19 % UE/EEE), con y sin establecimiento permanente.
- **Modelo 210**: autoliquidacion del IRNR, plazos segun tipo de renta.
- **Modelo 720**: bienes en el extranjero (umbrales 50.000 EUR, plazo enero-marzo).
- **Convenios de doble imposicion**: funcionamiento, tipos reducidos, acreditacion.
- **Ley Beckham**: regimen impatriados, 24 % fijo, requisitos, Modelo 149.
- **Inmueble en Espana**: imputacion de rentas, alquiler, venta (retencion 3 %).
- **Representante fiscal**: cuando es obligatorio.

**No accesible**: presentacion real de declaraciones, datos fiscales individuales, texto completo de cada CDI, estatus migratorio (usar `extranjeria-residencia`), IRPF de residentes (usar `fiscalidad-irpf-asalariados`).

## Estrategia

Skill de **conocimiento/orientacion** sobre fiscalidad de no residentes. Materia tecnica. Recomienda siempre asesor especializado en fiscalidad internacional.

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/no-residentes/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-no-residentes/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/no-residentes ~/.claude/skills/fiscalidad-no-residentes
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/no-residentes/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/no-residentes/tests/prompts.md) para pruebas manuales con el agente.
