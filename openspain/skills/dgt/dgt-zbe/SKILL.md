---
name: dgt-zbe
description: "Use when the user asks about Low Emission Zones (ZBE) in Spanish cities: which vehicles can enter, boundaries, restrictions by DGT environmental label (0 emissions, ECO, C, B). Triggers on: 'ZBE', 'zona de bajas emisiones', 'restricciones medioambientales', 'etiqueta DGT', 'vehículo puede entrar', 'zona cero emisiones', 'Madrid Central', 'Barcelona ZBE', 'etiqueta ambiental', 'zona de bajas emisiones Madrid', 'restricción circulación'."
license: MIT
---

# DGT — Zonas de Bajas Emisiones (ZBE)

Datos oficiales en formato **DATEX2 XML v3** publicados por la DGT en el NAP (Punto de Acceso Nacional). Sin autenticación. Usar GET.

## URL de acceso

```
GET https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication/{Ciudad}.xml
```

Devuelve XML con la geometría, restricciones, horarios y excepciones de la ZBE de la ciudad indicada.

## Ciudades disponibles (nombres de fichero exactos)

| Ciudad              | Fichero                    |
|---------------------|----------------------------|
| Madrid              | `Madrid.xml`               |
| Barcelona (interior)| `ZBEBarcelona.xml`         |
| Barcelona (rondas)  | `RondasDeBarcelona.xml`    |
| Castellón           | `Castellon.xml`            |
| Sabadell            | `Sabadell.xml`             |
| Málaga              | `Malaga.xml`               |
| A Coruña            | `ACoruna.xml`              |
| Oviedo              | `Oviedo.xml`               |
| Sant Joan Despí     | `SantJoanDespi.xml`        |
| Tarragona           | `Tarragona.xml`            |
| Viladecans          | `Viladecans.xml`           |

> Para descubrir todas las ciudades disponibles, visitar el directorio:
> `https://infocar.dgt.es/datex2/v3/dgt/zbe/`

## Estructura del XML (DATEX2 ControledZonePublication)

El XML sigue el esquema DATEX2 v3. Los elementos clave son:

```xml
<controlledZonePublication>
  <controlledZone id="...">
    <zoneName>
      <values>
        <value lang="es">Nombre oficial de la ZBE</value>
      </values>
    </zoneName>
    <zoneGeometry>
      <!-- GML o coordenadas del polígono que delimita la zona -->
    </zoneGeometry>
    <accessCondition>
      <validPeriod>
        <!-- Días de la semana y horas en que aplica la restricción -->
      </validPeriod>
      <vehicleCharacteristics>
        <vehicleType>...</vehicleType>
        <emissionClassificationEuro>...</emissionClassificationEuro>
        <emissionClassificationEuroMotorvehicle>...</emissionClassificationEuroMotorvehicle>
      </vehicleCharacteristics>
    </accessCondition>
  </controlledZone>
</controlledZonePublication>
```

## Etiquetas medioambientales DGT

| Etiqueta | Vehículos incluidos                                               | Acceso típico ZBE |
|----------|-------------------------------------------------------------------|-------------------|
| 0        | Eléctrico puro (BEV), pila de hidrógeno (FCEV)                   | Siempre permitido |
| ECO      | Híbrido enchufable (PHEV), GNC, GLP, híbrido no enchufable        | Generalmente sí   |
| C        | Gasolina Euro 4+ (matriculados desde 2006), diésel Euro 6 (2014+) | Con restricciones |
| B        | Gasolina Euro 3 (desde 2000), diésel Euro 4+ (desde 2006)         | Horario limitado  |
| Sin etiq.| Resto de vehículos más contaminantes                              | Restringido/prohibido |

## Instrucciones de uso

1. **Identificar la ciudad**: mapear el nombre que menciona el usuario al nombre de fichero de la tabla anterior.
2. **Obtener el XML**: `GET https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication/{Ciudad}.xml`
3. **Parsear y responder**: extraer del XML las `accessCondition` relevantes para el tipo de vehículo o etiqueta que pregunta el usuario.
4. Si la ciudad no está en la lista, indicar que no tiene ZBE publicada en el NAP o buscarla en el directorio.

## Notas importantes

- Los ficheros XML se actualizan periódicamente cuando hay cambios en las ZBE.
- Las restricciones varían por horario: muchas ZBE solo restringen en días laborables y en determinadas franjas horarias.
- Un vehículo **sin etiqueta** (anterior a Euro 3 gasolina o Euro 4 diésel) generalmente no puede circular dentro de la ZBE en los horarios de restricción.
- Las excepciones más comunes son: residentes con acreditación, vehículos de emergencia, carga/descarga en horario autorizado, vehículos adaptados para personas con movilidad reducida.
- Para saber si un vehículo concreto tiene etiqueta, el usuario debe consultar la sede electrónica de la DGT (no cubierto por esta skill).

## Dataset en NAP

Catálogo oficial: `https://nap.dgt.es/dataset/zonas-de-bajas-emisiones`
