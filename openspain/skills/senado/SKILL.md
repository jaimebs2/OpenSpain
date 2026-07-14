---
name: senado
description: "Use when the user wants to query the Spanish Senate (Senado de España) open data: composition of the chamber (senators, seats, parliamentary groups), legislative initiatives, plenary sessions and votes, motions and interpellations, and contracting/procurement data. Triggers on: 'Senado', 'senadores', 'senadoras', 'composición del Senado', 'grupos parlamentarios', 'pleno', 'sesión plenaria', 'iniciativas legislativas', 'mociones', 'interpelaciones', 'votaciones del Senado', 'contratos del Senado'."
license: MIT
---

# Senado de España — Datos abiertos (descarga XML directa)

El Senado **no expone una API REST**: sólo publica ficheros XML estáticos vía un servlet (`ficopendataservlet`) y rutas directas. Usar `WebFetch` con GET sobre las URLs listadas. Todas devuelven `text/xml; charset=UTF-8` y son públicas (sin autenticación).

> Catálogo oficial: <https://www.senado.es/web/relacionesciudadanos/datosabiertos/catalogodatos/index.html>
>
> El parámetro `legis=15` corresponde a la **legislatura actual** (XV). Para legislaturas anteriores cambiar el número.

## Endpoints verificados

### Composición y organización

| Dato | URL | Tag raíz |
|---|---|---|
| Composición del hemiciclo (legislatura actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=20` | `<hemiciclo>` |
| Senadores y senadoras desde 1977 (histórico completo) | `https://www.senado.es/web/ficopendataservlet?tipoFich=10` | `<senadores1977>` |
| Grupos parlamentarios y partidos políticos (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=4&legis=15` | `<GruposYpartidos>` |
| Organigrama del Senado | `https://www.senado.es/web/ficopendataservlet?tipoFich=5` | `<organigrama>` |
| Comisiones (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=7&legis=15` | `<listaComisiones>` |
| Ponencias (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=8&legis=15` | `<listaPonencias>` |
| Agenda de senadores del año en curso | `https://www.senado.es/web/ficopendataservlet?tipoFich=19` | `<agenda>` |

### Plenos y votaciones

| Dato | URL | Tag raíz |
|---|---|---|
| Sesiones plenarias (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=14&legis=15` | `<listaSesionesPlenarias>` |

Cada `<sesionPlenaria>` incluye:
- `<sesionNumero>`, `<sesionFechaInicio>`, `<sesionTitulo>`
- `<fichUrlVotaciones>` → ruta relativa al XML de votaciones de esa sesión, p. ej. `/legis15/votaciones/ses_60.xml`. Para descargar: anteponer `https://www.senado.es`.
- `<fichUrlDetalleSesion>` → ruta relativa al servlet con el detalle de la sesión.

### Iniciativas legislativas, mociones e interpelaciones

| Dato | URL | Tag raíz |
|---|---|---|
| Iniciativas legislativas (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=9&legis=15` | `<listaIniciativasLegislativas>` |
| Interpelaciones (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=15&legis=15` | `<listaInterpelaciones>` |
| Mociones (legis. actual) | `https://www.senado.es/web/ficopendataservlet?tipoFich=16&legis=15` | `<listaMociones>` |
| Tesauro del Senado (bloques y áreas temáticas) | `https://www.senado.es/web/ficopendataservlet?tipoFich=17&legis=15` | `<tesauro>` |

Cada `<iniciativa>` (en `tipoFich=9`) trae:
- `<tipoExpediente>`, `<numeroExpediente>`, `<titulo>`
- `<fichUrl>` → ficha XML de la iniciativa (ruta relativa al servlet)
- `<fichUrlEnmiendas>` → URL absoluta al XML global de enmiendas y vetos
- `<fichUrlVotaciones>` → ruta relativa al XML de votaciones de la iniciativa

Para descargar las rutas relativas, anteponer `https://www.senado.es`.

### Contratación pública (presupuesto/contratos)

| Dato | URL | Tag raíz |
|---|---|---|
| Contratos mayores año en curso | `https://www.senado.es/contratos/xml/mayores/Listacontmayor_2026.xml` | `<PROCEDIMIENTOS>` |
| Contratos menores año en curso | `https://www.senado.es/contratos/xml/menores/lista_menores_2026.xml` | `<PROCEDIMIENTOS>` |

Para años anteriores, sustituir `2026` por el año deseado (disponibles desde 2017 en mayores y desde 2024 en menores). **Atención**: estos XML llegan en `ISO-8859-1`, no UTF-8.

> El presupuesto y la ejecución del Senado sólo se publican en CSV (no XML), por lo que no son consumibles directamente desde esta skill.

## Reglas de uso

1. **Siempre GET** vía WebFetch. No hay POST.
2. Las respuestas son XML, no JSON. Pedir explícitamente al modelo que extraiga campos por nombre de tag.
3. La cabecera `Accept: application/xml` no es necesaria — el servidor sirve XML por defecto.
4. Si una URL devuelve una ruta relativa (`/web/...` o `/legis15/...`), construir la URL absoluta anteponiendo `https://www.senado.es`.
5. No inventes identificadores ni URLs. Si el dato no está en estos endpoints, dilo claramente.
6. Para localizar a un senador concreto, descargar la composición del hemiciclo (`tipoFich=20`) y filtrar por `<apellidos>` o `<circunscripción>`.

## Estructura mínima de respuesta

### Composición del hemiciclo (`tipoFich=20`)

```
<hemiciclo legislatura="15" fecha_informe="...">
  <escaños>
    <escaño>
      <número>...</número>
      <nombre>...</nombre>
      <apellidos>...</apellidos>
      <partido_político>PP|PSOE|...</partido_político>
      <fecha_designación>DD/MM/AA</fecha_designación>
      <sexo>Hombre|Mujer</sexo>
      <legislatura>15</legislatura>
      <procedencia>Electo|Designado</procedencia>
      <comunidad_autónoma>...</comunidad_autónoma>
      <circunscripción>...</circunscripción>
    </escaño>
    ...
  </escaños>
</hemiciclo>
```

### Grupos parlamentarios (`tipoFich=4&legis=15`)

```
<GruposYpartidos>
  <Grupo>
    <datosCabecera>
      <codigo>...</codigo>
      <nombre>GRUPO PARLAMENTARIO ...</nombre>
      <siglas>GPP|GPS|...</siglas>
      <fechaConstitucion>DD/MM/YYYY</fechaConstitucion>
      <total>...</total>
      <totalElectos>...</totalElectos>
      <totalDesignados>...</totalDesignados>
    </datosCabecera>
    <listaPartidosPoliticos>
      <partido>
        <partidoSiglas>...</partidoSiglas>
        <partidoNombre>...</partidoNombre>
        <partidoTotal>...</partidoTotal>
      </partido>
    </listaPartidosPoliticos>
  </Grupo>
</GruposYpartidos>
```

### Sesiones plenarias (`tipoFich=14&legis=15`)

```
<listaSesionesPlenarias>
  <sesionPlenaria>
    <sesionLegislatura>15</sesionLegislatura>
    <sesionNumero>...</sesionNumero>
    <sesionFechaInicio>... de ... de YYYY</sesionFechaInicio>
    <sesionHoraInicio>HH:MM</sesionHoraInicio>
    <sesionTitulo>Sesión plenaria número N</sesionTitulo>
    <urlPagina>/web/...</urlPagina>
    <fichUrlVotaciones>/legis15/votaciones/ses_NN.xml</fichUrlVotaciones>
    <fichUrlDetalleSesion>/web/ficopendataservlet?tipoFich=11&...</fichUrlDetalleSesion>
  </sesionPlenaria>
</listaSesionesPlenarias>
```

### Iniciativas legislativas (`tipoFich=9&legis=15`)

```
<listaIniciativasLegislativas>
  <iniciativa>
    <tipoExpediente>600</tipoExpediente>
    <numeroExpediente>000001</numeroExpediente>
    <titulo>...</titulo>
    <urlPagina>/web/...</urlPagina>
    <fichero>
      <fichUrl>/web/ficopendataservlet?legis=15&tipoFich=3&tipoEx=600&numEx=000001</fichUrl>
    </fichero>
    <listaEnmiendas>
      <fichGenEnmiendas>
        <fichUrlEnmiendas>https://www.senado.es/legis15/expedientes/600/enmiendas/global_enmiendas_vetos_15_600000001.xml</fichUrlEnmiendas>
      </fichGenEnmiendas>
    </listaEnmiendas>
    <votaciones>
      <fichGenVotaciones>
        <fichUrlVotaciones>/web/ficopendataservlet?legis=15&tipoFich=12&tipoEx=600&numEx=000001</fichUrlVotaciones>
      </fichGenVotaciones>
    </votaciones>
  </iniciativa>
</listaIniciativasLegislativas>
```
