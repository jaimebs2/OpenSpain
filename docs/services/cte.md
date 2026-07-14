# cte — Código Técnico de la Edificación

Marco normativo de las exigencias básicas de calidad de los edificios en España (RD 314/2006): ámbito de aplicación, los seis Documentos Básicos con sus PDFs oficiales, municipios en zona de radón (HS6), zonas climáticas (DB-HE) y texto consolidado vía BOE.

Metadata completa de la skill en [service.yml](../../openspain/skills/cte/service.yml).

## Qué puedes consultar

- **Qué es el CTE y su estructura**: Parte I (exigencias básicas) + Parte II (Documentos Básicos).
- **Ámbito de aplicación**: obra nueva, ampliación, reforma, rehabilitación y cambio de uso; criterio de flexibilidad en edificios existentes.
- **Los seis Documentos Básicos** con URL oficial de descarga: DB-SE (seguridad estructural, con partes SE-AE, SE-C, SE-A, SE-F, SE-M), DB-SI (incendio), DB-SUA (utilización y accesibilidad), DB-HS (salubridad), DB-HR (ruido), DB-HE (ahorro de energía).
- **Radón (HS 6)**: municipios afectados en zona I/II según el apéndice B del DB-HS y soluciones exigidas; Guía de rehabilitación frente al radón.
- **Zonas climáticas**: anejo B del DB-HE (provincia + altitud, nomenclatura α/A–E + 1–4).
- **Texto consolidado del RD 314/2006**: vía web del BOE o su API de datos abiertos (identificador `BOE-A-2006-5515`).

**No accesible**: normativa urbanística y licencias municipales (usar skill `emprendimiento-licencias-actividad`), certificado energético de un inmueble concreto (registros autonómicos, sin fuente), verificación de cumplimiento de un proyecto (requiere técnico competente), Código Estructural y RITE en detalle.

## Estrategia

Skill de **conocimiento/orientación** (nivel 3). No accede a APIs propias: enlaza los PDFs oficiales de los Documentos Básicos en `codigotecnico.org` (Ministerio de Vivienda y Agenda Urbana) y reutiliza el patrón de la skill `boe` para el texto consolidado del RD 314/2006. Los textos normativos no tienen propiedad intelectual (art. 13 LPI), por lo que su reutilización comercial es libre.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../openspain/skills/cte/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/cte/` |

### Opción — Skill

```bash
cp -r openspain/skills/cte ~/.claude/skills/cte
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash openspain/skills/cte/tests/smoke.sh
```

Verifica que el portal `codigotecnico.org`, los PDFs de los seis Documentos Básicos, la Guía del radón y el texto consolidado del BOE (web + API) responden correctamente. Ver también [tests/prompts.md](../../openspain/skills/cte/tests/prompts.md) para pruebas manuales con el agente.
