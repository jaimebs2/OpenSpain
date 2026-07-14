# fiscalidad/modelo-036 — Modelo 036 (Declaración Censal)

Skill de referencia sobre la declaración censal de la AEAT (Modelo 036 y su versión simplificada 037): altas, modificaciones y bajas del censo de empresarios, profesionales y retenedores.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/modelo-036/service.yml).

## Qué puedes consultar

- **Cuándo usar 036 vs 037**: diferencias, supuestos que obligan a usar el 036 completo (ROI, módulos, SII, sociedades, varios locales…).
- **Estructura del modelo por páginas**: qué va en cada una (P1 causas, P4 domicilio, P5 actividades y registros, P6 IVA, P7 IRPF, etc.).
- **Casillas clave por supuesto**: alta inicial (111, 118), modificación (120), baja (150), alta ROI (130 + 582/584), cambio domicilio (122), alta obligaciones (131), cambio régimen IVA/IRPF.
- **Paso a paso por Sede Electrónica AEAT**: ruta exacta, evitar el asistente simplificado.
- **Validación, firma y envío**: cómo rellenar lugar/firma, qué significan las opciones de "Firma en calidad de".
- **Qué pasa después**: plazos de resolución (hasta 3 meses para ROI), posibles requerimientos, silencio positivo.

**No accesible**: presentación real del modelo (requiere certificado digital/Cl@ve), datos censales individuales, histórico de modificaciones, texto legal de la normativa censal (usar `boe`).

## Estrategia

Skill de **conocimiento/orientación**. No accede a APIs. Sirve como hub al que el resto de skills (`fiscalidad-autonomos`, `alta-autonomo`, `crear-empresa`, `fiscalidad-operaciones-intracomunitarias`) apuntan cuando necesitan detalle del censo, para evitar duplicar contenido.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/modelo-036/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-modelo-036/` |

### Opción — Skill

```bash
cp -r skills/fiscalidad/modelo-036 ~/.claude/skills/fiscalidad-modelo-036
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/modelo-036/tests/smoke.sh
```

Verifica que las páginas informativas de la AEAT referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/fiscalidad/modelo-036/tests/prompts.md) para pruebas manuales con el agente.
