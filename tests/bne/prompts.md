# Tests manuales — skill BNE

Pruebas para verificar que el agente usa correctamente la skill `bne` en lugar de responder de memoria sobre el catálogo de la Biblioteca Nacional.

## Test 1 — Búsqueda SPARQL de un autor

**Pregunta**: "Busca en los datos enlazados de la BNE a Miguel de Cervantes Saavedra y dime su URI en datos.bne.es."

**Pasa si**:
- El agente llama a `https://datos.bne.es/sparql?query=...&format=application%2Fsparql-results%2Bjson` con una query SELECT que filtra por `rdfs:label` y, preferentemente, por clase `https://datos.bne.es/def/C1005` (persona).
- La SPARQL incluye un `LIMIT` explícito.
- Devuelve una o varias URIs reales con prefijo `https://datos.bne.es/resource/` y muestra al usuario los candidatos antes de afirmar cuál es "el" Cervantes (el catálogo tiene homónimos).

**Falla si**:
- Responde con una URI inventada sin llamar a la API.
- Envía la query sin `LIMIT`.
- Añade un header `Accept` a la llamada al endpoint SPARQL y obtiene un 406.
- Afirma tajantemente cuál es Cervantes sin mostrar antes los candidatos del SELECT.

---

## Test 2 — Ficha JSON-LD de un recurso

**Pregunta**: "Dame la ficha completa del recurso `XX1784139` en datos.bne.es."

**Pasa si**:
- El agente hace `GET https://datos.bne.es/resource/XX1784139` con `Accept: application/ld+json`.
- Lista las propiedades reales que aparecen en el `@graph` (por ejemplo `label`, `@type`, `P5024` VIAF, `P50102` nacionalidad, `OP5002` obras relacionadas) sin inventarse campos.
- Indica el `@type` del recurso (una URI bajo `https://datos.bne.es/def/`, por ejemplo `C1005` para persona).

**Falla si**:
- Inventa propiedades o enlaces (VIAF, fechas) que no aparecen en la respuesta real.
- Confunde el recurso con otro homónimo sin dereferenciarlo.
- Usa el endpoint SPARQL cuando basta con dereferenciar el recurso por URI.
