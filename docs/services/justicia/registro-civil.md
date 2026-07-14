# justicia/registro-civil — Registro Civil

Guía completa sobre el Registro Civil en España: certificados, últimas voluntades, antecedentes penales, fe de vida y el nuevo sistema digitalizado.

Metadata completa de la skill en [service.yml](../../../skills/justicia/registro-civil/service.yml).

## Qué puedes consultar

- **Certificados**: nacimiento, matrimonio, defunción (literal y extracto plurilingüe).
- **Cómo solicitarlos**: online (sede electrónica), presencial, por correo. Gratuitos.
- **Últimas voluntades**: certificado del RGAUV (desde 15 días hábiles tras fallecimiento).
- **Antecedentes penales**: certificado del Registro Central de Penados (3,86 euros).
- **Delitos sexuales**: certificado para trabajo con menores (gratuito).
- **Fe de vida**: ante notario, Registro Civil o consulado.
- **Libro de familia**: suprimido desde abril 2021, sustituido por certificados individuales.
- **Nuevo sistema**: Ley 20/2011, Registro Civil digitalizado, folio personal.
- **Inscripciones habituales**: nacimiento, matrimonio, defunción (plazos y documentación).

**No accesible**: emisión real de certificados (requiere sede electrónica con identificación), datos de inscripciones concretas, tramitación de herencias (usar skill `herencias`), trámites de extranjería (usar skill `extranjeria-nacionalidad`).

## Estrategia

Skill de **conocimiento/orientación** sobre el Registro Civil y certificados del Ministerio de Justicia. No accede a APIs de datos. Redirige a skills hermanas para herencias, testamentos y extranjería. Enlaza a la sede electrónica y web del Ministerio de Justicia.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/justicia/registro-civil/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/registro-civil/` |

### Opción — Skill

```bash
cp -r skills/justicia/registro-civil ~/.claude/skills/registro-civil
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/justicia/registro-civil/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/justicia/registro-civil/tests/prompts.md) para pruebas manuales con el agente.
