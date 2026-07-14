# extranjeria/nacionalidad — Nacionalidad Española

Guía completa sobre cómo obtener la nacionalidad española: vías de acceso, requisitos, pruebas CCSE y DELE A2, doble nacionalidad, Ley de Memoria Democrática, procedimiento y plazos.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/nacionalidad/service.yml).

## Qué puedes consultar

- **Vías de acceso**: por residencia (10, 5, 2, 1 año), carta de naturaleza, opción, Memoria Democrática.
- **Requisitos**: residencia legal continuada, buena conducta cívica, integración (CCSE + DELE A2).
- **Pruebas**: CCSE (contenido, puntuación, preparación), DELE A2 (exenciones).
- **Procedimiento**: paso a paso, solicitud electrónica, documentación, jura o promesa.
- **Doble nacionalidad**: países con convenio, renuncia.
- **Plazos**: legales y reales, seguimiento de expediente.
- **Menores**: nacidos en España de padres extranjeros, hijos de español.

**No accesible**: tramitación real (requiere Sede Electrónica del Ministerio de Justicia), consulta de expedientes individuales, detalle sobre permisos de residencia (usar skill `extranjeria-residencia`), cursos del Instituto Cervantes (usar skill `instituto-cervantes`).

## Estrategia

Skill de **conocimiento/orientación** de altísima demanda, especialmente para la población iberoamericana. No accede a APIs de datos. Redirige al Instituto Cervantes para las pruebas CCSE y DELE.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/nacionalidad/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-nacionalidad/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/nacionalidad ~/.claude/skills/extranjeria-nacionalidad
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/nacionalidad/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/nacionalidad/tests/prompts.md) para pruebas manuales con el agente.
