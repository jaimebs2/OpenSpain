---
name: dataestur
description: "Use when the user asks about Spanish tourism statistics: foreign tourist arrivals (FRONTUR), tourist expenditure (EGATUR), hotel occupancy rates, camping, rural tourism, leisure activities. Triggers on: 'turismo España', 'turistas extranjeros', 'FRONTUR', 'EGATUR', 'ocupación hotelera', 'gasto turístico', 'DataEstur', 'estadísticas turismo', 'visitantes internacionales', 'SEGITTUR'."
license: MIT
---

# DataEstur — API de Estadísticas de Turismo (SEGITTUR)

API pública sin autenticación. Todos los endpoints devuelven ficheros **XLSX** directamente (no JSON). El agente debe construir la URL de descarga y proporcionársela al usuario, describiendo qué datos contiene.

**Base URL**: `https://dataestur.azure-api.net/API-SEGITTUR-v1`

> ⚠️ Los ficheros XLSX pueden tardar 5-20 segundos en generarse. Siempre filtrar por fechas para reducir el tamaño y el tiempo de respuesta.

## Endpoints verificados

### FRONTUR — Turistas y excursionistas extranjeros

```
GET https://dataestur.azure-api.net/API-SEGITTUR-v1/FRONTUR_DL
```

**Columnas del XLSX**:
- `AÑO` — año
- `MES` — número de mes (1–12)
- `PAIS_RESIDENCIA` — país de residencia del visitante (Alemania, Francia, Reino Unido…)
- `TIPO_VISITANTE` — `Turista` o `Excursionista`
- `CCAA_DESTINO` — comunidad autónoma de destino principal
- `VISITANTES` — número de visitantes

**Ejemplo (enero 2025)**:
```
https://dataestur.azure-api.net/API-SEGITTUR-v1/FRONTUR_DL?desde%20(a%C3%B1o)=2025&desde%20(mes)=1&hasta%20(a%C3%B1o)=2025&hasta%20(mes)=1
```

### EGATUR — Gasto turístico

```
GET https://dataestur.azure-api.net/API-SEGITTUR-v1/EGATUR_DL
```

Mismos parámetros de fecha. Contiene datos de gasto por tipo de visitante, país de residencia y CCAA de destino.

### Actividades de ocio

```
GET https://dataestur.azure-api.net/API-SEGITTUR-v1/ACTIVIDADES_OCIO_DL
```

Entradas vendidas y gasto en actividades de ocio (disponible desde 2023-07).

## Parámetros de fecha

Todos los endpoints aceptan estos parámetros query (opcionales):

| Parámetro (literal) | URL-encoded | Descripción |
|---|---|---|
| `desde (año)` | `desde%20(a%C3%B1o)` | Año inicio |
| `desde (mes)` | `desde%20(mes)` | Mes inicio (1–12) |
| `hasta (año)` | `hasta%20(a%C3%B1o)` | Año fin |
| `hasta (mes)` | `hasta%20(mes)` | Mes fin (1–12) |

**Reglas**:
- Sin parámetros: devuelve toda la serie histórica (fichero grande, lento)
- Solo año inicio: filtra desde ese año hasta el último dato disponible
- Con año + mes de inicio: filtra desde esa fecha
- Si se especifica `hasta (año)`, hay que incluir `hasta (mes)` también

## Categorías adicionales (Swagger)

La API tiene más endpoints por categoría. Consultar el Swagger en `https://dataestur.azure-api.net/API-SEGITTUR-v1` para descubrir endpoints de:
- `ALOJAMIENTOS - ALOJAMIENTOS Y OCUPACIÓN` — ocupación hotelera, campings, turismo rural
- `ALOJAMIENTOS - ÍNDICES Y PRECIOS` — IPC turístico, precios hoteleros
- `ECONOMÍA - EMPLEO Y EMPRESAS` — empleo en turismo
- `TRANSPORTE` — transporte turístico
- `SOSTENIBILIDAD` — indicadores de sostenibilidad
- `CONOCIMIENTO` — estudios y conocimiento del sector

## Workflow recomendado

```
1. Identificar el indicador que necesita el usuario (FRONTUR / EGATUR / otro)
2. Construir la URL con los parámetros de fecha del usuario
3. Proporcionar la URL al usuario para que descargue el XLSX
4. Describir las columnas que encontrará y cómo filtrar el fichero
5. Si el usuario quiere datos más específicos (un solo país, una CCAA), indicar que filtre el Excel descargado
```

## Notas

- Los datos de FRONTUR y EGATUR son producidos por el INE pero distribuidos vía SEGITTUR
- Si el usuario quiere datos del INE directamente (series temporales en JSON), usar la skill `ine` con operación FRONTUR o EGATUR
- Los datos tienen varios meses de retraso respecto a la fecha actual
