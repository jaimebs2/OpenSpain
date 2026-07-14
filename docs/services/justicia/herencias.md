# justicia/herencias — Herencias: Guía Práctica

Guía práctica para tramitar una herencia en España: pasos tras un fallecimiento, con y sin testamento, aceptación, renuncia, escritura de adjudicación, impuestos e inscripción.

Metadata completa de la skill en [service.yml](../../../skills/justicia/herencias/service.yml).

## Qué puedes consultar

- **Pasos tras un fallecimiento**: certificado de defunción, últimas voluntades, copia del testamento, certificado de seguros.
- **Herencia con testamento**: proceso completo hasta la escritura de adjudicación.
- **Herencia sin testamento**: orden de sucesión intestada, declaración de herederos abintestato.
- **Aceptación**: pura y simple, a beneficio de inventario (protege patrimonio personal).
- **Renuncia**: irrevocable, ante notario.
- **Escritura de adjudicación**: contenido, documentación necesaria.
- **Impuestos**: Impuesto de Sucesiones (6 meses), plusvalía municipal, orientación general.
- **Inscripción**: Registro de la Propiedad, Catastro, bancos, vehículos.
- **Plazos clave**: de cada trámite.

**No accesible**: tramitación real de herencias (requiere notario), cálculo del Impuesto de Sucesiones (usar skill `fiscalidad-sucesiones-donaciones`), redacción de testamentos (usar skill `testamento`), datos registrales individuales.

## Estrategia

Skill de **conocimiento/orientación** con enfoque práctico (qué hacer cuando alguien fallece). No accede a APIs de datos. Redirige a skills hermanas para testamentos, fiscalidad sucesoria y registro civil. Enlaza a páginas oficiales del Notariado, Registradores y Ministerio de Justicia.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/justicia/herencias/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/herencias/` |

### Opción — Skill

```bash
cp -r skills/justicia/herencias ~/.claude/skills/herencias
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/justicia/herencias/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/justicia/herencias/tests/prompts.md) para pruebas manuales con el agente.
