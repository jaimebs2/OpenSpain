# identidad-digital/autofirma — AutoFirma y Firma Electrónica

Guía completa de AutoFirma (aplicación de firma electrónica del Gobierno de España) y del marco de firma electrónica en España: tipos de firma, instalación, uso, formatos, validación y problemas frecuentes.

Metadata completa de la skill en [service.yml](../../../skills/identidad-digital/autofirma/service.yml).

## Qué puedes consultar

- **AutoFirma**: qué es, descarga, instalación en Windows/macOS/Linux.
- **Tipos de firma**: simple, avanzada y cualificada según el Reglamento eIDAS.
- **Firma de documentos**: cómo firmar localmente y desde sedes electrónicas.
- **Formatos**: XAdES, CAdES, PAdES, FacturaE.
- **Validación**: cómo verificar firmas con VALIDe.
- **Problemas frecuentes**: Java, permisos macOS, certificados no detectados.
- **Marco legal**: Reglamento eIDAS y Ley 6/2020.
- **Alternativas**: Cl@ve Firma, PortaFirmas, otros clientes de firma.

**No accesible**: firma real de documentos (requiere AutoFirma + certificado), gestión de certificados digitales (skill `certificado-digital`), información sobre DNIe (skill `dnie`), Cl@ve (skill `clave`).

## Estrategia

Skill de **conocimiento/orientación** sobre firma electrónica en España y la herramienta AutoFirma. No firma documentos ni accede a certificados. Redirige a skills relacionadas (`certificado-digital`, `dnie`, `clave`) para la obtención de certificados y otros medios de identificación.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/identidad-digital/autofirma/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/autofirma/` |

### Opción — Skill

```bash
cp -r skills/identidad-digital/autofirma ~/.claude/skills/autofirma
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/identidad-digital/autofirma/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/identidad-digital/autofirma/tests/prompts.md) para pruebas manuales con el agente.
