---
name: rtve
description: "Use when the user wants to query the public catalog of Radio Televisión Española (RTVE) — Spain's public broadcaster: list recent noticias (news items) on rtve.es, browse programas (TV/radio shows) including the RTVE archive, list videos a la carta, list channels (TVE, La 1, La 2, 24H, Clan, Teledeporte, RNE, Radio Clásica), or look up a noticia/programa/video by id. Triggers on: 'RTVE', 'TVE', 'La 1', 'La 2', '24H', 'Teledeporte', 'RNE', 'radio nacional', 'Radio Clásica', 'programa España', 'archivo noticias RTVE', 'a la carta'."
license: MIT
---

# RTVE — API pública (no oficial) de Radio Televisión Española

API REST-JSON sin autenticación, descubierta a partir del portal `www.rtve.es`. Usar `WebFetch` con **GET** y siempre el header `Accept: application/json`.

## Aviso importante (decir al usuario si aplica)

Esta API **no es oficialmente abierta**: CRTVE no publica contrato ni garantías. Endpoints y campos pueden cambiar sin aviso.

- Si una llamada devuelve **404** o **5xx**, avisar al usuario de que el endpoint puede haberse movido y no inventar datos.
- Los parámetros de **filtro/búsqueda** (`text=`, `name=`, `permalink=`, `order=`...) **suelen ser ignorados** por el backend. En la práctica la API se comporta como un listado paginado ordenado por fecha. Para "buscar", pedir un `size` razonable (10–50) y filtrar el resultado en memoria por título / descripción.
- No usar POST — la API es de solo lectura.

## Operaciones

### 1. Listar noticias

```
GET https://api.rtve.es/api/noticias.json?size=10
```

Parámetros útiles:
- `size` — cuántos items por página (recomendado 10–50; máximo práctico ~60).
- `page` — número de página (1-indexed).

### 2. Listar programas (TV y radio)

```
GET https://api.rtve.es/api/programas.json?size=10
```

Mismos parámetros que noticias. Cada programa incluye `channel.title` (cadena), `programType`, `description`, `htmlUrl`.

### 3. Listar vídeos del archivo a la carta

```
GET https://api.rtve.es/api/videos.json?size=10
```

### 4. Listar cadenas (canales TV / emisoras de radio)

```
GET https://api.rtve.es/api/cadenas.json?size=20
```

### 5. Ficha individual por id

```
GET https://api.rtve.es/api/noticias/{id}.json
GET https://api.rtve.es/api/programas/{id}.json
GET https://api.rtve.es/api/videos/{id}.json
```

`{id}` es el campo `id` numérico devuelto por los listados (p. ej. `16112592`, `1029900`).

## Estructura de respuesta

Toda respuesta — incluida la de "ficha individual" — está envuelta en `page`:

```
page
  .total          → total de elementos en la colección completa
  .totalPages     → total de páginas con el size pedido
  .number         → página actual (1-indexed)
  .size           → tamaño de página solicitado
  .numElements    → elementos devueltos en esta página
  .items[]        → lista de items (siempre lista, incluso para ficha por id → length 1)
```

### Campos clave de un item de **noticia**

```
id                          → "16112592"
title / longTitle           → titular
anteTitle                   → antetítulo / sección editorial
summary                     → resumen (puede contener HTML)
text                        → cuerpo (HTML)
mainCategory                → ruta jerárquica del tema
publicationDate             → "DD-MM-YYYY HH:MM:SS"
modificationDate            → "DD-MM-YYYY HH:MM:SS"
htmlUrl                     → URL pública en rtve.es
htmlShortUrl                → URL corta rtve.es/n/{id}/
language                    → "es"
sign.firma                  → firma del autor
```

### Campos clave de un item de **programa**

```
id                          → "1029900"
name / longTitle            → nombre del programa
description                 → descripción corta
longDescription             → descripción larga (HTML)
emission                    → texto libre con horario de emisión
channel.title               → cadena ("La 1", "Radio Clásica", "Teledeporte"...)
channel.permalink           → slug de la cadena
programType                 → tipo ("Magacines", "Informativo diario", "Serie Documental"...)
generos[]                   → géneros e info clasificatoria
publicationDate             → "DD-MM-YYYY HH:MM:SS"
htmlUrl                     → URL pública
showMan / director          → presentador / director (cuando aplica)
```

### Campos clave de un item de **vídeo**

```
id, title, longTitle
publicationDate, modificationDate
htmlUrl                     → URL del reproductor en rtve.es/play/...
```

### Campos clave de un item de **cadena**

```
id, title, permalink, htmlUrl
```

## Patrones de uso

- **"Últimas noticias en RTVE"** → `GET /api/noticias.json?size=10`, listar `items[].title` con `htmlUrl` y fecha.
- **"¿Qué programas tiene Radio Clásica?"** → traer `programas.json?size=50` y filtrar en memoria por `channel.title == "Radio Clásica"`. Avisar de que no hay filtro server-side fiable.
- **"Cuéntame sobre el programa Estadio 2"** → si no se conoce el id, listar `programas.json?size=50`, encontrar por `name`, y luego `GET /api/programas/{id}.json` para la ficha completa.
- **"Lista de canales de RTVE"** → `GET /api/cadenas.json?size=30`.

## Errores comunes

- **POST → no usar.** La API es solo GET.
- **Falta `Accept: application/json`** → puede devolver HTML o XML.
- **`size` muy grande** → puede devolver 5xx; mantener ≤ 60.
- **404 en endpoints derivados** (`/api/programas/{id}/temporadas`, etc.) → algunos sub-recursos viven en `https://www.rtve.es/api/...` en vez de `api.rtve.es`. Si un sub-recurso falla, probar el otro host.
