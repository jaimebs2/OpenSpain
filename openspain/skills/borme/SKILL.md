---
name: borme
description: "Use when the user wants to query the Spanish Official Gazette of the Mercantile Registry (BORME — Boletín Oficial del Registro Mercantil): get the daily summary of company acts published on a given date, list inscribed acts (constituciones, nombramientos, ceses, ampliaciones de capital, disoluciones, fusiones) by province, or look up legal notices and announcements published in the mercantile registry. Triggers on: 'BORME', 'boletín oficial registro mercantil', 'registro mercantil', 'sumario BORME', 'actos inscritos', 'constitución de sociedad', 'nombramiento administrador', 'cese administrador', 'ampliación de capital', 'disolución sociedad', 'anuncio mercantil'."
license: MIT
---

# BORME — API de datos abiertos del Boletín Oficial del Registro Mercantil

API pública, sin autenticación. Usar WebFetch con GET. **Nunca usar POST — devuelve 403.**

Siempre incluir el header `Accept: application/json`.

El BORME se publica de lunes a viernes (días hábiles). Si el usuario pide "hoy" y hoy es fin de semana o festivo, no habrá publicación: usar el último día hábil anterior.

## Operación

### Sumario diario

```
GET https://www.boe.es/datosabiertos/api/borme/sumario/{fecha}
```

`fecha` en formato `YYYYMMDD`. Ejemplo: `20260406`.

## Estructura de respuesta

Todas las respuestas tienen `status.code`. Si es distinto de `"200"`, hay error (típicamente `404` si la fecha no es día hábil o no existe BORME).

```
data.sumario.metadatos
  .publicacion                            → "BORME"
  .fecha_publicacion                      → "YYYYMMDD"
data.sumario.diario[]
  .numero                                 → número del BORME
  .sumario_diario
    .identificador                        → "BORME-S-YYYY-NNN"
    .url_pdf.texto                        → PDF del sumario completo
  .seccion[]
    .codigo                               → "A", "B" o "C"
    .nombre                               → nombre de la sección
    .item                                 → objeto {} o lista [] de anuncios
      .identificador                      → "BORME-A-YYYY-NNN-MM"
      .titulo                             → provincia (Sección A/B) o título del anuncio (Sección C)
      .url_pdf.texto                      → enlace al PDF del anuncio
      .url_pdf.pagina_inicial             → página inicial dentro del BORME
      .url_pdf.pagina_final               → página final dentro del BORME
```

> `item` puede ser un objeto `{}` o una lista `[]`. Tratar siempre como lista.

## Secciones del BORME

| Código | Nombre                                                                       | Contenido                                                                                                       |
|--------|------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| A      | SECCIÓN PRIMERA. Empresarios. Actos inscritos                                | Constituciones, nombramientos, ceses, ampliaciones de capital, disoluciones, fusiones, etc., agrupados por provincia. |
| B      | SECCIÓN PRIMERA. Empresarios. Otros actos publicados en el Registro Mercantil | Convocatorias de juntas, reducciones de capital con derecho de oposición, traslados internacionales, etc.       |
| C      | SECCIÓN SEGUNDA. Anuncios y avisos legales                                   | Anuncios diversos no inscribibles directamente.                                                                 |

En las secciones A y B, cada `item` corresponde a una **provincia**: el `titulo` del item es el nombre de la provincia (p. ej. `MADRID`, `BARCELONA`, `ARABA/ÁLAVA`) y el PDF enlazado contiene todos los actos inscritos en esa provincia ese día.

## Limitaciones importantes

- La API **no devuelve el texto plano** de los actos individuales (nombres de empresas, tipos de acto, importes). Solo devuelve metadatos del sumario y enlaces a los PDF oficiales por provincia.
- Para conocer empresas concretas, sus actos o detalles, hay que abrir el PDF correspondiente a la provincia (`url_pdf.texto`) — Claude puede ofrecer el enlace directo al usuario.
- No hay endpoint de búsqueda por nombre de empresa, NIF ni tipo de acto. Si el usuario lo pide, indicarlo claramente.

## Formato de respuesta sugerido

Cuando el usuario pida el sumario de un día:

1. Confirmar la fecha consultada (`fecha_publicacion`) y el número del BORME.
2. Resumir cuántas provincias publican en la Sección A y, si procede, B.
3. Listar las provincias con su enlace al PDF.
4. Mencionar si hay anuncios en la Sección C y enlazarlos.
5. Recordar que el detalle (empresas, actos concretos) está en los PDF.

## Errores comunes

- **`404` o `status.code != "200"`**: la fecha no tiene BORME publicado (fin de semana, festivo, fecha futura). Sugerir el último día hábil.
- **Fechas anteriores a 2009**: la cobertura de la API puede ser parcial. Si falla, indicarlo al usuario.
