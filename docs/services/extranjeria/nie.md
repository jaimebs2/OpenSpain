# extranjeria/nie — NIE (Número de Identidad de Extranjero)

Guía completa sobre el NIE en España: qué es, para qué sirve, diferencia con la TIE, cómo obtenerlo en España o desde el extranjero, documentación necesaria, tasa 790-012, vigencia, renovación y cita previa.

Metadata completa de la skill en [service.yml](../../../skills/extranjeria/nie/service.yml).

## Qué puedes consultar

- **Qué es el NIE**: número de identificación de extranjero, formato, usos.
- **Diferencia NIE vs. TIE**: número vs. documento físico, comunitarios vs. no comunitarios.
- **Cómo obtenerlo**: en España (comisaría con cita previa) o desde el extranjero (consulado).
- **Documentación**: formulario EX-15, pasaporte, foto, justificación del motivo, tasa 790-012.
- **NIE para ciudadanos UE**: certificado de registro, inscripción en Registro Central de Extranjeros.
- **Vigencia y renovación**: el número no caduca; la TIE sí.
- **Cita previa**: cómo pedirla, consejos para ciudades saturadas.
- **Preguntas frecuentes**: trabajar con NIE, NIE sin residencia, etc.

**No accesible**: tramitación real del NIE (requiere presencia física), consulta de expedientes, detalle sobre permisos de residencia (usar skill `extranjeria-residencia`), permisos de trabajo (usar skill `extranjeria-trabajo`), nacionalidad (usar skill `extranjeria-nacionalidad`).

## Estrategia

Skill de **conocimiento/orientación** que funciona como guía del primer trámite para casi cualquier extranjero en España. No accede a APIs de datos. Redirige a skills específicas del bloque de extranjería para trámites relacionados.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/extranjeria/nie/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/extranjeria-nie/` |

### Opción — Skill

```bash
cp -r skills/extranjeria/nie ~/.claude/skills/extranjeria-nie
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/extranjeria/nie/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/extranjeria/nie/tests/prompts.md) para pruebas manuales con el agente.
