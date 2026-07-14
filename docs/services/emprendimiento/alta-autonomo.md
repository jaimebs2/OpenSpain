# emprendimiento/alta-autonomo — Tutorial: Hacerse Autónomo Paso a Paso

Tutorial práctico y cronológico para darse de alta como trabajador autónomo (persona física) en España: identificación digital, alta en Hacienda, alta en Seguridad Social, tarifa plana, primeras obligaciones y coste orientativo.

Metadata completa de la skill en [service.yml](../../../skills/emprendimiento/alta-autonomo/service.yml).

## Qué puedes consultar

- **Proceso paso a paso**: orden cronológico de trámites para hacerse autónomo.
- **Identificación digital**: Cl@ve y certificado digital FNMT como requisito previo.
- **Alta en Hacienda**: Modelo 036/037, epígrafe IAE, régimen fiscal.
- **Alta en Seguridad Social**: RETA vía Import@ss, tarifa plana, mutua, base de cotización.
- **Ayuntamiento**: cuándo es necesaria declaración responsable o licencia de actividad.
- **Primeras obligaciones**: facturación, libros registro, impuestos trimestrales.
- **Checklist completo**: lista de verificación de todos los pasos.
- **Coste del primer año**: estimación orientativa con y sin tarifa plana.
- **Capitalización del desempleo**: pago único del SEPE para emprender.

**No accesible**: realización de trámites de alta, datos personales del contribuyente, obligaciones fiscales continuas en detalle (usar skill `fiscalidad-autonomos`), cuotas de SS detalladas (usar skill `seguridad-social`), creación de empresas (usar skill `crear-empresa`).

## Estrategia

Skill de **conocimiento/orientación** tipo tutorial. No accede a APIs de datos. Proporciona una guía cronológica para nuevos autónomos y redirige a skills específicas para temas de detalle. Puede enlazar a páginas informativas oficiales de la AEAT, Import@ss, Cl@ve y FNMT.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/emprendimiento/alta-autonomo/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/alta-autonomo/` |

### Opción — Skill

```bash
cp -r skills/emprendimiento/alta-autonomo ~/.claude/skills/alta-autonomo
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/emprendimiento/alta-autonomo/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/emprendimiento/alta-autonomo/tests/prompts.md) para pruebas manuales con el agente.
