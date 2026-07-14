# extranjeria/asilo — Asilo y Protección Internacional

Guía completa sobre el derecho de asilo y la protección internacional en España: quién puede solicitarla, procedimiento, derechos del solicitante (tarjeta roja), plazos, apátridas y recursos.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/asilo/service.yml).

## Qué puedes consultar

- **Protección internacional**: asilo (estatuto de refugiado) y protección subsidiaria.
- **Quién puede solicitarla**: requisitos, dónde presentar la solicitud.
- **Procedimiento**: solicitud, admisión a trámite, instrucción, resolución (OAR, CIAR).
- **Tarjeta roja**: qué es, derechos que confiere, renovación.
- **Derechos del solicitante**: no devolución, sanidad, educación, trabajo a los 6 meses.
- **Colectivos específicos**: menores no acompañados, víctimas de trata, persecución por género.
- **Apátridas**: estatuto, procedimiento.
- **Recursos**: reposición, contencioso-administrativo, asistencia jurídica.

**No accesible**: tramitación real de la solicitud (requiere presencia física), consulta de expedientes individuales, detalle sobre permisos de residencia (usar skill `extranjeria-residencia`), permisos de trabajo (usar skill `extranjeria-trabajo`).

## Estrategia

Skill de **conocimiento/orientación** sobre un tema sensible y relevante. No accede a APIs de datos. Proporciona información clara y derivaciones a organizaciones de apoyo (ACNUR, CEAR, ACCEM, Cruz Roja).

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/asilo/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-asilo/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/asilo ~/.claude/skills/extranjeria-asilo
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/asilo/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/asilo/tests/prompts.md) para pruebas manuales con el agente.
