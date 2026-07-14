# @jaimebs2/OpenSpain-core (TypeScript)

Versión TypeScript de la librería compartida importada por MCPs/clientes JavaScript/TypeScript que consumen OpenSpain. Contiene los mismos primitivos que [openspain-core-py](../openspain-core-py/README.md):

- **Tipos**: `NIF`, `CIF`, `NIE`, `RefCat`, `CodigoINE`, `FechaISO`, `Importe`.
- **Validadores**: formato + dígito de control donde aplique.
- **Mapeo de errores**: tipo unión `OpenSpainError` con discriminante por categoría.

## Estado

**Esqueleto**. La implementación real llega con el primer MCP que lo importe (ver [ROADMAP.md](../../ROADMAP.md)), siguiendo la decisión de [ADR-0003](../../docs/adr/0003-openspain-core-desde-el-primer-mcp.md).

## Instalación local (desarrollo)

```bash
cd packages/openspain-core-ts
npm install
npm run build
```

## Equivalencia con la versión Python

Ambos paquetes mantienen **paridad de API pública**: si añades un tipo en la versión Python, lo añades también en TypeScript. Si se rompe paridad, abrir issue para reconciliar antes de publicar.
