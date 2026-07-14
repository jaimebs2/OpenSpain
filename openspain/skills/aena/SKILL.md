---
name: aena
description: "Use when the user asks about Spanish airport statistics: passenger numbers, flight operations, cargo by airport, airport rankings, or air traffic trends. Triggers on: 'Aena', 'aeropuerto', 'pasajeros aeropuerto', 'tráfico aéreo', 'vuelos', 'estadísticas aeroportuarias', 'aeropuerto Madrid', 'aeropuerto Barcelona', 'Barajas', 'El Prat', 'LEMD', 'LEBL', 'operaciones aéreas', 'carga aérea', 'mercancías aeropuerto'."
license: MIT
---

# Aena — Estadísticas Aeroportuarias

Aena no tiene API REST pública. Los datos se publican como ficheros XLS descargables desde su portal estadístico. Para responder preguntas sobre tráfico aéreo, descargar el XLS correspondiente con WebFetch y leer su contenido.

## URLs directas verificadas

### Informes anuales (XLS)

Usar estas URLs directamente — están verificadas y funcionan sin autenticación:

| Año | URL XLS |
|-----|---------|
| 2025 | `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576873058143&ssbinary=true` |
| 2024 | `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576871820226&ssbinary=true` |
| 2023 | `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576869794642&ssbinary=true` |

### Informes mensuales 2026 (XLS — caché de atajo)

> Estas URLs son un **atajo** para evitar un salto adicional. Los IDs `blobwhere=N` son opacos (MungoBlobs) y **no siguen ningún patrón derivable** del mes o año. Para cualquier mes no listado aquí, NO intentes adivinar el ID: usa siempre el **Paso 1b** (navegar al portal y extraer el `blobwhere` del HTML). La tabla se actualiza oportunísticamente, no es autoritativa.

| Mes | URL XLS |
|-----|---------|
| Febrero 2026 | `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576873491064&ssbinary=true` |
| Enero 2026 | `https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576873282373&ssbinary=true` |

## Workflow para responder preguntas de tráfico

### Paso 1 — Determinar qué informe usar

- Si la pregunta es sobre un año completo o comparativa anual → usar informe anual.
- Si la pregunta es sobre un mes concreto → usar informe mensual de ese año/mes.
- Si el mes/año pedido no está en las URLs conocidas arriba, ir al **Paso 1b**.

### Paso 1b — Localizar informes no listados

Acceder al portal de informes mensuales para obtener la URL del XLS del mes buscado:

```
GET https://www.aena.es/es/estadisticas/informes-mensuales.html
```

Extraer del HTML los enlaces con patrón `blobwhere=\d+` que correspondan al mes/año pedido. Luego construir la URL completa:

```
https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere={ID}&ssbinary=true
```

### Paso 2 — Descargar el XLS

Usar WebFetch con la URL del XLS. El fichero es XLSX (~50-70 KB) con dos hojas.

```
GET https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere={BLOB_ID}&ssbinary=true
```

No se requieren headers adicionales.

### Paso 3 — Leer e interpretar el XLS

El XLSX descargado contiene:
- **Hoja 1**: Datos de pasajeros, operaciones y mercancías por aeropuerto para el periodo.
- **Hoja 2**: Posiblemente datos adicionales o comparativos.

Columnas típicas:
- Aeropuerto (nombre o código IATA/ICAO)
- Pasajeros (total, nacional, internacional)
- Operaciones (aterrizajes + despegues)
- Mercancías / Carga aérea (toneladas)
- Variación respecto al periodo anterior (%)

### Paso 4 — Responder con datos reales

Presentar los datos extraídos del XLS. Para rankings, ordenar por la métrica pedida (pasajeros, operaciones, etc.). Citar el periodo exacto del informe.

## Aeropuertos principales (referencia rápida)

| Nombre | IATA | ICAO |
|--------|------|------|
| Madrid-Barajas Adolfo Suárez | MAD | LEMD |
| Barcelona-El Prat | BCN | LEBL |
| Palma de Mallorca | PMI | LEPA |
| Málaga-Costa del Sol | AGP | LEMG |
| Gran Canaria | LPA | GCLP |
| Alicante-Elche | ALC | LEAL |
| Tenerife Sur | TFS | GCTS |
| Valencia | VLC | LEVC |
| Ibiza | IBZ | LEIB |
| Sevilla | SVQ | LEZL |

## Limitaciones

- Las consultas personalizadas (por compañía aérea, ruta o destino) requieren registro en el portal de Aena — no accesibles sin autenticación.
- No hay datos en tiempo real (slots, retrasos, ocupación actual).
- Para años anteriores a 2023 no listados arriba, navegar a la página de informes anuales: `https://www.aena.es/es/estadisticas/informes-anuales.html`
