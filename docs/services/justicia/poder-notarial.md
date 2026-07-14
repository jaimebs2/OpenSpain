# justicia/poder-notarial — Poder Notarial

Guía completa sobre poderes notariales en España: tipos, otorgamiento, coste, revocación, poder preventivo y uso internacional.

Metadata completa de la skill en [service.yml](../../../skills/justicia/poder-notarial/service.yml).

## Qué puedes consultar

- **Tipos de poder**: general, especial, para pleitos, preventivo, recíproco entre cónyuges.
- **Cuándo se necesita**: venta de inmueble, gestiones bancarias, representación procesal, trámites administrativos.
- **Cómo se otorga**: requisitos, documentación, proceso ante notario.
- **Coste orientativo**: aranceles según tipo de poder (40-100 euros).
- **Revocación**: escritura de revocación, causas de extinción automática.
- **Poder preventivo**: para incapacidad futura (Ley 8/2021).
- **Uso internacional**: Apostilla de La Haya, legalización diplomática, consulado español.

**No accesible**: otorgamiento real de poderes (requiere presencia ante notario), consulta de poderes vigentes, asesoramiento individualizado, trámites de herencia (usar skill `herencias`).

## Estrategia

Skill de **conocimiento/orientación** sobre poderes notariales. No accede a APIs de datos. Redirige a skills hermanas para herencias, testamentos y trámites de extranjería. Enlaza a la página oficial del Consejo General del Notariado.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/justicia/poder-notarial/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/poder-notarial/` |

### Opción — Skill

```bash
cp -r skills/justicia/poder-notarial ~/.claude/skills/poder-notarial
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/justicia/poder-notarial/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/justicia/poder-notarial/tests/prompts.md) para pruebas manuales con el agente.
