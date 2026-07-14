# educacion-guia/oposiciones — Oposiciones al Empleo Público

Guía completa de las oposiciones al empleo público en España: sistemas de acceso, cuerpos y escalas, proceso de selección, requisitos, principales oposiciones, OEP, bolsas de interinos y estabilización.

Metadata completa de la skill en [service.yml](../../../skills/educacion-guia/oposiciones/service.yml).

## Qué puedes consultar

- **Sistemas de acceso**: oposición, concurso-oposición, concurso.
- **Grupos y subgrupos**: A1, A2, C1, C2, E con titulación requerida y sueldos orientativos.
- **Proceso de selección**: desde la OEP hasta el nombramiento, paso a paso.
- **Principales oposiciones**: AGE, sanidad, educación, justicia, fuerzas de seguridad, Correos.
- **Requisitos generales**: nacionalidad, edad, titulación, habilitación.
- **Turnos de acceso**: libre, promoción interna, discapacidad.
- **OEP**: qué es, dónde se publica, plazo de 3 años.
- **Bolsas de interinos**: cómo se forman, orden de llamamiento.
- **Estabilización**: Ley 20/2021, procesos extraordinarios.
- **Consejos prácticos**: preparación, academias, simulacros.

**No accesible**: convocatorias específicas en tiempo real (usar skill `boe`), temarios detallados, estado de procesos individuales, datos estadísticos (usar skill `educacion`), becas (usar skill `becas-mec`).

## Estrategia

Skill de **conocimiento/orientación** sobre el sistema de oposiciones en España. No accede a APIs de datos. Proporciona información general y redirige a skills específicas para convocatorias concretas (boe) y consultas no relacionadas.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/educacion-guia/oposiciones/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/oposiciones/` |

### Opción — Skill

```bash
cp -r skills/educacion-guia/oposiciones ~/.claude/skills/oposiciones
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/educacion-guia/oposiciones/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/educacion-guia/oposiciones/tests/prompts.md) para pruebas manuales con el agente.
