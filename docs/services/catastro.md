# catastro — Dirección General del Catastro

Acceso a la información pública del Catastro español: inmuebles, parcelas, referencias catastrales, direcciones y coordenadas.

Metadata completa de la skill en [service.yml](../../services/catastro/service.yml).

## Qué puedes consultar

- Inmuebles por referencia catastral (14 o 20 caracteres)
- Búsqueda por dirección: provincia → municipio → calle → número
- Parcelas rústicas por polígono y parcela
- Coordenadas → referencia catastral (y viceversa)
- Referencias catastrales cercanas a un punto

**No accesible**: titularidad y valor catastral (datos protegidos).
**No cubre**: País Vasco y Navarra (catastro propio).

## Implementaciones disponibles

Esta skill ofrece **dos implementaciones independientes**. Instala la que encaje con tu agente:

| Implementación | Cuándo usar | Instalación |
|---|---|---|
| [SKILL.md](../../services/catastro/SKILL.md) | Claude Code, Claude Desktop, cualquier cliente que soporte Anthropic Skills | Cero dependencias. Copia la carpeta a `~/.claude/skills/catastro/` |
| [mcp/](mcp/) | Codex, otros clientes MCP, o si necesitas un servidor persistente | Requiere Python 3.12+ y `pip install` |

### Opción A — Skill (recomendada para Claude)

```bash
cp -r services/catastro ~/.claude/skills/catastro
```

Eso es todo. La skill usa `WebFetch` directamente contra los endpoints JSON del Catastro — sin instalación, sin dependencias, sin scripts.

### Opción B — MCP (para Codex u otros clientes MCP)

```bash
cd services/catastro/mcp
python3 -m venv .venv
source .venv/bin/activate
pip install -e .
```

Ver instrucciones completas de configuración (Codex, Claude Desktop, etc.) en [mcp/](../../services/catastro/mcp/).

## API pública

El Catastro expone tres endpoints JSON sin autenticación:

- **Callejero**: provincias, municipios, calles, datos de inmuebles
- **Códigos**: búsqueda por códigos catastrales
- **Coordenadas**: conversión coordenadas ↔ referencia catastral

URLs, límites y términos de uso en [service.yml](../../services/catastro/service.yml).
