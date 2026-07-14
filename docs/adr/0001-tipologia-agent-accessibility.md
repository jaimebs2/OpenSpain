# 0001 — Tipología de niveles `agent_accessibility` en `service.yml`

- **Estado**: aceptado
- **Fecha**: 2026-05-19
- **Decisión nuclear vinculada**: tipología de servicios por accesibilidad para agentes

## Contexto

Antes de esta decisión, `service.yml` distinguía `api.type: knowledge | rest-json | rest-xml | …`. Esa clasificación describe el formato técnico de la fuente, no qué tan accesible es para un agente IA. Como consecuencia, era imposible responder preguntas como:

- "¿Qué skills puede consumir un agente headless sin gestionar credenciales?"
- "¿Qué skills entregan valor añadido (curación/cálculo) más allá de proxy de APIs?"
- "¿Qué skills requieren identidad ciudadana y por tanto no son automatizables hoy?"

Sin esta tipología, decisiones de empaquetado (knowledge plane vs data plane vs tools) y arquitectura (qué MCPs hace falta hospedar) son ambiguas.

## Decisión

Añadir al schema canónico de `service.yml` dos campos nuevos:

- `agent_accessibility: 0 | 1 | 2 | 3 | 4 | 5` — nivel de accesibilidad para un agente IA.
- `auth_owner: none | app | citizen` — quién posee la credencial que da acceso.

Los seis niveles, agrupados en tres familias:

**Familia A — Acceso a datos**
- **0**: Web pública estática (HTTP read libre, sin rate limit, sin API formal). `auth_owner: none`.
- **1**: APIs públicas gratuitas con rate limits, sin clave. `auth_owner: none`.
- **2**: APIs públicas con API key institucional. `auth_owner: app`.

**Familia B — Conocimiento procesado** (valor añadido por OpenSpain, no por la fuente)
- **3**: Conocimiento normativo preprocesado e informativo (las 64 skills `knowledge` actuales).
- **4**: Tools deterministas vía MCP (cálculo, validación, propuesta). No es UI ni copiloto: tools que el agente del cliente llama.

**Familia C — Ejecución autenticada**
- **5**: Trámites ejecutables que requieren identidad ciudadana. `auth_owner: citizen`. **Fuera de scope** del proyecto a corto plazo.

## Consecuencias

**Positivas**
- El catálogo se vuelve consultable por dimensión de accesibilidad ("dame todos los Nivel 1 sin auth").
- La arquitectura federada de MCPs (ADR-0002) se alinea naturalmente con los niveles: MCPs de datos = Niveles 1–2, knowledge plane = Nivel 3, MCPs de tools = Nivel 4.
- El valor diferencial del repo se localiza explícitamente en Niveles 3–4, donde OpenSpain añade valor por encima del simple proxy: conocimiento curado y cálculo determinista.

**Negativas**
- Hay que rellenar el campo en 96 `service.yml`. Trabajo mecánico, no creativo, pero no trivial.
- Algunas skills se solapan entre niveles (ej. una skill que tiene parte informativa Nivel 3 y APIs Nivel 1 hospedadas a la vez). Se resuelve documentando el nivel **dominante** y aclarando ambigüedades en `notes`.

## Alternativas consideradas

- **Mantener sólo `api.type`**: descartada porque mezcla formato técnico con accesibilidad.
- **Una clasificación binaria "auth required: yes/no"**: insuficiente — no distingue entre rate limits sin clave (Catastro), key institucional (AEMET), y identidad ciudadana (Cl@ve), que son problemas operacionales muy distintos.
- **Tres niveles en vez de seis**: probada mentalmente; pierde la distinción crítica entre Nivel 3 (informativo) y Nivel 4 (tools deterministas), que es justamente donde el proyecto añade más valor.
