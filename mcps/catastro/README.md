# OpenSpain Catastro MCP

Servidor MCP para los endpoints JSON públicos del Catastro.

## Qué hace

Expone estas tools MCP:

- `list_provinces`
- `search_municipalities`
- `search_streets`
- `search_numbers_by_street_code`
- `get_property_by_refcat`
- `get_property_by_location`
- `get_refcat_from_coordinates`
- `get_coordinates_from_refcat`
- `get_property_by_polygon_parcel`
- `get_nearby_refcats`

## Cómo lo descubre un agente

No hay autodiscovery.

Un cliente MCP descubre este servidor solo si lo registras explícitamente en la configuración del cliente:

- en modo `stdio`, el cliente lanza el binario como subproceso y habla MCP por `stdin/stdout`
- en modo HTTP, el cliente se conecta a una URL MCP que tú arrancas antes

## Transporte recomendado

Para uso local con agentes, usa `stdio`.

- no escucha en ningún puerto
- no imprime nada en terminal
- se queda bloqueado esperando mensajes MCP del cliente

Para inspección manual o despliegue local, usa `streamable-http`.

- por defecto escucha en `127.0.0.1:8000`
- endpoint MCP: `http://127.0.0.1:8000/mcp`
- mantén `127.0.0.1` en local salvo que tengas un motivo claro para exponerlo fuera
- si usas `sse`, el endpoint SSE por defecto es `http://127.0.0.1:8000/sse`
- `sse` queda como modo de compatibilidad; para HTTP nuevo usa `streamable-http`

## Instalación

Desde esta carpeta (`services/catastro/mcp/`):

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -e .
```

## Ejecución

Modo local por `stdio`:

```bash
openspain-catastro-mcp
```

Equivalente:

```bash
PYTHONPATH=src python3 -m catastro.server
```

Modo HTTP:

```bash
openspain-catastro-mcp --transport streamable-http --host 127.0.0.1 --port 8000
```

Modo SSE:

```bash
openspain-catastro-mcp --transport sse --host 127.0.0.1 --port 8000
```

## Configuración en Codex

Ejemplo en `~/.codex/config.toml`:

```toml
[mcp_servers.catastro]
command = "/ruta/al/venv/bin/openspain-catastro-mcp"
args = []
```

Con esa configuración, Codex:

1. arranca el proceso cuando lo necesita
2. hace `initialize`
3. descubre las tools MCP del servidor
4. las usa durante la sesión

## Configuración en Claude Desktop

Ejemplo en la configuración MCP de Claude Desktop:

```json
{
  "mcpServers": {
    "catastro": {
      "command": "/ruta/al/venv/bin/openspain-catastro-mcp",
      "args": []
    }
  }
}
```

## Inspección manual

Si quieres probarlo sin integrarlo todavía en un agente:

1. Arranca el servidor en HTTP:

```bash
openspain-catastro-mcp --transport streamable-http --host 127.0.0.1 --port 8000
```

2. Conecta un inspector MCP a:

```text
http://127.0.0.1:8000/mcp
```

## Comportamiento esperado al lanzarlo a mano

Si ejecutas `openspain-catastro-mcp` directamente, es normal que:

- no salga ningún texto
- parezca que “se queda colgado”

No está colgado. Está esperando a que un cliente MCP le envíe mensajes por `stdio`.

## Desarrollo

Tests:

```bash
PYTHONPATH=src python3 -m unittest discover -s tests -v
```

Ayuda del CLI:

```bash
openspain-catastro-mcp --help
```
