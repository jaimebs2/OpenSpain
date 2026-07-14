# justicia/testamento — Testamento

Guía completa sobre testamentos en España: tipos, legítimas, tres tercios, coste, registro de últimas voluntades y diferencias del derecho foral.

Metadata completa de la skill en [service.yml](../../../skills/justicia/testamento/service.yml).

## Qué puedes consultar

- **Tipos de testamento**: abierto ante notario, cerrado, ológrafo, especiales.
- **Sistema de legítimas**: tres tercios (legítima estricta, mejora, libre disposición).
- **Herederos forzosos**: hijos, ascendientes, cónyuge viudo y sus cuotas.
- **Desheredación**: causas tasadas y procedimiento.
- **Derecho foral**: diferencias en Cataluña, Aragón, Navarra, País Vasco, Baleares y Galicia.
- **Coste**: arancel notarial orientativo (40-60 euros).
- **Otorgamiento**: pasos, documentación, modificación y revocación.
- **RGAUV**: Registro General de Actos de Última Voluntad, cómo obtener el certificado.
- **Parejas de hecho**: situación sucesoria.

**No accesible**: contenido de testamentos concretos, redacción de testamentos (requiere notario), asesoramiento individualizado, trámites de herencia (usar skill `herencias`), Impuesto de Sucesiones (usar skill `fiscalidad-sucesiones-donaciones`).

## Estrategia

Skill de **conocimiento/orientación** sobre derecho testamentario. No accede a APIs de datos. Redirige a skills hermanas para herencias, fiscalidad sucesoria y registro civil. Enlaza a páginas oficiales del Consejo General del Notariado y Ministerio de Justicia.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/justicia/testamento/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/testamento/` |

### Opción — Skill

```bash
cp -r skills/justicia/testamento ~/.claude/skills/testamento
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/justicia/testamento/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/justicia/testamento/tests/prompts.md) para pruebas manuales con el agente.
