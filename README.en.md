<div align="center">

# 🇪🇸 OpenSpain

**Spanish Government public data, ready for your AI agents.**

A curated directory of official Spanish public data, APIs and knowledge packaged as [Agent Skills](https://agentskills.io): standard metadata, one-command install, zero dependencies for most.

```bash
npx skills add jaimebs2/OpenSpain --skill openspain
```

[Services](#services) · [MCPs](#mcps) · [Installation](#installation) · [Structure](#service-structure) · [Documentation](docs/)

🇪🇸 [Leer en español](README.md)

</div>

---

## What is this?

OpenSpain turns Spanish public-sector APIs, datasets and official knowledge into **skills consumable from any AI agent** that supports the [Agent Skills standard](https://agentskills.io): Claude, ChatGPT, Cursor, GitHub Copilot, Cline and more. Each skill knows its endpoints, regulations, quirks and limits — the agent just has to invoke it.

No servers to spin up. No SDKs to install. No API keys in most cases. One folder, one `SKILL.md`, and you're good to go.

For use cases that need real logic (geometric buffers, deterministic tool calls, Codex) there are also **Python MCPs** under [mcps/](mcps/) — see [MCPs](#mcps).

---

## Services

97 services covering legislation, parliaments, weather, statistics, taxation, immigration, labour law, social security, justice, housing, entrepreneurship, digital identity, common citizen procedures, energy, healthcare, education, transport and more. Verified with real smoke tests against official sources.

| # | Service | What it does | Auth | Details |
|---|---------|-------------|:---:|---------|
| 01 | **aeat** | Tax statistics: income tax, VAT, corporate tax | — | [📄](docs/services/aeat.md) |
| 02 | **aemet** | Forecasts, climatology, weather alerts | 🔑 | [📄](docs/services/aemet.md) |
| 03 | **aena** | Airport statistics: passengers, operations, cargo | — | [📄](docs/services/aena.md) |
| 04 | **bde** | Bank of Spain: interest rates, balance of payments, macroeconomics | — | [📄](docs/services/bde.md) |
| 05 | **bne** | Bibliography, sound archive, heritage | — | [📄](docs/services/bne.md) |
| 06 | **boe** | Legislation, daily summaries, consolidated laws | — | [📄](docs/services/boe.md) |
| 07 | **borme** | Commercial Registry: company incorporations and changes | — | [📄](docs/services/borme.md) |
| 08 | **catastro** | Properties, plots, cadastral references | — | [📄](docs/services/catastro.md) |
| 09 | **cis** | Barometers, sociological surveys since 1963 | — | [📄](docs/services/cis.md) |
| 10 | **cnig** | Cartography, orthophotos, DEM, geocoding | — | [📄](docs/services/cnig.md) |
| 11 | **cnmc** | Energy, telecoms, audiovisual, transport | — | [📄](docs/services/cnmc.md) |
| 12 | **congreso** | Votes, legislative initiatives, speeches, plenary videos | — | [📄](docs/services/congreso.md) |
| 13 | **cte** | Spanish building code (CTE): Basic Documents, fire safety, accessibility, radon, climate zones | — | [📄](docs/services/cte.md) |
| 14 | **dataestur** | Tourism statistics: FRONTUR, EGATUR, accommodation | — | [📄](docs/services/dataestur.md) |
| 15 | **datos-gob-es** | National catalogue: 90,000+ public datasets | — | [📄](docs/services/datos-gob-es.md) |
| 16 | **dgt** | Real-time traffic, accidents, low-emission zones | — | [traffic](docs/services/dgt/trafico.md) · [lez](docs/services/dgt/zbe.md) · [accidents](docs/services/dgt/accidentes.md) |
| 17 | **educacion** | Schools, enrolment, education statistics | — | [📄](docs/services/educacion.md) |
| 18 | **educacion-guia** | MEC scholarships, university entrance exams (Selectividad), vocational training (FP), civil service exams | — | [becas-mec](docs/services/educacion-guia/becas-mec.md) · [selectividad](docs/services/educacion-guia/selectividad.md) · [fp](docs/services/educacion-guia/fp.md) · [oposiciones](docs/services/educacion-guia/oposiciones.md) |
| 19 | **emprendimiento** | Self-employed registration, company creation, activity licences | — | [alta-autonomo](docs/services/emprendimiento/alta-autonomo.md) · [crear-empresa](docs/services/emprendimiento/crear-empresa.md) · [licencias-actividad](docs/services/emprendimiento/licencias-actividad.md) |
| 20 | **esios** | Power system: price, demand, generation by technology | 🔑 | [📄](docs/services/esios.md) |
| 21 | **extranjeria** | NIE, residence permits, work permits, nationality, arraigo, family reunification, EU family card, asylum | — | [nie](docs/services/extranjeria/nie.md) · [residencia](docs/services/extranjeria/residencia.md) · [trabajo](docs/services/extranjeria/trabajo.md) · [nacionalidad](docs/services/extranjeria/nacionalidad.md) · [arraigo](docs/services/extranjeria/arraigo.md) · [reagrupacion](docs/services/extranjeria/reagrupacion.md) · [familiar-ue](docs/services/extranjeria/familiar-ue.md) · [asilo](docs/services/extranjeria/asilo.md) |
| 22 | **fiscalidad** | Autónomos, VAT, income tax, companies, Modelo 036, EU intracommunity operations, invoicing, non-residents, inheritance | — | [autonomos](docs/services/fiscalidad/autonomos.md) · [iva](docs/services/fiscalidad/iva.md) · [irpf-autonomos](docs/services/fiscalidad/irpf-autonomos.md) · [irpf-asalariados](docs/services/fiscalidad/irpf-asalariados.md) · [sociedades](docs/services/fiscalidad/sociedades.md) · [modelo-036](docs/services/fiscalidad/modelo-036.md) · [operaciones-intracomunitarias](docs/services/fiscalidad/operaciones-intracomunitarias.md) · [facturacion](docs/services/fiscalidad/facturacion.md) · [retenciones](docs/services/fiscalidad/retenciones.md) · [itp-ajd](docs/services/fiscalidad/itp-ajd.md) · [impuestos-locales](docs/services/fiscalidad/impuestos-locales.md) · [no-residentes](docs/services/fiscalidad/no-residentes.md) · [sucesiones-donaciones](docs/services/fiscalidad/sucesiones-donaciones.md) |
| 23 | **identidad-digital** | FNMT digital certificate, Cl@ve, electronic ID card, AutoFirma | — | [certificado-digital](docs/services/identidad-digital/certificado-digital.md) · [clave](docs/services/identidad-digital/clave.md) · [dnie](docs/services/identidad-digital/dnie.md) · [autofirma](docs/services/identidad-digital/autofirma.md) |
| 24 | **laboral** | Employment contracts, payslips, unemployment, ERE/ERTE, collective agreements, Labour Inspectorate | — | [contratos](docs/services/laboral/contratos.md) · [nominas](docs/services/laboral/nominas.md) · [desempleo](docs/services/laboral/desempleo.md) · [ere-erte](docs/services/laboral/ere-erte.md) · [convenios](docs/services/laboral/convenios.md) · [inspeccion](docs/services/laboral/inspeccion.md) |
| 25 | **ine** | Demographics, economy, unemployment, censuses, CPI | — | [📄](docs/services/ine.md) |
| 26 | **infosubvenciones** | Public grant calls and awards | — | [📄](docs/services/infosubvenciones.md) |
| 27 | **jec** | Election results, census, votes by party | — | [📄](docs/services/jec.md) |
| 28 | **justicia** | Free legal aid, wills, inheritance, power of attorney, civil registry, data protection | — | [justicia-gratuita](docs/services/justicia/justicia-gratuita.md) · [testamento](docs/services/justicia/testamento.md) · [herencias](docs/services/justicia/herencias.md) · [poder-notarial](docs/services/justicia/poder-notarial.md) · [registro-civil](docs/services/justicia/registro-civil.md) · [proteccion-datos](docs/services/justicia/proteccion-datos.md) |
| 29 | **miteco** | Reservoirs, air quality, biodiversity | — | [📄](docs/services/miteco.md) |
| 30 | **placsp** | Public-sector tenders and contracts | — | [📄](docs/services/placsp.md) |
| 31 | **puertos** | Oceanography (tide gauges, waves) and port statistics | — | [📄](docs/services/puertos.md) |
| 32 | **rtve** | News archive, programmes, videos | — | [📄](docs/services/rtve.md) |
| 33 | **sanidad** | Health centres, hospitals, mortality | — | [📄](docs/services/sanidad.md) |
| 34 | **seguridad-social** | Affiliation, registrations/deregistrations, pensions | — | [📄](docs/services/seguridad-social.md) |
| 35 | **seguridad-social-guia** | Retirement pensions, employment history, disability, parental leave, contributions | — | [jubilacion](docs/services/seguridad-social-guia/jubilacion.md) · [vida-laboral](docs/services/seguridad-social-guia/vida-laboral.md) · [incapacidad](docs/services/seguridad-social-guia/incapacidad.md) · [maternidad-paternidad](docs/services/seguridad-social-guia/maternidad-paternidad.md) · [cotizaciones](docs/services/seguridad-social-guia/cotizaciones.md) |
| 36 | **senado** | Parliamentary activity, committees, texts | — | [📄](docs/services/senado.md) |
| 37 | **snczi** | Flood zones, public hydraulic domain (DPH), police/easement zones (SNCZI, MITECO) | — | [📄](docs/services/snczi.md) |
| 38 | **sepe** | Registered unemployment by municipality, sex, age, sector | — | [📄](docs/services/sepe.md) |
| 39 | **tramites** | Municipal registration, criminal records, apostille, appointments, EHIC, document legalisation | — | [empadronamiento](docs/services/tramites/empadronamiento.md) · [antecedentes-penales](docs/services/tramites/antecedentes-penales.md) · [apostilla](docs/services/tramites/apostilla.md) · [cita-previa](docs/services/tramites/cita-previa.md) · [tarjeta-sanitaria-europea](docs/services/tramites/tarjeta-sanitaria-europea.md) · [legalizacion-documentos](docs/services/tramites/legalizacion-documentos.md) |
| 40 | **transparencia** | Contracts, grants, senior officials | — | [📄](docs/services/transparencia.md) |
| 41 | **vehiculos** | Driving licences, vehicle inspection (ITV), international driving permit, used-vehicle ownership transfer | — | [carnet-conducir](docs/services/vehiculos/carnet-conducir.md) · [itv](docs/services/vehiculos/itv.md) · [permiso-internacional](docs/services/vehiculos/permiso-internacional.md) · [transferencia-vehiculos](docs/services/vehiculos/transferencia-vehiculos.md) |
| 42 | **vivienda** | Home buying/selling, mortgages, land registry, homeowner associations, rental | — | [compraventa](docs/services/vivienda/compraventa.md) · [hipotecas](docs/services/vivienda/hipotecas.md) · [registro-propiedad](docs/services/vivienda/registro-propiedad.md) · [comunidad-propietarios](docs/services/vivienda/comunidad-propietarios.md) · [alquiler](docs/services/vivienda/alquiler.md) |

🔑 = requires free API key.

> **Full index of service sheets**: [docs/README.md](docs/README.md)

---

## MCPs

Some services ship an additional **Python MCP implementation** under [mcps/](mcps/) for clients that prefer the [Model Context Protocol](https://modelcontextprotocol.io) (Codex, Claude Desktop, HTTP inspection, etc.) or that need logic you cannot express as LLM instructions (geometric computation, structured parsing, parallelism).

Skills and MCPs are **independent artifacts** and can be used separately.

| MCP | What it exposes | When to pick it over the skill |
|---|---|---|
| [catastro](mcps/catastro/) | Provinces, municipalities, streets, refcat, coords ↔ property, polygon/parcel, nearby refcats | You need deterministic (JSON) tool calls instead of LLM instructions, or you're on Codex |
| [snczi](mcps/snczi/) | Flood zones (T=10/100/500), DPH, police/easement zone approximation, combined report | You want the 100 m / 5 m buffer applied automatically, or you're on Codex |

Each MCP ships its own README with install, transports (`stdio` / `streamable-http` / `sse`) and Codex/Claude Desktop snippets.

Quick install (example with `snczi`):

```bash
cd mcps/snczi
python3 -m venv .venv
source .venv/bin/activate
pip install -e .
openspain-snczi-mcp                                   # stdio
openspain-snczi-mcp --transport streamable-http       # HTTP
```

> Common requirement: Python ≥ 3.12. No authentication against the source agencies (same as the skills).

---

## Installation

### As a Claude skill (recommended)

Install the **`openspain` master skill** so your agent knows what public data exists and which skill to use for each query:

```bash
npx skills add jaimebs2/OpenSpain --skill openspain
```

Or install all skills at once:

```bash
npx skills add jaimebs2/OpenSpain
```

### Manual installation

Copy the master skill bundle:

```bash
cp -r openspain ~/.claude/skills/openspain
```

Or install all specialised skills at once:

```bash
for d in openspain/skills/*/; do
  name=$(basename "$d")
  [ -f "$d/SKILL.md" ] && cp -r "$d" "$HOME/.claude/skills/$name"
done
```

### Services with API key

Some agencies require free registration. Export the variable before using the skill:

```bash
export AEMET_API_KEY="your_key"     # AEMET
export ESIOS_TOKEN="your_token"     # Red Eléctrica / ESIOS
```

Skills read these variables from the environment — **they never ask the model for them as a parameter**.

---

## Service structure

The repository groups the master skill and all specialised skills under the `openspain/` folder:

```
openspain/
├── SKILL.md              # master skill: full directory + automatic routing
└── skills/
    ├── boe/
    │   ├── service.yml   # standard metadata: URLs, auth, rate limits, licence, data
    │   └── SKILL.md      # YAML frontmatter + instructions for Claude
    └── ...
```

Tests live inside each skill folder:

```
openspain/skills/boe/
├── service.yml
├── SKILL.md
└── tests/
    ├── smoke.sh          # real call against the API
    └── prompts.md        # use cases for manual validation
```

Services with sub-skills (DGT) group them in subdirectories:

```
openspain/skills/dgt/
├── dgt-trafico/
│   ├── service.yml
│   └── SKILL.md
├── dgt-zbe/...
└── dgt-accidentes/...
```

### `service.yml` — the service contract

Each service declares in `service.yml` everything an agent (or a human) needs to know **before** using it: what it does, official URLs, whether it requires auth, known rate limits, which data is accessible and which isn't, licence, issuing body.

It is the **public contract** of the service. No hidden magic: URLs, limits and terms of use are all in plain YAML.

### `SKILL.md` — the skill itself

Follows the [Agent Skills standard](https://agentskills.io): YAML frontmatter (`name`, `description`, `allowed-tools`…) followed by markdown instructions that Claude loads when the skill is activated. See the [official reference](https://code.claude.com/docs/en/skills) for all supported fields.

### `tests/` — reproducible verification

- **`smoke.sh`** — self-contained bash script that makes a real API call and verifies the response. No dependencies beyond `curl` and `jq`. Exits with code `0` on success, `1` on failure.
- **`prompts.md`** — test questions with pass/fail criteria to manually validate that the agent is using the skill correctly.

### `mcps/<name>/` — optional Python MCP

When a service needs logic an LLM can't express reliably (geometric buffers, binary parsing, parallel calls with specific retry) we ship an independent MCP under [mcps/](mcps/) with its own `pyproject.toml`, `src/<name>/`, `tests/` and README. It follows the [Model Context Protocol](https://modelcontextprotocol.io) and is **compatible with Codex, Claude Desktop and any MCP client**.

```
mcps/<name>/
├── README.md           # install, transports, Codex/Claude Desktop snippets
├── pyproject.toml      # package openspain-<name>, entrypoint openspain-<name>-mcp
├── src/<name>/
│   ├── server.py       # MCP tools (stdio / streamable-http / sse)
│   └── service.py      # pure HTTP client, testable without MCP
└── tests/              # unittest with httpx.MockTransport
```

---

## Quality

Before marking a service as ready:

1. `bash openspain/skills/<name>/tests/smoke.sh` must pass.
2. At least 2 manual tests with the agent using the prompts from `openspain/skills/<name>/tests/prompts.md`.

---

## Contributing

Missing an agency? Know an API that isn't covered? Open an issue or PR. The bar is low: if the source is official, the data is reusable and a stable endpoint or page exists, it fits.

Three non-negotiable rules (enforced in CI): **declared origin** (official URLs in `service.yml`), **declared data licence**, and **updatable content** (every fact must be re-verifiable against its source, by a human or by an agent).

Full guide in [CONTRIBUTING.md](CONTRIBUTING.md) · Project plan in [ROADMAP.md](ROADMAP.md) · [Code of conduct](CODE_OF_CONDUCT.md)

---

## Licence

**Code**: MIT.

**Data**: belongs to their issuing bodies and is governed by their respective reuse conditions (mostly Law 37/2007 on the reuse of public-sector information or equivalent open licences). Each `service.yml` declares the specific licence for the service.
