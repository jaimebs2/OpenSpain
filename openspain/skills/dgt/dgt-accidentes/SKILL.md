---
name: dgt-accidentes
description: "Use when the user asks about traffic accident statistics in Spain: number of accidents, fatalities, injuries, accident causes, road types, vehicle types involved, accident trends by year or province. Data published annually by DGT (Dirección General de Tráfico) on datos.gob.es. Triggers on: 'accidentes tráfico', 'accidentes carretera', 'víctimas accidentes', 'fallecidos carretera', 'DGT accidentes', 'siniestralidad vial', 'estadísticas accidentes España', 'muertos en carretera', 'heridos tráfico', 'accidentes por provincia', 'microdatos accidentes'."
license: MIT
---

# DGT — Accidentes de Tráfico

Microdatos anuales de accidentes con víctimas publicados por la **DGT** en **datos.gob.es**. **Sin autenticación.** Formato XLSX (~24 MB por año).

## Ficheros disponibles

| Año  | URL de descarga | Tamaño |
|------|-----------------|--------|
| 2024 | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/publicaciones/Ficheros_microdatos_de_accidentalidad_con_victimas/TABLA_ACCIDENTES_24.XLSX | 24.18 MB |
| 2023 | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/TABLA_ACCIDENTES_23.XLSX | 24.05 MB |
| 2022 | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/TABLA_ACCIDENTES_22.xlsx | 23.18 MB |
| 2020 | https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/TABLA_ACCIDENTES_20.xlsx | 17.16 MB |

Diccionario de variables: https://www.dgt.es/export/sites/web-DGT/.galleries/downloads/dgt-en-cifras/24h/Diccionario_Tabla_Accidentes.xlsx

Página de catálogo (año más reciente):
https://datos.gob.es/en/catalogo/e00130502-ficheros-de-microdatos-de-accidentes-con-victimas-2024

## Variables principales de cada registro

Cada fila = 1 accidente con víctimas. Columnas documentadas en el diccionario oficial:

- **Fecha / hora / día semana** del accidente
- **Provincia y municipio** de ocurrencia
- **Carretera** (código) y **punto kilométrico**
- **Tipo de vía**: autopista, autovía, carretera convencional, vía urbana
- **Fallecidos en 24h** y **fallecidos en 30 días**
- **Heridos hospitalizados** (más de 24h) y **heridos leves**
- **Número de vehículos** implicados
- **Condiciones meteorológicas** en el momento del accidente
- **Luminosidad**: pleno día, noche iluminada, noche sin iluminación, crepúsculo
- **Estado de la calzada**: seco, mojado, con barro, con hielo/nieve, aceite
- **Causa probable** del accidente

## Cómo responder al usuario

1. **Identificar el año** de interés. Si no lo especifica, usar el año más reciente disponible (2024).
2. **Advertir del tamaño** antes de descargar: los ficheros pesan ~24 MB. Preguntar al usuario si desea continuar si va a descargar el fichero completo.
3. **Descargar el XLSX** usando la URL correspondiente de la tabla anterior.
4. **Analizar el fichero** para responder la pregunta concreta (totales por provincia, tendencia anual, causas más frecuentes, etc.).
5. Citar siempre la fuente: "según los microdatos de la DGT publicados en datos.gob.es".

## Reglas operativas

- Nunca inventes estadísticas; descarga y analiza siempre el fichero oficial.
- Si el usuario pregunta por varios años, ofrecer descargar un año primero para confirmar que es lo que necesita.
- Si el fichero no está disponible (HTTP 404 o error de red), informar al usuario y dirigirle a la página del catálogo para comprobar si hay una URL actualizada.
- Los datos tienen retraso: el año 2024 se publicó en noviembre de 2025. No hay datos en tiempo real; para incidencias en tiempo real usar la skill `dgt-trafico`.
- El diccionario de variables es necesario para interpretar los códigos de columnas; descargarlo si el usuario necesita entender un campo concreto.
