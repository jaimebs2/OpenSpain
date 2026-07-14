# extranjeria/reagrupacion — Reagrupación Familiar

Guía completa sobre la reagrupación familiar para extranjeros residentes en España: quién puede reagrupar, a qué familiares, requisitos económicos y de vivienda, procedimiento y plazos.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/reagrupacion/service.yml).

## Qué puedes consultar

- **Quién puede reagrupar**: requisitos del reagrupante (residencia renovada, medios, vivienda).
- **Familiares reagrupables**: cónyuge, hijos menores, ascendientes (con condiciones).
- **Requisitos económicos**: referencia al IPREM, documentación.
- **Informe de adecuación de vivienda**: qué es, cómo obtenerlo, qué valora.
- **Procedimiento**: solicitud, visado del familiar, TIE, plazos.
- **Autorización de trabajo**: del cónyuge e hijos reagrupados.
- **Denegación y recursos**: causas frecuentes, recurso de reposición y contencioso.

**No accesible**: tramitación real (requiere Oficina de Extranjería), informes de vivienda (se solicitan en el Ayuntamiento), régimen comunitario (usar skill `extranjeria-familiar-ue`).

## Estrategia

Skill de **conocimiento/orientación** complemento natural del bloque de extranjería. No accede a APIs de datos. Redirige a `extranjeria-familiar-ue` para cónyuges/familiares de ciudadanos UE.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/reagrupacion/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-reagrupacion/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/reagrupacion ~/.claude/skills/extranjeria-reagrupacion
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/reagrupacion/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/reagrupacion/tests/prompts.md) para pruebas manuales con el agente.
