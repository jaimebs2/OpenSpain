# identidad-digital/clave — Sistema Cl@ve

Guía completa del sistema Cl@ve de identificación electrónica del Gobierno de España: modalidades, registro, activación, uso y comparativa con otros medios de identificación.

Metadata completa de la skill en [service.yml](../../../skills/identidad-digital/clave/service.yml).

## Qué puedes consultar

- **Modalidades**: diferencias entre Cl@ve PIN, Cl@ve Permanente y Cl@ve Firma.
- **Registro**: proceso completo (presencial, videollamada, con certificado digital).
- **App Cl@ve**: instalación, activación y uso en iOS y Android.
- **Gestión de contraseña**: cambio, restablecimiento, caducidad.
- **Trámites disponibles**: qué organismos y servicios aceptan cada modalidad.
- **Problemas frecuentes**: SMS no llega, contraseña no funciona, app no se activa.
- **Comparativa**: diferencias con certificado FNMT y DNI electrónico.

**No accesible**: gestión real de la cuenta Cl@ve (requiere portal oficial), datos personales del ciudadano, trámites de CC.AA. no adheridas, información detallada sobre el certificado FNMT (skill `certificado-digital`) o DNIe (skill `dnie`).

## Estrategia

Skill de **conocimiento/orientación** que cubre el sistema Cl@ve de extremo a extremo. No accede a APIs ni gestiona cuentas. Redirige a skills relacionadas (`certificado-digital`, `dnie`, `autofirma`) para otros medios de identificación y firma.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/identidad-digital/clave/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/clave/` |

### Opción — Skill

```bash
cp -r skills/identidad-digital/clave ~/.claude/skills/clave
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/identidad-digital/clave/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/identidad-digital/clave/tests/prompts.md) para pruebas manuales con el agente.
