# identidad-digital/dnie — DNI Electrónico

Guía completa del DNI electrónico español: chip, certificados, PIN, lectores, software, uso para identificación y firma, y comparativa con otros medios de identificación digital.

Metadata completa de la skill en [service.yml](../../../skills/identidad-digital/dnie/service.yml).

## Qué puedes consultar

- **Chip y certificados**: qué contiene el chip del DNI y para qué sirven los certificados de autenticación y firma.
- **PIN**: cómo activarlo, cambiarlo y qué hacer si se olvida o bloquea.
- **Lectores**: qué lector de tarjetas comprar, precios orientativos, compatibilidad.
- **Software**: módulos criptográficos necesarios por sistema operativo y navegador.
- **Uso online**: cómo identificarse en sedes electrónicas y firmar documentos.
- **NFC**: uso del DNIe 3.0 con smartphone.
- **Renovación**: del DNI y de los certificados del chip.
- **Limitaciones**: adopción, hardware, configuración, alternativas.
- **Comparativa**: DNIe vs. certificado FNMT vs. Cl@ve.

**No accesible**: lectura real de los certificados (requiere lector + PIN), datos personales del titular, información detallada sobre el certificado FNMT (skill `certificado-digital`), Cl@ve (skill `clave`) o AutoFirma (skill `autofirma`).

## Estrategia

Skill de **conocimiento/orientación** sobre el DNI electrónico. No accede a APIs ni lee chips. Puede recomendar Cl@ve o certificado FNMT como alternativas más prácticas cuando el usuario no quiera comprar hardware.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/identidad-digital/dnie/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/dnie/` |

### Opción — Skill

```bash
cp -r skills/identidad-digital/dnie ~/.claude/skills/dnie
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/identidad-digital/dnie/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/identidad-digital/dnie/tests/prompts.md) para pruebas manuales con el agente.
