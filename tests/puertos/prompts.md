# Tests manuales — skill Puertos del Estado

Pruebas para verificar que el agente usa correctamente la skill `puertos` en lugar de responder de memoria o con datos inventados.

---

## Test 1 — Nivel del mar en un puerto

**Pregunta**: "¿Cuál es el nivel del mar en el puerto de Barcelona hoy? Dime el nombre de la estación, sus coordenadas y el periodo de tiempo que cubre el último dato disponible."

**Pasa si**:
- El agente navega el catálogo THREDDS de `tidegauge_bar2` para el año y mes actuales: `http://opendap.puertos.es/thredds/catalog/tidegauge_bar2/<YYYY>/<MM>/catalog.xml`
- Selecciona un fichero `_analysis_HM.nc4` del catálogo y consulta su `.das`.
- Devuelve el nombre real de la estación ("Barcelona_Bar2"), coordenadas reales (41.34°N, 2.17°E), el rango temporal (`time_coverage_start` / `time_coverage_end`) del fichero y el modo de datos (R=real-time o D=delayed).
- Enlaza a Portus para la estación: `https://portus.puertos.es/?station=3758`.

**Falla si**:
- Inventa el nivel del mar en metros sin consultar la API.
- Responde con datos genéricos o históricos sin hacer ninguna llamada al servidor THREDDS.
- No navega el catálogo XML y no obtiene metadatos `.das`.
- Confunde el mareógrafo de Barcelona con otra estación.

---

## Test 2 — Disponibilidad de datos de oleaje en una zona

**Pregunta**: "¿Hay datos de predicción de oleaje para las Islas Baleares? ¿Qué variables incluyen y de dónde vienen?"

**Pasa si**:
- El agente consulta el catálogo del modelo de oleaje regional de Baleares: `http://opendap.puertos.es/thredds/catalog/wave_regional_bal/catalog.xml`
- Identifica que los datos provienen del servidor THREDDS de Puertos del Estado.
- Menciona variables reales del modelo de oleaje (ej. `VHM0` altura significativa, `VTPK` periodo de pico, `VTM02` periodo medio) obtenidas del `.dds` o del catálogo.
- Indica que los datos son una predicción numérica, no una observación directa.

**Falla si**:
- Responde que no existen datos de oleaje para Baleares sin consultar la API.
- Inventa variables o nombres de modelos sin verificar contra el catálogo real.
- Confunde los modelos de predicción con observaciones en tiempo real de boyas.
