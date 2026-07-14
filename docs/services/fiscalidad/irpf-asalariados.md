# fiscalidad/irpf-asalariados -- IRPF para Asalariados (Declaracion de la Renta)

Guia completa del IRPF para trabajadores asalariados en Espana: obligacion de declarar, tramos, borrador, Renta Web, deducciones, dos pagadores y plazos de la campana.

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/irpf-asalariados/service.yml).

## Que puedes consultar

- **Obligacion de declarar**: limites de 22.000 EUR (un pagador) y 15.876 EUR (dos pagadores).
- **Tramos del IRPF**: escala estatal progresiva y orientacion sobre la autonomica.
- **Tipos de rendimientos**: trabajo, capital mobiliario/inmobiliario, ganancias patrimoniales.
- **Minimo personal y familiar**: importes por contribuyente, descendientes, ascendientes, discapacidad.
- **Deducciones**: vivienda (regimen transitorio), maternidad, familia numerosa, planes de pensiones, donativos.
- **Borrador y Renta Web**: como acceder, revisar y presentar la declaracion.
- **Dos pagadores**: por que sube la retencion y como evitar sorpresas.
- **Plazos**: campana de Renta (abril-junio), fraccionamiento del pago.

**No accesible**: presentacion real de declaraciones, datos fiscales individuales, escalas autonomicas detalladas por CCAA, pagos fraccionados de autonomos (usar `fiscalidad-irpf-autonomos`).

## Estrategia

Skill de **conocimiento/orientacion** sobre el IRPF del asalariado. No accede a APIs. Complementa `fiscalidad-irpf-autonomos` (pagos trimestrales) y `fiscalidad-autonomos` (vision general del autonomo).

## Implementaciones disponibles

| Implementacion | Cuando usar | Instalacion |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/irpf-asalariados/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-irpf-asalariados/` |

### Opcion -- Skill

```bash
cp -r skills/fiscalidad/irpf-asalariados ~/.claude/skills/fiscalidad-irpf-asalariados
```

Skill puramente informativa -- sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/irpf-asalariados/tests/smoke.sh
```

Verifica que las paginas oficiales referenciadas en la skill responden correctamente. Ver tambien [tests/prompts.md](../../../skills/fiscalidad/irpf-asalariados/tests/prompts.md) para pruebas manuales con el agente.
