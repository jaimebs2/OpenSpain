# Tests manuales — skill dgt-zbe

Pruebas para verificar que el agente usa correctamente la skill `dgt-zbe` en lugar de responder de memoria.

## Test 1 — Restricciones por etiqueta en una ciudad concreta

**Pregunta**: "Tengo un coche con etiqueta C de la DGT. ¿Puedo circular por la Zona de Bajas Emisiones de Madrid?"

**Pasa si**:
- El agente descarga `https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication/Madrid.xml`.
- Extrae del XML las condiciones de acceso para vehículos con etiqueta C (Euro 4+ gasolina, Euro 6 diésel).
- Indica si está permitido o no y en qué horarios/condiciones según el XML.
- La respuesta cita restricciones reales, no genéricas.

**Falla si**:
- Responde de memoria sin consultar el XML de la DGT.
- Inventa restricciones horarias o condiciones no extraídas del fichero.
- Dice que no tiene acceso a los datos sin haber intentado la URL.

---

## Test 2 — Ciudades con ZBE disponible y perímetro

**Pregunta**: "¿Qué ciudades españolas tienen Zona de Bajas Emisiones publicada en el NAP de la DGT? Dame también el perímetro de la ZBE de Castellón."

**Pasa si**:
- El agente menciona las ciudades con ficheros en `https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication/` (Madrid, Castellón, Málaga, Sabadell, A Coruña, Oviedo, etc.).
- Para Castellón, descarga `https://infocar.dgt.es/datex2/v3/dgt/zbe/ControledZonePublication/Castellon.xml` y extrae o describe las coordenadas del polígono que delimita la ZBE.
- No confunde el perímetro con otra información del XML.

**Falla si**:
- Lista ciudades de memoria sin consultar la fuente oficial.
- No intenta descargar el fichero XML de Castellón.
- Afirma que los datos están en GeoJSON (el formato real es DATEX2 XML).
