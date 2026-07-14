# vivienda/compraventa --- Compraventa de vivienda

Guía completa del proceso de compraventa de una vivienda en España: búsqueda, verificación, arras, escritura pública, inscripción registral, gastos del comprador y del vendedor, nota simple, referencia catastral y certificado energético.

Metadata completa de la skill en [service.yml](../../../skills/vivienda/compraventa/service.yml).

## Qué puedes consultar

- **Proceso de compraventa**: paso a paso desde la búsqueda hasta la inscripción en el Registro.
- **Arras**: tipos (penitenciales, confirmatorias, penales), importe habitual, efectos del incumplimiento.
- **Gastos del comprador**: IVA/ITP, AJD, notaría, registro, gestoría, tasación.
- **Gastos del vendedor**: plusvalía municipal, ganancia patrimonial IRPF, cancelación de hipoteca.
- **Nota simple**: qué contiene, cómo solicitarla, coste.
- **Vivienda nueva vs. segunda mano**: diferencias fiscales.
- **Compra sobre plano**: garantías, aval bancario, licencia de primera ocupación.
- **Referencia catastral y certificado energético**: obligaciones legales.
- **Checklist del comprador y plazos de liquidación de impuestos**.

**No accesible**: solicitud real de nota simple (requiere sede.registradores.org con pago), detalle de ITP/AJD por CCAA (usar skill `fiscalidad-itp-ajd`), detalle de plusvalía e IBI (usar skill `fiscalidad-impuestos-locales`), datos catastrales (usar skill `catastro`), hipotecas (usar skill `vivienda-hipotecas`).

## Estrategia

Skill de **conocimiento/orientación** que cubre el proceso completo de compraventa. No accede a APIs de datos. Redirige a skills específicas para detalle fiscal, catastral e hipotecario. Puede enlazar a páginas informativas del Consejo General del Notariado y el Colegio de Registradores.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vivienda/compraventa/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/vivienda-compraventa/` |

### Opción --- Skill

```bash
cp -r skills/vivienda/compraventa ~/.claude/skills/vivienda-compraventa
```

Skill puramente informativa --- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vivienda/compraventa/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vivienda/compraventa/tests/prompts.md) para pruebas manuales con el agente.
