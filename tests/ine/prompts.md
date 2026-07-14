# Tests manuales — INE

## Test 1 — IPC mensual reciente
**Pregunta**: "¿Cuál ha sido la variación mensual del IPC general en España en los últimos meses?"
**Pasa si**: Devuelve una lista de valores reales con mes/año y variación en porcentaje, obtenidos de `DATOS_SERIE` (serie `IPC206449` u otra serie IPC equivalente). Menciona explícitamente que los datos vienen del INE.
**Falla si**: Responde con cifras genéricas "de memoria" sin llamar a la API del INE, o inventa meses posteriores a la última publicación oficial.

## Test 2 — Búsqueda de serie por operación
**Pregunta**: "¿Qué series publica el INE sobre la Encuesta de Población Activa (EPA)?"
**Pasa si**: Llama a `SERIES_OPERACION/EPA?page=1` (y páginas siguientes si hace falta) y devuelve una muestra de series reales con su `COD` y `Nombre`, explicando que hay paginación.
**Falla si**: Lista series inventadas, confunde `Id` con `COD`, o no llega a hacer ninguna petición al endpoint Wstempus.
