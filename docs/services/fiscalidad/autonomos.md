# fiscalidad/autonomos — Guía General para Autónomos

Guía completa de las obligaciones fiscales de un trabajador autónomo (persona física) en España: alta censal, impuestos que paga, calendario fiscal, facturación, declaración de la Renta, libros obligatorios y accesos digitales.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/autonomos/service.yml).

## Qué puedes consultar

- **Alta censal**: Modelos 036/037, elección de epígrafe IAE, régimen de IRPF e IVA.
- **Impuestos del autónomo**: resumen de IVA (303) e IRPF (130/131) con routing a skills detalladas.
- **Calendario fiscal**: fechas trimestrales y anuales, modelos a presentar en cada plazo.
- **Facturación**: datos obligatorios de una factura, factura simplificada, conservación, factura electrónica.
- **Cuánto reservar**: orientación sobre el 30-40 % de cada factura para impuestos y Seguridad Social.
- **Declaración de la Renta**: Modelo 100, plazos, borrador, cómo afectan los pagos fraccionados.
- **Libros y registros**: qué libros son obligatorios según el régimen.
- **Accesos digitales**: Cl@ve, certificado digital FNMT, DNI electrónico.
- **Trámites habituales**: URLs directas para alta censal, presentar modelos, cita previa, etc.

**No accesible**: presentación real de declaraciones (requiere certificado digital/Cl@ve), detalle de cálculo del IVA (usar skill `fiscalidad-iva`), detalle de cálculo del IRPF (usar skill `fiscalidad-irpf-autonomos`), cuotas de la Seguridad Social (usar skill `seguridad-social`), obligaciones de sociedades.

## Estrategia

Skill de **conocimiento/orientación** que funciona como mapa general de la fiscalidad del autónomo. No accede a APIs de datos. Redirige a skills específicas para detalle sobre cada impuesto. Puede enlazar a páginas informativas oficiales de la AEAT, Cl@ve y FNMT.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/autonomos/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-autonomos/` |

### Opción — Skill

```bash
cp -r skills/fiscalidad/autonomos ~/.claude/skills/fiscalidad-autonomos
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/autonomos/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/fiscalidad/autonomos/tests/prompts.md) para pruebas manuales con el agente.
