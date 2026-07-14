---
name: cnmc
description: "Use when the user asks about CNMC data: electricity market, gas market, telecommunications, audiovisual, railway or postal regulation. Triggers on: 'CNMC', 'mercado eléctrico', 'gas regulado', 'telecomunicaciones regulación', 'tarifas CNMC', 'datos CNMC', 'operadores telecom', 'cuotas de mercado CNMC', 'energía eléctrica CNMC', 'mercado gas', 'sector postal', 'transporte ferroviario regulación'."
license: MIT
---

# CNMC — Portal CKAN de Datos Abiertos

API pública CKAN, sin autenticación. Usar WebFetch con GET.

Base URL: `https://catalogodatos.cnmc.es`

## Operaciones

### Buscar datasets por texto libre

```
GET https://catalogodatos.cnmc.es/api/3/action/package_search?q={texto}&rows=10
```

Ejemplo: `?q=electricidad&rows=10`

### Buscar datasets por sector (grupo)

```
GET https://catalogodatos.cnmc.es/api/3/action/package_search?fq=groups:{grupo}&rows=10
```

Grupos disponibles:

| Sector | Valor del grupo |
|---|---|
| Energía eléctrica | `grupo_energia_electrica` |
| Gas natural | `grupo_gas_natural` |
| Telecomunicaciones | `grupo_telco` |
| Petróleo | `grupo_petroleo` |
| Transporte | `grupo_transporte` |
| Postal | `grupo_postal` |
| Comercio electrónico | `grupo_comercio_electronico` |
| Panel de hogares | `panel-de-hogares` |

Ejemplo: `?fq=groups:grupo_telco&rows=10`

Se puede combinar texto y filtro: `?q=operadores&fq=groups:grupo_telco&rows=10`

### Detalle de un dataset

```
GET https://catalogodatos.cnmc.es/api/3/action/package_show?id={id}
```

`id` puede ser el UUID o el nombre (slug) del dataset. Ejemplo:
`?id=88b1b2bb-2398-4dc6-af02-136a430e9db0`

## Estructura de respuesta

Todas las respuestas CKAN tienen:

```
result.success        → true si la llamada fue correcta
result.result.count   → número total de resultados (solo en package_search)
result.result.results → lista de datasets (solo en package_search)
result.result         → objeto dataset (solo en package_show)
```

### Dataset (cada elemento de `result.result.results[]` o el objeto `result.result`)

```
.id               → UUID del dataset
.name             → slug del dataset (p. ej. "ds_1793_1")
.title            → título legible
.notes            → descripción
.groups[].name    → sector al que pertenece (p. ej. "grupo_energia_electrica")
.organization.title → nombre de la organización/subdirección (p. ej. "Energía")
.license_title    → licencia (habitualmente "CC-BY-SA-4.0")
.resources[]      → lista de recursos descargables
  .id             → UUID del recurso
  .name           → nombre del archivo (p. ej. "ds_1793_1.csv")
  .format         → formato: "CSV", "JSON", "XML"
  .url            → URL de descarga directa
```

## Flujo recomendado

1. Hacer `package_search` con el término o grupo relevante.
2. Identificar el dataset más pertinente por su `title` y `notes`.
3. Si el usuario quiere más detalle o la URL de descarga, usar `package_show` con el `id` del dataset.
4. Presentar las URLs de descarga (`resources[].url`) ordenadas por formato preferido (CSV > JSON > XML).

## Ejemplo completo

Buscar datos de electricidad y obtener la primera URL de descarga CSV:

```
1. GET https://catalogodatos.cnmc.es/api/3/action/package_search?q=electricidad&fq=groups:grupo_energia_electrica&rows=5
   → result.result.results[0].id = "88b1b2bb-2398-4dc6-af02-136a430e9db0"
   → result.result.results[0].title = "Mercado minorista de electricidad 2022T4"

2. GET https://catalogodatos.cnmc.es/api/3/action/package_show?id=88b1b2bb-2398-4dc6-af02-136a430e9db0
   → result.result.resources[1].url = "https://catalogodatos.cnmc.es/dataset/.../download/ds_1793_1.csv"
   → result.result.resources[1].format = "CSV"
```

## Notas

- Los datasets son estáticos y periódicos (trimestrales, anuales). No hay datos en tiempo real.
- Los títulos suelen incluir el periodo temporal: "2022T4", "2023", "Mensual", etc.
- Para encontrar la serie histórica completa de un indicador, buscar por el prefijo del nombre (p. ej. `ds_1793`) y aparecerán todos los periodos disponibles.
