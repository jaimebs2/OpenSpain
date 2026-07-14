---
name: aemet
description: "Use when the user wants Spanish weather data from AEMET (Agencia Estatal de Meteorología): daily municipal forecasts, current observations from weather stations, or active meteorological warnings (avisos CAP). Triggers on: 'aemet', 'tiempo', 'lluvia', 'temperatura', 'predicción meteorológica', 'previsión del tiempo', 'pronóstico', 'aviso meteorológico', 'alerta meteorológica', 'estación meteorológica', 'observación meteorológica', 'clima España'."
license: MIT
---

# AEMET OpenData — API de la Agencia Estatal de Meteorología

API pública con **API key obligatoria**. Usar WebFetch con GET.

## Autenticación (OBLIGATORIO)

La API key se lee **siempre** de la variable de entorno `AEMET_API_KEY`. **Nunca pidas la clave al usuario en el prompt** y **nunca la solicites como parámetro** — si no está definida, aborta con este mensaje exacto:

> "Falta la variable de entorno `AEMET_API_KEY`. Solicita una clave gratuita en https://opendata.aemet.es/centrodedescargas/altaUsuario y expórtala antes de usar esta skill."

La clave se envía como **query parameter** `?api_key=<valor>` (más sencillo con WebFetch que usar header). Alternativamente, el header `api_key: <valor>` también funciona.

## Patrón de doble salto (CRÍTICO)

Todas las operaciones de AEMET OpenData siguen el mismo patrón:

1. **Primera GET** al endpoint de la operación con la API key. Respuesta:
   ```json
   {
     "descripcion": "exito",
     "estado": 200,
     "datos": "https://opendata.aemet.es/opendata/sh/<hash>",
     "metadatos": "https://opendata.aemet.es/opendata/sh/<hash>"
   }
   ```
2. **Segunda GET** a la URL que aparece en el campo `datos`. Esa segunda URL **no necesita API key** y **caduca en ~5 minutos**. Devuelve el JSON (o XML para los avisos CAP) con los datos reales.

Si la primera respuesta trae `estado: 429` o el HTTP devuelve 429, esperar unos segundos y reintentar **una sola vez**. Si vuelve a fallar, informar al usuario del throttling.

Si `estado` no es 200 (por ejemplo 401, 404), informa al usuario del `descripcion` que devuelva AEMET.

## Base URL

```
https://opendata.aemet.es/opendata
```

## Operaciones

### 1. Predicción diaria por municipio

```
GET /api/prediccion/especifica/municipio/diaria/{codigo_municipio}?api_key=...
```

- `codigo_municipio`: código INE de 5 dígitos **sin el dígito de control** (ejemplos: `28079` Madrid, `08019` Barcelona, `46250` Valencia, `41091` Sevilla, `48020` Bilbao).
- Segunda GET → devuelve una lista con un objeto que contiene `prediccion.dia[]`. Cada elemento tiene:
  - `fecha` → `YYYY-MM-DDT00:00:00`
  - `temperatura.maxima`, `temperatura.minima` (°C)
  - `probPrecipitacion[]` → por franja horaria (`periodo` + `value` en %)
  - `estadoCielo[]` → `descripcion` ("Despejado", "Cubierto", ...)
  - `viento[]` → `direccion`, `velocidad` (km/h)
  - `sensTermica`, `humedadRelativa`, `uvMax`

### 2. Observación convencional de estación

```
GET /api/observacion/convencional/datos/estacion/{idema}?api_key=...
```

- `idema`: identificador de estación (ejemplos: `3195` Madrid-Retiro, `0076` Barcelona-Aeropuerto, `8416` Valencia).
- Para el endpoint **"todas las estaciones"** usa `/api/observacion/convencional/todas`.
- Segunda GET → lista de observaciones horarias de las últimas ~24 h. Campos útiles:
  - `fint` → timestamp ISO
  - `ta` → temperatura del aire (°C)
  - `hr` → humedad relativa (%)
  - `prec` → precipitación acumulada (mm)
  - `vv`, `dv` → velocidad y dirección del viento
  - `pres` → presión (hPa)
  - `ubi` → nombre de la estación

### 3. Avisos meteorológicos CAP (último elaborado)

```
GET /api/avisos_cap/ultimoelaborado/area/esp?api_key=...
```

O para toda España: `/api/avisos_cap/ultimoelaborado` — ambos válidos. Segunda GET → devuelve un TAR/ZIP de ficheros CAP (XML) en producción. Para uso conversacional, lo más sencillo es consultar los avisos por **área (CCAA)**:

```
GET /api/avisos_cap/ultimoelaborado/area/{area}?api_key=...
```

Áreas comunes: `61` Andalucía, `77` Aragón, `65` Canarias, `62` Cataluña, `78` Galicia, `63` Madrid, `66` Murcia, `79` País Vasco, `64` Com. Valenciana.

Para casos simples, indica al usuario los avisos vigentes a partir de los primeros elementos del CAP devuelto (cabecera `info.event`, `info.severity`, `info.areaDesc`). Si el fichero es demasiado grande o binario, resume que hay avisos activos y enlaza a https://www.aemet.es/es/eltiempo/prediccion/avisos.

## Ejemplo de flujo completo (predicción Madrid)

1. WebFetch GET `https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/28079?api_key=$AEMET_API_KEY`
2. Extraer campo `datos` de la respuesta.
3. WebFetch GET a esa URL (sin api_key).
4. Parsear `[0].prediccion.dia[]` y presentar al usuario las próximas 3-5 jornadas con máxima, mínima, estado del cielo y probabilidad de precipitación.

## Reglas operativas

- Siempre menciona la fuente ("según AEMET").
- Nunca inventes temperaturas, probabilidades ni avisos.
- Si `AEMET_API_KEY` no está definida, aborta con el mensaje del bloque de autenticación — **no intentes la llamada**.
- Ante 429, espera y reintenta una sola vez.
- Avisa al usuario si los datos están cacheados más de unos minutos por el doble salto caducado.
