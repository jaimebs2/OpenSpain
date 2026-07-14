# Puertos del Estado — Oceanografía y Estadísticas Portuarias

Acceso a datos oceanográficos en tiempo real y predicciones numéricas costeras de los puertos de interés general del Estado español, servidos a través del servidor THREDDS/OPeNDAP de Puertos del Estado.

## Datos disponibles

- **Nivel del mar en tiempo real** — Red de 45+ mareógrafos (REDCOS) en todo el litoral español e islas. Datos a 2 Hz y análisis horario (HM).
- **Modelos de oleaje** — Predicciones numéricas a escala grande (Atlántico-Mediterráneo), regional (Gibraltar, Baleares, Canarias, Atlántico Ibérico, IBI) y costera/portuaria.
- **Corrientes superficiales por radar HF** — 6 zonas: Delta del Ebro, Estrecho de Gibraltar, NW Ibérico, Golfo de Cádiz, Vigo, Canarias-PLOCAN.
- **Temperatura superficial del mar** — Satélite, región IBI (Iberia-Biscay-Ireland).
- **Modelos atmosféricos costeros** — HARMONIE 2.5 km (regional) y 1 km (16 puertos específicos).
- **Modelos 3D oceánicos** — Temperatura, circulación, salinidad y nivel del mar a escala costera y portuaria.

## Acceso

El servidor THREDDS es público y no requiere autenticación:

- Catálogo HTML: http://opendap.puertos.es/thredds/catalog.html
- Catálogo XML: http://opendap.puertos.es/thredds/catalog.xml
- Visualización interactiva: https://portus.puertos.es

## Uso con el agente

La skill `puertos` permite al agente navegar el catálogo THREDDS y consultar metadatos de datasets oceanográficos. Ver `skill/SKILL.md` para las instrucciones de uso.

## Tests

```bash
bash tests/puertos/smoke.sh
```
