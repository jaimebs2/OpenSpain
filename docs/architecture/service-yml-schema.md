# Schema canónico de `service.yml`

Cada skill bajo `openspain/skills/<nombre>/` (y opcionalmente cada MCP bajo `mcps/<nombre>/` y `tools/<nombre>/`) lleva un fichero `service.yml` que declara su metadata. Este documento es la referencia canónica.

Ver también: [data/schemas/service.schema.json](../../data/schemas/service.schema.json) para la versión machine-readable.

## Campos obligatorios

```yaml
name: fiscalidad-iva                       # kebab-case, coincide con el directorio
display_name: "Fiscalidad — IVA"
description: >
  Descripción legible para humanos en una pasada.
organization: "Agencia Estatal de Administración Tributaria (AEAT)"
agent_accessibility: 3                     # 0–5 (ver ADR-0001)
auth_owner: none                           # none | app | citizen

api:
  type: knowledge                          # knowledge | rest-json | rest-xml | soap | ckan | sparql | thredds-opendap | static-files | xml-static | xlsx-download | datos-gob-es-static | mixed | meta-skill
  auth:
    required: false                        # true sólo si el agente necesita credencial

license:
  data: "Información pública de la AEAT"
  code: MIT
```

## Campos de rellenado incremental

Cuatro campos añadidos al schema canónico en la reestructuración. Su rellenado en las skills existentes es **incremental**: cada skill los completa cuando se toca, no en un bulk-update transversal.

### `agent_accessibility` (obligatorio cuando se toca la skill)

Número entero 0–5 según la tipología de [ADR-0001](../adr/0001-tipologia-agent-accessibility.md):

| Valor | Familia | Definición |
|---|---|---|
| 0 | Datos | Web pública estática (HTTP read libre, sin rate limit, sin API formal) |
| 1 | Datos | APIs públicas gratuitas con rate limits, sin clave |
| 2 | Datos | APIs públicas con API key institucional |
| 3 | Conocimiento | Conocimiento normativo preprocesado e informativo |
| 4 | Conocimiento | Tools deterministas vía MCP (cálculo, validación, propuesta) |
| 5 | Ejecución | Trámites con identidad ciudadana (fuera de scope) |

### `auth_owner` (obligatorio cuando se toca la skill)

`none | app | citizen` — quién posee la credencial que da acceso. Coherente con `agent_accessibility`:

- Niveles 0, 1 → `none`
- Nivel 2 → `app`
- Nivel 5 → `citizen`
- Niveles 3, 4 → `none` (el conocimiento/cálculo no requiere auth de fuente)

### `reuse_commercial` (obligatorio sólo en Nivel 2)

`yes | conditions | no` — auditoría de Terms of Service. Sólo aplica a APIs con clave institucional (Nivel 2). Si `conditions`, añadir campo `reuse_notes` con las condiciones específicas (ej. atribución requerida, prohibición de reventa, etc.) y enlace al ToS.

```yaml
agent_accessibility: 2
auth_owner: app
reuse_commercial: conditions
reuse_notes: "CC-BY 4.0 — uso comercial permitido con atribución a AEMET"
reuse_audited_at: "2026-01-15"             # fecha de la última revisión humana
```

### `cache_ttl_seconds` (opcional, recomendado en Niveles 1–2)

Entero. TTL declarativo que respeta el middleware de caché de cada MCP. Si se omite, el MCP usa su default conservador.

```yaml
cache_ttl_seconds: 86400                   # 1 día
```

Ejemplos orientativos:
- Catastro (datos predial estáticos): `2592000` (30 días)
- BOE sumario diario: `3600` (1 hora)
- INE indicador mensual: `2592000`
- AEMET predicción: `300` (5 minutos)

### `proxy_of` (opcional)

`<nombre-de-otra-skill>` — declara que esta skill es un alias temático de otra fuente. Útil para honestidad de catálogo.

```yaml
name: aeat
proxy_of: datos-gob-es
proxy_notes: "Filtrado temático del catálogo datos.gob.es por tag AEAT"
```

## Bloque `data`

Declarativo de qué información se puede / no se puede obtener.

```yaml
data:
  scope:
    national: true
    autonomic: false
    municipal: false
  accessible:
    - "Tipos de IVA vigentes y a qué productos/servicios aplican"
    - "Plazos del Modelo 303 trimestral"
  not_accessible:
    - "Presentación real de declaraciones (requiere certificado digital — Nivel 5)"
    - "Datos fiscales individuales del contribuyente"
```

## Bloque `implementations`

Declarativo de qué representaciones existen de esta skill en el repo.

```yaml
implementations:
  skill:
    available: true
    path: skill/                           # relativo al directorio de la skill
  mcp:
    available: false                       # si true, path al directorio del MCP
  tool:
    available: false                       # si true, qué tool del tools-plane la cubre
```

## Bloque `links` (obligatorio)

URLs oficiales referenciadas. Se valida que devuelven HTTP 200 en `tests/smoke.sh`.

```yaml
links:
  website: "https://sede.agenciatributaria.gob.es/Sede/iva.html"
  modelo_303: "https://sede.agenciatributaria.gob.es/Sede/procedimientoini/G414.shtml"
```

## Migración del schema actual

El schema actual (pre-reestructuración) no tiene `agent_accessibility`, `auth_owner`, `reuse_commercial`, `cache_ttl_seconds`, `proxy_of`. Estos campos se añaden **cuando se toca una skill**, no en un bulk-update transversal. El catálogo coexiste con skills "viejas" y "nuevas" hasta que todas se hayan actualizado.

Las skills de datos con MCP (capa C) son las primeras que deben tener el schema completo.
