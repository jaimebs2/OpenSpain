# Tests manuales — dataestur

## Test 1 — FRONTUR: turistas extranjeros

**Pregunta**: "¿Cuántos turistas extranjeros llegaron a España en enero de 2025 por país de origen?"

**Pasa si**:
- Construye la URL de descarga del FRONTUR filtrada a enero 2025:
  `https://dataestur.azure-api.net/API-SEGITTUR-v1/FRONTUR_DL?desde%20(a%C3%B1o)=2025&desde%20(mes)=1&hasta%20(a%C3%B1o)=2025&hasta%20(mes)=1`
- Indica que el fichero XLSX contiene las columnas: AÑO, MES, PAIS_RESIDENCIA, TIPO_VISITANTE, CCAA_DESTINO, VISITANTES
- Proporciona la URL al usuario para que descargue el Excel

**Falla si**:
- Inventa cifras de turistas sin descargar el XLSX
- Responde con datos genéricos de memoria sobre turismo en España
- Usa datos del INE sin indicar que está usando una fuente distinta

---

## Test 2 — EGATUR: gasto turístico

**Pregunta**: "Dame los datos de gasto turístico de los visitantes extranjeros en España en 2024."

**Pasa si**:
- Construye la URL del endpoint EGATUR_DL filtrada al año 2024
- Explica que el XLSX contiene gasto por país de residencia, tipo de visitante y CCAA
- Si intenta descargar el XLSX y tiene acceso a herramientas de ejecución, muestra un resumen de los datos

**Falla si**:
- Confunde EGATUR (gasto) con FRONTUR (número de visitantes)
- Inventa cifras de gasto sin consultar la API
- Devuelve una URL HTML del portal de turismo en vez de la URL de descarga del XLSX
