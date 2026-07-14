# educacion-guia/fp — Formación Profesional (FP)

Guía completa de la Formación Profesional en España: niveles, familias profesionales, acceso, modalidades, FP dual, convalidaciones con la universidad y el portal TodoFP.

Metadata completa de la skill en [service.yml](../../../skills/educacion-guia/fp/service.yml).

## Qué puedes consultar

- **Niveles**: FP Básica (Grado A), Grado Medio (Grado C), Grado Superior (Grado D), cursos de especialización (Grado E).
- **Familias profesionales**: 26 familias con ejemplos de títulos representativos.
- **Requisitos de acceso**: titulación, pruebas de acceso, edades mínimas.
- **Modalidades**: presencial, a distancia, FP dual (general e intensiva).
- **FCT (prácticas)**: duración, evaluación, exención por experiencia.
- **Convalidaciones**: acceso a universidad desde Grado Superior, créditos ECTS convalidables.
- **TodoFP**: buscador de títulos, centros, orientación profesional.
- **FP para el empleo**: formación continua, certificados de profesionalidad.

**No accesible**: plazas en centros concretos (consultar TodoFP o CCAA), matriculación, datos estadísticos educativos (usar skill `educacion`), becas de FP (usar skill `becas-mec`), contratos formativos (usar skill `laboral-contratos`).

## Estrategia

Skill de **conocimiento/orientación** sobre la Formación Profesional en España. No accede a APIs de datos. Proporciona información general y redirige a TodoFP para búsquedas concretas de centros y títulos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/educacion-guia/fp/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fp/` |

### Opción — Skill

```bash
cp -r skills/educacion-guia/fp ~/.claude/skills/fp
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/educacion-guia/fp/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/educacion-guia/fp/tests/prompts.md) para pruebas manuales con el agente.
