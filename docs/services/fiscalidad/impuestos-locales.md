# fiscalidad/impuestos-locales -- Impuestos Locales (IBI, IAE, Plusvalia, IVTM)

Guia completa de los cuatro impuestos locales principales en Espana y las tasas municipales habituales. Competencia municipal.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/impuestos-locales/service.yml).

## Que puedes consultar

- **IBI**: que es, quien paga, calculo (valor catastral x tipo), horquillas de tipos, bonificaciones.
- **IAE**: quien paga (solo empresas >= 1 M EUR), exenciones, epigrafes, calculo.
- **Plusvalia municipal**: cuando se paga (venta, herencia, donacion), metodo real y objetivo, sentencias TC.
- **IVTM**: cuotas, bonificaciones para electricos/hibridos/discapacidad, baja de vehiculo.
- **Tasas municipales**: basura, vado, terrazas, ICIO.
- **Marco legal**: Ley de Haciendas Locales (RDLeg 2/2004).

**No accesible**: ordenanzas fiscales de cada municipio, tipos exactos de cada ayuntamiento, valor catastral concreto (usar `catastro`), ITP/AJD (usar `fiscalidad-itp-ajd`), ISD (usar `fiscalidad-sucesiones-donaciones`).

## Estrategia

Skill de **conocimiento/orientacion** sobre impuestos locales. Explica el marco legal y las horquillas. Cada ayuntamiento fija tipos y bonificaciones propios.

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/impuestos-locales/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-impuestos-locales/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/impuestos-locales ~/.claude/skills/fiscalidad-impuestos-locales
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/impuestos-locales/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/impuestos-locales/tests/prompts.md) para pruebas manuales con el agente.
