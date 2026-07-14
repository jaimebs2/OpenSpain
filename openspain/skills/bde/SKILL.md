---
name: bde
description: "Use when the user asks about Banco de España statistics: interest rates (Euribor 1Y/3M, official rates, mortgage reference rates), balance of payments, public debt, public deficit, monetary aggregates, banking statistics. Triggers on: 'Banco de España', 'BDE', 'BIEst', 'tipos de interés', 'Euribor', 'balanza de pagos', 'deuda pública', 'déficit público', 'masa monetaria', 'estadísticas bancarias', 'estadísticas BDE'."
license: MIT
---

# Banco de España — API BIEst

API pública, sin autenticación. Usar WebFetch con GET.

> ⚠️ La API devuelve las respuestas comprimidas (gzip). WebFetch descomprime automáticamente. Si se usa curl directamente, añadir `--compressed`.

Base URL: `https://app.bde.es/bierest/resources/srdatosapp`

Dos endpoints disponibles:

license: MIT
---

## Endpoint 1 — Último dato de una o varias series

```
GET /favoritas?idioma={idioma}&series={codigos}
```

- `idioma`: `es` (español) o `en` (inglés)
- `series`: uno o más códigos separados por coma. Si un código contiene `#`, reemplazar con `%23`.

**Respuesta** — array JSON, un objeto por serie:

```json
[
  {
    "serie": "D_1NBAF472",
    "descripcionCorta": "One-year Euribor",
    "codFrecuencia": "M",
    "decimales": 3,
    "simbolo": "%",
    "tendencia": "+",
    "fechaValor": "2026-03-01T09:15:00Z",
    "valor": 2.565
  }
]
```

- `tendencia`: `+` (sube), `-` (baja), `=` (estable)
- `codFrecuencia`: `D` (diaria), `M` (mensual), `Q` (trimestral), `A` (anual)

**Ejemplo — varios indicadores de golpe:**

```
GET https://app.bde.es/bierest/resources/srdatosapp/favoritas?idioma=es&series=D_1NBAF472,D_DNBAD172,DTNPDE2010_P0000P_PS_APU,DTNSEC2010_S0000P_APU_SUMAMOVIL
```

license: MIT
---

## Endpoint 2 — Serie histórica completa

```
GET /listaSeries?idioma={idioma}&series={codigos}&rango={rango}
```

- `rango` según frecuencia:
  - Diaria (`D`): `3M`, `12M`, `36M`
  - Mensual (`M`): `30M`, `60M`, `MAX`
  - Trimestral (`Q`): `30M`, `60M`, `MAX`
  - Anual (`A`): `60M`, `MAX`
  - O un año concreto, p.ej. `2025`

**Respuesta** — array JSON, un objeto por serie:

```json
[
  {
    "serie": "D_1NBAF472",
    "descripcion": "One-year Euribor",
    "descripcionCorta": "One-year Euribor",
    "codFrecuencia": "M",
    "decimales": 3,
    "simbolo": "%",
    "fechaInicio": "1999-01-01T09:15:00Z",
    "fechaFin": "2026-03-01T09:15:00Z",
    "informacion": [
      {"titulo": "Name", "descripcion": "One-year Euribor"},
      {"titulo": "Units", "descripcion": "Rate"},
      {"titulo": "Source", "descripcion": "EURIBOR European Banking Federation..."}
    ],
    "fechas": ["2026-03-01T09:15:00Z", "2026-02-01T09:15:00Z", "..."],
    "valores": [2.565, 2.521, "..."]
  }
]
```

`fechas` y `valores` son arrays paralelos del mismo tamaño: `fechas[i]` corresponde a `valores[i]`.
Los datos están ordenados del más reciente al más antiguo.

license: MIT
---

## Series verificadas

| Código | Descripción | Frecuencia | Unidad |
|--------|-------------|-----------|--------|
| `D_1NBAF472` | Euribor a 1 año | M (mensual) | % |
| `D_DNBAD172` | Euribor a 3 meses | D (diaria) | % |
| `DTNPDE2010_P0000P_PS_APU` | Deuda EDP. Sector público. % del PIB | Q (trimestral) | % |
| `DTNSEC2010_S0000P_APU_SUMAMOVIL` | Déficit. Sector público. % del PIB | Q (trimestral) | % |
| `DEEQ.N.ES.W1.S1.S1.T.B.G._Z._Z._Z.EUR._T._X.N.ALL` | Balanza de pagos. Bienes | Q (trimestral) | M€ |

license: MIT
---

## Cómo buscar más series

El sistema BIEst contiene miles de series. Para encontrar códigos adicionales:

1. Acceder al buscador BIEst: `https://app.bde.es/bie_www?Idioma=es`
2. Buscar por tema. El código de la serie aparece en los archivos CSV descargables de cada tabla estadística.
3. Las tablas del Boletín Estadístico también incluyen acceso BIEst con formato `be,<capítulo>,<tabla>` (ejemplo: `be,19,1` = tipos de interés oficiales, capítulo 19 tabla 1).

license: MIT
---

## Instrucciones de uso

1. Para preguntas sobre el valor actual de un indicador, usar el endpoint `/favoritas`.
2. Para preguntas sobre evolución histórica o tendencia, usar `/listaSeries` con el `rango` apropiado.
3. Indicar siempre la fuente: "Banco de España, BIEst" y la fecha del último dato (`fechaValor` o `fechaFin`).
4. Si el usuario pregunta por un indicador no incluido en las series verificadas, explicar que puede buscarse en el sistema BIEst de la web del BDE.
