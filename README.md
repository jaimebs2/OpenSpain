<div align="center">

# 🇪🇸 OpenSpain

**Todos los datos públicos de España, a un comando de tu agente de IA.**

97 skills que conectan a Claude, ChatGPT (y cualquier agente compatible) con los datos, APIs e información oficial del sector público español: legislación, estadística, fiscalidad, vivienda, emprendimiento, identidad digital, tráfico, meteorología, energía, sanidad, elecciones y mucho más.

```bash
npx skills add jaimebs2/OpenSpain --skill openspain
```

Una skill. Cero servidores. Cero SDKs. Todo el sector público español.

[Quick start](#quick-start) · [Skills](#skills) · [MCPs](#mcps) · [Instalación avanzada](#instalación-avanzada) · [Estructura](#estructura-de-una-skill) · [Documentación](docs/)

🇬🇧 [Read in English](README.en.md)

</div>

---

## Quick start

Instala la **skill `openspain`** y tu agente sabrá qué datos públicos existen, qué skill usar para cada consulta, y cómo instalarla al vuelo:

```bash
npx skills add jaimebs2/OpenSpain --skill openspain
```

> Con una sola skill instalada, tu agente puede guiarte a instalar cualquiera de las 97 skills especializadas cuando las necesites. Es como tener un experto en datos públicos españoles siempre disponible.

¿Prefieres instalar todo de golpe? 👇

```bash
npx skills add jaimebs2/OpenSpain
```

Esto instala las 97 skills y tu agente tiene acceso directo a todos los datos e información pública desde el primer momento.

---

## ¿Qué es esto?

OpenSpain convierte las APIs, datasets e información del sector público español en **skills consumibles desde cualquier agente de IA** que soporte el [estándar Agent Skills](https://agentskills.io): Claude, ChatGPT, Cursor, GitHub Copilot, Cline y más. Cada skill conoce sus endpoints, normativa, particularidades y límites — el agente solo tiene que invocarla.

Sin servidores que levantar. Sin SDKs que instalar. Sin claves de API en la mayoría de los casos.

Para los casos que necesitan lógica real (cálculo geométrico, tool calls deterministas, Codex) hay además **MCPs en Python** bajo [mcps/](mcps/) — ver [MCPs](#mcps).

---

## Skills

97 skills cubriendo legislación, parlamentos, meteorología, estadística, fiscalidad, extranjería, derecho laboral, justicia, vivienda, emprendimiento, identidad digital, energía, sanidad, educación, transporte y más. Verificadas con smoke tests reales contra las fuentes oficiales.

| # | Skill | Qué hace | Auth | Ficha |
|---|----------|----------|:---:|---|
| ⭐ | **openspain** | **Meta-skill**: directorio completo + routing automático a todas las skills | — | — |
| 01 | **aeat** | Estadísticas fiscales: IRPF, IVA, sociedades | — | [📄](docs/services/aeat.md) |
| 02 | **aemet** | Predicción, climatología, alertas meteorológicas | 🔑 | [📄](docs/services/aemet.md) |
| 03 | **aena** | Estadísticas aeroportuarias: pasajeros, operaciones, carga | — | [📄](docs/services/aena.md) |
| 04 | **bde** | Banco de España: tipos de interés, balanza, macroeconomía | — | [📄](docs/services/bde.md) |
| 05 | **bne** | Bibliografía, fondo sonoro, patrimonio | — | [📄](docs/services/bne.md) |
| 06 | **boe** | Legislación, sumarios diarios, leyes consolidadas | — | [📄](docs/services/boe.md) |
| 07 | **borme** | Registro Mercantil: constitución y cambios de empresas | — | [📄](docs/services/borme.md) |
| 08 | **catastro** | Inmuebles, parcelas, referencias catastrales | — | [📄](docs/services/catastro.md) |
| 09 | **cis** | Barómetros, encuestas sociológicas desde 1963 | — | [📄](docs/services/cis.md) |
| 10 | **cnig** | Cartografía, ortofotos, MDT, geocodificación | — | [📄](docs/services/cnig.md) |
| 11 | **cnmc** | Energía, telecomunicaciones, audiovisual, transporte | — | [📄](docs/services/cnmc.md) |
| 12 | **congreso** | Votaciones, iniciativas, intervenciones, vídeos de plenos | — | [📄](docs/services/congreso.md) |
| 13 | **cte** | Código Técnico de la Edificación: Documentos Básicos, incendios, accesibilidad, radón, zonas climáticas | — | [📄](docs/services/cte.md) |
| 14 | **dataestur** | Estadísticas de turismo: FRONTUR, EGATUR, alojamiento | — | [📄](docs/services/dataestur.md) |
| 15 | **datos-gob-es** | Catálogo nacional: +90.000 datasets públicos | — | [📄](docs/services/datos-gob-es.md) |
| 16 | **dgt** | Tráfico en tiempo real, zonas de bajas emisiones, siniestralidad vial | — | [tráfico](docs/services/dgt/trafico.md) · [zbe](docs/services/dgt/zbe.md) · [accidentes](docs/services/dgt/accidentes.md) |
| 17 | **educacion** | Centros educativos, matrículas, estadísticas | — | [📄](docs/services/educacion.md) |
| 18 | **educacion-guia** | Becas MEC, Selectividad/EBAU, Formación Profesional, oposiciones | — | [becas-mec](docs/services/educacion-guia/becas-mec.md) · [selectividad](docs/services/educacion-guia/selectividad.md) · [fp](docs/services/educacion-guia/fp.md) · [oposiciones](docs/services/educacion-guia/oposiciones.md) |
| 19 | **emprendimiento** | Alta como autónomo, crear empresa, licencias de actividad | — | [alta-autonomo](docs/services/emprendimiento/alta-autonomo.md) · [crear-empresa](docs/services/emprendimiento/crear-empresa.md) · [licencias-actividad](docs/services/emprendimiento/licencias-actividad.md) |
| 20 | **esios** | Sistema eléctrico: precio, demanda, generación por tecnología | 🔑 | [📄](docs/services/esios.md) |
| 21 | **extranjeria** | NIE, residencia, trabajo, nacionalidad, arraigo, reagrupación, familiar UE, asilo | — | [nie](docs/services/extranjeria/nie.md) · [residencia](docs/services/extranjeria/residencia.md) · [trabajo](docs/services/extranjeria/trabajo.md) · [nacionalidad](docs/services/extranjeria/nacionalidad.md) · [arraigo](docs/services/extranjeria/arraigo.md) · [reagrupacion](docs/services/extranjeria/reagrupacion.md) · [familiar-ue](docs/services/extranjeria/familiar-ue.md) · [asilo](docs/services/extranjeria/asilo.md) |
| 22 | **fiscalidad** | Autónomos, IVA, IRPF, sociedades, Modelo 036, operaciones intracomunitarias, facturación, no residentes, sucesiones | — | [autonomos](docs/services/fiscalidad/autonomos.md) · [iva](docs/services/fiscalidad/iva.md) · [irpf-autonomos](docs/services/fiscalidad/irpf-autonomos.md) · [irpf-asalariados](docs/services/fiscalidad/irpf-asalariados.md) · [sociedades](docs/services/fiscalidad/sociedades.md) · [modelo-036](docs/services/fiscalidad/modelo-036.md) · [operaciones-intracomunitarias](docs/services/fiscalidad/operaciones-intracomunitarias.md) · [facturacion](docs/services/fiscalidad/facturacion.md) · [retenciones](docs/services/fiscalidad/retenciones.md) · [itp-ajd](docs/services/fiscalidad/itp-ajd.md) · [impuestos-locales](docs/services/fiscalidad/impuestos-locales.md) · [no-residentes](docs/services/fiscalidad/no-residentes.md) · [sucesiones-donaciones](docs/services/fiscalidad/sucesiones-donaciones.md) |
| 23 | **identidad-digital** | Certificado digital FNMT, Cl@ve, DNI electrónico, AutoFirma | — | [certificado-digital](docs/services/identidad-digital/certificado-digital.md) · [clave](docs/services/identidad-digital/clave.md) · [dnie](docs/services/identidad-digital/dnie.md) · [autofirma](docs/services/identidad-digital/autofirma.md) |
| 24 | **laboral** | Contratos, nóminas, desempleo, ERE/ERTE, convenios colectivos, Inspección de Trabajo | — | [contratos](docs/services/laboral/contratos.md) · [nominas](docs/services/laboral/nominas.md) · [desempleo](docs/services/laboral/desempleo.md) · [ere-erte](docs/services/laboral/ere-erte.md) · [convenios](docs/services/laboral/convenios.md) · [inspeccion](docs/services/laboral/inspeccion.md) |
| 25 | **ine** | Demografía, economía, paro, censos, IPC | — | [📄](docs/services/ine.md) |
| 26 | **infosubvenciones** | Convocatorias y concesiones de subvenciones públicas | — | [📄](docs/services/infosubvenciones.md) |
| 27 | **jec** | Resultados electorales, censo, votos por partido | — | [📄](docs/services/jec.md) |
| 28 | **justicia** | Justicia gratuita, testamentos, herencias, poder notarial, registro civil, protección de datos | — | [justicia-gratuita](docs/services/justicia/justicia-gratuita.md) · [testamento](docs/services/justicia/testamento.md) · [herencias](docs/services/justicia/herencias.md) · [poder-notarial](docs/services/justicia/poder-notarial.md) · [registro-civil](docs/services/justicia/registro-civil.md) · [proteccion-datos](docs/services/justicia/proteccion-datos.md) |
| 29 | **miteco** | Embalses, calidad del aire, biodiversidad | — | [📄](docs/services/miteco.md) |
| 30 | **placsp** | Licitaciones y contratos del sector público | — | [📄](docs/services/placsp.md) |
| 31 | **puertos** | Oceanografía (mareógrafos, oleaje) y estadísticas portuarias | — | [📄](docs/services/puertos.md) |
| 32 | **rtve** | Archivo de noticias, programas, vídeos | — | [📄](docs/services/rtve.md) |
| 33 | **sanidad** | Centros de salud, hospitales, mortalidad | — | [📄](docs/services/sanidad.md) |
| 34 | **seguridad-social** | Afiliación, altas/bajas, pensiones | — | [📄](docs/services/seguridad-social.md) |
| 35 | **seguridad-social-guia** | Jubilación, vida laboral, incapacidad, maternidad/paternidad, cotizaciones | — | [jubilacion](docs/services/seguridad-social-guia/jubilacion.md) · [vida-laboral](docs/services/seguridad-social-guia/vida-laboral.md) · [incapacidad](docs/services/seguridad-social-guia/incapacidad.md) · [maternidad-paternidad](docs/services/seguridad-social-guia/maternidad-paternidad.md) · [cotizaciones](docs/services/seguridad-social-guia/cotizaciones.md) |
| 36 | **senado** | Actividad parlamentaria, comisiones, textos | — | [📄](docs/services/senado.md) |
| 37 | **snczi** | Zonas inundables, DPH, zona de policía/servidumbre (SNCZI, MITECO) | — | [📄](docs/services/snczi.md) |
| 38 | **sepe** | Paro registrado por municipio, sexo, edad, sector | — | [📄](docs/services/sepe.md) |
| 39 | **tramites** | Empadronamiento, antecedentes penales, apostilla, cita previa, TSE, legalización | — | [empadronamiento](docs/services/tramites/empadronamiento.md) · [antecedentes-penales](docs/services/tramites/antecedentes-penales.md) · [apostilla](docs/services/tramites/apostilla.md) · [cita-previa](docs/services/tramites/cita-previa.md) · [tarjeta-sanitaria-europea](docs/services/tramites/tarjeta-sanitaria-europea.md) · [legalizacion-documentos](docs/services/tramites/legalizacion-documentos.md) |
| 40 | **transparencia** | Contratos, subvenciones, altos cargos | — | [📄](docs/services/transparencia.md) |
| 41 | **vehiculos** | Carnet de conducir, ITV, permiso internacional, transferencia de vehículos | — | [carnet-conducir](docs/services/vehiculos/carnet-conducir.md) · [itv](docs/services/vehiculos/itv.md) · [permiso-internacional](docs/services/vehiculos/permiso-internacional.md) · [transferencia-vehiculos](docs/services/vehiculos/transferencia-vehiculos.md) |
| 42 | **vivienda** | Compraventa, hipotecas, registro propiedad, comunidad propietarios, alquiler | — | [compraventa](docs/services/vivienda/compraventa.md) · [hipotecas](docs/services/vivienda/hipotecas.md) · [registro-propiedad](docs/services/vivienda/registro-propiedad.md) · [comunidad-propietarios](docs/services/vivienda/comunidad-propietarios.md) · [alquiler](docs/services/vivienda/alquiler.md) |

🔑 = requiere API key gratuita.

> **Índice completo de fichas técnicas**: [docs/README.md](docs/README.md)

---

## MCPs

Algunas skills disponen además de una **implementación MCP en Python** bajo [mcps/](mcps/) para clientes que prefieren el [Model Context Protocol](https://modelcontextprotocol.io) (Codex, Claude Desktop, inspección HTTP, etc.) o que necesitan lógica que no se puede expresar como instrucciones (cálculo geométrico, parsing estructurado, paralelismo).

Skills y MCPs son **artefactos independientes** y se pueden usar por separado.

| MCP | Qué expone | Cuándo elegirlo sobre la skill |
|---|---|---|
| [catastro](mcps/catastro/) | Provincias, municipios, calles, refcat, coordenadas ↔ inmueble, parcela polígono, inmuebles cercanos | Necesitas tool calls deterministas (JSON) en vez de instrucciones a un LLM, o integrarlo con Codex |
| [snczi](mcps/snczi/) | Zonas inundables (T=10/100/500), DPH, aproximación zona policía/servidumbre, reporte combinado | Quieres el cálculo de buffers 100 m/5 m aplicado automáticamente, o lo integras con Codex |

Cada MCP trae su propio README con instalación, transportes (`stdio` / `streamable-http` / `sse`) y ejemplos para Codex y Claude Desktop.

Instalación rápida (ejemplo con `snczi`):

```bash
cd mcps/snczi
python3 -m venv .venv
source .venv/bin/activate
pip install -e .
openspain-snczi-mcp                                   # stdio
openspain-snczi-mcp --transport streamable-http       # HTTP
```

> Requisito común: Python ≥ 3.12. Cero autenticación contra los organismos (igual que las skills).

---

## Instalación avanzada

### Requisitos previos

El CLI de skills se ejecuta con `npx`, que viene incluido con Node.js. Si no lo tienes instalado:

```bash
# macOS (Homebrew)
brew install node

# Windows (winget)
winget install OpenJS.NodeJS

# Linux (NodeSource)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Verifica que funciona:

```bash
npx --version
```

### Opción 1 — La skill `openspain` (recomendado)

La forma más rápida de empezar. Instala una sola skill que actúa como **directorio inteligente**: tu agente sabrá qué datos públicos existen, qué skill cubre cada consulta, y le dirá al usuario cómo instalarla cuando la necesite.

```bash
npx skills add jaimebs2/OpenSpain --skill openspain
```

> Pregunta lo que quieras sobre datos públicos españoles y el agente te guía. Cuando necesites una skill concreta, te dice exactamente qué comando ejecutar.

### Opción 2 — Instalar todo

Si sabes que vas a necesitar varias skills, instálalas todas de una vez:

```bash
npx skills add jaimebs2/OpenSpain
```

### Opción 3 — Skills individuales

Instala solo las skills que necesites:

```bash
npx skills add jaimebs2/OpenSpain --skill boe        # Legislación
npx skills add jaimebs2/OpenSpain --skill ine        # Estadística
npx skills add jaimebs2/OpenSpain --skill catastro   # Inmuebles
npx skills add jaimebs2/OpenSpain --skill aemet      # Meteorología
```

Busca skills disponibles:

```bash
npx skills find openspain
```

Funciona con 18+ agentes de IA: Claude Code, GitHub Copilot, Cursor, Cline y más. El CLI copia la skill al directorio correcto del agente que estés usando.

### Instalación manual

Si prefieres no usar el CLI, copia la carpeta de la skill directamente:

```bash
cp -r openspain ~/.claude/skills/openspain
```

O instala todas las skills especializadas a la vez:

```bash
for d in openspain/skills/*/; do
  name=$(basename "$d")
  [ -f "$d/SKILL.md" ] && cp -r "$d" "$HOME/.claude/skills/$name"
done
```

Claude carga la skill automáticamente cuando una pregunta encaje con su `description`. Cero dependencias: las skills usan `WebFetch` directamente contra las APIs públicas.

### Skills con API key

Algunos organismos exigen registro gratuito. Exporta la variable antes de usar la skill:

```bash
export AEMET_API_KEY="tu_clave"     # AEMET
export ESIOS_TOKEN="tu_token"       # Red Eléctrica / ESIOS
```

Las skills leen estas variables del entorno — **nunca las piden como parámetro al modelo**.

---

## Estructura de una skill

El repositorio agrupa la skill maestra y todas las skills especializadas bajo la carpeta `openspain/`:

```
openspain/
├── SKILL.md              # skill maestra: directorio completo + routing automático
└── skills/
    ├── boe/
    │   ├── service.yml   # metadata estándar: URLs, auth, rate limits, licencia, datos
    │   └── SKILL.md      # frontmatter YAML + instrucciones para Claude
    └── ...
```

Tests junto a cada skill:

```
openspain/skills/boe/
├── service.yml
├── SKILL.md
└── tests/
    ├── smoke.sh          # llamada real contra la API
    └── prompts.md        # casos de uso para validación manual
```

Skills con variantes (ej. DGT) se agrupan en subcarpetas. El CLI escanea recursivamente, así que el `name` del frontmatter solo debe coincidir con el directorio padre inmediato:

```
openspain/skills/dgt/
├── dgt-trafico/
│   ├── service.yml
│   └── SKILL.md          # name: dgt-trafico
├── dgt-zbe/
│   ├── service.yml
│   └── SKILL.md          # name: dgt-zbe
└── dgt-accidentes/
    ├── service.yml
    └── SKILL.md           # name: dgt-accidentes
```

### `service.yml` — el contrato de la skill

Cada skill declara en `service.yml` todo lo que un agente (o un humano) necesita saber **antes** de usarla: qué hace, URLs oficiales, si requiere auth, rate limits conocidos, qué datos son accesibles y cuáles no, licencia, organismo emisor.

Es el **contrato público** de la skill. No hay magia oculta: las URLs, los límites y los términos de uso están a la vista en YAML legible.

### `SKILL.md` — la skill en sí

Sigue el [estándar Agent Skills](https://agentskills.io/specification): frontmatter YAML (`name`, `description`, `license`…) seguido de instrucciones markdown que Claude carga cuando la skill se activa. El nombre del directorio debe coincidir con el campo `name`. Compatible con `npx skills add`.

### `tests/` — verificación reproducible

- **`smoke.sh`** — script bash autocontenido que hace una llamada real a la API y verifica la respuesta. Sin dependencias más allá de `curl` y `jq`. Sale con código `0` si todo va bien, `1` si algo falla.
- **`prompts.md`** — preguntas de prueba con criterios de "pasa/falla" para validar manualmente que el agente está usando la skill correctamente.

### `mcps/<nombre>/` — MCP opcional en Python

Cuando una skill necesita lógica que un LLM no puede expresar de forma fiable (buffers geométricos, parsing binario, llamadas paralelas con retry específico) se añade un MCP independiente bajo [mcps/](mcps/) con su propio `pyproject.toml`, `src/<nombre>/`, `tests/` y README. Sigue el [Model Context Protocol](https://modelcontextprotocol.io) y es **compatible con Codex, Claude Desktop y cualquier cliente MCP**.

```
mcps/<nombre>/
├── README.md           # instalación, transportes, ejemplos Codex/Claude Desktop
├── pyproject.toml      # paquete openspain-<nombre>, script openspain-<nombre>-mcp
├── src/<nombre>/
│   ├── server.py       # tools MCP (stdio / streamable-http / sse)
│   └── service.py      # cliente HTTP puro, testeable sin MCP
└── tests/              # unittest con httpx.MockTransport
```

---

## Calidad

Antes de dar una skill por lista:

1. `bash openspain/skills/<nombre>/tests/smoke.sh` debe pasar.
2. Al menos 2 pruebas manuales con el agente usando los prompts de `openspain/skills/<nombre>/tests/prompts.md`.

---

## Contribuir

¿Falta un organismo? ¿Una API que conoces no está cubierta? Abre un issue o un PR. La barrera es baja: si la fuente es oficial, los datos son reutilizables y existe un endpoint o página estable, encaja.

Tres reglas no negociables (verificadas en CI): **origen declarado** (URLs oficiales en `service.yml`), **licencia de los datos declarada** y **contenido actualizable** (cada dato debe poder re-verificarse contra su fuente, por un humano o por un agente).

Guía completa en [CONTRIBUTING.md](CONTRIBUTING.md) · Plan del proyecto en [ROADMAP.md](ROADMAP.md) · [Código de conducta](CODE_OF_CONDUCT.md)

---

## Licencia

**Código**: MIT.

**Datos**: pertenecen a sus organismos emisores y se rigen por sus respectivas condiciones de reutilización (mayoritariamente Ley 37/2007 sobre reutilización de información del sector público o licencias abiertas equivalentes). Cada `service.yml` declara la licencia específica de la skill.
