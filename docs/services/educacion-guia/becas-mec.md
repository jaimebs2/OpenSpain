# educacion-guia/becas-mec — Becas MEC

Guía completa de las becas y ayudas al estudio convocadas por el Ministerio de Educación (MEC) de España: tipos de becas, requisitos académicos y económicos, componentes de la beca, calendario y proceso de solicitud.

Metadata completa de la skill en [service.yml](../../../skills/educacion-guia/becas-mec/service.yml).

## Qué puedes consultar

- **Tipos de becas**: generales (universidad, FP, bachillerato), NEAE, colaboración, idiomas.
- **Requisitos académicos**: nota mínima, créditos superados, según nivel educativo.
- **Requisitos económicos**: umbrales de renta (1, 2, 3), requisitos patrimoniales.
- **Componentes de la beca**: matrícula, cuantía fija (renta, residencia, excelencia), cuantía variable.
- **Calendario**: convocatoria, solicitud, resolución provisional, alegaciones, resolución definitiva.
- **Proceso de solicitud**: sede electrónica, Cl@ve, documentación, subsanación.
- **Resolución y recursos**: alegaciones, recurso de reposición, contencioso-administrativo.
- **Otros programas**: inmersión lingüística, Erasmus+ complementario, libros de texto.

**No accesible**: estado de solicitudes individuales (requiere Cl@ve), cuantías exactas del curso vigente, datos estadísticos educativos (usar skill `educacion`), texto legal de la convocatoria (usar skill `boe`).

## Estrategia

Skill de **conocimiento/orientación** sobre el sistema de becas MEC. No accede a APIs de datos. Proporciona información general y redirige a skills específicas para consultas no relacionadas con becas.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/educacion-guia/becas-mec/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/becas-mec/` |

### Opción — Skill

```bash
cp -r skills/educacion-guia/becas-mec ~/.claude/skills/becas-mec
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/educacion-guia/becas-mec/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/educacion-guia/becas-mec/tests/prompts.md) para pruebas manuales con el agente.
