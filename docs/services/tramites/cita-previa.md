# tramites/cita-previa — Cita Previa con la Administración

Meta-skill informativa que recopila las URLs y consejos para pedir cita previa con los principales organismos de la Administración española.

Metadata completa de la skill en [service.yml](../../../skills/tramites/cita-previa/service.yml).

## Qué puedes consultar

- **AEAT (Hacienda)**: cita para trámites tributarios y Renta.
- **Seguridad Social (INSS/TGSS)**: cita para prestaciones, afiliación, vida laboral.
- **SEPE (desempleo)**: cita para prestaciones y demanda de empleo.
- **DGT**: cita para trámites de tráfico y permisos.
- **DNI/Pasaporte**: cita para obtención y renovación.
- **Extranjería**: cita para NIE, TIE, autorizaciones de residencia.
- **Registro Civil**: cita para certificados e inscripciones.
- **Otros**: Catastro, Correos, ayuntamientos.
- **Consejos**: horarios para conseguir cita, estrategias, identificación electrónica.

**No accesible**: obtención real de citas (cada sistema requiere acceso directo), disponibilidad en tiempo real, detalle de cada trámite (usar la skill del organismo correspondiente).

## Estrategia

**Meta-skill de conocimiento** que agrupa URLs de cita previa de distintos organismos. No automatiza la obtención de citas. Redirige a las skills específicas para detalle sobre cada trámite (`seguridad-social`, `extranjeria-nie`, etc.).

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/tramites/cita-previa/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/cita-previa/` |

### Opción — Skill

```bash
cp -r skills/tramites/cita-previa ~/.claude/skills/cita-previa
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/tramites/cita-previa/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/tramites/cita-previa/tests/prompts.md) para pruebas manuales con el agente.
