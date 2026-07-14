# Prompts de prueba — fiscalidad-modelo-036

## 1. 036 vs 037

**Prompt**: "Soy autónomo residente en España, tributo en estimación
directa simplificada y régimen general de IVA. Quiero darme de alta en
el ROI para operar con un proveedor de Irlanda. ¿Uso el Modelo 036 o el
037?"

**Pasa si**: responde que tiene que usar el **Modelo 036** porque el
037 no admite el alta en ROI (ni ninguna operación intracomunitaria).
Menciona que el ROI se solicita con la casilla 130 en la página 1 y las
casillas 582 (alta) y 584 (fecha) en la página 5, bloque D) Registros.

**Falla si**: dice que vale el 037, o que el ROI es automático, o que
se tramita en otro modelo distinto.

---

## 2. Casillas para alta en ROI

**Prompt**: "¿Qué casillas exactas tengo que marcar en el Modelo 036
para darme de alta en el Registro de Operadores Intracomunitarios?"

**Pasa si**: indica claramente:
- Página 1: casilla **130** (solicitud de alta/baja en ROI). Si ya
  estabas dado de alta en el censo, también casilla 120 (modificación).
- Página 5, bloque D) Registros: casilla **582** (Alta) y casilla
  **584** (Fecha).

Puede añadir la recomendación de poner como fecha la del día de
presentación, no una retroactiva.

**Falla si**: da casillas inventadas, confunde 582/584 con otras, o
dice que se hace en otra página distinta.

---

## 3. Qué pasa tras presentar el 036 con alta en ROI

**Prompt**: "Acabo de presentar el Modelo 036 para darme de alta en ROI.
¿Cuándo empezaré a aparecer en VIES y puedo ya comprar sin IVA a
proveedores de la UE?"

**Pasa si**: explica que el alta en ROI **no es automática**, que
Hacienda tiene hasta **3 meses** para resolver, que puede pedir
justificación documental (facturas, correos, presupuestos), que hay
silencio positivo si no responde, y que la verificación real se hace en
la web VIES (`https://ec.europa.eu/taxation_customs/vies/`) con
"ES-España" y el NIF sin guiones.

**Falla si**: dice que es inmediato, que no hay que esperar, o que el
alta en el censo español otorga automáticamente el NIF-IVA europeo.

---

## 4. Cambio de domicilio fiscal

**Prompt**: "Me he mudado de Madrid a Valencia. ¿Tengo que avisar a
Hacienda? ¿Cómo?"

**Pasa si**: explica que hay que presentar un Modelo 036 de modificación
(casilla 120 + casilla 122 en página 1) actualizando el domicilio fiscal
en la página 4, dentro del plazo de 1 mes desde el cambio.

**Falla si**: dice que no hace falta avisar, o que es un simple cambio
en el padrón municipal, o menciona modelos que no existen.
