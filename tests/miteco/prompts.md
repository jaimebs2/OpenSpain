# Tests manuales — miteco

## Test 1 — Estado de embalses

**Pregunta**: "¿Hay datos abiertos del estado de los embalses en España que pueda descargar?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/embalses?_pageSize=...&_format=json`.
- Devuelve al menos 2 datasets con título real que contenga "embalse"
  (p.ej. "Estado Embalses", "Embalses de las demarcaciones hidrográficas
  del Guadalquivir, Ceuta y Melilla").
- Extrae `distribution[].accessURL` de al menos un dataset y muestra una
  URL concreta de descarga (preferentemente CSV o JSON).
- Indica el formato (`text/csv`, `application/json`, …) y el tamaño si
  está disponible.
- Si el dataset pertenece a una comunidad autónoma concreta (Navarra,
  País Vasco…) y no al conjunto de España, lo advierte explícitamente.

**Falla si**:
- Inventa URLs de `miteco.gob.es`, `chebro.es` o confederaciones sin
  haberlas obtenido de la API de datos.gob.es.
- Usa el parámetro `?q=` en vez de `/title/` (devuelve 400).
- Responde con porcentajes de llenado inventados de memoria sin consultar
  la API.

---

## Test 2 — Red Natura 2000 y espacios protegidos

**Pregunta**: "Quiero un listado de los espacios protegidos de la Red Natura 2000 en España, ¿de dónde lo saco?"

**Pasa si**:
- Llama a `https://datos.gob.es/apidata/catalog/dataset/title/red%20natura?...&_format=json`.
- Identifica al menos un dataset relevante (por ejemplo, "Base de datos de
  los espacios protegidos Red Natura 2000 de España (CNTRYES)" o "Red
  Natura 2000. Zonas de Especial Protección de Aves (ZEPA)").
- Muestra al usuario la `accessURL` real y el formato de la distribución.
- Si la distribución es geoespacial (SHP, GML, ZIP), advierte que se
  necesita un cliente GIS o busca una distribución tabular alternativa.

**Falla si**:
- Recita de memoria el número aproximado de ZEPA o ZEC en España sin
  haber descargado ningún fichero.
- Devuelve la URL HTML de la página de datos.gob.es en vez de la
  `accessURL` real.
- Recomienda ir manualmente al visor de MITECO sin intentar antes la API.
