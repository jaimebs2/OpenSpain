# fiscalidad/iva — IVA (Impuesto sobre el Valor Añadido)

Orientación sobre las obligaciones del IVA en España: tipos impositivos, Modelo 303 (autoliquidación trimestral), regímenes especiales, actividades exentas y Modelo 390 (resumen anual).

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/iva/service.yml).

## Qué puedes consultar

- **Tipos de IVA** vigentes: general (21 %), reducido (10 %), superreducido (4 %) y 0 %.
- **Modelo 303**: cálculo (IVA devengado − IVA deducible), casillas principales, plazos de presentación trimestral.
- **Regímenes especiales**: general, simplificado (módulos), recargo de equivalencia, agricultura/ganadería/pesca (REAGYP), criterio de caja.
- **Actividades exentas** de IVA: sanidad, educación, artísticas, seguros, financieros, arrendamiento de vivienda.
- **Modelo 390**: resumen anual, quién está exonerado.
- **Modelo 349**: operaciones intracomunitarias.

**No accesible**: presentación real de declaraciones (requiere certificado digital/Cl@ve), datos fiscales individuales, estadísticas agregadas del IVA (usar skill `aeat`).

## Estrategia

Skill de **conocimiento/orientación**. No accede a APIs de datos. Proporciona guía sobre obligaciones, plazos, cálculo y tipos del IVA basándose en la normativa vigente (Ley 37/1992 del IVA). Puede enlazar a páginas informativas oficiales de la AEAT mediante WebFetch.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/iva/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-iva/` |

### Opción — Skill

```bash
cp -r skills/fiscalidad/iva ~/.claude/skills/fiscalidad-iva
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/iva/tests/smoke.sh
```

Verifica que las páginas informativas de la AEAT referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/fiscalidad/iva/tests/prompts.md) para pruebas manuales con el agente.
