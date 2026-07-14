# fiscalidad/sociedades -- Impuesto de Sociedades

Guia completa del Impuesto de Sociedades (IS) en Espana: tipos impositivos, modelos 200 y 202, calculo de la base imponible, deducciones, compensacion de perdidas y obligaciones contables.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/sociedades/service.yml).

## Que puedes consultar

- **Sujetos pasivos**: quien tributa por IS (SL, SA, cooperativas, fundaciones, etc.).
- **Tipos impositivos**: general 25 %, reducido 15 % nuevas empresas, cooperativas 20 %, etc.
- **Modelo 200**: declaracion anual, plazo en julio, documentacion necesaria.
- **Modelo 202**: pagos fraccionados, plazos (abril, octubre, diciembre), calculo.
- **Base imponible**: resultado contable +/- ajustes fiscales.
- **Deducciones**: I+D+i, ERD, Canarias (ZEC, REF), reserva de capitalizacion/nivelacion.
- **Perdidas**: compensacion de bases imponibles negativas sin limite temporal.
- **Contabilidad**: PGC, libros obligatorios, legalizacion, deposito de cuentas anuales.

**No accesible**: presentacion real de declaraciones, datos fiscales individuales, contabilidad de la entidad, detalle del IVA (usar `fiscalidad-iva`), retenciones (usar `fiscalidad-retenciones`), tramites de constitucion.

## Estrategia

Skill de **conocimiento/orientacion** sobre el Impuesto de Sociedades. No accede a APIs. Proporciona el marco general y redirige a skills especificas para IVA, retenciones y otros impuestos.

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/sociedades/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-sociedades/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/sociedades ~/.claude/skills/fiscalidad-sociedades
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/sociedades/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/sociedades/tests/prompts.md) para pruebas manuales con el agente.
