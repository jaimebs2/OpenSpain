# Tests manuales — skill CNIG (CartoCiudad / IGN)

Pruebas para verificar que el agente usa correctamente la skill `cnig` en lugar de responder de memoria o inventar coordenadas.

## Test 1 — Geocodificación directa de una dirección

**Pregunta**: "¿Cuáles son las coordenadas (lat/lon) de la Puerta del Sol de Madrid según el IGN?"

**Pasa si**:
- El agente llama a `https://www.cartociudad.es/geocoder/api/geocoder/find?q=Puerta%20del%20Sol%2C%20Madrid...` con GET.
- Devuelve `lat` y `lng` en torno a `40.417, -3.702` (WGS84) extraídos del JSON de CartoCiudad.
- Menciona el municipio (`Madrid`), la provincia y, si está disponible, el código postal o la referencia catastral devueltos por la API.
- Cita la fuente como IGN / CartoCiudad (CC BY 4.0 ign.es).

**Falla si**:
- Responde con coordenadas de memoria sin llamar a la API.
- Usa la variante `findJsonp` (que devuelve `callback(...)` y no JSON puro).
- Inventa una referencia catastral o un código postal.

---

## Test 2 — Búsqueda de topónimo / municipio

**Pregunta**: "Busca 'Santiago del Teide' en el nomenclátor del IGN y dime en qué provincia y comunidad autónoma está."

**Pasa si**:
- El agente llama a `https://www.cartociudad.es/geocoder/api/geocoder/candidates?q=Santiago%20del%20Teide...` con GET.
- Identifica al menos una entrada con `type = "Municipio"` o `type = "poblacion"`.
- Responde que está en la provincia de **Santa Cruz de Tenerife**, comunidad autónoma de **Canarias**, a partir de los campos `province` y `comunidadAutonoma` devueltos por la API.
- Si el usuario pregunta por coordenadas concretas del municipio y `lat`/`lng` vienen a `0.0`, hace una segunda llamada a `/find` para obtenerlas.

**Falla si**:
- Responde con la ubicación de memoria sin tocar la API.
- Confunde Santiago del Teide (municipio) con el Teide (volcán, que no está en CartoCiudad).
- Inventa una llamada a un endpoint inexistente (`NomencladorServicio`, etc.).
