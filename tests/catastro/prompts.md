# Tests manuales — skill Catastro

Pruebas para verificar que el agente usa correctamente la skill `catastro` en lugar de responder de memoria o inventar referencias catastrales.

## Test 1 — Inmueble por dirección

**Pregunta**: "Dame los datos catastrales de la Gran Vía 1 de Madrid: referencia catastral, uso, superficie construida y año de construcción."

**Pasa si**:
- El agente normaliza los parámetros a mayúsculas y separa el tipo de vía (`Sigla=CL`, `Calle=GRAN VIA`).
- Hace una llamada GET a `https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/Consulta_DNPLOC` con `Provincia=MADRID`, `Municipio=MADRID`, `Sigla=CL`, `Calle=GRAN VIA`, `Numero=1` (o sigue el workflow `ObtenerProvincias` → `ObtenerMunicipios` → `ObtenerCallejero` → `ObtenerNumereroCodigos` → `Consulta_DNPRC`).
- Devuelve al menos una referencia catastral real concatenando `pc1 + pc2 + car + cc1 + cc2` (20 caracteres) junto con `luso`, `sfc` y `ant` leídos de la respuesta.
- Si hay varios inmuebles en la finca (lo habitual en Gran Vía 1), lo indica y lista algunos con su planta/puerta (`loint.pt`, `loint.pu`).

**Falla si**:
- Inventa una referencia catastral sin llamar a la API.
- Envía los parámetros en minúsculas o con tildes (`Gran Vía`) en vez de mayúsculas.
- Mete el tipo de vía dentro de `Calle` (`Calle=CL GRAN VIA`) y obtiene un error.
- Ignora el wrapper `.consulta_dnplocResult.lrcdnp.rcdnp` y responde con texto genérico.

---

## Test 2 — Refcat por coordenadas WGS84

**Pregunta**: "¿A qué inmueble corresponden las coordenadas 40.4153, -3.7033? Dame la referencia catastral y la dirección."

**Pasa si**:
- El agente reconoce que el formato es lat/lon WGS84 y usa `SRS=EPSG:4326`.
- Llama a `https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc/json/Consulta_RCCOOR` con `CoorX=-3.7033` (longitud) y `CoorY=40.4153` (latitud), en ese orden.
- Devuelve la referencia catastral concatenada desde `coord.pc` y la etiqueta `ldt` con una dirección real del centro de Madrid (zona Sol / Carretas).
- Opcionalmente encadena con `Consulta_DNPRC` para dar detalles del inmueble (uso, superficie, año).

**Falla si**:
- Intercambia longitud y latitud (`CoorX=40.4153`, `CoorY=-3.7033`) y obtiene un error o un resultado absurdo.
- Usa un SRS incorrecto (por ejemplo `EPSG:25830` con valores lat/lon sin proyectar).
- Inventa una dirección sin llamar a la API o sin leer el campo `ldt`.
- No detecta el error reportado por la API cuando alguna clave `cuerr*` del `control` es mayor que 0.
