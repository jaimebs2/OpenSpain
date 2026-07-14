# tramites/empadronamiento — Padrón Municipal

Guía completa sobre el empadronamiento en España: qué es el padrón municipal, cómo inscribirse, documentación necesaria, diferencia entre volante y certificado, y casos especiales.

Metadata completa de la skill en [service.yml](../../../skills/tramites/empadronamiento/service.yml).

## Qué puedes consultar

- **Qué es el padrón**: registro administrativo obligatorio de vecinos de un municipio.
- **Cómo empadronarse**: presencialmente o por sede electrónica (municipios grandes).
- **Documentación**: DNI/NIE/pasaporte, acreditación del domicilio, autorización del titular.
- **Volante vs. certificado**: diferencia, valor legal, cuándo necesitas cada uno.
- **Cambio de domicilio**: dentro del municipio y entre municipios (baja automática).
- **Empadronamiento sin hogar**: derecho a inscripción con domicilio ficticio.
- **Extranjería**: importancia del padrón para arraigo, nacionalidad, reagrupación.
- **Preguntas frecuentes**: sin contrato, menores, caducidad, doble empadronamiento.

**No accesible**: datos individuales del padrón, inscripción real (trámite municipal), horarios y direcciones de cada ayuntamiento, trámites de extranjería detallados (usar skills `extranjeria-nie`, `extranjeria-nacionalidad`).

## Estrategia

Skill de **conocimiento/orientación** sobre un trámite municipal. No accede a APIs de datos. Redirige a skills de extranjería para trámites de inmigración y a `cita-previa` para citas con la Administración.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/tramites/empadronamiento/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/empadronamiento/` |

### Opción — Skill

```bash
cp -r skills/tramites/empadronamiento ~/.claude/skills/empadronamiento
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/tramites/empadronamiento/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/tramites/empadronamiento/tests/prompts.md) para pruebas manuales con el agente.
