# DGT — Zonas de Bajas Emisiones (ZBE)

Datos oficiales de las Zonas de Bajas Emisiones (ZBE) en ciudades españolas, publicados por la Dirección General de Tráfico a través del Punto de Acceso Nacional (NAP).

## Fuente de datos

**NAP DGT**: [https://nap.dgt.es/dataset/zonas-de-bajas-emisiones](https://nap.dgt.es/dataset/zonas-de-bajas-emisiones)

Los ficheros están en formato **DATEX2 XML v3** (estándar europeo para datos de movilidad), accesibles libremente sin autenticación desde `infocar.dgt.es`.

### URL de descarga por ciudad

```
https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication/{Ciudad}.xml
```

Ejemplos:
- Madrid: `.../Madrid.xml`
- Castellón: `.../Castellon.xml`
- Málaga: `.../Malaga.xml`
- A Coruña: `.../ACoruna.xml`
- Sabadell: `.../Sabadell.xml`

Ver el directorio completo: [https://infocar.dgt.es/datex2/v3/dgt/zbe/](https://infocar.dgt.es/datex2/v3/dgt/zbe/)

## Contenido de los datos

Cada fichero XML describe una o más zonas de bajas emisiones con:
- **Geometría**: perímetro de la zona (polígono/multipolígono)
- **Restricciones de acceso**: por etiqueta medioambiental DGT (0 emisiones, ECO, C, B) y tipo de vehículo
- **Horarios**: días y horas en que aplican las restricciones
- **Excepciones**: residentes, carga/descarga, servicios de emergencia, vehículos adaptados, etc.
- **Identificador y nombre oficial** de la zona

## Etiquetas medioambientales DGT

| Etiqueta | Color    | Tipo de vehículo                              |
|----------|----------|-----------------------------------------------|
| 0        | Azul/Verde | Eléctrico puro, hidrógeno                  |
| ECO      | Verde    | Híbrido enchufable, GNC/GLP, híbrido no enchuf.|
| C        | Verde    | Gasolina Euro 4+ (≥2006), diésel Euro 6+ (≥2014)|
| B        | Amarillo | Gasolina Euro 3 (≥2000), diésel Euro 4+ (≥2006)|
| Sin etiqueta | —    | Vehículos más contaminantes                  |

## Uso con el agente

El agente puede responder preguntas como:
- "¿Puede entrar mi coche con etiqueta C en la ZBE de Madrid?"
- "¿Cuáles son los horarios de restricción de Madrid Central?"
- "¿Qué ciudades tienen ZBE activa?"
- "Dame el perímetro de la ZBE de Barcelona"

## Tests

```bash
bash tests/dgt-zbe/smoke.sh
```
