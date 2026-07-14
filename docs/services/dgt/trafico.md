# DGT — Tráfico en Tiempo Real

Incidencias y estado de la circulación en la red viaria estatal española publicados por la **Dirección General de Tráfico (DGT)** a través del **NAP (Nodo de Acceso Nacional de Tráfico y Movilidad)**.

## Fuente de datos

- **NAP**: https://nap.dgt.es
- **Mapa interactivo DGT**: https://infocar.dgt.es/etraffic/
- **Dataset incidencias (NAP)**: https://nap.dgt.es/dataset/incidencias-dgt-datex2-v3-6

## Endpoints

| Endpoint | Descripción | Formato |
|---|---|---|
| `https://infocar.dgt.es/datex2/v3/dgt/SituationPublication/incidencias.xml` | Incidencias en tiempo real (accidentes, obras, retenciones) | DATEX II v3 XML |
| `https://infocar.dgt.es/datex2/dgt/SituationPublication/paneles/content.xml` | Estado de paneles informativos en carretera | DATEX II XML |

- **Autenticación**: ninguna (acceso abierto)
- **Actualización**: continua, 24 h al día
- **Cobertura**: red viaria estatal. Excluye Euskadi y Cataluña.

## Uso

Esta skill se activa automáticamente cuando el usuario pregunta por:
- Estado del tráfico en una carretera
- Incidencias DGT
- Obras, retenciones, accidentes en carretera
- Condiciones de circulación

## Tests

```bash
bash tests/dgt-trafico/smoke.sh
```
