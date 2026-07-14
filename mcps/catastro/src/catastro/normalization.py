from __future__ import annotations

import re
import unicodedata


_SPACE_RE = re.compile(r"\s+")
_STREET_TYPE_PREFIXES: tuple[tuple[str, str], ...] = (
    ("AVENIDA", "AV"),
    ("AVDA", "AV"),
    ("AV", "AV"),
    ("CALLE", "CL"),
    ("C/", "CL"),
    ("CL", "CL"),
    ("PASEO", "PS"),
    ("PS", "PS"),
    ("PLAZA", "PZ"),
    ("PZ", "PZ"),
    ("CARRETERA", "CR"),
    ("CR", "CR"),
    ("CAMINO", "CM"),
    ("CM", "CM"),
    ("TRAVESIA", "TR"),
    ("TR", "TR"),
    ("GLORIETA", "GL"),
    ("GL", "GL"),
    ("PASAJE", "PJ"),
    ("PJ", "PJ"),
    ("BARRIO", "BO"),
    ("BO", "BO"),
    ("URBANIZACION", "UR"),
    ("URB", "UR"),
    ("RONDA", "RD"),
    ("RD", "RD"),
)


def collapse_spaces(value: str) -> str:
    return _SPACE_RE.sub(" ", value.strip())


def normalize_text(value: str | None) -> str | None:
    if value is None:
        return None
    collapsed = collapse_spaces(value)
    if not collapsed:
        return None
    return collapsed.upper()


def strip_accents(value: str) -> str:
    normalized = unicodedata.normalize("NFD", value)
    return "".join(char for char in normalized if unicodedata.category(char) != "Mn")


def normalize_for_scoring(value: str | None) -> str | None:
    normalized = normalize_text(value)
    if normalized is None:
        return None
    return strip_accents(normalized)


def normalize_street_query(
    street_name_text: str | None,
    street_type_code: str | None = None,
) -> tuple[str | None, str | None]:
    normalized_type = normalize_text(street_type_code)
    normalized_name = normalize_text(street_name_text)
    if normalized_name is None:
        return normalized_type, None

    score_name = normalize_for_scoring(normalized_name)
    if score_name is None:
        return normalized_type, normalized_name

    for raw_prefix, mapped_type in _STREET_TYPE_PREFIXES:
        if score_name == raw_prefix:
            return normalized_type or mapped_type, normalized_name

        prefix = f"{raw_prefix} "
        if score_name.startswith(prefix):
            cleaned_name = normalized_name[len(prefix) :]
            return normalized_type or mapped_type, normalize_text(cleaned_name)

    return normalized_type, normalized_name
