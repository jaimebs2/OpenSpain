# justicia/justicia-gratuita — Justicia Gratuita

Guía completa sobre el derecho a la asistencia jurídica gratuita en España: requisitos económicos, colectivos con derecho automático, qué cubre, cómo solicitarla y plazos.

Metadata completa de la skill en [service.yml](../../../skills/justicia/justicia-gratuita/service.yml).

## Qué puedes consultar

- **Qué es la justicia gratuita**: derecho constitucional, Ley 1/1996.
- **Requisitos económicos**: umbrales en relación con el IPREM según composición de la unidad familiar.
- **Derecho automático**: víctimas de violencia de género, terrorismo, trata, menores.
- **Qué cubre**: abogado de oficio, procurador, exención de tasas, perito gratuito, reducción aranceles.
- **Cómo solicitarla**: formulario en Colegio de Abogados, documentación, plazos.
- **Resolución y plazos**: designación provisional 15 días, resolución 30 días hábiles, silencio positivo.
- **Turno de oficio**: cómo funciona, cambio de abogado, retribución.
- **Revocación**: cuándo puede revocarse el derecho.

**No accesible**: tramitación real de solicitudes (requiere acudir al Colegio de Abogados), datos personales de abogados del turno, estado de expedientes, asesoramiento jurídico individualizado.

## Estrategia

Skill de **conocimiento/orientación** sobre el acceso a justicia gratuita. No accede a APIs de datos. Redirige a skills hermanas para trámites relacionados (registro-civil, herencias). Enlaza a la página oficial del Ministerio de Justicia.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/justicia/justicia-gratuita/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/justicia-gratuita/` |

### Opción — Skill

```bash
cp -r skills/justicia/justicia-gratuita ~/.claude/skills/justicia-gratuita
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/justicia/justicia-gratuita/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/justicia/justicia-gratuita/tests/prompts.md) para pruebas manuales con el agente.
