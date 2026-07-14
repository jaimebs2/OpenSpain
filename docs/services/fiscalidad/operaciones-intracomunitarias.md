# fiscalidad/operaciones-intracomunitarias — Operaciones Intracomunitarias

Guía sobre la operativa fiscal de compras y ventas entre un autónomo o empresa españoles y contrapartes establecidas en otros Estados miembros de la UE: ROI/VIES, inversión del sujeto pasivo (reverse charge), Modelo 303 (autoimputación) y Modelo 349 (informativa).

Metadata completa de la skill en [service.yml](../../../skills/fiscalidad/operaciones-intracomunitarias/service.yml).

## Qué puedes consultar

- **ROI (Registro de Operadores Intracomunitarios) y VIES**: qué son, cómo verificar el NIF-IVA, qué hacer si no estás en VIES.
- **Inversión del sujeto pasivo (reverse charge)**: concepto, condiciones, referencia al artículo 196 de la Directiva 2006/112/CE.
- **Modelo 303 — autoimputación**: casillas 10–11 (adquisiciones intracomunitarias de bienes), 12–13 (servicios y otros reverse charge), 28–29 (IVA deducible correspondiente). Ejemplo numérico.
- **Modelo 349 — declaración informativa**: periodicidad (trimestral/mensual), plazos, claves por tipo de operación (A, E, I, S, T), qué contiene cada línea.
- **Supuestos prácticos**: compra de SaaS a Anthropic/AWS/Stripe/Google Cloud, ventas de servicios a empresas UE, adquisición de bienes UE.
- **Factura UE sin IVA sin estar en ROI**: cómo regularizar.

**No accesible**: presentación real de modelos (requiere certificado digital/Cl@ve), datos fiscales individuales, régimen OSS para ventas B2C a consumidor final UE, importaciones/exportaciones fuera UE (DUA). Para el trámite concreto de alta en ROI vía Modelo 036, usar `fiscalidad/modelo-036`.

## Estrategia

Skill de **conocimiento/orientación**. No accede a APIs. Cubre la operativa trimestral intracomunitaria; el trámite de alta en ROI está en la skill `fiscalidad/modelo-036`, a la que se enlaza para evitar duplicar contenido.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/fiscalidad/operaciones-intracomunitarias/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/fiscalidad-operaciones-intracomunitarias/` |

### Opción — Skill

```bash
cp -r skills/fiscalidad/operaciones-intracomunitarias ~/.claude/skills/fiscalidad-operaciones-intracomunitarias
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/fiscalidad/operaciones-intracomunitarias/tests/smoke.sh
```

Verifica que las páginas oficiales de la AEAT y de VIES referenciadas responden correctamente. Ver también [tests/prompts.md](../../../skills/fiscalidad/operaciones-intracomunitarias/tests/prompts.md) para pruebas manuales con el agente.
