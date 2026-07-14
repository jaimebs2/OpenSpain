# Banco de España — Estadísticas BIEst

Acceso a las estadísticas económicas y financieras del Banco de España a través de su API BIEst (Banco de Información Estadística).

## Qué datos ofrece

- **Tipos de interés**: Euribor a 1 año y 3 meses, tipos hipotecarios de referencia
- **Deuda pública**: deuda EDP del sector público general (% del PIB)
- **Déficit público**: déficit del sector público general (% del PIB)
- **Balanza de pagos**: bienes, servicios y rentas de la economía española
- **Miles de series** adicionales accesibles por código en el sistema BIEst

## API

Base URL: `https://app.bde.es/bierest/resources/srdatosapp`

Sin autenticación. Respuestas en JSON.

Documentación oficial: https://www.bde.es/webbe/en/estadisticas/recursos/api-estadisticas-bde.html

## Uso con el agente

Activa la skill `bde` en tu configuración de Claude Code. El agente consultará
automáticamente la API cuando se le pregunten datos del Banco de España.
