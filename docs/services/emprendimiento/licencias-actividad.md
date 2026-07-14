# emprendimiento/licencias-actividad — Licencias de Actividad y Apertura

Guía orientativa sobre licencias de actividad y apertura en España: marco general, tipos de actividades, declaración responsable vs. licencia previa, documentación habitual y habilitaciones sectoriales.

Metadata completa de la skill en [service.yml](../../../skills/emprendimiento/licencias-actividad/service.yml).

## Qué puedes consultar

- **Licencia de actividad**: qué es, cuándo es obligatoria, cuándo no.
- **Actividades inocuas vs. clasificadas**: categorías MINP, ejemplos, trámite para cada una.
- **Declaración responsable vs. licencia previa**: cuándo aplica cada una, ventajas, Ley 12/2012.
- **Documentación habitual**: por tipo de trámite (declaración responsable y licencia).
- **EUGO**: ventanilla única para consultar requisitos por actividad y localización.
- **Licencias de obras**: obra menor y obra mayor, trámite y coste.
- **Habilitaciones sectoriales**: sanidad, alimentación, hostelería, turismo, educación, transporte.
- **Costes orientativos**: por concepto (tasa municipal, proyecto técnico, boletín eléctrico…).

**No accesible**: requisitos concretos de cada ayuntamiento (competencia municipal), normativa autonómica específica, realización de trámites, alta como autónomo (usar skill `alta-autonomo`), creación de empresas (usar skill `crear-empresa`).

## Estrategia

Skill de **conocimiento/orientación** que proporciona el marco general de licencias de actividad. Advierte siempre que la competencia es municipal y los requisitos varían. No accede a APIs de datos. Puede enlazar a EUGO y al BOE.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/emprendimiento/licencias-actividad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/licencias-actividad/` |

### Opción — Skill

```bash
cp -r skills/emprendimiento/licencias-actividad ~/.claude/skills/licencias-actividad
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/emprendimiento/licencias-actividad/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/emprendimiento/licencias-actividad/tests/prompts.md) para pruebas manuales con el agente.
