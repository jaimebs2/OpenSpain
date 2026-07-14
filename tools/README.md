# Tools plane (Nivel 4)

MCPs Python que exponen **tools deterministas** por vertical: cálculo, validación y propuesta basados en el domain knowledge español. No son proxy de una API (eso vive en [`mcps/`](../mcps/)); combinan una o varias fuentes con lógica determinista.

Un MCP de tools vive en `tools/<vertical>-tools/` con la misma estructura que un MCP de datos:

```
tools/<vertical>-tools/
├── pyproject.toml       # paquete openspain-<vertical>-tools
├── src/<vertical>_tools/
│   ├── server.py        # entry point MCP
│   └── ...              # tools deterministas
├── tests/               # tests por cada rama de decisión, con casos reales
└── README.md
```

## Cuándo una tool vive aquí y no en `mcps/`

- Si **solo** hace proxy de una API pública → va a [`mcps/`](../mcps/).
- Si añade **cálculo o validación determinista** sobre una o varias fuentes → va aquí.

Ejemplos del tipo de tool que encaja en este plano (una por vertical, según demanda real): simuladores de cálculo, validadores de requisitos, mapeos deterministas. Se implementan cuando un vertical los necesita de verdad, no por adelantado (ver [ROADMAP.md](../ROADMAP.md)).

Aún no hay ningún MCP de tools publicado. Si quieres aportar uno, abre un issue para acordar el vertical y el alcance antes de empezar (ver [CONTRIBUTING.md](../CONTRIBUTING.md)).
