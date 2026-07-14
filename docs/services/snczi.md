# snczi — Sistema Nacional de Cartografía de Zonas Inundables (MITECO)

Consulta de zonas inundables, Dominio Público Hidráulico (DPH), zona de policía y zona de servidumbre a partir de coordenadas, referencia catastral o dirección, usando los servicios WMS públicos del MITECO.

Metadata completa de la skill en [service.yml](../../skills/snczi/service.yml).

## Qué puedes consultar

- Zonas inundables con probabilidad **alta** (T=10 años), **media** (T=100) y **baja** (T=500).
- Dominio Público Hidráulico (DPH) cartográfico.
- Aproximación de zona de policía (100 m) y zona de servidumbre (5 m) desde el DPH (art. 6 y 7 del RD 849/1986).
- Entrada aceptada: coordenadas WGS84, referencia catastral (refcat) o dirección postal (se encadena con la skill `catastro` para el geocodificado).

**No cubre**: País Vasco y Navarra (cartografías propias no federadas en el SNCZI).
**No accesible como WMS estable**: Zona de Flujo Preferente (ZFP), calado máximo y velocidades punto a punto — disponibles solo en el visor oficial.

## Implementaciones disponibles

Esta skill ofrece **dos implementaciones independientes**:

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../skills/snczi/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/snczi/` |
| [mcps/snczi/](../../mcps/snczi/) | Codex, otros clientes MCP, o si necesitas buffer de zona de policía/servidumbre | Requiere Python 3.12+ y `pip install` |

### Opción A — Skill (recomendada para Claude)

```bash
cp -r skills/snczi ~/.claude/skills/snczi
```

La skill consulta los WMS vía `WebFetch` con `GetFeatureInfo` — sin instalación, sin dependencias.

### Opción B — MCP (Codex u otros clientes MCP)

```bash
cd mcps/snczi
python3 -m venv .venv
source .venv/bin/activate
pip install -e .
```

Instrucciones completas de configuración en [mcps/snczi/](../../mcps/snczi/).

## API pública

El SNCZI expone servicios WMS OGC sin autenticación bajo el dominio `wms.mapama.gob.es/sig/Agua/`:

| Capa              | Endpoint                                   | Layer name                    |
|-------------------|--------------------------------------------|-------------------------------|
| Z.I. T=10         | `ZI_LaminasQ10/wms.aspx`                   | `NZ.RiskZone`                 |
| Z.I. T=100        | `ZI_LaminasQ100/wms.aspx`                  | `NZ.RiskZone`                 |
| Z.I. T=500        | `ZI_LaminasQ500/wms.aspx`                  | `NZ.RiskZone`                 |
| DPH cartográfico  | `DPHCartografico/wms.aspx`                 | `Cauces con DPH cartográfico` |

Operaciones soportadas: `GetCapabilities`, `GetMap`, `GetFeatureInfo`. CRS recomendado: `EPSG:4326` con `VERSION=1.3.0`.

Detalle técnico, ejemplos y parámetros en [skills/snczi/references/wms-endpoints.md](../../skills/snczi/references/wms-endpoints.md).

## Marco legal

- [Directiva 2007/60/CE](https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:32007L0060) sobre evaluación y gestión de riesgos de inundación.
- [RD 903/2010](https://www.boe.es/buscar/act.php?id=BOE-A-2010-11184) de evaluación y gestión de riesgos de inundación.
- [RD 849/1986](https://www.boe.es/buscar/act.php?id=BOE-A-1986-10638) Reglamento del Dominio Público Hidráulico (arts. 6 y 7, zonas de servidumbre y policía).

La cartografía del SNCZI es orientativa: para dictámenes formales en proyectos constructivos, consulte a la Confederación Hidrográfica competente.
