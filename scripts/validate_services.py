#!/usr/bin/env python3
"""Valida todos los service.yml del repo contra el schema canónico.

Comprueba, para cada skill/MCP/tool:
  1. service.yml existe y parsea como YAML.
  2. Cumple data/schemas/service.schema.json.
  3. El campo `name` coincide con el nombre del directorio
     (o con `<padre>-<directorio>` en sub-skills, ej. fiscalidad/iva → fiscalidad-iva).
  4. SKILL.md existe (sólo skills) y su frontmatter `name` coincide con el del service.yml.
  5. `license.data` está declarada (origen de los datos) y hay al menos un enlace
     en `links` (origen consultable para actualizaciones automáticas).

Uso: python3 scripts/validate_services.py
Sale con código 0 si todo pasa, 1 si hay errores.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

try:
    import yaml
    from jsonschema import Draft202012Validator
except ImportError:
    print("Faltan dependencias: pip install pyyaml jsonschema", file=sys.stderr)
    sys.exit(2)

REPO = Path(__file__).resolve().parent.parent
SCHEMA_PATH = REPO / "data" / "schemas" / "service.schema.json"

FRONTMATTER_NAME = re.compile(r"^name:\s*[\"']?([a-z0-9-]+)[\"']?\s*$", re.MULTILINE)


def find_service_files() -> list[Path]:
    roots = [REPO / "openspain" / "skills", REPO / "mcps", REPO / "tools"]
    files = []
    for root in roots:
        if root.is_dir():
            files.extend(sorted(root.rglob("service.yml")))
    bundle = REPO / "openspain" / "service.yml"
    if bundle.exists():
        files.append(bundle)
    return files


def expected_names(directory: Path) -> set[str]:
    names = {directory.name}
    parent = directory.parent.name
    if parent not in ("skills", "mcps", "tools", "openspain"):
        names.add(f"{parent}-{directory.name}")
    return names


def main() -> int:
    schema = json.loads(SCHEMA_PATH.read_text())
    validator = Draft202012Validator(schema)

    errors: list[str] = []
    files = find_service_files()

    for path in files:
        rel = path.relative_to(REPO)
        directory = path.parent
        try:
            data = yaml.safe_load(path.read_text())
        except yaml.YAMLError as exc:
            errors.append(f"{rel}: YAML inválido — {exc}")
            continue
        if not isinstance(data, dict):
            errors.append(f"{rel}: el contenido no es un mapping YAML")
            continue

        for err in sorted(validator.iter_errors(data), key=lambda e: list(e.path)):
            loc = ".".join(str(p) for p in err.path) or "(raíz)"
            errors.append(f"{rel}: {loc}: {err.message}")

        name = data.get("name")
        if name and directory != REPO / "openspain" and name not in expected_names(directory):
            errors.append(
                f"{rel}: name '{name}' no coincide con el directorio "
                f"(esperado uno de: {', '.join(sorted(expected_names(directory)))})"
            )

        # Origen consultable: sin al menos un enlace oficial, un agente no puede
        # verificar ni refrescar el contenido de la skill.
        links = data.get("links") or {}
        if not links:
            errors.append(f"{rel}: links vacío — declara al menos una URL oficial de origen")
        license_ = data.get("license") or {}
        if "openspain/skills" in str(rel) and not license_.get("data"):
            errors.append(f"{rel}: license.data ausente — declara la licencia de los datos de origen")

        skill_md = directory / "SKILL.md"
        if "openspain" in str(rel) and skill_md.exists() and name:
            match = FRONTMATTER_NAME.search(skill_md.read_text()[:500])
            if match and match.group(1) != name:
                errors.append(
                    f"{rel}: name '{name}' ≠ frontmatter de SKILL.md '{match.group(1)}'"
                )

    print(f"Validados {len(files)} service.yml")
    if errors:
        print(f"\n{len(errors)} error(es):\n", file=sys.stderr)
        for err in errors:
            print(f"  ✗ {err}", file=sys.stderr)
        return 1
    print("Todos los service.yml cumplen el schema.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
