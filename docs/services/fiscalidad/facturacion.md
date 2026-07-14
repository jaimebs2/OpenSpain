# fiscalidad/facturacion — Facturación

Guía sobre los documentos comerciales en España: diferencia entre factura y recibo, datos obligatorios, factura simplificada, facturas rectificativas, factura electrónica (Ley Crea y Crece, VeriFactu, Facturae) y casos especiales (facturas UE sin IVA, facturas de fuera UE).

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/facturacion/service.yml).

## Qué puedes consultar

- **Diferencia entre factura y recibo**: cuál vale para deducir, cuál es solo comprobante de pago.
- **Datos obligatorios** de una factura completa (RD 1619/2012).
- **Factura simplificada** (antes "ticket"): cuándo se puede, límites (400 € o 3.000 € según actividad), qué datos lleva y por qué no basta para que un autónomo deduzca.
- **Facturas rectificativas**: supuestos, serie propia, plazos, referencia a la factura rectificada.
- **Factura electrónica B2B** obligatoria: Ley Crea y Crece (Ley 18/2022), VeriFactu / SIF (RD 1007/2023), Facturae (AAPP).
- **Facturas UE sin IVA** (reverse charge): enlace a `fiscalidad-operaciones-intracomunitarias` para el detalle fiscal.
- **Facturas de fuera de la UE**: exportaciones exentas, importaciones con DUA, servicios de proveedores extracomunitarios.
- **Numeración, series, plazos de emisión, conservación** (4–10 años según caso).
- **Software de facturación** y qué requisitos cumple desde 2026.

**No accesible**: emisión real de facturas (requiere software), envío por FACe (requiere certificado digital), datos de facturas individuales, texto legal íntegro (usar `boe`).

## Estrategia

Skill de **conocimiento/orientación**. No accede a APIs ni emite facturas. Absorbe y amplía la sección de facturación de `fiscalidad-autonomos`, a la que queda enlazada.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/facturacion/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-facturacion/` |

### Opción — Skill

```bash
cp -r skills/fiscalidad/facturacion ~/.claude/skills/fiscalidad-facturacion
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/facturacion/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas responden correctamente. Ver también [tests/prompts.md](../../../skills/fiscalidad/facturacion/tests/prompts.md) para pruebas manuales con el agente.
