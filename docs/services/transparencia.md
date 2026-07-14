# Transparencia — Portal de Transparencia del Estado

Skill de OpenSpain para consultar datos publicados por el Portal de
Transparencia de la Administración General del Estado y otras
administraciones públicas españolas: contratos, subvenciones, altos cargos,
agendas y retribuciones.

## Qué puedes preguntar

- "¿Qué contratos mayores se han publicado en el sector público en 2024?"
- "Dame datasets de subvenciones concedidas por las administraciones
  públicas."
- "¿Hay datos sobre nombramientos y ceses de altos cargos?"
- "Busca retribuciones de altos cargos de la Administración."
- "¿Qué licitaciones hay en la Plataforma de Contratación del Sector
  Público (PLACSP)?"

## Cómo funciona

El Portal de Transparencia (`transparencia.gob.es`) **no publica una API REST
propia** con un catálogo consultable. En su lugar, la skill descubre los
datasets a través del catálogo nacional `datos.gob.es`, que indexa tanto las
publicaciones del propio Portal como las de cada ministerio, organismo y
administración autonómica/local.

1. La skill hace una búsqueda por título en `datos.gob.es` con términos como
   `PLACSP`, `subvenciones`, `contratos mayores`, `altos cargos`, etc.
2. Revisa los `distribution[].accessURL` que devuelve el catálogo.
3. Elige la distribución con formato más útil (CSV > JSON > XLSX).
4. Descarga los datos reales desde esa URL.

## Tests

```bash
bash tests/transparencia/smoke.sh
```

Verifica que la API de `datos.gob.es` responde correctamente para búsquedas
típicas de transparencia (contratación y subvenciones) y que devuelve
distribuciones con URLs de descarga reales.

Para pruebas con el agente, ver `tests/transparencia/prompts.md`.

## Cuándo NO usar esta skill

- Si preguntas por una **ley** o norma concreta → usa `boe`.
- Si preguntas por datos **fiscales** (IRPF, IVA, recaudación) → usa `aeat`.
- Si preguntas por datos de **empleo** (paro registrado) → usa `sepe`.
- Si necesitas presentar una **solicitud de acceso** real → no es posible
  desde esta skill: redirige a `https://transparencia.gob.es`.
