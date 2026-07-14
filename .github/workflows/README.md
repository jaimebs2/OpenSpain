# GitHub Workflows

Pipelines automáticos del repo. Ver [ROADMAP.md](../../ROADMAP.md) para el plan general.

## Estado actual

| Workflow | Cuándo se ejecuta | Cubre | Estado |
|---|---|---|---|
| [smoke-all.yml](smoke-all.yml) | push/PR a main, lunes 08:00 UTC, manual | Smoke tests de skills (HTTP 200 en URLs documentadas) | Activo |
| [validate-services.yml](validate-services.yml) | push/PR a main | Validación de todos los `service.yml` contra el schema canónico | Activo |
| `refresh-volatile-values.yml` | semanal | SMI, IPREM, bases cotización, calendario fiscal | Futuro (según demanda) |
| `refresh-normativa.yml` | mensual | Cambios estructurales en normativa | Futuro (según demanda) |
| `calendar-check.yml` | mensual | Calendario AEAT | Llegará si es necesario |

## Convenciones

- Cron en UTC.
- Cada workflow lleva comentario explicando la decisión (por qué este cron, por qué este trigger).
- Para workflows con coste (LLM calls, agentes), documentar el coste estimado en el comentario inicial.
- Workflows con efectos en el repo (abrir PR, mergear) exigen revisor humano vía CODEOWNERS — nunca auto-merge.
