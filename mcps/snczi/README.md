# OpenSpain SNCZI MCP

Servidor MCP para consulta de zonas inundables y Dominio Público Hidráulico (DPH) en España vía los servicios WMS públicos del SNCZI (MITECO).

## Qué hace

Expone estas tools MCP:

- `check_flood_zone(lat, lon)` — comprueba si un punto está en zonas inundables (T=10, T=100, T=500) y en DPH cartográfico.
- `check_flood_zone_by_refcat(refcat)` — resuelve la referencia catastral vía Catastro y llama a `check_flood_zone`.
- `check_flood_zone_by_address(province, municipality, street_type_code, street_name, number)` — resuelve una dirección vía Catastro y llama a `check_flood_zone`.
- `check_zona_policia_servidumbre(lat, lon, police_buffer_m=100, easement_buffer_m=5)` — aproxima si el punto está en zona de policía (100 m) o servidumbre (5 m) ampliando el BBOX sobre el DPH cartográfico.
- `get_snczi_report(lat, lon)` — reporte combinado: zonas inundables + DPH + policía/servidumbre + disclaimer legal.
- `get_snczi_report_by_refcat(refcat)` — lo mismo pero partiendo de una refcat.

Cobertura: todo el territorio nacional excepto País Vasco y Navarra.

## Fuentes de datos

- WMS SNCZI (MITECO):
  - `https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ10/wms.aspx`
  - `https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ100/wms.aspx`
  - `https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ500/wms.aspx`
  - `https://wms.mapama.gob.es/sig/Agua/DPHCartografico/wms.aspx`
- Catastro (resolución de refcat/dirección → coordenadas): `https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc`.

Ninguno requiere autenticación.

## Transporte recomendado

Para uso local con agentes, usa `stdio`. Para inspección manual o despliegue local, usa `streamable-http`.

## Instalación

Desde esta carpeta (`mcps/snczi/`):

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -e .
```

## Ejecución

Modo local por `stdio`:

```bash
openspain-snczi-mcp
```

Equivalente:

```bash
PYTHONPATH=src python3 -m snczi.server
```

Modo HTTP:

```bash
openspain-snczi-mcp --transport streamable-http --host 127.0.0.1 --port 8000
```

## Configuración en Codex

Ejemplo en `~/.codex/config.toml`:

```toml
[mcp_servers.snczi]
command = "/ruta/al/venv/bin/openspain-snczi-mcp"
args = []
```

## Configuración en Claude Desktop

```json
{
  "mcpServers": {
    "snczi": {
      "command": "/ruta/al/venv/bin/openspain-snczi-mcp",
      "args": []
    }
  }
}
```

## Desarrollo

Tests:

```bash
PYTHONPATH=src python3 -m unittest discover -s tests -v
```

## Notas

- `check_zona_policia_servidumbre` es una **aproximación** por BBOX ampliado sobre el DPH cartográfico, no un buffer geométrico exacto. Para dictámenes formales consulte a la Confederación Hidrográfica competente.
- La Zona de Flujo Preferente (ZFP) no se expone como WMS público estable y por eso no hay tool dedicada. Se puede aproximar con T=100 + vía de intenso desagüe.
- El calado máximo y las velocidades punto a punto solo están disponibles en el visor oficial del SNCZI.
