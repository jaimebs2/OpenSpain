# educacion-guia/selectividad — Selectividad / EBAU / EvAU

Guía completa de la Selectividad (EBAU/EvAU/PAU) en España: estructura del examen, cálculo de notas de acceso y admisión, notas de corte, convocatorias y acceso para mayores.

Metadata completa de la skill en [service.yml](../../../skills/educacion-guia/selectividad/service.yml).

## Qué puedes consultar

- **Estructura del examen**: fase obligatoria (4-5 exámenes) y fase voluntaria (hasta 4 materias).
- **Nota de acceso**: fórmula 60% bachillerato + 40% fase obligatoria, sobre 10.
- **Nota de admisión**: nota de acceso + ponderaciones de la fase voluntaria, sobre 14.
- **Ponderaciones**: cómo funcionan los coeficientes 0,1 y 0,2 por materia/grado.
- **Notas de corte**: qué son, factores que las afectan, cifras orientativas, dónde consultarlas.
- **Convocatorias**: ordinaria (junio) y extraordinaria (julio).
- **Diferencias entre CCAA**: denominación, lenguas cooficiales, distrito único.
- **Acceso para mayores**: vías de 25, 40 y 45 años.
- **Preinscripción**: proceso post-Selectividad para solicitar plaza.

**No accesible**: notas de corte en tiempo real de grados/universidades concretos, resultados individuales, datos estadísticos educativos (usar skill `educacion`), información sobre becas (usar skill `becas-mec`).

## Estrategia

Skill de **conocimiento/orientación** sobre el sistema de acceso a la universidad. No accede a APIs de datos. Proporciona información general y orientativa sobre la Selectividad y redirige a skills específicas para consultas fuera de su ámbito.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/educacion-guia/selectividad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/selectividad/` |

### Opción — Skill

```bash
cp -r skills/educacion-guia/selectividad ~/.claude/skills/selectividad
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/educacion-guia/selectividad/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/educacion-guia/selectividad/tests/prompts.md) para pruebas manuales con el agente.
