# vehiculos/carnet-conducir — Carnet de Conducir

Guía completa sobre permisos de conducir en España: tipos de permiso, obtención, renovación, canje de permisos extranjeros y sistema de puntos.

Metadata completa de la skill en [service.yml](../../../skills/vehiculos/carnet-conducir/service.yml).

## Qué puedes consultar

- **Tipos de permiso**: AM, A1, A2, A, B, C1, C, D1, D y variantes con remolque (+E). Acceso progresivo en motos.
- **Obtener el permiso B**: proceso completo (autoescuela, examen teórico, examen práctico), requisitos, costes orientativos.
- **Renovación**: plazos según edad (10 años / 5 años), proceso en centro de reconocimiento médico, coste.
- **Canje de permisos extranjeros**: países con convenio bilateral (sin examen), UE/EEE (directamente válidos), países sin convenio (examen obligatorio).
- **Permiso por puntos**: saldo inicial (12/8), infracciones que restan puntos, consulta online, recuperación (cursos y tiempo), pérdida total.
- **Tasas DGT**: importes vigentes para exámenes, expedición, canje, duplicado.
- **URLs de trámites**: enlaces directos a la Sede Electrónica de la DGT.

**No accesible**: saldo de puntos individual (requiere Cl@ve/certificado), tramitación real de permisos, tráfico en tiempo real (usar `dgt-trafico`), ITV (usar `itv`), permiso internacional (usar `permiso-internacional`).

## Estrategia

Skill de **conocimiento/orientación** sobre permisos de conducir. No accede a APIs de datos. Proporciona información práctica sobre trámites y enlaza a las páginas oficiales de la DGT. Para trámites de circulación y tráfico, usar las skills hermanas del bloque vehículos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/vehiculos/carnet-conducir/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/carnet-conducir/` |

### Opción — Skill

```bash
cp -r skills/vehiculos/carnet-conducir ~/.claude/skills/carnet-conducir
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/vehiculos/carnet-conducir/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/vehiculos/carnet-conducir/tests/prompts.md) para pruebas manuales con el agente.
