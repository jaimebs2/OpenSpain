---
name: esios
description: "Use when the user asks about Spanish electricity: PVPC price (today's or historical), electricity demand, generation by technology (wind, solar, nuclear, hydro), energy balance or market prices. Requires ESIOS_TOKEN env variable. Triggers on: 'precio electricidad', 'PVPC', 'tarifa luz', 'demanda eléctrica', 'generación renovable', 'mix energético', 'precio mercado eléctrico', 'REE', 'Red Eléctrica', 'precio luz hoy', 'eólica', 'solar fotovoltaica', 'nuclear España', 'intercambio eléctrico'."
license: MIT
---

# ESIOS — API del Sistema Eléctrico Español

API REST de Red Eléctrica de España (REE). Usar WebFetch con GET.

## Autenticación (OBLIGATORIO para la mayoría de indicadores)

El token se lee **siempre** de la variable de entorno `ESIOS_TOKEN`. **Nunca pidas el token al usuario en el prompt** y **nunca lo solicites como parámetro**.

Si `ESIOS_TOKEN` no está definida y el indicador lo requiere, aborta con este mensaje exacto:

> "Falta la variable de entorno `ESIOS_TOKEN`. Solicita un token gratuito en https://www.esios.ree.es/es/área-privada/api-de-acceso y expórtalo antes de usar esta skill."

El token se envía en la cabecera HTTP:

```
Authorization: Token token=<valor_de_ESIOS_TOKEN>
```

**Todos los endpoints de datos requieren token** (incluidos 460, 600, 10211 y 1001 — PVPC). Solo el listado `/indicators` es accesible sin token.

## Base URL

```
https://api.esios.ree.es
```

Incluir siempre la cabecera `Accept: application/json`.

## Endpoint principal: indicadores

### Listar todos los indicadores

```
GET /indicators
```

Devuelve `{ "indicators": [ { "id": N, "name": "...", "short_name": "..." }, ... ] }`. No requiere token.

### Obtener datos de un indicador

```
GET /indicators/{id}?start_date=YYYY-MM-DDT00:00:00&end_date=YYYY-MM-DDT23:59:59
```

Parámetros de filtrado:
- `start_date`: fecha/hora inicio en formato ISO 8601 (p.ej. `2026-04-07T00:00:00`)
- `end_date`: fecha/hora fin en formato ISO 8601 (p.ej. `2026-04-07T23:59:59`)

Sin filtros devuelve los datos del día en curso.

### Estructura de la respuesta

```json
{
  "indicator": {
    "id": 1001,
    "name": "...",
    "short_name": "...",
    "composited": false,
    "step_type": "linear",
    "disaggregated": false,
    "magnitud": [{ "id": N, "name": "Precio €/MWh" }],
    "tiempo": [{ "id": N, "name": "Hora" }],
    "geos": [{ "geo_id": 8741, "geo_name": "Península" }],
    "values_updated_at": "2026-04-07T10:00:00.000+02:00",
    "values": [
      {
        "value": 85.23,
        "datetime": "2026-04-07T01:00:00.000+02:00",
        "datetime_utc": "2026-04-06T23:00:00Z",
        "tz_time": "2026-04-06T23:00:00.000Z",
        "geo_id": 8741,
        "geo_name": "Península"
      }
    ]
  }
}
```

Los precios están en **€/MWh**. Para convertir a **ct€/kWh** (más familiar para el consumidor), dividir por 10.

## Indicadores más útiles

| ID | Nombre | Token | Unidad | Notas |
|---|---|---|---|---|
> **Todos los indicadores de la tabla requieren `ESIOS_TOKEN`.** La columna "Token" se ha eliminado porque ya no aporta información: sin token solo es accesible el listado `/indicators`.

| ID | Nombre | Unidad | Notas |
|---|---|---|---|
| 1001 | Precio PVPC | €/MWh | Tarifa regulada hora a hora para pequeños consumidores |
| 1739 | Precio energía excedentaria autoconsumo (PVPC) | €/MWh | Para propietarios de paneles solares con compensación simplificada |
| 10211 | Precio medio horario final suma de componentes | €/MWh | Precio final compuesto, resolución horaria, Península |
| 600 | Precio mercado SPOT Diario | €/MWh | Precio mayorista por países: España, Portugal, Francia, Alemania, Bélgica, Países Bajos |
| 460 | Previsión diaria demanda eléctrica peninsular | MW | Previsión de demanda cada 15 minutos |
| 461 | Previsión a corto plazo demanda eléctrica | MW | Previsión a corto plazo |
| 1 | Generación programada PBF Hidráulica UGH | MWh | Programa base de funcionamiento |
| 4 | Generación programada PBF Nuclear | MWh | |
| 9 | Generación programada PBF Ciclo combinado | MWh | |
| 12 | Generación programada PBF Eólica terrestre | MWh | |
| 14 | Generación programada PBF Solar fotovoltaica | MWh | |
| 15 | Generación programada PBF Solar térmica | MWh | |
| 21 | Generación programada PBF Biomasa | MWh | |
| 28-35 | Importación/Exportación PBF por país | MWh | Francia, Portugal, Marruecos, Andorra |

## Operaciones habituales

### 1. Precio PVPC de hoy (requiere token)

```
GET https://api.esios.ree.es/indicators/1001?start_date=YYYY-MM-DDT00:00:00&end_date=YYYY-MM-DDT23:59:59
Header: Authorization: Token token=<ESIOS_TOKEN>
Header: Accept: application/json
```

Devuelve 24 valores horarios (uno por hora) con el precio PVPC en €/MWh. Presentar en tabla o lista indicando hora y precio, convirtiendo también a ct€/kWh si es útil para el usuario.

### 2. Precio medio horario final (requiere token)

```
GET https://api.esios.ree.es/indicators/10211?start_date=YYYY-MM-DDT00:00:00&end_date=YYYY-MM-DDT23:59:59
Header: Authorization: Token token=<ESIOS_TOKEN>
Header: Accept: application/json
```

Precio compuesto final hora a hora. Resolución horaria, ámbito Península.

### 3. Precio SPOT mercado diario por países (requiere token)

```
GET https://api.esios.ree.es/indicators/600?start_date=YYYY-MM-DDT00:00:00&end_date=YYYY-MM-DDT23:59:59
Header: Authorization: Token token=<ESIOS_TOKEN>
Header: Accept: application/json
```

Devuelve precios por país. Filtrar por `geo_name` para mostrar solo España o comparar países.

### 4. Previsión de demanda (requiere token)

```
GET https://api.esios.ree.es/indicators/460?start_date=YYYY-MM-DDT00:00:00&end_date=YYYY-MM-DDT23:59:59
Header: Authorization: Token token=<ESIOS_TOKEN>
Header: Accept: application/json
```

Resolución de 15 minutos. `value` en MW. `geo_name: "Península"`.

### 5. Generación programada por tecnología (requiere token)

Consultar cada tecnología por separado usando los IDs de la tabla anterior. Para un resumen del mix, consultar varios indicadores y agregar.

## Reglas operativas

- Leer siempre `ESIOS_TOKEN` del entorno antes de cada llamada que lo requiera. **Nunca hardcodear ni mostrar el token.**
- Si el token no está definido y el indicador lo requiere, abortar con el mensaje de la sección de autenticación.
- Los precios están en €/MWh. Ofrecer siempre la conversión a ct€/kWh (dividir por 10) cuando sea útil para el consumidor doméstico.
- Indicar siempre la fuente: "según ESIOS / Red Eléctrica de España".
- Indicar la hora a la que corresponde cada precio (usar el campo `datetime` en hora local).
- Si `values` está vacío, puede ser que la fecha solicitada no tenga datos todavía (datos futuros) o que la fecha sea muy antigua.
- Ante error 401/403, verificar que `ESIOS_TOKEN` está correctamente definida y no ha expirado.
- Nunca inventar precios, demandas ni datos de generación.
