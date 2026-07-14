# Tests manuales — skill RTVE

Pruebas para verificar que el agente usa correctamente la skill `rtve` en lugar de responder de memoria. La API de RTVE **no es oficialmente abierta**: si los endpoints cambian, el agente debe avisar y no inventar datos.

## Test 1 — Últimas noticias en rtve.es

**Pregunta**: "Dame las 5 últimas noticias publicadas en RTVE con su titular y enlace."

**Pasa si**:
- El agente llama a `https://api.rtve.es/api/noticias.json?size=5` (o un `size` similar) con el header `Accept: application/json`.
- Lista 5 items reales con `title`, `publicationDate` y `htmlUrl` extraídos de `.page.items[]`.
- Los enlaces devueltos apuntan a `www.rtve.es/...` y son válidos.

**Falla si**:
- Inventa titulares o usa información desactualizada de su entrenamiento sin tocar la API.
- Usa POST en lugar de GET.
- Omite `Accept: application/json`.
- Inventa URLs `rtve.es/...` que no provienen del JSON.

---

## Test 2 — Buscar un programa por nombre y devolver su ficha

**Pregunta**: "¿Qué sabes del programa 'Estadio 2' de Teledeporte? Dame su descripción, presentador y enlace en RTVE Play."

**Pasa si**:
- El agente reconoce que la API no tiene búsqueda full-text fiable y trae un listado (`/api/programas.json?size=50` u otra página) y filtra en memoria por `name`.
- Cuando encuentra el `id` (`1029900` aprox.), hace `GET /api/programas/{id}.json` para traer la ficha completa.
- Devuelve `description` o `longDescription`, `channel.title == "Teledeporte"`, `showMan` (presentador) y `htmlUrl` reales obtenidos del JSON.
- Si la API falla (404/5xx), avisa al usuario explícitamente de que el endpoint puede haberse movido y NO inventa datos.

**Falla si**:
- Recita información del programa de memoria sin tocar la API.
- Inventa un id de programa o un htmlUrl.
- Confunde el host (`api.rtve.es` vs `www.rtve.es`) sin probar el correcto.
