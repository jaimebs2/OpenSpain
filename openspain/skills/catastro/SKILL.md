---
name: catastro
description: "Use when the user wants to query the Spanish Cadastre (Catastro) — search streets, municipalities, provinces, get property data by address or refcat, look up coordinates. Triggers on: 'catastro', 'referencia catastral', 'buscar calle', 'inmueble', 'parcela', 'municipio catastro', 'provincia catastro', 'coordenadas catastro', 'refcat'. No installation required — calls the public Catastro JSON API directly via WebFetch."
license: MIT
---

# Catastro — API pública del Catastro español

Permite consultar el Catastro sin instalar nada. La API es pública, sin autenticación, HTTP GET + JSON.

## Base URLs

```
CALLEJERO    https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc
CODIGOS      https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejeroCodigos.svc
COORDENADAS  https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc
```

Todos los endpoints usan `/json/<Metodo>` y parámetros query string.

## Reglas de normalización (CRÍTICO)

Antes de enviar cualquier parámetro de texto:
- Convertir a **MAYÚSCULAS**
- Eliminar espacios sobrantes (trim + collapse)
- Los parámetros de texto de callejero van en mayúsculas sin tildes cuando sea posible
- El tipo de vía puede ir incluido en el nombre (el API lo extrae internamente)

Tipos de vía reconocidos: `CL` (Calle/C/), `AV`/`AVDA` (Avenida), `PS` (Paseo), `PZ` (Plaza), `CR` (Carretera), `CM` (Camino), `TR` (Travesía), `GL` (Glorieta), `PJ` (Pasaje), `BO` (Barrio), `UR`/`URB` (Urbanización), `RD` (Ronda).

Si el nombre de calle incluye el tipo (`"CALLE MAYOR"`), separarlo: `TipoVia=CL`, `NomVia=MAYOR`.

## Workflow recomendado para buscar una dirección

```
1. list_provinces          → obtener nombre exacto de provincia
2. search_municipalities   → obtener códigos cd (delegación) y cmc (municipio catastro)
3. search_streets          → obtener cv (código catastro de vía) y tv (tipo vía)
4. search_numbers          → obtener refcat para un número concreto
5. get_property_by_refcat  → datos completos del inmueble
```

> ⚠️ **No saltar al paso 5 con `get_property_by_location` directamente**
> aunque el usuario te dé la dirección "completa". El callejero catastral
> usa una forma normalizada concreta (`VEREDA DEL PALACIO`, no `VEREDA DE
> PALACIO`) y el matching es **exacto, contiguo y sensible a artículos,
> tildes y abreviaturas**. Validar siempre primero el nombre real con
> `search_streets` usando el **token más distintivo y corto** del nombre
> (ej: `PALACIO`, no la frase entera), y luego usar la forma exacta de
> `dir.nv` para la consulta del inmueble.

> ⚠️ La API **ignora silenciosamente parámetros mal escritos** en lugar de
> dar error. Si pones `NombreVia` en vez de `NomVia`, recibirás el
> municipio entero como si no hubieras filtrado. Verificar siempre los
> nombres exactos de los parámetros en
> [references/api-endpoints.md](references/api-endpoints.md).

## Cómo hacer las llamadas

Usar `WebFetch` con GET. Ejemplo para listar provincias:

```
GET https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/ObtenerProvincias
```

Ejemplo con parámetros (buscar municipios de Madrid):
```
GET https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/ObtenerMunicipios?Provincia=MADRID
```

## Estructura de respuesta — cómo detectar errores

Cada respuesta tiene un wrapper raíz (ver referencias). Dentro buscar el campo `control`:
- Si alguna key empieza por `cuerr` y su valor es > 0 → hay error
- Los errores están en `lerr.err[].des` (descripción) y `lerr.err[].cod` (código)

Ejemplo de error:
```json
{
  "control": { "cuerr1": "1" },
  "lerr": { "err": { "cod": "2", "des": "NO EXISTE LA PROVINCIA" } }
}
```

## Campos clave en respuestas

| Campo | Significado |
|-------|-------------|
| `np`  | Nombre de provincia |
| `cpine` | Código INE de provincia |
| `nm`  | Nombre de municipio |
| `locat.cd` | Código delegación catastro |
| `locat.cmc` | Código municipio catastro |
| `loine.cp` | Código INE provincia |
| `loine.cm` | Código INE municipio |
| `dir.cv` | Código catastro de vía |
| `dir.tv` | Tipo de vía (CL, AV, PS...) |
| `dir.nv` | Nombre de vía |
| `dir.pnp` | Número de portal |
| `pc1`, `pc2`, `car`, `cc1`, `cc2` | Partes de la referencia catastral |
| `cn` | Tipo de bien (UR = urbano, RU = rústico) |
| `luso` | Uso del inmueble |
| `sfc` | Superficie construida m² |
| `ant` | Año de construcción |
| `cpt` | Coeficiente de participación |

**Referencia catastral completa**: concatenar `pc1 + pc2 + car + cc1 + cc2` (20 caracteres).

## Referencia detallada de endpoints

Para documentación completa de cada endpoint (parámetros, respuesta JSON, ejemplos):
→ Ver [references/api-endpoints.md](references/api-endpoints.md)
