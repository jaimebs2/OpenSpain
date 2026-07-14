# tramites/tarjeta-sanitaria-europea — Tarjeta Sanitaria Europea (TSE)

Guía completa sobre la Tarjeta Sanitaria Europea: cobertura, solicitud, validez, CPS y diferencias con seguro de viaje privado.

Metadata completa de la skill en [service.yml](../../../skills/tramites/tarjeta-sanitaria-europea/service.yml).

## Qué puedes consultar

- **Qué es la TSE**: documento que da derecho a asistencia sanitaria pública en UE/EEE/Suiza.
- **Cobertura**: asistencia pública necesaria, urgencias, enfermedades crónicas, embarazo.
- **No cubre**: asistencia privada, repatriación, viaje con finalidad médica.
- **Solicitud**: sede electrónica de la Seguridad Social, Import@ss, teléfono, presencial.
- **Validez**: 2 años, renovable.
- **CPS**: Certificado Provisional Sustitutorio para viajes inminentes (90 días, inmediato).
- **TSE vs. seguro de viaje**: comparativa detallada.
- **Quién tiene derecho**: trabajadores, pensionistas, beneficiarios, desempleados con prestación.
- **Sin TSE en Europa**: reembolso de gastos al volver a España.

**No accesible**: solicitud real de la TSE (requiere identificación), estado de solicitudes, sistema sanitario español (usar skill `sanidad`), cotizaciones (usar skill `seguridad-social`).

## Estrategia

Skill de **conocimiento/orientación** estacional (vacaciones). No accede a APIs de datos. Redirige a `sanidad` para el sistema sanitario general, a `seguridad-social` para cotizaciones y prestaciones, y a `cita-previa` para citas con la Seguridad Social.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/tramites/tarjeta-sanitaria-europea/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/tarjeta-sanitaria-europea/` |

### Opción — Skill

```bash
cp -r skills/tramites/tarjeta-sanitaria-europea ~/.claude/skills/tarjeta-sanitaria-europea
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/tramites/tarjeta-sanitaria-europea/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/tramites/tarjeta-sanitaria-europea/tests/prompts.md) para pruebas manuales con el agente.
