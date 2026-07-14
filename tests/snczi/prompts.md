# Tests manuales — skill SNCZI

Pruebas para verificar que el agente resuelve preguntas de zonas inundables y DPH usando la skill `snczi` (WMS del MITECO), y no responde de memoria o mezclando fuentes distintas.

## Test 1 — Punto en zona inundable por coordenadas

**Pregunta**: "¿Están las coordenadas 39.4735, -0.3821 (cauce del Turia, Valencia) en zona inundable? Dime a qué períodos de retorno aplica y si están sobre el DPH."

**Pasa si**:
- El agente reconoce que son coordenadas WGS84 (lat, lon) y NO las intercambia.
- Construye un BBOX pequeño (≈ ±0.0001°) alrededor del punto.
- Hace cuatro llamadas `GetFeatureInfo` (una por capa) contra `https://wms.mapama.gob.es/sig/Agua/{ZI_LaminasQ10,ZI_LaminasQ100,ZI_LaminasQ500,DPHCartografico}/wms.aspx` con `VERSION=1.3.0`, `CRS=EPSG:4326` y BBOX en orden **lat,lon**.
- Interpreta la respuesta HTML: filas de atributos ⇒ dentro; "no se han encontrado datos" ⇒ fuera.
- Reporta la probabilidad (alta / media / baja) según qué capas contienen el punto y si está en DPH.
- Cita la fuente (SNCZI, MITECO) y aclara que la información es orientativa.

**Falla si**:
- Intercambia lat/lon (`CoorX=39.4735`, `CoorY=-0.3821`) o usa WMS 1.1.1 + CRS sin ajustar el orden del BBOX.
- Inventa el resultado sin hacer la llamada WMS.
- Usa un endpoint inexistente (`ZI.aspx`, `ZFP.aspx`, `DPH.aspx`) y acepta el `NullReferenceException` como "no hay datos".

---

## Test 2 — Parcela por referencia catastral

**Pregunta**: "Tengo la parcela con referencia catastral 9872023VH5797S0001WX. ¿Está en zona inundable o en zona de policía del río? ¿Puedo construir?"

**Pasa si**:
- El agente delega primero en la skill `catastro` (`Consulta_CPMRC` con `SRS=EPSG:4326`) para obtener las coordenadas (lat, lon) del refcat.
- Con esas coordenadas consulta las capas WMS del SNCZI.
- Para zona de policía explica la regla del art. 6.2 del RD 849/1986 (100 m desde el DPH) y:
  - Si tiene el MCP disponible, calcula el buffer exacto.
  - Si no, usa la aproximación por BBOX ampliado (±0.001°) sobre `DPHCartografico` y lo advierte como orientativo.
- Concluye indicando que cualquier obra en zona de policía requiere autorización previa de la Confederación Hidrográfica competente y recomienda consulta formal.

**Falla si**:
- Inventa coordenadas del refcat sin pasar por `catastro`.
- Afirma categóricamente que se puede o no construir sin mencionar el régimen de autorizaciones del RD 849/1986.
- Confunde zona de policía (100 m) con zona de servidumbre (5 m).

---

## Test 3 — Zona de flujo preferente y límites del servicio

**Pregunta**: "¿Está la Puerta del Sol de Madrid en zona de flujo preferente? ¿Y mi parcela rural con polígono 5, parcela 23 en Aldeanueva de Ebro, La Rioja?"

**Pasa si**:
- Para la Puerta del Sol (40.4168, -3.7038), hace la consulta WMS y responde que está fuera de cualquier zona inundable SNCZI y del DPH.
- Para la parcela rural, delega en `catastro` (`Consulta_DNPPP` con provincia/municipio/polígono/parcela) para obtener coordenadas, y consulta el WMS.
- Explica que la Zona de Flujo Preferente (ZFP) **no está publicada como WMS público estable** del SNCZI y que para un dictamen exacto hay que consultar el visor oficial (https://sig.miteco.gob.es/snczi/index.html?herramienta=DPHZI).
- Aproxima con la lámina T=100 + vía de intenso desagüe si es relevante, dejando claro que es una aproximación.

**Falla si**:
- Asegura que Puerta del Sol está en ZFP (falso positivo) sin consultar nada.
- Afirma conocer la ZFP vía WMS público cuando no existe esa capa estable.
- Omite la excepción de País Vasco y Navarra cuando el usuario pregunte por parcelas en esas comunidades.
