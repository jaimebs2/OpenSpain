# esios — Sistema Eléctrico Español

Acceso a la API ESIOS de Red Eléctrica de España: precio PVPC hora a hora, demanda eléctrica, generación por tecnología y precios de mercado.

Metadata completa de la skill en [service.yml](../../services/esios/service.yml).

## Qué puedes consultar

- **Precio PVPC** hora a hora (indicador 1001) — el precio regulado de la electricidad para consumidores acogidos a tarifa PVPC
- **Precio energía excedentaria autoconsumo PVPC** (indicador 1739)
- **Precio medio horario final** suma de componentes (indicador 10211)
- **Precio mercado SPOT Diario** por países: España, Portugal, Francia, Alemania, Bélgica, Países Bajos (indicador 600)
- **Previsión diaria de demanda eléctrica peninsular** (indicador 460)
- **Generación programada** por tecnología (hidráulica, nuclear, eólica, solar fotovoltaica, solar térmica, ciclo combinado, biomasa, etc.)
- **Intercambios internacionales** con Francia, Portugal, Marruecos y Andorra

**No cubre** (por ahora): demanda real en tiempo estricto sin token, datos de distribución local, información de fincas o contratos de suministro.

## Requisitos

La mayoría de los endpoints requieren un **token ESIOS gratuito**. Solicítalo en:

https://www.esios.ree.es/es/área-privada/api-de-acceso

Exporta el token antes de usar la skill:

```bash
export ESIOS_TOKEN="tu_token_aqui"
```

La skill lee el token de la variable de entorno `ESIOS_TOKEN` y nunca lo pide como parámetro.

**Indicadores públicos** (accesibles sin token): 460 (previsión demanda), 600 (SPOT Diario), 10211 (precio medio horario final), 1739 (precio energía excedentaria autoconsumo).

## Implementación disponible

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/esios/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/esios/` |

```bash
cp -r services/esios ~/.claude/skills/esios
export ESIOS_TOKEN="..."
```

## Autenticación

El token se pasa en la cabecera HTTP:

```
Authorization: Token token=<ESIOS_TOKEN>
```

## Parámetros de filtrado por fecha

Los endpoints de indicadores aceptan `start_date` y `end_date` en formato ISO 8601:

```
GET /indicators/1001?start_date=2026-04-07T00:00:00&end_date=2026-04-07T23:59:59
```

## Tests

```bash
bash tests/esios/smoke.sh
```

Si `ESIOS_TOKEN` no está definida, el smoke test sale con código 0 imprimiendo `SKIP`.
