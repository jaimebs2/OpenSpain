# extranjeria/residencia — Permisos de Residencia

Guía completa sobre los permisos de residencia para extranjeros en España: residencia temporal, larga duración, nómada digital, golden visa, emprendedor, no lucrativa, estudios y régimen comunitario.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/residencia/service.yml).

## Qué puedes consultar

- **Tipos de residencia**: temporal, larga duración, inversión, nómada digital, emprendedor, no lucrativa, estudios.
- **Requisitos**: generales y específicos de cada tipo de permiso.
- **Procedimiento**: dónde presentar la solicitud, plazos de resolución, silencio administrativo.
- **Renovación**: plazos, documentación, causas de denegación frecuentes.
- **Ciudadanos UE**: certificado de registro, libre circulación.
- **Visas especiales**: nómada digital (Ley de Startups), golden visa, emprendedor.

**No accesible**: tramitación real de permisos (requiere Oficina de Extranjería o consulado), consulta de expedientes, detalle sobre el NIE (usar skill `extranjeria-nie`), permisos de trabajo (usar skill `extranjeria-trabajo`), nacionalidad (usar skill `extranjeria-nacionalidad`).

## Estrategia

Skill de **conocimiento/orientación** que funciona como mapa general de los permisos de residencia. No accede a APIs de datos. Redirige a skills específicas del bloque de extranjería para trámites relacionados.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/residencia/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-residencia/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/residencia ~/.claude/skills/extranjeria-residencia
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/residencia/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/residencia/tests/prompts.md) para pruebas manuales con el agente.
