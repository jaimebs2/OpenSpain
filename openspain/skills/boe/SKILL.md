---
name: boe
description: "Use when the user wants to query the Spanish Official State Gazette (BOE — Boletín Oficial del Estado): get today's or any day's BOE summary/index, look up dispositions by section or department, or get the table of contents of a consolidated law by its BOE identifier. Triggers on: 'BOE', 'boletín oficial', 'sumario BOE', 'disposición', 'legislación consolidada', 'Constitución', 'norma BOE'."
license: MIT
---

# BOE — API de datos abiertos del Boletín Oficial del Estado

API pública, sin autenticación. Usar WebFetch con GET. **Nunca usar POST — devuelve 403.**

Siempre incluir el header `Accept: application/json`.

## Operaciones

### Sumario diario

```
GET https://www.boe.es/datosabiertos/api/boe/sumario/{fecha}
```

`fecha` en formato `YYYYMMDD`. Ejemplo: `20260407`.

### Índice de ley consolidada

```
GET https://www.boe.es/datosabiertos/api/legislacion-consolidada/id/{id}/texto/indice
```

Ejemplo: `BOE-A-1978-31229` (Constitución Española).

Para leer el texto de un bloque concreto, hacer GET a la `url` que devuelve cada entrada del índice.

## Estructura de respuesta

Todas las respuestas tienen `status.code`. Si es distinto de `"200"`, hay error.

### Sumario

```
data.sumario.metadatos.fecha_publicacion   → "YYYYMMDD"
data.sumario.diario[]
  .numero                                  → número del BOE
  .seccion[]
    .nombre                                → sección ("I. Disposiciones generales", ...)
    .departamento[]
      .nombre                              → ministerio u organismo
      .epigrafe[]
        .nombre                            → epígrafe / rango de la disposición
        .item                              → objeto {} o lista [] de disposiciones
          .identificador                   → "BOE-A-2026-XXXX"
          .titulo                          → texto completo de la disposición
          .url_html                        → enlace al texto
```

> `item` puede ser un objeto `{}` o una lista `[]`. Tratar siempre como lista.

### Índice de ley consolidada

```
data[]
  .bloque[]
    .id                   → identificador interno ("preambulo", "a1", "ti", ...)
    .titulo               → título legible ("Artículo 1", "TÍTULO I", ...)
    .fecha_actualizacion  → última modificación ("YYYYMMDD")
    .url                  → enlace para obtener el texto completo del bloque
```

## IDs útiles

| Norma                        | ID                    |
|------------------------------|-----------------------|
| Constitución Española        | `BOE-A-1978-31229`    |
| Código Civil                 | `BOE-A-1889-4763`     |
| Estatuto de los Trabajadores | `BOE-A-2015-11430`    |
