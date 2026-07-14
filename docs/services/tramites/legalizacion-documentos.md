# tramites/legalizacion-documentos — Legalización de Documentos Extranjeros

Guía completa sobre cómo dar validez legal en España a documentos emitidos en el extranjero: legalización, traducciones juradas y ejemplos prácticos.

Metadata completa de la skill en [service.yml](../../../skills/tramites/legalizacion-documentos/service.yml).

## Qué puedes consultar

- **Cuándo legalizar**: inscripciones en Registro Civil, nacionalidad, homologación de títulos, extranjería.
- **Tres vías**: Convenio de La Haya (apostilla), convenios bilaterales (exención), cadena consular completa.
- **Traducciones juradas**: cuándo son necesarias, quién puede hacerlas, excepciones (portugués, formularios UE).
- **Lista de traductores jurados**: del MAEC, por idioma y provincia.
- **Convenios bilaterales**: Atenas, Reglamento UE 2016/1191, La Paz.
- **Ejemplos prácticos**: Colombia (La Haya), Marruecos (cadena consular), Francia (convenio bilateral).
- **Preguntas frecuentes**: coste, caducidad, fotocopias, estados desaparecidos.

**No accesible**: realización de legalizaciones o traducciones, homologación de títulos (proceso educativo), trámites de nacionalidad completos (usar skill `extranjeria-nacionalidad`).

## Estrategia

Skill de **conocimiento/orientación** complementaria a `apostilla` (que cubre la dirección inversa: documentos españoles para el extranjero). Redirige a `extranjeria-nacionalidad` para el proceso de nacionalidad, a `antecedentes-penales` para el certificado de penales y a `apostilla` para documentos españoles que van al exterior.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/tramites/legalizacion-documentos/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/legalizacion-documentos/` |

### Opción — Skill

```bash
cp -r skills/tramites/legalizacion-documentos ~/.claude/skills/legalizacion-documentos
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/tramites/legalizacion-documentos/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/tramites/legalizacion-documentos/tests/prompts.md) para pruebas manuales con el agente.
