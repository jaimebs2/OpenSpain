---
name: puertos
description: "Use when the user asks about Spanish coastal oceanography or port data: sea level (tide gauges/mareógrafos), wave height and period (oleaje/boyas), sea surface temperature, coastal currents, or numerical ocean/wave forecasts. Triggers on: 'Puertos del Estado', 'mareógrafo', 'nivel del mar', 'oleaje', 'altura de ola', 'periodo de ola', 'corrientes costeras', 'temperatura del mar', 'oceanografía costera', 'THREDDS', 'boyas', 'REDCOS', 'portus', 'barcelona puerto nivel', 'bilbao marea'."
license: MIT
---

# Puertos del Estado — Servidor THREDDS OPeNDAP

Datos oceanográficos en tiempo real y predicciones numéricas servidos por el servidor THREDDS de Puertos del Estado. Acceso público, sin autenticación.

## Servidor THREDDS

- **Catálogo raíz (XML)**: `http://opendap.puertos.es/thredds/catalog.xml`
- **Catálogo HTML navegable**: `http://opendap.puertos.es/thredds/catalog.html`
- **Base OPeNDAP**: `http://opendap.puertos.es/thredds/dodsC/`
- **Descarga directa**: `http://opendap.puertos.es/thredds/fileServer/`

## Estructura del catálogo

El catálogo raíz tiene dos categorías principales:

### Medidas (observaciones en tiempo real)

| Dataset | Catalog path | Variables principales |
|---|---|---|
| Mareógrafos (nivel del mar) | `tidegauge_<id>/` | SLEV (m), TIME, LATITUDE, LONGITUDE |
| Radar de corrientes HF | `radar_local_<zona>/` | U, V (velocidad), covarianza |
| Satélite temperatura mar | `sat_large_ibi/` | SST |

### Modelos (predicciones numéricas)

| Dataset | Catalog path | Descripción |
|---|---|---|
| Oleaje gran escala | `wave_large_atlmed/` | Atlántico-Mediterráneo |
| Oleaje regional Gibraltar | `wave_regional_gib/` | Estrecho de Gibraltar |
| Oleaje regional Baleares | `wave_regional_bal/` | Mediterráneo occidental |
| Oleaje regional Canarias | `wave_regional_can/` | Archipiélago canario |
| Oleaje regional Atlántico Ibérico | `wave_regional_aib/` | Costa atlántica |
| Oleaje regional IBI | `wave_regional_ibi/` | Iberia-Biscay-Ireland |
| Atmósfera HARMONIE 1 km (16 puertos) | `atmos_local_<puerto>/` | Viento, presión local |
| 3D circulación costera | `circ_coast_*/` | Temperatura, salinidad, corrientes |
| Nivel del mar 2D (NIVMAR) | `level_large_*/` | Nivel del mar regional |

## Estaciones mareográficas conocidas

| ID catálogo | Puerto | Coordenadas | Portus station |
|---|---|---|---|
| `tidegauge_bar2` | Barcelona | 41.3418°N, 2.1657°E | 3758 |
| `tidegauge_alge` | Algeciras | 36.177°N, 5.398°W | — |
| `tidegauge_bil` | Bilbao | — | — |
| `tidegauge_val` | Valencia | — | — |
| `tidegauge_vig` | Vigo | — | — |

Hay 45 estaciones en total. Para descubrir otras, navega el catálogo raíz.

## Flujo de consulta — mareógrafo (nivel del mar)

Para consultar el nivel del mar de una estación, sigue estos pasos:

### Paso 1 — Descubrir el dataset disponible

Navega el sub-catálogo de la estación para el año/mes actuales:

```
WebFetch GET http://opendap.puertos.es/thredds/catalog/<catalog_id>/<año>/<mes>/catalog.xml
```

Ejemplo (Barcelona, abril 2026):
```
http://opendap.puertos.es/thredds/catalog/tidegauge_bar2/2026/04/catalog.xml
```

La respuesta XML lista los ficheros con su `urlPath`. Los ficheros `_analysis_HM.nc4` contienen datos horarios analizados (los más útiles para consultas de nivel del mar). Los ficheros sin sufijo `_analysis_*` contienen datos en alta frecuencia (2 Hz, ~172.800 muestras/día).

Ejemplo de `urlPath`:
```
tidegauge_bar2/2026/04/MIR2Z_Barcelona_Bar2_3758_20260407_analysis_HM.nc4
```

### Paso 2 — Obtener metadatos del dataset (.das)

```
WebFetch GET http://opendap.puertos.es/thredds/dodsC/<urlPath>.das
```

Ejemplo:
```
http://opendap.puertos.es/thredds/dodsC/tidegauge_bar2/2026/04/MIR2Z_Barcelona_Bar2_3758_20260407_analysis_HM.nc4.das
```

El `.das` devuelve atributos globales: nombre de la estación, coordenadas, cobertura temporal, institución, modo de datos (R=real-time, D=delayed).

### Paso 3 — Obtener estructura de variables (.dds)

```
WebFetch GET http://opendap.puertos.es/thredds/dodsC/<urlPath>.dds
```

El `.dds` devuelve las dimensiones de cada variable (necesario para construir consultas ASCII con slicing).

### Paso 4 — Descargar datos completos (fileServer)

Para ficheros de análisis horario (`_analysis_HM.nc4`), el tamaño es manejable. Descarga el fichero completo:

```
WebFetch GET http://opendap.puertos.es/thredds/fileServer/<urlPath>
```

Nota: el fileServer devuelve un binario NetCDF4/HDF5. WebFetch puede recuperar el fichero pero no puede parsearlo directamente. Usa el `.das` para obtener metadatos y el rango temporal.

### Resumen para el usuario

Cuando el usuario pregunta por el nivel del mar en una estación:
1. Navega el catálogo del día actual para la estación.
2. Descarga los metadatos `.das` del fichero `_analysis_HM.nc4` del día actual.
3. Presenta: nombre del puerto, coordenadas, cobertura temporal (`time_coverage_start`, `time_coverage_end`), modo de datos, institución.
4. Indica la URL del fichero NetCDF para quien quiera procesar los datos.
5. Enlaza a Portus para visualización interactiva: `https://portus.puertos.es/?station=<station_id>`.

## Flujo de consulta — oleaje (modelos)

Para consultar predicciones de oleaje en una zona:

### Paso 1 — Navegar el sub-catálogo regional

```
WebFetch GET http://opendap.puertos.es/thredds/catalog/<catalog_id>/catalog.xml
```

Ejemplo (Baleares):
```
http://opendap.puertos.es/thredds/catalog/wave_regional_bal/catalog.xml
```

### Paso 2 — Obtener metadatos del dataset de predicción más reciente

Selecciona el fichero más reciente del catálogo y consulta su `.das`:

```
http://opendap.puertos.es/thredds/dodsC/<urlPath>.das
```

Los modelos de oleaje incluyen variables como: `VHM0` (altura significativa, m), `VTPK` (periodo de pico, s), `VTM02` (periodo medio, s), `VTMX` (altura máxima, m).

## Portus — visualización interactiva

Para que el usuario vea datos en tiempo real de forma gráfica, enlaza al portal Portus:
- Inicio: `https://portus.puertos.es/`
- Estación específica: `https://portus.puertos.es/?station=<id>`

Ejemplo (Barcelona mareógrafo): `https://portus.puertos.es/?station=3758`

## Reglas operativas

- Nunca inventes datos de nivel del mar, altura de ola ni coordenadas.
- Siempre cita la fuente: "datos de Puertos del Estado (opendap.puertos.es)".
- Si la navegación del catálogo devuelve 404, prueba con el mes anterior (los datos del día actual pueden no estar publicados todavía).
- Para visualización interactiva, redirige siempre a Portus — no intentes renderizar los datos NetCDF.
- Los ficheros `_analysis_HM.nc4` (análisis horario) son los más adecuados para responder preguntas de usuario; los ficheros en bruto a 2 Hz son para uso técnico.
- Los modelos con `restrictAccess` en el catálogo no son accesibles públicamente — informa al usuario si intenta acceder a ellos.
