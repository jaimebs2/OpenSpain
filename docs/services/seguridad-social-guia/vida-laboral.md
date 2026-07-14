# seguridad-social-guia/vida-laboral — Vida Laboral e Import@ss

Guía práctica sobre el informe de vida laboral y el portal Import@ss de la Seguridad Social: qué es, qué contiene, para qué sirve, cómo obtenerlo y qué otros trámites permite Import@ss.

Metadata completa de la skill en [service.yml](../../../skills/seguridad-social-guia/vida-laboral/service.yml).

## Qué puedes consultar

- **Vida laboral**: qué es, qué contiene (periodos de alta/baja, empresas, régimen, días cotizados) y qué NO contiene (salarios, bases).
- **Para qué sirve**: jubilación, empleo, hipoteca, oposiciones, extranjería, etc.
- **Cómo obtenerla**: Import@ss (web/app), sede electrónica, SMS, CAISS presencial, teléfono.
- **Import@ss**: qué es, URL, todos los trámites disponibles (simulador de pensión, bases, prestaciones, alta autónomos...).
- **Informe de bases de cotización**: distinto de la vida laboral, cómo obtenerlo.
- **Certificado de estar al corriente**: para licitaciones, subvenciones, etc.
- **Número de afiliación (NAF)**: qué es, formato, cómo consultarlo.
- **Periodos en el extranjero**: UE (Reglamentos Comunitarios), convenios bilaterales.
- **Rectificación de errores**: cómo corregir datos incorrectos.

**No accesible**: datos personales de vida laboral (requiere identificación), bases de cotización individuales (requiere Import@ss), cálculo de pensión (usar skill `jubilacion`), detalle de cotizaciones (usar skill `cotizaciones`).

## Estrategia

Skill de **conocimiento/orientación** breve y práctica. La vida laboral es uno de los documentos más solicitados. No accede a APIs de datos. Redirige a skills específicas para jubilación, cotizaciones y datos estadísticos.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/seguridad-social-guia/vida-laboral/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/vida-laboral/` |

### Opción — Skill

```bash
cp -r skills/seguridad-social-guia/vida-laboral ~/.claude/skills/vida-laboral
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/seguridad-social-guia/vida-laboral/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/seguridad-social-guia/vida-laboral/tests/prompts.md) para pruebas manuales con el agente.
