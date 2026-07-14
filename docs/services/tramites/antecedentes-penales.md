# tramites/antecedentes-penales — Certificado de Antecedentes Penales

Guía completa sobre el certificado de antecedentes penales en España: solicitud online y presencial, certificado de delitos sexuales para trabajar con menores, cancelación de antecedentes y particularidades para extranjeros.

Metadata completa de la skill en [service.yml](../../../skills/tramites/antecedentes-penales/service.yml).

## Qué puedes consultar

- **Qué es**: documento del Registro Central de Penados que certifica si hay condenas.
- **Para qué se pide**: empleo, oposiciones, adopción, nacionalidad, visados.
- **Solicitud online**: sede electrónica del Ministerio de Justicia, inmediato y gratuito.
- **Solicitud presencial**: oficinas del Ministerio de Justicia, 3-5 días hábiles.
- **Delitos sexuales**: certificado obligatorio para trabajar con menores.
- **Cancelación**: requisitos, plazos según gravedad de la pena.
- **Extranjeros**: certificado español + del país de origen (apostillado y traducido).

**No accesible**: emisión real de certificados (requiere identificación), datos del Registro de Penados, asesoramiento jurídico penal, trámites de nacionalidad detallados (usar skill `extranjeria-nacionalidad`).

## Estrategia

Skill de **conocimiento/orientación** sobre un trámite del Ministerio de Justicia. No accede a APIs de datos. Redirige a `apostilla` y `legalizacion-documentos` para documentos extranjeros, y a `extranjeria-nacionalidad` para el proceso de nacionalidad.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/tramites/antecedentes-penales/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/antecedentes-penales/` |

### Opción — Skill

```bash
cp -r skills/tramites/antecedentes-penales ~/.claude/skills/antecedentes-penales
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/tramites/antecedentes-penales/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/tramites/antecedentes-penales/tests/prompts.md) para pruebas manuales con el agente.
