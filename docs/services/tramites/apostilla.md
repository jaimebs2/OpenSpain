# tramites/apostilla — Apostilla de La Haya y Legalización

Guía completa sobre la Apostilla de La Haya en España, legalización consular para países no firmantes, traducciones juradas y convenios bilaterales de exención.

Metadata completa de la skill en [service.yml](../../../skills/tramites/apostilla/service.yml).

## Qué puedes consultar

- **Apostilla de La Haya**: qué es, qué documentos se apostillan, dónde según el tipo.
- **Organismos competentes**: Colegios Notariales, TSJ, Ministerio de Justicia, Ministerio de Educación.
- **Legalización consular**: cadena completa para países no firmantes del Convenio.
- **Traducción jurada**: qué es, lista oficial de traductores del MAEC, diferencia con traducción certificada.
- **Convenios bilaterales**: exenciones UE (Reglamento 2016/1191), Iberoamérica, etc.
- **Ejemplos prácticos**: paso a paso para distintos escenarios.

**No accesible**: realización de apostillas o legalizaciones (trámite presencial/online), homologación de títulos extranjeros, detalle de trámites de extranjería (usar skills `extranjeria-nie`, `extranjeria-nacionalidad`), tarifas exactas de traductores.

## Estrategia

Skill de **conocimiento/orientación** sobre apostilla y legalización de documentos españoles para el extranjero. Complementaria a `legalizacion-documentos` (documentos extranjeros para España). Redirige a `antecedentes-penales` para el certificado de penales y a `extranjeria-nacionalidad` para el proceso de nacionalidad.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/tramites/apostilla/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/apostilla/` |

### Opción — Skill

```bash
cp -r skills/tramites/apostilla ~/.claude/skills/apostilla
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/tramites/apostilla/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/tramites/apostilla/tests/prompts.md) para pruebas manuales con el agente.
