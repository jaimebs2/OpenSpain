# laboral/desempleo — Prestación por desempleo

Guía completa sobre las prestaciones por desempleo en España: contributiva, subsidio, RAI, IMV, capitalización del desempleo, cómo solicitar y obligaciones del perceptor.

Metadata completa de la skill en [service.yml](../../../skills/laboral/desempleo/service.yml).

## Qué puedes consultar

- **Prestación contributiva**: requisitos (360 días), duración (4-24 meses), cuantía (70/50 % base reguladora), topes.
- **Subsidio por desempleo**: modalidades (agotamiento, cotización insuficiente, mayores 52, etc.).
- **RAI**: Renta Activa de Inserción para colectivos con dificultad de inserción.
- **IMV**: Ingreso Mínimo Vital como última red de protección.
- **Capitalización**: pago único para emprender como autónomo o cooperativista.
- **Cómo solicitar**: plazo (15 días hábiles), vías (sede SEPE, cita previa), documentación.
- **Obligaciones del perceptor**: renovar demanda, aceptar empleo adecuado, comunicar cambios.
- **Compatibilidad**: con trabajo a tiempo parcial y por cuenta propia.
- **IPREM**: referencia para cálculo de topes y cuantías.

**No accesible**: estadísticas de paro registrado (usar skill `sepe`), gestión de solicitudes (requiere Cl@ve), tipos de contrato (usar skill `laboral-contratos`), ERE/ERTE (usar skill `laboral-ere-erte`).

## Estrategia

Skill de **conocimiento/orientación** sobre el sistema de protección por desempleo. Las cuantías y topes se actualizan anualmente (vinculados al IPREM y SMI). No accede a APIs de datos ni gestiona solicitudes.

## Implementaciones disponibles

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../../skills/laboral/desempleo/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente compatible con Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/laboral-desempleo/` |

### Opción — Skill

```bash
cp -r skills/laboral/desempleo ~/.claude/skills/laboral-desempleo
```

Skill puramente informativa — sin scripts, sin APIs, sin dependencias.

## Tests

```bash
bash skills/laboral/desempleo/tests/smoke.sh
```

Verifica que las páginas oficiales referenciadas en la skill responden correctamente. Ver también [tests/prompts.md](../../../skills/laboral/desempleo/tests/prompts.md) para pruebas manuales con el agente.
