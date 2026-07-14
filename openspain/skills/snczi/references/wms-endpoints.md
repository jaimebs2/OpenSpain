# Referencia técnica — WMS del SNCZI

Detalle de cada servicio WMS consumido por la skill `snczi`. Todos los servicios soportan las operaciones OGC estándar `GetCapabilities`, `GetMap` y `GetFeatureInfo`.

## Endpoints

| ID                 | URL base                                                               |
|--------------------|------------------------------------------------------------------------|
| `zi_t10`           | https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ10/wms.aspx              |
| `zi_t100`          | https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ100/wms.aspx             |
| `zi_t500`          | https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ500/wms.aspx             |
| `dph_cartografico` | https://wms.mapama.gob.es/sig/Agua/DPHCartografico/wms.aspx            |

## Layer names por servicio

| Endpoint           | Layer name (parámetro `LAYERS`/`QUERY_LAYERS`) |
|--------------------|-------------------------------------------------|
| `zi_t10`           | `NZ.RiskZone`                                   |
| `zi_t100`          | `NZ.RiskZone`                                   |
| `zi_t500`          | `NZ.RiskZone`                                   |
| `dph_cartografico` | `Cauces con DPH cartográfico`                   |

> La capa de los tres servicios ZI se llama igual (`NZ.RiskZone`, nombre INSPIRE). El periodo de retorno queda determinado por el endpoint, no por el layer name.

## CRS soportados (subset)

- `EPSG:4326` — WGS84 (lat, lon). En WMS 1.3.0 el BBOX va **lat antes que lon**.
- `EPSG:4258` — ETRS89 (lat, lon).
- `EPSG:25829`, `EPSG:25830`, `EPSG:25831` — ETRS89 UTM 29N/30N/31N (x, y en metros).
- `EPSG:3857` — Web Mercator (x, y en metros).

Recomendado para LLM: `EPSG:4326` con WMS 1.3.0.

## GetCapabilities

```
GET {base_url}?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities
```

Devuelve XML con la metadata completa: extensión geográfica, CRS, estilos, formatos. Útil para verificar que el servicio responde.

## GetFeatureInfo (consulta puntual)

```
GET {base_url}
    ?SERVICE=WMS
    &VERSION=1.3.0
    &REQUEST=GetFeatureInfo
    &LAYERS={layer}
    &QUERY_LAYERS={layer}
    &CRS=EPSG:4326
    &BBOX={lat_min},{lon_min},{lat_max},{lon_max}
    &WIDTH=101
    &HEIGHT=101
    &I=50
    &J=50
    &INFO_FORMAT=text/html
```

- `BBOX` — ventana de consulta en lat,lon (orden WMS 1.3.0). Para consulta puntual: `d = 0.0001` (≈ 11 m) → `lat_min=lat-d, lon_min=lon-d, lat_max=lat+d, lon_max=lon+d`.
- `WIDTH=101, HEIGHT=101, I=50, J=50` — el punto a consultar es el píxel central.
- `INFO_FORMAT` soportados: `text/html`, `text/xml`, `text/plain`, `application/vnd.ogc.wms_xml`, `application/vnd.ogc.gml`. Para LLM preferir `text/html` (más robusto de parsear como texto) o `application/vnd.ogc.gml` para parsing estructurado.

### Ejemplo 1 — punto en zona inundable T=100 (río Turia, Valencia)

```
GET https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ100/wms.aspx
    ?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetFeatureInfo
    &LAYERS=NZ.RiskZone&QUERY_LAYERS=NZ.RiskZone
    &CRS=EPSG:4326
    &BBOX=39.4734,-0.3822,39.4736,-0.3820
    &WIDTH=101&HEIGHT=101&I=50&J=50
    &INFO_FORMAT=text/html
```

Respuesta (recortada): tabla HTML con columnas `FID`, `INSPIREID`, `RISKLEVELCODE`, `RETURNPERIOD` y valores del feature que cubre el punto. Presencia de filas ⇒ punto **dentro** de zona inundable T=100.

### Ejemplo 2 — punto fuera (Puerta del Sol, Madrid)

```
GET https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ100/wms.aspx
    ?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetFeatureInfo
    &LAYERS=NZ.RiskZone&QUERY_LAYERS=NZ.RiskZone
    &CRS=EPSG:4326
    &BBOX=40.4167,-3.7039,40.4169,-3.7037
    &WIDTH=101&HEIGHT=101&I=50&J=50
    &INFO_FORMAT=text/html
```

Respuesta: HTML con mensaje "No se han encontrado datos en la ubicación seleccionada" ⇒ punto **fuera**.

### Ejemplo 3 — DPH cartográfico

```
GET https://wms.mapama.gob.es/sig/Agua/DPHCartografico/wms.aspx
    ?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetFeatureInfo
    &LAYERS=Cauces%20con%20DPH%20cartogr%C3%A1fico
    &QUERY_LAYERS=Cauces%20con%20DPH%20cartogr%C3%A1fico
    &CRS=EPSG:4326
    &BBOX={lat_min},{lon_min},{lat_max},{lon_max}
    &WIDTH=101&HEIGHT=101&I=50&J=50
    &INFO_FORMAT=text/html
```

> El nombre de la capa contiene espacios y acento; URL-encodear siempre (`%20` para espacio, `%C3%A1` para `á`).

## Errores frecuentes

- **`ServiceException` con "service is not WMS"**: falta `SERVICE=WMS` o está mal escrito.
- **`NullReferenceException` (objeto no instanciado)**: normalmente aparece al probar endpoints que **no existen** (por ejemplo `ZI` o `ZFP` a secas). Los únicos nombres válidos comprobados son los listados arriba.
- **Respuesta vacía o HTTP 500**: el WMS del MITECO tiene microcaídas ocasionales. Reintentar tras 2-5 s antes de dar por malo el endpoint.
- **BBOX invertido**: en WMS 1.3.0 + EPSG:4326 el orden es lat,lon. Mezclarlo con WMS 1.1.1 (lon,lat) devuelve una zona fuera del mapa y el WMS responde "no data" incluso sobre puntos que sí están dentro.

## Cuándo usar GetMap

No es necesario para consulta puntual por IA — `GetFeatureInfo` basta. `GetMap` se usa para generar la imagen (PNG/JPEG) si se quiere mostrar la capa encima de otra cartografía.
