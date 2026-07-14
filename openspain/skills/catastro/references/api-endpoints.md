# Catastro API — Referencia completa de endpoints

## 1. list_provinces — Listar provincias

```
GET /json/ObtenerProvincias
Base: CALLEJERO
Params: (ninguno)
```

**Respuesta:**
```json
{
  "consulta_provincieroResult": {
    "control": { "cuerr1": "0" },
    "provinciero": {
      "prov": [
        { "np": "ALAVA", "cpine": "01" },
        { "np": "ALBACETE", "cpine": "02" }
      ]
    }
  }
}
```

Navegar: `consulta_provincieroResult.provinciero.prov[]`
Campos útiles: `np` (nombre), `cpine` (código INE)

---

## 2. search_municipalities — Buscar municipios

```
GET /json/ObtenerMunicipios
Base: CALLEJERO
Params:
  Provincia      string  MAYÚSCULAS  (requerido)
  Municipio      string  MAYÚSCULAS  (opcional, filtro parcial)
```

**Respuesta:**
```json
{
  "consulta_municipieroResult": {
    "control": { "cuerr1": "0" },
    "municipiero": {
      "muni": [
        {
          "nm": "MADRID",
          "locat": { "cd": "79", "cmc": "900" },
          "loine": { "cp": "28", "cm": "079" }
        }
      ]
    }
  }
}
```

Navegar: `consulta_municipieroResult.municipiero.muni[]`

| Campo | Significado |
|-------|-------------|
| `nm` | Nombre municipio |
| `locat.cd` | Código delegación catastro |
| `locat.cmc` | Código municipio catastro |
| `loine.cp` | Código INE provincia |
| `loine.cm` | Código INE municipio |

> `muni` puede ser objeto (1 resultado) o array (varios). Tratar siempre como lista.

---

## 3. search_streets — Buscar calles

```
GET /json/ObtenerCallejero
Base: CALLEJERO
Params:
  Provincia      string  MAYÚSCULAS  (requerido)
  Municipio      string  MAYÚSCULAS  (requerido)
  TipoVia        string  MAYÚSCULAS  (opcional, ej: CL, AV, PS)
  NomVia         string  MAYÚSCULAS  (opcional, substring contiguo del nombre normalizado — NO es LIKE flexible: sensible a artículos, tildes y abreviaturas. Usar el token más corto y distintivo)
```

**Respuesta:**
```json
{
  "consulta_callejeroResult": {
    "control": { "cuerr1": "0" },
    "callejero": {
      "calle": [
        {
          "dir": { "cv": "12345", "tv": "CL", "nv": "GRAN VIA" },
          "dirine": {
            "ecine": "...", "esine": "...", "nucine": "...",
            "vine": "...", "sine": "...", "deine": "GRAN VIA"
          }
        }
      ]
    }
  }
}
```

Navegar: `consulta_callejeroResult.callejero.calle[]`

| Campo | Significado |
|-------|-------------|
| `dir.cv` | Código catastro de vía (usar en search_numbers) |
| `dir.tv` | Tipo de vía (CL, AV, PS, PZ...) |
| `dir.nv` | Nombre de vía |
| `dirine.*` | Códigos INE de la vía |

> `calle` puede ser objeto o array. Tratar como lista.

---

## 4. search_numbers_by_street_code — Buscar números por código de vía

```
GET /json/ObtenerNumereroCodigos
Base: CODIGOS
Params:
  CodigoProvincia       string  (requerido, ej: "28")
  CodigoVia             string  (requerido, código cv de search_streets)
  Numero                string  (requerido, ej: "15")
  CodigoMunicipio       string  (uno de los dos es requerido)
  CodigoMunicipioINE    string  (uno de los dos es requerido)
```

**Respuesta:**
```json
{
  "consulta_numereroResult": {
    "control": { "cuerr1": "0" },
    "nump": [
      {
        "pc": { "pc1": "0000000", "pc2": "0000000", "car": "0000", "cc1": "0", "cc2": "0" },
        "num": { "pnp": "15", "plp": null }
      }
    ]
  }
}
```

Navegar: `consulta_numereroResult.nump[]`

**Referencia catastral**: concatenar `pc.pc1 + pc.pc2 + pc.car + pc.cc1 + pc.cc2`

> `nump` puede ser objeto o array. Tratar como lista.

---

## 5. get_property_by_refcat — Datos de inmueble por referencia catastral

```
GET /json/Consulta_DNPRC
Base: CALLEJERO
Params:
  RefCat    string  (requerido, 14 o 20 caracteres)
```

**Respuesta (inmueble único):**
```json
{
  "consulta_dnprcResult": {
    "control": { "cuerr1": "0" },
    "bico": {
      "bi": {
        "idbi": {
          "rc": { "pc1": "...", "pc2": "...", "car": "...", "cc1": "...", "cc2": "..." },
          "cn": "UR"
        },
        "debi": {
          "luso": "Residencial",
          "sfc": "85",
          "ant": "1975",
          "cpt": "100"
        },
        "dt": {
          "np": "MADRID",
          "nm": "MADRID",
          "locs": {
            "lous": {
              "lourb": {
                "dir": { "tv": "CL", "nv": "GRAN VIA", "pnp": "15" },
                "loint": { "bq": null, "es": "1", "pt": "3", "pu": "A" }
              }
            }
          }
        }
      },
      "finca": { "dff": { "ss": "120" } },
      "lcons": [
        { "lcd": "ELEMENTOS COMUNES", "dfcons": { "stl": "20" } }
      ]
    }
  }
}
```

**Respuesta (refcat de 14 chars → múltiples unidades):**
```json
{
  "consulta_dnprcResult": {
    "lrcdnp": {
      "rcdnp": [
        {
          "rc": { "pc1": "...", ... },
          "dt": { "locs": { "lous": { "lourb": { "loint": { "bq": "1", "es": "1", "pt": "2", "pu": "B" } } } } }
        }
      ]
    }
  }
}
```

Campos del inmueble:

| Campo | Significado |
|-------|-------------|
| `bi.idbi.cn` | Tipo: `UR` urbano, `RU` rústico |
| `bi.debi.luso` | Uso (Residencial, Comercial...) |
| `bi.debi.sfc` | Superficie construida m² |
| `bi.debi.ant` | Año construcción |
| `bi.debi.cpt` | Coeficiente de participación % |
| `bi.dt.np` | Provincia |
| `bi.dt.nm` | Municipio |
| `bi.dt.locs.lous.lourb.dir.tv` | Tipo vía |
| `bi.dt.locs.lous.lourb.dir.nv` | Nombre vía |
| `bi.dt.locs.lous.lourb.dir.pnp` | Número |
| `bi.dt.locs.lous.lourb.loint.es` | Escalera |
| `bi.dt.locs.lous.lourb.loint.pt` | Planta |
| `bi.dt.locs.lous.lourb.loint.pu` | Puerta |
| `finca.dff.ss` | Superficie parcela m² |

---

## 6. get_property_by_location — Datos de inmueble por dirección

```
GET /json/Consulta_DNPLOC
Base: CALLEJERO
Params:
  Provincia    string  MAYÚSCULAS  (requerido)
  Municipio    string  MAYÚSCULAS  (requerido)
  Sigla        string  MAYÚSCULAS  (requerido, tipo vía: CL, AV, PS...)
  Calle        string  MAYÚSCULAS  (requerido, nombre SIN tipo)
  Numero       string              (requerido)
```

Respuesta: mismo formato que `Consulta_DNPRC` (ver endpoint 5).

---

## 7. get_refcat_from_coordinates — Refcat desde coordenadas

```
GET /json/Consulta_RCCOOR
Base: COORDENADAS
Params:
  SRS      string  (requerido, sistema de referencia: "EPSG:4326" para WGS84 lat/lon)
  CoorX    float   (requerido, longitud si WGS84)
  CoorY    float   (requerido, latitud si WGS84)
```

**Sistemas de referencia habituales:**
- `EPSG:4326` — WGS84 (lat/lon estándar, Google Maps)
- `EPSG:25830` — UTM zona 30N (frecuente en catastro)
- `EPSG:4230` — ED50

**Respuesta:**
```json
{
  "Consulta_RCCOORResult": {
    "control": { "cuerr1": "0" },
    "coordenadas": {
      "coord": {
        "pc": { "pc1": "...", "pc2": "...", "car": "...", "cc1": "...", "cc2": "..." },
        "geo": { "xcen": "-3.703", "ycen": "40.416", "srs": "EPSG:4326" },
        "ldt": "CL GRAN VIA 15 MADRID [MADRID]"
      }
    }
  }
}
```

Navegar: `Consulta_RCCOORResult.coordenadas.coord`
Campos: `pc.*` (refcat), `geo.xcen/ycen/srs` (coordenadas centroide), `ldt` (etiqueta dirección)

> `coord` puede ser objeto o array. Tratar como lista, usar primer elemento.

---

## 8. get_coordinates_from_refcat — Coordenadas desde refcat

```
GET /json/Consulta_CPMRC
Base: COORDENADAS
Params:
  RefCat    string  (requerido)
  SRS       string  (opcional, sistema de salida, default EPSG:4326)
```

**Respuesta:** Mismo formato que `Consulta_RCCOOR` (ver endpoint 7).

Navegar: `Consulta_CPMRCResult.coordenadas.coord`

---

## 9. get_property_by_polygon_parcel — Inmueble rústico por polígono y parcela

```
GET /json/Consulta_DNPPP
Base: CALLEJERO
Params:
  Provincia    string  MAYÚSCULAS  (requerido)
  Municipio    string  MAYÚSCULAS  (requerido)
  Poligono     string              (requerido)
  Parcela      string              (requerido)
```

Respuesta: mismo formato que `Consulta_DNPRC` más `rural_location`:
```json
{
  "rural_location": { "polygon": "14", "parcel": "532" }
}
```

Rústico: navegar `bi.dt.locs.lors.lorus.cpp` → `cpo` (polígono), `cpa` (parcela).

---

## 10. get_nearby_refcats — Refcats cercanas a un punto

```
GET /json/Consulta_RCCOOR_Distancia
Base: COORDENADAS
Params:
  SRS      string  (requerido, ej: "EPSG:4326")
  CoorX    float   (requerido)
  CoorY    float   (requerido)
```

**Respuesta:**
```json
{
  "Consulta_RCCOOR_DistanciaResult": {
    "control": { "cuerr1": "0" },
    "coordenadas_distancias": {
      "coordd": {
        "lpcd": [
          {
            "pc": { "pc1": "...", "pc2": "...", "car": "...", "cc1": "...", "cc2": "..." },
            "dis": "12",
            "ldt": "CL MAYOR 1 MADRID [MADRID]"
          }
        ]
      }
    }
  }
}
```

Navegar: `Consulta_RCCOOR_DistanciaResult.coordenadas_distancias.coordd[0].lpcd[]`
Campos: `pc.*` (refcat), `dis` (distancia en metros), `ldt` (etiqueta)

---

## Patrón común para arrays en respuestas

La API puede devolver un objeto `{}` cuando hay 1 resultado o un array `[]` cuando hay varios. **Siempre tratar como lista**: si es objeto, envolverlo en `[...]`.

## Flujo de error

```
response_root → control → cuerr1/cuerr2/... > "0" → hay error
                        → lerr.err → puede ser {} u []
                          → err.cod   (código numérico)
                          → err.des   (descripción legible)
```

Códigos comunes:
- Descripción con "NO EXISTE" / "NO HAY" → recurso no encontrado
- Descripción con "OBLIGATORI" / "FORMATO" / "INVALI" → parámetro incorrecto
