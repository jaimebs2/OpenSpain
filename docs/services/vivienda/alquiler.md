# vivienda/alquiler --- Alquiler de vivienda

Guía completa sobre el alquiler de vivienda en España: LAU, Ley 12/2023, contrato, fianza, actualización de renta, derechos del inquilino y arrendador, zonas tensionadas y deducciones fiscales.

Metadata completa de la skill en [service.yml](../../../skills/vivienda/alquiler/service.yml).

## Qué puedes consultar

- **Contrato de alquiler**: duración (5/7 años), prórrogas, forma escrita.
- **Fianza y garantías**: 1 mes obligatorio + máximo 2 meses adicionales, depósito autonómico.
- **Actualización de renta**: nuevo índice desde 2025 (sustituye IPC), procedimiento.
- **Derechos del inquilino**: prórroga obligatoria, desistimiento (6 meses), obras de conservación, tanteo y retracto.
- **Derechos del arrendador**: recuperación por necesidad, desahucio por impago.
- **Zonas tensionadas**: Ley 12/2023, limitación de rentas, gran tenedor.
- **Deducciones fiscales**: para inquilino (autonómicas) y arrendador (50-90 % IRPF).
- **Alquiler de habitación**: régimen del Código Civil (distinto a la LAU).

**No accesible**: gestión de contratos (requiere acuerdo entre partes), datos de zonas tensionadas declaradas (depende de cada CCAA), proceso de compraventa (usar skill `vivienda-compraventa`), comunidad de propietarios (usar skill `vivienda-comunidad-propietarios`), IBI y plusvalía (usar skill `fiscalidad-impuestos-locales`).

## Estrategia

Skill de **conocimiento/orientación** de altísima demanda. La Ley de Vivienda 2023 introdujo cambios significativos (zonas tensionadas, índice de referencia). No accede a APIs de datos. Redirige a skills de compraventa, comunidad de propietarios y fiscalidad para temas relacionados.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vivienda/alquiler/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/vivienda-alquiler/` |

### Opción --- Skill

```bash
cp -r skills/vivienda/alquiler ~/.claude/skills/vivienda-alquiler
```

Skill puramente informativa --- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vivienda/alquiler/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vivienda/alquiler/tests/prompts.md) para pruebas manuales con el agente.
