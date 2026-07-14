---
name: congreso
description: "Use when the user wants data from the Spanish Congress of Deputies (Congreso de los Diputados): plenary votes (with how each MP voted), the list of current or historical deputies (diputados), legislative initiatives (proyectos de ley, proposiciones de ley, leyes aprobadas) or parliamentary interventions. Triggers on: 'Congreso', 'Congreso de los Diputados', 'diputados', 'votación pleno', 'cómo votó', 'proyecto de ley', 'proposición de ley', 'iniciativa legislativa', 'pleno', 'legislatura'."
license: MIT
---

# Congreso de los Diputados — datos abiertos

El Congreso **no expone una API REST**. Lo que publica son **ficheros estáticos** (CSV, JSON, XML) bajo `https://www.congreso.es/webpublica/opendata/...`. El nombre de cada fichero **incluye un timestamp** que cambia cada día, por ejemplo:

```
/webpublica/opendata/diputados/DiputadosActivos__20260407050007.json
```

Por eso **nunca debes inventar URLs con timestamp**. El procedimiento es siempre el mismo:

1. **Descubrir** la URL del día parseando la página HTML índice de la sección.
2. **Descargar** el fichero JSON cuya URL acabas de extraer.

Ambos pasos se hacen con `WebFetch`. **Siempre** usa GET (POST devuelve 403). La página HTML del portal exige un User-Agent de navegador real, pero `WebFetch` ya lo envía por defecto, así que no requiere configuración adicional.

## Páginas índice (para descubrir la URL del día)

| Sección | Página índice |
|---|---|
| Votaciones | `https://www.congreso.es/es/opendata/votaciones` |
| Diputados | `https://www.congreso.es/es/opendata/diputados` |
| Iniciativas | `https://www.congreso.es/es/opendata/iniciativas` |
| Intervenciones | `https://www.congreso.es/es/opendata/intervenciones` |

En cada una, los enlaces de descarga aparecen en HTML como:

```html
<a class="btn btn-primary btn-vot"
   href="/webpublica/opendata/<seccion>/<NOMBRE>__<TIMESTAMP>.json"
   download>JSON</a>
```

Pide a `WebFetch` exactamente esto: *"Devuelve la URL completa (con dominio https://www.congreso.es) del enlace JSON cuyo nombre empieza por `<NOMBRE>`."* — sustituyendo `<NOMBRE>` por el dataset que necesites (ver tabla siguiente).

## Datasets disponibles

### Diputados (`/es/opendata/diputados`)

| `<NOMBRE>` | Contenido |
|---|---|
| `DiputadosActivos` | Diputados con escaño en la legislatura actual |
| `DiputadosDeBaja` | Diputados de la legislatura actual que han causado baja |
| `Diputadas` | Diputadas en todas las legislaturas (histórico femenino) |
| `Diput` | Todos los diputados de todas las legislaturas |
| `odsDiputados14` | Diputados de la legislatura XIV |
| `odsDiputados13` | Diputados de la legislatura XIII |
| ... `odsDiputadosCO` | Una entrada por cada legislatura hasta la Constituyente |
| `docacteco` | Declaraciones de actividades, intereses económicos y bienes |

Estructura del JSON `DiputadosActivos`: lista plana de objetos con claves `NOMBRE`, `CIRCUNSCRIPCION`, `FORMACIONELECTORAL`, `GRUPOPARLAMENTARIO`, `FECHAALTA`, `BIOGRAFIA`, etc.

### Iniciativas (`/es/opendata/iniciativas`)

| `<NOMBRE>` | Contenido |
|---|---|
| `IniciativasLegislativasAprobadas` | Leyes aprobadas (con número, título, BOE y enlace al PDF) |
| `ProyectosDeLey` | Proyectos de ley (iniciados por el Gobierno) |
| `ProposicionesDeLey` | Proposiciones de ley (iniciadas por grupos parlamentarios) |
| `PropuestasDeReforma` | Propuestas de reforma de Estatutos de Autonomía |

Estructura típica: lista de objetos con `LEGISLATURA`, `TIPO`, `OBJETO`, `NUMEXPEDIENTE`, `FECHAPRESENTACION`, `AUTOR`, `RESULTADOTRAMITACION`, `SITUACIONACTUAL`, `COMISIONCOMPETENTE`. Para `IniciativasLegislativasAprobadas`: `NUMERO_LEY`, `TITULO_LEY`, `FECHA_LEY`, `NUMERO_BOLETIN`, `PDF`.

### Intervenciones (`/es/opendata/intervenciones`)

| `<NOMBRE>` | Contenido |
|---|---|
| `IntervencionesIniciativa` | Intervenciones agrupadas por iniciativa parlamentaria |
| `IntervencionesCronologicamente` | Intervenciones en orden cronológico |

### Votaciones (`/es/opendata/votaciones`)

Las votaciones son distintas: **no** son un único fichero por dataset, sino **un fichero por votación** con la ruta jerárquica:

```
/webpublica/opendata/votaciones/Leg<N>/Sesion<NNN>/<YYYYMMDD>/Votacion<NNN>/VOT_<TS>.json
```

La página índice `https://www.congreso.es/es/opendata/votaciones` lista las sesiones recientes con enlaces directos a:

- ZIP completo de la sesión: `.../Leg15/Sesion169/20260326/VOT_<TS>.zip`
- JSON de cada votación individual: `.../Leg15/Sesion169/20260326/Votacion001/VOT_<TS>.json`
- También XML, PDF y PNG (gráfica)

Pide a `WebFetch` la URL exacta del JSON de la votación que te interese (por sesión, fecha o tema).

Estructura del JSON de una votación:

```
informacion
  .sesion           → entero
  .numeroVotacion   → entero
  .fecha            → "DD/M/YYYY"
  .titulo           → tipo de tramitación
  .textoExpediente  → descripción del expediente votado
  .tituloSubGrupo   → bloque concreto (enmienda, etc.)
totales
  .presentes / .afavor / .enContra / .abstenciones / .noVotan
  .asentimiento     → "Si" / "No"
votaciones[]
  .asiento          → número de escaño
  .diputado         → "Apellidos, Nombre"
  .grupo            → sigla del grupo (GP, GS, GVOX, GSUMAR, ...)
  .voto             → "Si" / "No" / "Abstención" / "No vota"
```

## Patrón de uso para Claude

### 1. Listar datos del día

> Usuario: «Dame el censo actual de diputadas y diputados.»

1. `WebFetch https://www.congreso.es/es/opendata/diputados` → pídele que extraiga la URL JSON cuyo nombre empieza por `DiputadosActivos`.
2. `WebFetch <esa URL>` → pídele que devuelva el total y la distribución por grupo parlamentario.

### 2. Buscar una votación concreta

> Usuario: «¿Cómo votó cada diputado del PSOE en la última reforma del artículo 49 de la Constitución?»

1. `WebFetch https://www.congreso.es/es/opendata/votaciones` → pídele que extraiga la URL JSON de la votación cuyo `textoExpediente` o título mencione esa reforma.
2. `WebFetch <esa URL>` → pídele que filtre `votaciones[]` por `grupo == "GS"` y devuelva nombre y voto.

### 3. Listar leyes aprobadas

> Usuario: «¿Qué leyes ha aprobado el Congreso este año?»

1. `WebFetch https://www.congreso.es/es/opendata/iniciativas` → URL JSON que empieza por `IniciativasLegislativasAprobadas`.
2. `WebFetch <esa URL>` → pídele las entradas con `FECHA_LEY` del año actual.

## Reglas

- **Nunca** inventes timestamps. Resuelve siempre la URL del día parseando la página HTML índice antes de descargar el JSON.
- **Nunca** uses POST: el servidor responde 403.
- Si una página índice no devuelve enlaces JSON visibles, comparte la limitación con el usuario en lugar de intentar adivinar URLs.
- Para obtener el voto individual de un diputado, ten en cuenta que el JSON usa el campo `diputado` con formato `"Apellidos, Nombre"` y `grupo` con la sigla parlamentaria, no el nombre del partido electoral.
- Las claves de los JSON están en MAYÚSCULAS sin acentos (`NOMBRE`, `CIRCUNSCRIPCION`, `GRUPOPARLAMENTARIO`, ...).
- Cuando el usuario pregunte por un órgano parlamentario (comisiones, mesa, junta de portavoces) o por el texto de un diario de sesiones, **avisa** de que esos datos no están en los ficheros JSON y enlaza al portal `https://www.congreso.es/es/datos-abiertos`.
