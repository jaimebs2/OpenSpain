# justicia/proteccion-datos — Protección de Datos (AEPD)

Guía completa sobre protección de datos personales en España: AEPD, RGPD, derechos del ciudadano, reclamaciones, obligaciones de empresas y herramientas gratuitas.

Metadata completa de la skill en [service.yml](../../../skills/justicia/proteccion-datos/service.yml).

## Qué puedes consultar

- **Marco normativo**: RGPD (UE 2016/679) y LOPDGDD (LO 3/2018).
- **La AEPD**: funciones, canal prioritario, sede electrónica.
- **Derechos ARCO-POL**: acceso, rectificación, supresión (olvido), oposición, portabilidad, limitación.
- **Cómo ejercerlos**: solicitud al responsable, plazo de 1 mes, reclamación ante AEPD.
- **Obligaciones empresas/autónomos**: base jurídica, registro de actividades, consentimiento, DPO, evaluación de impacto, brechas (72 h).
- **Herramientas AEPD**: Facilita RGPD, Facilita Emprende, GESTIONA-EIPD, COMUNICA-Brecha.
- **Sanciones**: hasta 20 M euros o 4 % facturación global.
- **Canal prioritario**: retirada urgente de contenido sexual, violento o de acoso.

**No accesible**: tramitación real de reclamaciones (requiere sede AEPD), expedientes individuales, asesoramiento jurídico personalizado, auditoría de cumplimiento, redacción de políticas de privacidad.

## Estrategia

Skill de **conocimiento/orientación** relevante tanto para ciudadanos (ejercer derechos) como para empresas (cumplimiento). No accede a APIs de datos. Redirige a herramientas de la AEPD para el cumplimiento y a skills hermanas para temas fiscales, mercantiles y legislativos. Enlaza a la web y sede electrónica de la AEPD.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/justicia/proteccion-datos/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/proteccion-datos/` |

### Opción — Skill

```bash
cp -r skills/justicia/proteccion-datos ~/.claude/skills/proteccion-datos
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/justicia/proteccion-datos/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/justicia/proteccion-datos/tests/prompts.md) para pruebas manuales con el agente.
