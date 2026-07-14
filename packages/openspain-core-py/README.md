# openspain-core (Python)

Librería compartida importada por cada MCP de OpenSpain. Contiene:

- **Tipos**: `NIF`, `CIF`, `NIE`, `RefCat` (referencia catastral), `CodigoINE`, `FechaISO`, `Importe`.
- **Validadores**: formato + dígito de control donde aplique.
- **Mapeo de errores**: enum `OpenSpainError` que cada MCP traduce desde el error específico de la fuente.

## Estado

**Esqueleto**. La implementación real llega con el primer MCP que lo importe (ver [ROADMAP.md](../../ROADMAP.md)), siguiendo la decisión de [ADR-0003](../../docs/adr/0003-openspain-core-desde-el-primer-mcp.md).

## Instalación local (desarrollo)

```bash
cd packages/openspain-core-py
pip install -e .
```

## Convenciones

- Mantener la superficie pública **pequeña**: sólo lo que algún MCP del repo usa hoy. Expandir cuando llegue una necesidad real.
- Cada cambio breaking incrementa el major version. Cada MCP fija una versión compatible explícita en su `pyproject.toml`.
- Tests viven en `tests/`. Coverage objetivo: >90% en validadores (los tipos son trivial; los validadores son donde el bug duele).
