# emprendimiento/crear-empresa — Crear una Empresa en España

Guía completa para constituir una empresa en España: formas jurídicas comparadas, proceso paso a paso para la SL, vía telemática CIRCE/PAE, la SL de 1 euro, costes orientativos y obligaciones tras la constitución.

Metadata completa de la skill en [service.yml](../../../skills/emprendimiento/crear-empresa/service.yml).

## Qué puedes consultar

- **Formas jurídicas**: SL, SA, SLU, SLL, cooperativa, comunidad de bienes, sociedad civil — tabla comparativa.
- **SL vs. autónomo**: criterios de decisión (responsabilidad, fiscalidad, coste, administración).
- **Constitución de SL paso a paso**: certificación de nombre, depósito, notario, NIF, Registro Mercantil.
- **CIRCE y PAE**: vía telemática acelerada, ventajas e inconvenientes.
- **SL de 1 euro**: reforma Ley Crea y Crece, restricciones, recomendación.
- **Costes y plazos**: estimación orientativa por concepto y vía.
- **Obligaciones post-constitución**: Impuesto de Sociedades, contabilidad mercantil, cuentas anuales, SS.

**No accesible**: realización de trámites de constitución, consulta de empresas registradas (usar skill `borme`), obligaciones fiscales de sociedades en detalle, alta como autónomo (usar skill `alta-autonomo`), licencias de actividad (usar skill `licencias-actividad`).

## Estrategia

Skill de **conocimiento/orientación** tipo tutorial. No accede a APIs de datos. Proporciona la guía de constitución y redirige a skills específicas para temas relacionados. Puede enlazar a páginas informativas oficiales de CIRCE, Registro Mercantil, Notariado y AEAT.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/emprendimiento/crear-empresa/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/crear-empresa/` |

### Opción — Skill

```bash
cp -r skills/emprendimiento/crear-empresa ~/.claude/skills/crear-empresa
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/emprendimiento/crear-empresa/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/emprendimiento/crear-empresa/tests/prompts.md) para pruebas manuales con el agente.
