---
name: snczi
description: "Use when the user asks if a point, parcel or address in Spain is inside a flood zone (zona inundable), the Public Hydraulic Domain (DPH, Dominio Público Hidráulico), the police zone (zona de policía, 100 m buffer around DPH) or the easement zone (zona de servidumbre, 5 m buffer). Official source: Sistema Nacional de Cartografía de Zonas Inundables (SNCZI, MITECO). Triggers on: 'SNCZI', 'zona inundable', 'zonas inundables', 'riesgo inundación', 'riesgo de inundación', 'dominio público hidráulico', 'DPH', 'zona de policía', 'zona policía', 'zona de servidumbre', 'zona servidumbre', 'zona de flujo preferente', 'flujo preferente', 'ZFP', 'inundabilidad parcela', 'inundabilidad coordenadas', 'inundabilidad refcat', 'cauces', 'RD 849/1986', 'reglamento DPH'. No installation required — consults the public MITECO WMS endpoints directly via WebFetch."
license: MIT
---

# SNCZI — Zonas inundables y DPH vía WMS MITECO

Permite responder a "¿este punto / esta parcela / esta dirección está en zona inundable, en DPH o en zona de policía?" consultando los servicios WMS OGC públicos del Ministerio para la Transición Ecológica (MITECO) / SNCZI. No requiere autenticación.

Cobertura: todo el territorio nacional excepto **País Vasco y Navarra** (cartografías propias no federadas en el SNCZI).

## Capas WMS disponibles

Todas las capas siguen el patrón `https://wms.mapama.gob.es/sig/Agua/{layer}/wms.aspx` y exponen `GetCapabilities`, `GetMap` y `GetFeatureInfo`.

| Capa WMS              | URL base `wms.mapama.gob.es/sig/Agua/...` | Layer name            | Contenido                                  |
|-----------------------|-------------------------------------------|-----------------------|--------------------------------------------|
| Z.I. T=10 (alta)      | `ZI_LaminasQ10/wms.aspx`                  | `NZ.RiskZone`         | Z.I. con alta probabilidad (T=10 años)     |
| Z.I. T=100 (media)    | `ZI_LaminasQ100/wms.aspx`                 | `NZ.RiskZone`         | Z.I. con probabilidad media (T=100 años)   |
| Z.I. T=500 (baja)     | `ZI_LaminasQ500/wms.aspx`                 | `NZ.RiskZone`         | Z.I. con probabilidad baja (T=500 años)    |
| DPH cartográfico      | `DPHCartografico/wms.aspx`                | `Cauces con DPH`      | Cauces con Dominio Público Hidráulico      |

Detalle completo de parámetros WMS, CRS soportados y ejemplos de respuesta en [references/wms-endpoints.md](references/wms-endpoints.md).

## Reglas de entrada (CRÍTICO)

El usuario puede indicar el punto de tres formas. Resolver siempre a **(lat, lon) en EPSG:4326** antes de llamar al WMS.

1. **Coordenadas directas** (lat, lon en WGS84) → usar tal cual.
2. **Referencia catastral** (refcat, 14 o 20 caracteres) → delegar en la skill `catastro`:
   - Endpoint `https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc/json/Consulta_CPMRC?RefCat={refcat}&SRS=EPSG:4326`
   - La respuesta trae `coord.geo.xcen` (longitud) y `coord.geo.ycen` (latitud).
3. **Dirección postal** → delegar en `catastro`:
   - Workflow: `ObtenerProvincias` → `ObtenerMunicipios` → `ObtenerCallejero` → `ObtenerNumereroCodigos` para obtener refcat, y de ahí a coordenadas con `Consulta_CPMRC`.
   - Alternativa más corta si ya se tiene provincia/municipio/calle/número: `Consulta_DNPLOC` y luego `Consulta_CPMRC` con el refcat.

> ⚠️ No inventar coordenadas ni refcats. Si el usuario da solo una dirección genérica ("un solar cerca del río Segura"), pedir precisión antes de llamar al WMS.

## Consulta WMS punto → capa

Para cada capa relevante, construir una petición `GetFeatureInfo` con un BBOX pequeño centrado en (lat, lon) y pedir si el punto cae dentro.

Plantilla (EPSG:4326, sustituir `{lat}`, `{lon}`, `{layer_name}` y `{wms_path}`):

```
GET https://wms.mapama.gob.es/sig/Agua/{wms_path}/wms.aspx
    ?SERVICE=WMS
    &VERSION=1.3.0
    &REQUEST=GetFeatureInfo
    &LAYERS={layer_name}
    &QUERY_LAYERS={layer_name}
    &CRS=EPSG:4326
    &BBOX={lat_min},{lon_min},{lat_max},{lon_max}
    &WIDTH=101
    &HEIGHT=101
    &I=50
    &J=50
    &INFO_FORMAT=text/html
```

Donde el BBOX se construye con offset `d = 0.0001°` (≈ 11 m):

- `lat_min = lat - d`, `lat_max = lat + d`
- `lon_min = lon - d`, `lon_max = lon + d`

> ⚠️ Con `VERSION=1.3.0` y `CRS=EPSG:4326` el orden del BBOX es **lat primero, lon después** (`lat_min,lon_min,lat_max,lon_max`). Con `VERSION=1.1.1` y `SRS=EPSG:4326` sería lon primero. No mezclar versiones.

### Cómo interpretar la respuesta

- `INFO_FORMAT=text/html` devuelve una tabla HTML. Si contiene filas con atributos (por ejemplo `FID`, `PERIODO_RETORNO`, `COD_MASA`…), el punto está **dentro** de la capa.
- Si el cuerpo contiene literalmente "No se han encontrado datos" o equivalente, el punto está **fuera**.
- `INFO_FORMAT=application/vnd.ogc.gml` o `text/xml` están disponibles para parseo estructurado, pero el HTML es más robusto para lectura por LLM.

## Workflow recomendado

```
1. Normalizar entrada → (lat, lon) en EPSG:4326 (usar skill `catastro` si viene refcat/dirección).
2. Construir BBOX pequeño alrededor del punto.
3. Lanzar 4 peticiones GetFeatureInfo (una por capa: T=10, T=100, T=500, DPH).
4. Marcar cada capa como "dentro" o "fuera".
5. Resumir al usuario:
   - Si T=10 → alta probabilidad de inundación
   - Si T=100 → probabilidad media (escenario urbanístico de referencia, RD 9/2008)
   - Si T=500 → probabilidad baja
   - Si DPH → el punto invade el cauce (prohibición casi total de ocupación)
6. Indicar fuente (SNCZI, MITECO) y fecha de la consulta.
```

## Zona de policía y zona de servidumbre

El Reglamento del DPH ([RD 849/1986](https://www.boe.es/buscar/act.php?id=BOE-A-1986-10638), arts. 6 y 7) define dos franjas contiguas al DPH:

- **Zona de servidumbre**: 5 m desde el límite del DPH. Uso público (tránsito peatonal, vigilancia, salvamento). Construcciones muy restringidas.
- **Zona de policía**: 100 m desde el límite del DPH. Requiere autorización previa de la Confederación Hidrográfica para cualquier movimiento de tierras, construcción o actividad que pueda alterar el cauce o el escurrimiento.

El SNCZI **no publica capas WMS específicas** de zona de policía/servidumbre — se derivan como **buffer geométrico sobre el DPH cartográfico**. Dos estrategias:

1. **Aproximación por WMS** (sin instalación): consultar `DPHCartografico` en un **BBOX ampliado** de ±100 m (lat/lon ≈ ±0.001°). Si la respuesta contiene el cauce, el punto está probablemente en zona de policía; no es exacto, pero da señal suficiente para responder "consulta obligatoria con la Confederación Hidrográfica".
2. **Cálculo exacto** (requiere instalación): usar el MCP opcional — ver sección "Implementación MCP".

Si el usuario pide un dictamen legal exacto (por ejemplo para un proyecto constructivo), **siempre** recomendar consulta con la Confederación Hidrográfica competente: la cartografía del SNCZI es orientativa.

## Zona de flujo preferente (ZFP)

El SNCZI publica la ZFP solo como capa del visor oficial, sin WMS público estable bajo nombres predictibles. Si el usuario pregunta específicamente por ZFP:

- Aproximar con la lámina T=100 (Z.I. probabilidad media) **más** la vía de intenso desagüe, que forma parte de la ZFP por definición.
- Recomendar consulta directa al visor: https://sig.miteco.gob.es/snczi/index.html?herramienta=DPHZI
- No afirmar que un punto está o no en ZFP sin verificación adicional.

## Implementación MCP (opcional)

Hay un servidor MCP en [mcps/snczi/](../../mcps/snczi/) que expone estos tools:

- `check_flood_zone(lat, lon, refcat?, address?)` — devuelve booleanos para T=10/100/500 y DPH.
- `check_dph(lat, lon | refcat)` — indica si el punto está sobre DPH cartográfico.
- `check_zona_policia_servidumbre(lat, lon | refcat)` — calcula buffers exactos de 5 m y 100 m sobre el DPH.
- `get_snczi_report(lat, lon | refcat | address)` — reporte combinado con interpretación.

Instalar solo si el agente soporta MCP y el usuario requiere precisión en buffers — para Claude Code / Claude Desktop basta esta skill.

## Cuándo NO usar esta skill

- Predicción meteorológica de lluvias o alertas de inundación inminente → **aemet**.
- Consulta del texto del RD 849/1986 u otras normas hidráulicas → **boe**.
- Datos ambientales genéricos (embalses, calidad del aire, Red Natura) → **miteco**.
- Datos protegidos del inmueble (titularidad, valor catastral) → no accesibles; redirigir a Sede Electrónica del Catastro.
- Trámite real ante la Confederación Hidrográfica (autorización en zona de policía, concesión) → redirigir a la sede de la confederación correspondiente (Tajo, Duero, Ebro, Guadiana, Guadalquivir, Júcar, Segura, Miño-Sil, Cantábrico).

## Fuentes y marco legal

- Visor oficial SNCZI: https://sig.miteco.gob.es/snczi/index.html?herramienta=DPHZI
- Portal SNCZI (MITECO): https://www.miteco.gob.es/es/agua/temas/gestion-de-los-riesgos-de-inundacion/snczi.html
- [Directiva 2007/60/CE](https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:32007L0060) relativa a la evaluación y gestión de los riesgos de inundación.
- [RD 903/2010](https://www.boe.es/buscar/act.php?id=BOE-A-2010-11184) de evaluación y gestión de riesgos de inundación.
- [RD 849/1986](https://www.boe.es/buscar/act.php?id=BOE-A-1986-10638) Reglamento del Dominio Público Hidráulico.
