---
name: cnig
description: "Use when the user wants to geocode Spanish addresses, convert coordinates to addresses, or look up place names (municipalities, localities, streets, toponyms) in Spain using the IGN / CNIG CartoCiudad public API. Triggers on: 'CNIG', 'IGN', 'CartoCiudad', 'geocodificar', 'geocodificación', 'topónimo', 'cartografía España', 'coordenadas dirección', 'buscar dirección', 'lat lon España', 'municipio España'."
license: MIT
---

# CNIG / IGN — API de CartoCiudad (geocodificación y topónimos)

API pública del Instituto Geográfico Nacional (IGN) / Centro Nacional de Información Geográfica (CNIG), sin autenticación. Usar WebFetch con GET.

Base: `https://www.cartociudad.es/geocoder/api/geocoder`

> Existen variantes con sufijo `Jsonp` (`findJsonp`, `candidatesJsonp`) que envuelven la respuesta en `callback(...)`. **No usar esas variantes desde WebFetch**: usar siempre los endpoints sin `Jsonp`, que devuelven JSON puro.

## Operaciones

### 1. Geocodificación directa — dirección a coordenadas

```
GET /find?q={direccion}&limit={n}
```

- `q`: dirección en texto libre (calle, número, municipio, provincia). URL-encode obligatorio.
- `limit`: opcional, entero. CartoCiudad suele devolver un único mejor candidato.

Ejemplo: `https://www.cartociudad.es/geocoder/api/geocoder/find?q=Puerta%20del%20Sol%2C%20Madrid&limit=5`

Devuelve un objeto JSON con, entre otros:

```
id                → identificador interno
address           → nombre de la vía normalizado
tip_via           → tipo de vía (CALLE, PLAZA, AVENIDA, ...)
portalNumber      → número de portal si aplica
muni              → municipio
province          → provincia
comunidadAutonoma → comunidad autónoma
postalCode        → código postal
lat, lng          → latitud y longitud (WGS84)
geom              → geometría WKT (POINT o MULTILINESTRING)
type              → tipo del resultado (portal, callejero, poblacion, Municipio, ...)
refCatastral      → referencia catastral del portal (si está disponible)
countryCode       → "011" para España
```

### 2. Geocodificación inversa — coordenadas a dirección

```
GET /reverseGeocode?lon={lon}&lat={lat}
```

- `lon`, `lat`: coordenadas en WGS84 (grados decimales).

Ejemplo: `https://www.cartociudad.es/geocoder/api/geocoder/reverseGeocode?lon=-3.70237&lat=40.41696`

Devuelve un objeto con los mismos campos que `find` para el portal/vía más cercano.

### 3. Búsqueda de candidatos / topónimos por nombre

```
GET /candidates?q={texto}&limit={n}
```

- `q`: texto libre (nombre de municipio, localidad, topónimo, calle). URL-encode obligatorio.
- `limit`: opcional, entero (por defecto unos 5–10).

Ejemplo: `https://www.cartociudad.es/geocoder/api/geocoder/candidates?q=Teide&limit=10`

Devuelve una **lista** de objetos con los mismos campos que `find`. Cada entrada incluye `type` con valores como:

- `Municipio` — municipio completo
- `poblacion` — núcleo de población dentro de un municipio
- `callejero` — vía urbana (calle, plaza, avenida)
- `portal` — portal concreto de una vía

Para municipios/poblaciones puede que `lat`/`lng` vengan a `0.0` y `geom` a `null`. En ese caso, para obtener coordenadas exactas del elemento, hacer una segunda llamada a `/find` con `q = "{address}, {muni}, {province}"`.

## Consejos

- URL-encode siempre el parámetro `q` (espacios → `%20`, comas → `%2C`, tildes → porcentaje).
- Para direcciones concretas, incluir siempre municipio y a ser posible provincia en `q` para desambiguar.
- Si el usuario pide un topónimo natural (monte, río, paraje), `candidates` solo cubre lo presente en CartoCiudad (sobre todo callejero, núcleos y municipios). Si no aparece, indicar al usuario que el topónimo no está en CartoCiudad y que la información exhaustiva del Nomenclátor Geográfico Básico de España (NGBE) del IGN solo está expuesta vía WFS (XML), no directamente accesible con WebFetch.
- Cobertura nacional; País Vasco y Navarra pueden tener menos detalle en algunos campos.
- Licencia de los datos: **CC BY 4.0 ign.es**. Al citar coordenadas o direcciones, mencionar la fuente (IGN / CartoCiudad).
