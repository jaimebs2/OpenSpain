---
name: dgt-trafico
description: "Use when the user asks about real-time traffic conditions on Spanish roads: incidents, accidents, roadworks, restrictions, traffic jams, road closures, traffic panels, or general road conditions. Triggers on: 'tráfico tiempo real', 'estado carretera', 'incidencias DGT', 'obras carretera', 'retenciones', 'tráfico A-6', 'tráfico A-1', 'accidente carretera', 'condiciones circulación', 'corte de carretera', 'NAP DGT', 'incidencias tráfico', 'hay retenciones', 'está cortada la', 'estado vías'."
license: MIT
---

# DGT Tráfico — Incidencias en Tiempo Real

Datos abiertos publicados por la DGT en el NAP (Nodo de Acceso Nacional). **Sin autenticación**. Formato DATEX II XML.

Cobertura: red viaria estatal española, **excepto Euskadi y Cataluña** (tienen gestión propia).

## Endpoints disponibles

### 1. Incidencias en tiempo real (principal)

```
GET https://nap.dgt.es/datex2/v3/dgt/SituationPublication/datex2_v36.xml
```

Devuelve XML en formato DATEX II v3.6 con todas las incidencias activas: accidentes, obras, restricciones, condiciones meteorológicas adversas, retenciones, etc. Licencia CC-BY. Cobertura: red viaria estatal excepto Euskadi y Cataluña.

Actualización: cada 1 minuto, 24 h a cargo de la Guardia Civil de Tráfico y los Centros de Gestión del Tráfico de la DGT.

### 2. Paneles informativos (tiempo real)

```
GET https://infocar.dgt.es/datex2/dgt/SituationPublication/paneles/content.xml
```

Estado actual de los paneles de mensaje variable instalados en carretera. Útil para saber qué información se está mostrando a los conductores en una vía.

## Estructura del XML de incidencias

El XML sigue el esquema DATEX II `SituationPublication`. Campos clave:

```xml
<situation id="...">
  <situationRecord>
    <!-- Tipo de incidencia -->
    <_situationRecordType>Accident | MaintenanceWorks | OperatorAction | ...</_situationRecordType>

    <!-- Descripción en texto libre -->
    <nonGeneralPublicComment>
      <comment><values><value lang="es">Descripción legible</value></values></comment>
    </nonGeneralPublicComment>

    <!-- Carretera y tramo afectado -->
    <groupOfLocations>
      <locationForDisplay>
        <latitude>40.41</latitude>
        <longitude>-3.70</longitude>
      </locationForDisplay>
    </groupOfLocations>

    <!-- Validez temporal -->
    <validity>
      <validityTimeSpecification>
        <overallStartTime>2025-01-01T08:00:00Z</overallStartTime>
        <overallEndTime>2025-01-01T18:00:00Z</overallEndTime>
      </validityTimeSpecification>
    </validity>

    <!-- Carretera específica -->
    <supplementaryPositionalDescription>
      <roadInformation>
        <roadNumber>A-6</roadNumber>
      </roadInformation>
    </supplementaryPositionalDescription>
  </situationRecord>
</situation>
```

## Cómo responder al usuario

1. Hacer GET al endpoint de incidencias (sin headers especiales, devuelve XML directamente).
2. Parsear el XML para extraer `situation` elements.
3. Para cada situación relevante presentar:
   - **Tipo**: accidente, obras, restricción, retención, etc.
   - **Carretera**: número de vía (A-6, N-II, AP-7...)
   - **Descripción**: texto del campo `nonGeneralPublicComment`
   - **Vigencia**: horas de inicio y fin si están disponibles
   - **Coordenadas** (si el usuario las necesita): latitud/longitud del `locationForDisplay`
4. Si el usuario pregunta por una carretera específica, filtrar por `roadNumber`.
5. Si el usuario pregunta por una zona geográfica, filtrar por coordenadas aproximadas.

## Filtrado por carretera

Al buscar incidencias en una carretera concreta (por ejemplo "A-6"), buscar en el XML los elementos que contengan ese identificador en los campos:
- `<roadNumber>A-6</roadNumber>`
- O bien en el texto de `<nonGeneralPublicComment>`

## Tipos de incidencia más comunes

| Valor DATEX II | Significado |
|---|---|
| `Accident` | Accidente de tráfico |
| `MaintenanceWorks` | Obras de mantenimiento |
| `ConstructionWorks` | Obras de construcción |
| `AbnormalLoad` | Carga especial / convoy |
| `Poor weather conditions` | Condiciones meteorológicas adversas |
| `Congestion` | Retención / congestión |
| `RoadClosed` | Carretera cortada |
| `LanesRestricted` | Carriles restringidos |

## Reglas operativas

- Nunca inventes incidencias; consulta siempre la API.
- Citar siempre la fuente: "según la DGT (datos en tiempo real)".
- Si el XML está vacío o no contiene situaciones, indicar que no hay incidencias registradas en este momento para la vía consultada.
- Si el usuario pregunta por Euskadi o Cataluña, informar que esas redes no están cubiertas por este endpoint y remitir al servicio de tráfico autonómico correspondiente (Ertzaintza / SCT).
- El endpoint no requiere autenticación; si devuelve error HTTP, indicar al usuario que el servicio puede estar temporalmente no disponible y sugerir https://infocar.dgt.es/etraffic/ como alternativa visual.
