# Tests manuales — skill BDE

Pruebas para verificar que el agente usa correctamente la skill `bde` en lugar de responder de memoria.

## Test 1 — Euribor actual

**Pregunta**: "¿A cuánto está el Euribor a 1 año ahora mismo?"

**Pasa si**:
- El agente llama a `https://app.bde.es/bierest/resources/srdatosapp/favoritas?idioma=es&series=D_1NBAF472` (o `idioma=en`).
- Devuelve el valor numérico real con su porcentaje, la fecha del dato (`fechaValor`) y la tendencia (`+`/`-`/`=`).
- Menciona la fuente: Banco de España, BIEst.

**Falla si**:
- Responde con un valor de memoria sin consultar la API.
- No indica la fecha del dato o da una fecha incorrecta.
- Inventa el valor del Euribor.

---

## Test 2 — Deuda pública y déficit

**Pregunta**: "¿Cuál es la deuda pública de España como porcentaje del PIB y cuál es el déficit público?"

**Pasa si**:
- El agente llama a `/favoritas` con al menos los códigos `DTNPDE2010_P0000P_PS_APU` (deuda EDP) y `DTNSEC2010_S0000P_APU_SUMAMOVIL` (déficit).
- Devuelve valores reales en porcentaje del PIB con la fecha del dato trimestral.
- Distingue claramente entre deuda (stock acumulado) y déficit (flujo anual).

**Falla si**:
- Responde con cifras de memoria sin llamar a la API.
- Confunde los dos indicadores o usa códigos de serie incorrectos.
- No menciona que los datos son del Banco de España o no indica la fecha del último dato.
