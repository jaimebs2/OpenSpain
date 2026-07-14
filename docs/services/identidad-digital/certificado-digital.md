# identidad-digital/certificado-digital — Certificado Digital FNMT

Guía completa del certificado digital de persona física emitido por la FNMT-RCM: solicitud, acreditación, instalación, exportación, renovación, revocación, usos en la Administración y resolución de problemas.

Metadata completa de la skill en [service.yml](../../../skills/identidad-digital/certificado-digital/service.yml).

## Qué puedes consultar

- **Solicitud**: proceso paso a paso para obtener el certificado (solicitud online, acreditación, descarga).
- **Instalación**: cómo instalar en diferentes navegadores (Chrome, Firefox, Edge, Safari) y sistemas operativos.
- **Copia de seguridad**: exportar e importar el archivo .pfx/.p12.
- **Renovación**: cuándo y cómo renovar antes del vencimiento.
- **Revocación**: cómo revocar un certificado comprometido.
- **Usos**: trámites con AEAT, Seguridad Social, DGT, justicia, registro civil, catastro, ayuntamientos.
- **Problemas frecuentes**: certificado no aparece, error de descarga, caducidad, compatibilidad.
- **Comparativa**: diferencias con Cl@ve y DNI electrónico.

**No accesible**: gestión real del certificado (requiere sede FNMT), datos personales del titular, estado de validez de un certificado concreto (usar VALIDe), información detallada sobre Cl@ve (skill `clave`) o DNIe (skill `dnie`).

## Estrategia

Skill de **conocimiento/orientación** que cubre el ciclo de vida completo del certificado digital FNMT. No accede a APIs ni gestiona certificados. Redirige a skills relacionadas (`clave`, `dnie`, `autofirma`) para otros medios de identificación y firma electrónica.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/identidad-digital/certificado-digital/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/certificado-digital/` |

### Opción — Skill

```bash
cp -r skills/identidad-digital/certificado-digital ~/.claude/skills/certificado-digital
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/identidad-digital/certificado-digital/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/identidad-digital/certificado-digital/tests/prompts.md) para pruebas manuales con el agente.
