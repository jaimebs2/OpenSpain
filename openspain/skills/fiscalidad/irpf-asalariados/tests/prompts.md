# Tests manuales -- fiscalidad-irpf-asalariados

Preguntas para validar que el agente usa la skill correctamente.

---

## Test 1 -- Obligacion de declarar con dos pagadores

**Prompt**: "He cambiado de trabajo este ano y he tenido dos pagadores. Estoy obligado a hacer la Renta si he ganado 18.000 EUR?"

**Criterios de aceptacion**:
- Explica la regla de los dos pagadores (limite baja a 15.876 EUR si el segundo pagador supera 1.500 EUR).
- Indica que con 18.000 EUR y dos pagadores probablemente si esta obligado.
- Advierte de que probablemente le saldra a pagar por la infraretencion.
- Sugiere usar el simulador de Renta Web para estimar.

---

## Test 2 -- Tramos del IRPF

**Prompt**: "Cuanto IRPF pago si gano 40.000 EUR al ano?"

**Criterios de aceptacion**:
- Muestra los tramos progresivos (no aplica un tipo unico).
- Indica los tipos estatales y menciona que hay que sumar la escala autonomica.
- Menciona el minimo personal (5.550 EUR).
- Da una orientacion del tipo efectivo aproximado.

---

## Test 3 -- Deducciones

**Prompt**: "Que deducciones puedo aplicar en la Renta? Tengo un hijo pequeno y aporto a un plan de pensiones."

**Criterios de aceptacion**:
- Menciona la deduccion por maternidad (1.200 EUR/hijo < 3 anos, madre trabajadora).
- Menciona la reduccion por aportaciones a planes de pensiones (hasta 1.500 EUR).
- Indica que existen deducciones autonomicas adicionales.
- Recomienda revisar el borrador para verificar que estan aplicadas.

---

## Test 4 -- Redireccion a autonomos

**Prompt**: "Soy freelance y quiero saber los tramos del IRPF para mis pagos trimestrales."

**Criterios de aceptacion**:
- Aclara que los pagos trimestrales de autonomos se cubren en fiscalidad-irpf-autonomos.
- Puede mencionar que la escala del IRPF es la misma, pero la mecanica trimestral es diferente.
- Redirige a la skill correcta.
