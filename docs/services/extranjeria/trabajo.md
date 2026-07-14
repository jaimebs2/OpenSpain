# extranjeria/trabajo — Permisos de Trabajo

Guía completa sobre las autorizaciones de trabajo para extranjeros en España: cuenta ajena, cuenta propia, CODC, Tarjeta Azul UE, trabajo de temporada y modificación de situación.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/trabajo/service.yml).

## Qué puedes consultar

- **Trabajo por cuenta ajena**: requisitos del trabajador y empleador, procedimiento, duración.
- **Situación Nacional de Empleo y CODC**: qué son, cómo funcionan, ocupaciones habituales.
- **Trabajo por cuenta propia**: autónomo extranjero, plan de negocio, requisitos.
- **Tarjeta Azul UE**: profesionales altamente cualificados, requisitos, ventajas.
- **Trabajo de temporada**: gestión colectiva, sectores habituales.
- **Modificación de situación**: de estudiante a trabajo, búsqueda de empleo tras estudios.
- **Compatibilidad**: qué permisos de residencia permiten trabajar.

**No accesible**: tramitación real de permisos, CODC actualizado en tiempo real, detalle sobre tipos de residencia (usar skill `extranjeria-residencia`), contratos de trabajo (usar skill `laboral-contratos`), alta en Seguridad Social (usar skill `seguridad-social`).

## Estrategia

Skill de **conocimiento/orientación** centrada en los permisos de trabajo para extranjeros. Complementa `extranjeria-residencia` con el enfoque laboral. Redirige a skills de empleo y Seguridad Social para temas no específicos de extranjería.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/trabajo/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-trabajo/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/trabajo ~/.claude/skills/extranjeria-trabajo
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/trabajo/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/trabajo/tests/prompts.md) para pruebas manuales con el agente.
