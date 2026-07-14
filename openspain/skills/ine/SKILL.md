---
name: ine
description: "Use when the user wants official Spanish statistics from the INE (Instituto Nacional de Estadística): list statistical operations, browse the series that belong to an operation, or fetch the latest values of a specific time series (IPC inflation, EPA unemployment, demographics, census, industry, trade, etc.). Triggers on: 'INE', 'Instituto Nacional de Estadística', 'estadísticas España', 'estadística oficial', 'IPC', 'inflación', 'paro EPA', 'tasa de paro', 'demografía', 'población España', 'censo'."
license: MIT
---

# INE — API Wstempus del Instituto Nacional de Estadística

API pública REST, sin autenticación. Usar WebFetch con GET. Incluir siempre el header `Accept: application/json`.

Base URL: `https://servicios.ine.es/wstempus/js/ES`

## Operaciones

### 1. Listar operaciones estadísticas disponibles

```
GET https://servicios.ine.es/wstempus/js/ES/OPERACIONES_DISPONIBLES
```

Devuelve un array con todas las operaciones del INE. Campos útiles por operación:

- `Id` — identificador numérico interno
- `Cod_IOE` — código IOE
- `Nombre` — nombre descriptivo ("Índice de Precios de Consumo", "Encuesta de Población Activa", ...)
- `Codigo` — código corto, el que se usa en `SERIES_OPERACION` (ej. `IPC`, `EPA`, `ECH`)

### 2. Series de una operación (paginado)

```
GET https://servicios.ine.es/wstempus/js/ES/SERIES_OPERACION/{codigo}?page=1
```

`{codigo}` es el `Codigo` corto devuelto por `OPERACIONES_DISPONIBLES` (ej. `IPC`). Hay muchas series por operación, así que la respuesta está paginada: incrementar `page` (2, 3, ...) hasta que la respuesta sea una lista vacía `[]`.

Campos útiles por serie:

- `Id` — id numérico interno
- `COD` — código completo de la serie (ej. `IPC206449`). Este es el que se usa en `DATOS_SERIE`.
- `Nombre` — descripción legible ("Total Nacional. Índice general. Variación mensual.", ...)
- `FK_Periodicidad` — periodicidad (1 = mensual, 12 = anual, etc.)

> No bajar todas las páginas a ciegas: cuando el usuario pide una serie concreta, filtrar por palabras clave en `Nombre` y parar en cuanto aparezca el match.

### 3. Datos de una serie temporal

```
GET https://servicios.ine.es/wstempus/js/ES/DATOS_SERIE/{COD}?nult=10
```

`{COD}` es el campo `COD` de la serie (ej. `IPC206449`). `nult=N` devuelve los últimos N valores; ajustar según lo que pida el usuario (12 para un año mensual, 4 para un año trimestral, etc.).

Estructura de respuesta:

```
COD       → código de la serie
Nombre    → descripción
Data[]    → valores ordenados cronológicamente
  .Fecha      → timestamp en milisegundos (epoch UTC)
  .Anyo       → año
  .FK_Periodo → mes/trimestre según la periodicidad
  .Valor      → número (puede ser null si está en secreto estadístico)
  .Secreto    → true si el valor está protegido
```

Para convertir `Fecha` a fecha legible: es milisegundos desde epoch, dividir entre 1000 y formatear.

## Flujo típico

1. El usuario pide algo como "IPC de marzo" o "tasa de paro del último trimestre".
2. Si ya conoces el `COD` de la serie, saltar al paso 4.
3. Si no lo conoces, buscar entre las series de la operación correspondiente (`SERIES_OPERACION/IPC`, `SERIES_OPERACION/EPA`, ...) filtrando por nombre.
4. `DATOS_SERIE/{COD}?nult=N` con el N adecuado.
5. Responder con los valores reales, fecha y unidad.

## Códigos de operación frecuentes

| Operación                                     | Código |
|-----------------------------------------------|--------|
| Índice de Precios de Consumo                  | IPC    |
| Encuesta de Población Activa (paro)           | EPA    |
| Índices de Producción Industrial              | IPI    |
| Contabilidad Nacional Trimestral (PIB)        | CNTR   |
| Estadística del Padrón Continuo               | EPC    |

## Notas

- La API solo admite **GET**. No usar POST.
- Si una petición falla, reintentar con la URL exacta — no inventar parámetros.
- No confundir `Id` (numérico) con `COD` (alfanumérico). `DATOS_SERIE` requiere `COD`.
- Si `Valor` es `null` o `Secreto` es `true`, indicar que el dato está protegido en vez de inventar un número.
