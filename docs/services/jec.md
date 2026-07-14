# jec — Resultados electorales (Ministerio del Interior / JEC)

Acceso a los resultados electorales oficiales de España: Congreso, Senado,
Municipales, Cabildos, Parlamento Europeo y Referéndum. Aunque la Junta
Electoral Central (JEC) organiza los procesos, **los datos los publica el
Ministerio del Interior** en el portal Infoelectoral.

Metadata completa de la skill en [service.yml](../../services/jec/service.yml).

## Qué puedes consultar

- Tipos de convocatoria (Congreso, Senado, Municipales, Cabildos, Europeas, Referéndum)
- Listado histórico de convocatorias por tipo (fechas)
- Descarga de los ZIPs oficiales con los resultados por convocatoria y nivel
  de agregación (Mesa, Municipio, Superior al municipio)
- Datasets electorales autonómicos / municipales indexados en datos.gob.es

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/jec/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/jec/` |

### Skill (única implementación)

```bash
cp -r services/jec ~/.claude/skills/jec
```

La skill usa `WebFetch` directamente contra:

- La API JSON interna de Infoelectoral (`/min/...`, autenticación HTTP Basic
  con credenciales públicas embebidas en el JS del portal).
- Las URLs estáticas de los ZIPs (`/estaticos/docxl/apliextr/...`, sin auth).
- El catálogo nacional `datos.gob.es` como fallback para datasets de
  elecciones autonómicas / municipales publicados por otros organismos.

## Importante

- Los **resultados electorales nacionales no los publica la JEC** sino el
  Ministerio del Interior. La JEC solo organiza el proceso. El nombre del
  skill (`jec`) es por familiaridad del usuario.
- Los ZIPs contienen CSVs de **ancho fijo** (no separados por comas). Para
  parsearlos hace falta consultar el documento de metodología oficial:
  https://infoelectoral.interior.gob.es/export/sites/default/pdf/metodologia/Metodologia.pdf
