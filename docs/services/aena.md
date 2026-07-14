# Aena — Estadísticas Aeroportuarias

Estadísticas de tráfico aéreo de los aeropuertos españoles gestionados por Aena: pasajeros, operaciones y carga, por aeropuerto, mes y año.

## Datos disponibles

| Tipo | Cobertura temporal | Formato |
|------|--------------------|---------|
| Pasajeros por aeropuerto | 2004–actualidad | XLS, PDF |
| Operaciones (vuelos) por aeropuerto | 2004–actualidad | XLS, PDF |
| Mercancías (carga aérea) por aeropuerto | 2004–actualidad | XLS, PDF |

Los datos se publican como informes **mensuales** y **anuales** descargables desde el portal estadístico de Aena.

## Acceso a los datos

### Informes anuales

- Portal: https://www.aena.es/es/estadisticas/informes-anuales.html
- Informe anual 2024 (XLS): https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576871820226&ssbinary=true
- Informe anual 2025 (XLS): https://www.aena.es/sites/Satellite?blobcol=urldata&blobkey=id&blobtable=MungoBlobs&blobwhere=1576873058143&ssbinary=true

### Informes mensuales

- Portal: https://www.aena.es/es/estadisticas/informes-mensuales.html
- Los informes de cada mes/año se listan en esa página y son descargables como XLS o PDF.

## Limitaciones

- No existe API REST pública. Los datos son ficheros XLS con IDs opacos (`blobwhere`).
- Las consultas personalizadas (por compañía, destino) requieren registro en el portal.
- Para obtener los IDs de informes de meses anteriores, es necesario consultar la página de informes mensuales y extraer los enlaces.

## Skill

La skill `aena` guía al agente para localizar y descargar los informes XLS correctos según la pregunta del usuario. Ver `skill/SKILL.md`.
