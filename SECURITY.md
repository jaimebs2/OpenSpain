# Política de seguridad

## Alcance

OpenSpain es un directorio de skills de datos públicos y orientación sobre el sector público español (APIs, datasets, normativa, fiscalidad, trámites…). Las skills **no** manejan datos personales, credenciales de usuario ni sistemas de producción propios.

Sin embargo, algunas skills referencian URLs de APIs oficiales y dos requieren API keys (AEMET, ESIOS). Si detectas un problema de seguridad relacionado con el proyecto, agradecemos que lo reportes de forma responsable.

## Reportar una vulnerabilidad

**No abras un issue público** para reportar vulnerabilidades de seguridad.

En su lugar, usa la funcionalidad de [Security Advisories de GitHub](https://github.com/jaimebs2/OpenSpain/security/advisories/new) para reportar de forma privada. Incluye:

- Descripción del problema.
- Pasos para reproducirlo.
- Impacto potencial.

## Qué reportar

- API keys expuestas accidentalmente en el código o en el historial de commits.
- URLs maliciosas o comprometidas en las skills.
- Inyección de instrucciones en SKILL.md que puedan hacer que un agente ejecute acciones no deseadas.
- Cualquier otro problema que pueda afectar a los usuarios del proyecto.

## Qué NO es un problema de seguridad de este proyecto

- Vulnerabilidades en las APIs oficiales del Gobierno de España (reportar al organismo correspondiente).
- Problemas del agente de IA en sí (reportar al proveedor: Anthropic, OpenAI, etc.).
