# 0004 — Separación knowledge plane / data plane / tools deterministas N4

- **Estado**: aceptado
- **Fecha**: 2026-05-19
- **Decisión nuclear vinculada**: separación de planos por naturaleza de artefacto y forma de distribución

## Contexto

El repo mezcla hoy en un único plano (`openspain/skills/`) tres tipos de artefacto cualitativamente distintos:

1. **Skills `knowledge`** (64): markdown puro con orientación procedimental. Datos volátiles a veces embebidos en tablas markdown.
2. **Skills con API real** (33): delegan a endpoints públicos. Algunos con clave hospedable, otros no.
3. **Lógica determinista de razonamiento** (dispersa en secciones procedimentales de skills `knowledge`): cálculos de IRPF, validación de requisitos, mapeo de epígrafes IAE. Hoy vive como markdown que el agente reinterpreta cada vez.

Mantener los tres en un único plano tiene tres problemas:

- **Distribución diferente**: el conocimiento puede viajar dentro del contexto del agente (markdown); los datos vivos exigen runtime; las tools deterministas exigen código verificable.
- **Naturaleza técnica diferente**: el knowledge plane es texto que el agente lee; el data plane es proxy con caché y procedencia; el tools plane es cálculo determinista con tests de casos límite.
- **Ciclo de mantenimiento diferente**: el conocimiento se actualiza contra su fuente; los datos dependen de la disponibilidad de la API; las tools evolucionan con la lógica de negocio.

## Decisión

Separar explícitamente **tres planos** en la arquitectura, alineados con la tipología de [ADR-0001](0001-tipologia-agent-accessibility.md):

1. **Data plane** (Niveles 1–2): MCPs Python por dominio, en `mcps/<dominio>/`. Cada uno usa caché declarativa (TTL en `service.yml`) y procedencia plana (`source_url`, `fetched_at`, `cache_hit`, `license`).
2. **Tools plane** (Nivel 4): MCPs Python por vertical, en `tools/<vertical>-tools/`. Exponen tools deterministas (cálculo, validación, propuesta). Importan `openspain-core` y, opcionalmente, datos del data plane.
3. **Knowledge plane** (Nivel 3): las skills informativas en `openspain/skills/<nombre>/`. **No son tools MCP**. Se exponen como MCP Resources desde el router (cuando exista), o se distribuyen standalone vía `npx skills add`.

Esta separación se refleja en la estructura del repo: directorios distintos, paquetes/binarios distintos, README distintos.

## Consecuencias

**Positivas**
- Cada plano se puede empaquetar y distribuir independientemente (skills portables vs MCPs vs tools).
- El esfuerzo de valor añadido queda localizado en Niveles 3–4 (conocimiento curado y cálculo determinista), no en duplicar el proxy de datos.
- Contribuir al repo es más claro: ¿añades una skill informativa? Va al knowledge plane. ¿Una tool de cálculo? Va al tools plane. ¿Un wrapper de API? Data plane.

**Negativas**
- Tres directorios top-level (`openspain/skills/`, `mcps/`, `tools/`) en lugar de uno solo. Más navegación.
- Casos límite: una skill `knowledge` con sección procedimental puede vivir parcialmente en knowledge plane y parcialmente en tools plane. Se resuelve: la skill informativa permanece donde está; la lógica determinista se extrae a un MCP de tools cuando hay demanda real.

## Alternativas consideradas

- **Un único plano (estado actual)**: descartado por las razones del Contexto.
- **Dos planos (knowledge + everything else)**: probado mentalmente. Pierde la distinción crítica entre data plane (proxy + caché) y tools plane (cálculo determinista), que son arquitecturalmente distintos.
- **Cuatro planos (separar Nivel 0 — web pública — como plano propio)**: rechazado. Nivel 0 vive bien como contenido enlazado desde el knowledge plane; no justifica un plano propio.
