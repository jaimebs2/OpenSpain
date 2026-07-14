# fiscalidad/itp-ajd -- ITP y AJD (Transmisiones Patrimoniales y Actos Juridicos Documentados)

Guia completa del ITP-AJD en Espana: TPO (compraventa entre particulares), AJD (hipotecas, escrituras), OS (operaciones societarias), tipos impositivos, modelos 600/620 y plazos.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/itp-ajd/service.yml).

## Que puedes consultar

- **TPO**: compraventa de vivienda de segunda mano, vehiculos usados, tipos por CCAA (6-10 %).
- **AJD**: hipotecas (paga el banco desde 2018), escrituras, tipos (0,5-1,5 %).
- **OS**: operaciones societarias (exentas desde 2010 para constituciones y ampliaciones).
- **Incompatibilidad IVA/TPO**: cuando se aplica cada uno.
- **Modelos**: 600 (general) y 620 (vehiculos usados).
- **Plazos**: 30 dias habiles desde el devengo.
- **Resumen fiscal**: compraventa de vivienda nueva vs. segunda mano.
- **Vehiculos usados**: base imponible por tablas, tipo, tramite.

**No accesible**: liquidacion real del impuesto, tipos exactos actualizados de cada CCAA, tramite de transferencia en la DGT, plusvalia municipal (usar `fiscalidad-impuestos-locales`), IVA (usar `fiscalidad-iva`).

## Estrategia

Skill de **conocimiento/orientacion** sobre el ITP-AJD. Explica el marco general y los rangos de tipos impositivos. Competencia autonomica: orienta a la CCAA correspondiente para tipos exactos.

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/itp-ajd/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-itp-ajd/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/itp-ajd ~/.claude/skills/fiscalidad-itp-ajd
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/itp-ajd/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/itp-ajd/tests/prompts.md) para pruebas manuales con el agente.
