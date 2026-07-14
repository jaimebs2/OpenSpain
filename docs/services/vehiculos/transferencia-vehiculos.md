# vehiculos/transferencia-vehiculos — Compraventa de Vehículos Usados

Guía completa sobre el proceso de compraventa y transferencia de vehículos usados en España: cambio de titular, documentación, ITP, comprobaciones previas, importación.

Metadata completa de la skill en [service.yml](../../../skills/vehiculos/transferencia-vehiculos/service.yml).

## Qué puedes consultar

- **Proceso de transferencia**: pasos ordenados para comprador y vendedor.
- **Comprobaciones previas**: informe de vehículo DGT (cargas, embargos, multas, km).
- **Contrato de compraventa**: datos mínimos obligatorios.
- **ITP**: Modelo 620, base imponible (tablas de Hacienda vs precio real), tipo (~4 %), plazo.
- **Documentación DGT**: lista completa para el cambio de titular.
- **Vías de tramitación**: electrónica, presencial, gestoría.
- **Notificación de venta**: protección del vendedor.
- **Baja temporal y definitiva**: cuándo y cómo.
- **Importación de vehículos**: desde la UE y desde fuera de la UE (homologación, impuestos).
- **Compraventa a profesional**: IVA en lugar de ITP, régimen REBU.

**No accesible**: tramitación real de transferencias (requiere Cl@ve/certificado), datos de vehículos concretos, tablas exactas de valoración de Hacienda, normativa ITP por CCAA en detalle (usar `fiscalidad-itp-ajd`).

## Estrategia

Skill de **conocimiento/orientación** sobre compraventa de vehículos. No accede a APIs de datos ni realiza trámites. Enlaza a las páginas oficiales de la DGT (Sede Electrónica). Para temas fiscales detallados (ITP, IVTM) remite a las skills de fiscalidad correspondientes.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vehiculos/transferencia-vehiculos/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/transferencia-vehiculos/` |

### Opción — Skill

```bash
cp -r skills/vehiculos/transferencia-vehiculos ~/.claude/skills/transferencia-vehiculos
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vehiculos/transferencia-vehiculos/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vehiculos/transferencia-vehiculos/tests/prompts.md) para pruebas manuales con el agente.
