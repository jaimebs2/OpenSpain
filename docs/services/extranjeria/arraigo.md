# extranjeria/arraigo — Arraigo (Social, Laboral, Familiar, Formación)

Guía completa sobre las vías de arraigo para la regularización de extranjeros en situación irregular en España: arraigo social, laboral, familiar y para la formación.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/arraigo/service.yml).

## Qué puedes consultar

- **Arraigo social**: 3 años de permanencia + contrato de trabajo o medios económicos + informe de inserción social.
- **Arraigo laboral**: 2 años de permanencia + relación laboral demostrable (mín. 6 meses).
- **Arraigo familiar**: progenitor de menor español o hijo de ciudadano español (sin mínimo de permanencia).
- **Arraigo para la formación**: 2 años de permanencia + compromiso de formación reglada.
- **Informe de inserción social**: qué es, cómo obtenerlo, qué valora.
- **Procedimiento**: dónde y cómo presentar la solicitud, documentación, plazos.
- **Acreditación de permanencia**: empadronamiento, facturas, otros documentos.

**No accesible**: tramitación real del arraigo (requiere Oficina de Extranjería), informes de inserción social (se solicitan en servicios sociales), detalle sobre permisos de residencia (usar skill `extranjeria-residencia`), permisos de trabajo (usar skill `extranjeria-trabajo`).

## Estrategia

Skill de **conocimiento/orientación** relevante para inmigrantes en situación irregular que buscan vías de regularización. No accede a APIs de datos. Redirige a skills de residencia y trabajo para la continuidad tras el arraigo.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/arraigo/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-arraigo/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/arraigo ~/.claude/skills/extranjeria-arraigo
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/arraigo/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/arraigo/tests/prompts.md) para pruebas manuales con el agente.
