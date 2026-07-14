# DGT — Accidentes de Tráfico

Microdatos anuales de accidentes de tráfico con víctimas en España publicados por la **Dirección General de Tráfico (DGT)** a través de **datos.gob.es**.

Cada fila del fichero corresponde a un accidente con víctimas ocurrido en vías urbanas o interurbanas de España.

## Fuente de datos

- **datos.gob.es (DGT)**: https://datos.gob.es/en/catalogo?publisher_org=E00130502
- **DGT en cifras**: https://www.dgt.es/menusecundario/dgt-en-cifras/dgt-en-cifras-resultados/
- **Diccionario de variables**: https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/Diccionario_Tabla_Accidentes.xlsx

## Ficheros disponibles

| Año  | Formato | Tamaño | URL de descarga |
|------|---------|--------|-----------------|
| 2024 | XLSX | 24.18 MB | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/publicaciones/Ficheros_microdatos_de_accidentalidad_con_victimas/TABLA_ACCIDENTES_24.XLSX |
| 2023 | XLSX | 24.05 MB | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/TABLA_ACCIDENTES_23.XLSX |
| 2022 | XLSX | 23.18 MB | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/TABLA_ACCIDENTES_22.xlsx |
| 2020 | XLSX | 17.16 MB | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/TABLA_ACCIDENTES_20.xlsx |

- **Autenticación**: ninguna (acceso abierto)
- **Actualización**: anual (publicación con varios meses de retraso)
- **Cobertura**: todo el territorio nacional

## Variables principales

Los ficheros incluyen (según el diccionario oficial DGT):

- Fecha, hora y día de la semana del accidente
- Provincia y municipio
- Carretera y punto kilométrico
- Tipo de vía (autopista, autovía, carretera convencional, urbana)
- Número de fallecidos (24h y 30 días), heridos hospitalizados y leves
- Número de vehículos implicados
- Condiciones meteorológicas, luminosidad y estado de la calzada
- Causa probable del accidente

## Uso

Esta skill se activa automáticamente cuando el usuario pregunta por:
- Estadísticas de accidentes de tráfico en España
- Número de fallecidos o heridos en carretera
- Siniestralidad vial por año, provincia o tipo de vía
- Causas más frecuentes de accidentes de tráfico

## Tests

```bash
bash tests/dgt-accidentes/smoke.sh
```
