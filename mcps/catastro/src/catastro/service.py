from __future__ import annotations

import atexit
from dataclasses import dataclass
from typing import Any

import httpx

from .normalization import normalize_street_query, normalize_text


CALLEJERO_BASE_URL = (
    "https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc"
)
CALLEJERO_CODES_BASE_URL = (
    "https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejeroCodigos.svc"
)
COORDINATES_BASE_URL = (
    "https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc"
)


def _null_if_blank(value: Any) -> str | None:
    if value is None:
        return None
    text = str(value).strip()
    return text or None


def _ensure_list(value: Any) -> list[Any]:
    if value is None:
        return []
    if isinstance(value, list):
        return value
    return [value]


def _parse_number(value: Any) -> int | float | None:
    if value is None:
        return None
    text = str(value).strip()
    if not text:
        return None

    if "," in text:
        normalized = text.replace(".", "").replace(",", ".")
    else:
        normalized = text
    try:
        number = float(normalized)
    except ValueError:
        return None

    if number.is_integer():
        return int(number)
    return number


def _compose_refcat(rc: dict[str, Any] | None) -> str | None:
    if not rc:
        return None
    parts = [
        _null_if_blank(rc.get("pc1")),
        _null_if_blank(rc.get("pc2")),
        _null_if_blank(rc.get("car")),
        _null_if_blank(rc.get("cc1")),
        _null_if_blank(rc.get("cc2")),
    ]
    return "".join(part for part in parts if part)


def _extract_errors(payload: dict[str, Any]) -> list[dict[str, Any]]:
    control = payload.get("control") or {}
    has_error = any(
        str(key).startswith("cuerr") and int(str(value)) > 0
        for key, value in control.items()
        if str(value).isdigit()
    )
    if not has_error:
        return []

    raw_errors = payload.get("lerr")
    if raw_errors is None:
        return []
    if isinstance(raw_errors, list):
        return raw_errors
    if isinstance(raw_errors, dict):
        if "err" in raw_errors:
            return _ensure_list(raw_errors["err"])
        return [raw_errors]
    return []


def _map_error_code(upstream_code: str | None, description: str | None) -> str:
    text = f"{upstream_code or ''} {description or ''}".upper()
    if any(token in text for token in ("NO EXISTE", "NO HAY", "INEXISTENTE", "NO DISPONIBLE")):
        return "NOT_FOUND"
    if any(
        token in text
        for token in (
            "OBLIGATORIA",
            "OBLIGATORIO",
            "FORMATO",
            "INCORRECT",
            "INVALI",
            "DEBE",
            "ERRONEA",
        )
    ):
        return "INVALID_INPUT"
    return "UPSTREAM_ERROR"


def _first_error_payload(
    service_name: str,
    payload: dict[str, Any],
    candidates: list[dict[str, Any]] | None = None,
) -> dict[str, Any] | None:
    errors = _extract_errors(payload)
    if not errors:
        return None

    first_error = errors[0] or {}
    description = _null_if_blank(first_error.get("des")) or "Upstream service error"
    upstream_code = _null_if_blank(first_error.get("cod"))
    error: dict[str, Any] = {
        "error": {
            "code": _map_error_code(upstream_code, description),
            "message": description,
            "upstream": {
                "service": service_name,
                "code": upstream_code,
                "description": description,
            },
        }
    }
    if candidates:
        error["error"]["candidates"] = candidates
    return error


def _street_ine_payload(dirine: dict[str, Any] | None) -> dict[str, str | None] | None:
    if not isinstance(dirine, dict):
        return None

    payload = {
        "collective_entity_code": _null_if_blank(dirine.get("ecine")),
        "singular_entity_code": _null_if_blank(dirine.get("esine")),
        "nucleus_code": _null_if_blank(dirine.get("nucine")),
        "street_code": _null_if_blank(dirine.get("vine")),
        "street_type_code": _null_if_blank(dirine.get("sine")),
        "street_name": _null_if_blank(dirine.get("deine")),
    }
    if all(value is None for value in payload.values()):
        return None
    return payload


def _extract_urban_address(source: dict[str, Any]) -> dict[str, str | None]:
    dt = source.get("dt") or {}
    urban = (
        dt.get("locs", {})
        .get("lous", {})
        .get("lourb", {})
    )
    direction = urban.get("dir", {})
    return {
        "street_type_code": _null_if_blank(direction.get("tv")),
        "street_name": _null_if_blank(direction.get("nv")),
        "number": _null_if_blank(direction.get("pnp")),
        "municipality": _null_if_blank(dt.get("nm")),
        "province": _null_if_blank(dt.get("np")),
    }


def _extract_plot_area(finca: dict[str, Any]) -> int | float | None:
    dff = finca.get("dff") or {}
    if "ss" in dff:
        return _parse_number(dff.get("ss"))
    return _parse_number((dff.get("ssf") or {}).get("ss"))


def _extract_rural_location(source: dict[str, Any]) -> dict[str, str | None]:
    dt = source.get("dt") or {}
    locs = dt.get("locs") or {}

    for branch_name in ("lors", "lous"):
        branch = locs.get(branch_name) or {}
        lorus = branch.get("lorus") or {}
        cpp = lorus.get("cpp") or {}
        polygon = _null_if_blank(cpp.get("cpo"))
        parcel = _null_if_blank(cpp.get("cpa"))
        if polygon is not None or parcel is not None:
            return {"polygon": polygon, "parcel": parcel}

    return {"polygon": None, "parcel": None}


def _common_elements_area(lcons: Any) -> int | float | None:
    for item in _ensure_list(lcons):
        if _null_if_blank(item.get("lcd")) == "ELEMENTOS COMUNES":
            return _parse_number(item.get("dfcons", {}).get("stl"))
    return None


def _property_payload_from_bi(bi: dict[str, Any], finca: dict[str, Any], lcons: Any) -> dict[str, Any]:
    idbi = bi.get("idbi") or {}
    debi = bi.get("debi") or {}
    return {
        "refcat": _compose_refcat(idbi.get("rc")),
        "asset_type": _null_if_blank(idbi.get("cn")),
        "address": _extract_urban_address(bi),
        "property": {
            "use": _null_if_blank(debi.get("luso")),
            "built_area_m2": _parse_number(debi.get("sfc")),
            "year_built": _parse_number(debi.get("ant")),
            "participation_coefficient": _parse_number(debi.get("cpt")),
        },
        "plot": {
            "plot_area_m2": _extract_plot_area(finca),
            "common_elements_area_m2": _common_elements_area(lcons),
        },
    }


def _multi_location_item(entry: dict[str, Any]) -> dict[str, Any]:
    loint = (
        entry.get("dt", {})
        .get("locs", {})
        .get("lous", {})
        .get("lourb", {})
        .get("loint", {})
    )
    return {
        "refcat": _compose_refcat(entry.get("rc")),
        "block": _null_if_blank(loint.get("bq")),
        "stair": _null_if_blank(loint.get("es")),
        "floor": _null_if_blank(loint.get("pt")),
        "door": _null_if_blank(loint.get("pu")),
    }


@dataclass(slots=True)
class CatastroService:
    client: httpx.Client

    def _get_json(
        self,
        base_url: str,
        path: str,
        params: dict[str, Any],
    ) -> dict[str, Any]:
        sanitized = {key: value for key, value in params.items() if value is not None}
        response = self.client.get(f"{base_url}{path}", params=sanitized)
        response.raise_for_status()
        return response.json()

    def list_provinces(self) -> dict[str, Any]:
        data = self._get_json(CALLEJERO_BASE_URL, "/json/ObtenerProvincias", {})
        payload = data["consulta_provincieroResult"]
        error = _first_error_payload("ObtenerProvincias", payload)
        if error:
            return error

        items = []
        for province in _ensure_list(payload.get("provinciero", {}).get("prov")):
            items.append(
                {
                    "province_name": _null_if_blank(province.get("np")),
                    "province_ine_code": _null_if_blank(province.get("cpine")),
                }
            )
        return {"items": items}

    def search_municipalities(
        self,
        province: str,
        municipality_text: str | None = None,
    ) -> dict[str, Any]:
        data = self._get_json(
            CALLEJERO_BASE_URL,
            "/json/ObtenerMunicipios",
            {
                "Provincia": normalize_text(province),
                "Municipio": normalize_text(municipality_text),
            },
        )
        payload = data["consulta_municipieroResult"]
        error = _first_error_payload("ObtenerMunicipios", payload)
        if error:
            return error

        items = []
        for municipality in _ensure_list(payload.get("municipiero", {}).get("muni")):
            items.append(
                {
                    "province_name": normalize_text(province),
                    "municipality_name": _null_if_blank(municipality.get("nm")),
                    "municipality_catastro_codes": {
                        "delegation": _null_if_blank((municipality.get("locat") or {}).get("cd")),
                        "municipality": _null_if_blank((municipality.get("locat") or {}).get("cmc")),
                    },
                    "municipality_ine_codes": {
                        "province": _null_if_blank((municipality.get("loine") or {}).get("cp")),
                        "municipality": _null_if_blank((municipality.get("loine") or {}).get("cm")),
                    },
                }
            )
        return {"items": items}

    def search_streets(
        self,
        province: str,
        municipality: str,
        street_name_text: str | None = None,
        street_type_code: str | None = None,
    ) -> dict[str, Any]:
        normalized_type, normalized_name = normalize_street_query(
            street_name_text,
            street_type_code,
        )
        data = self._get_json(
            CALLEJERO_BASE_URL,
            "/json/ObtenerCallejero",
            {
                "Provincia": normalize_text(province),
                "Municipio": normalize_text(municipality),
                "TipoVia": normalized_type,
                "NomVia": normalized_name,
            },
        )
        payload = data["consulta_callejeroResult"]
        error = _first_error_payload("ObtenerCallejero", payload)
        if error:
            return error

        items = []
        for street in _ensure_list(payload.get("callejero", {}).get("calle")):
            direction = street.get("dir") or {}
            items.append(
                {
                    "street_catastro_code": _null_if_blank(direction.get("cv")),
                    "street_type_code": _null_if_blank(direction.get("tv")),
                    "street_name": _null_if_blank(direction.get("nv")),
                    "street_ine": _street_ine_payload(street.get("dirine")),
                }
            )
        return {"items": items}

    def search_numbers_by_street_code(
        self,
        province_code: str,
        street_catastro_code: str,
        number: str,
        municipality_code: str | None = None,
        municipality_ine_code: str | None = None,
    ) -> dict[str, Any]:
        if municipality_code is None and municipality_ine_code is None:
            return {
                "error": {
                    "code": "INVALID_INPUT",
                    "message": "municipality_code or municipality_ine_code is required",
                    "upstream": {
                        "service": "ObtenerNumereroCodigos",
                        "code": None,
                        "description": None,
                    },
                }
            }

        data = self._get_json(
            CALLEJERO_CODES_BASE_URL,
            "/json/ObtenerNumereroCodigos",
            {
                "CodigoProvincia": normalize_text(province_code),
                "CodigoMunicipio": normalize_text(municipality_code),
                "CodigoMunicipioINE": normalize_text(municipality_ine_code),
                "CodigoVia": normalize_text(street_catastro_code),
                "Numero": normalize_text(number),
            },
        )
        payload = data["consulta_numereroResult"]
        candidate_items = [
            {
                "refcat": _compose_refcat(item.get("pc")),
                "street_number": _null_if_blank((item.get("num") or {}).get("pnp")),
                "street_number_dup": _null_if_blank((item.get("num") or {}).get("plp")),
            }
            for item in _ensure_list(payload.get("nump"))
        ]
        error = _first_error_payload(
            "ObtenerNumereroCodigos",
            payload,
            candidates=candidate_items or None,
        )
        if error:
            return error

        return {"items": candidate_items}

    def get_property_by_refcat(self, refcat: str) -> dict[str, Any]:
        data = self._get_json(
            CALLEJERO_BASE_URL,
            "/json/Consulta_DNPRC",
            {"RefCat": normalize_text(refcat)},
        )
        payload = data["consulta_dnprcResult"]
        error = _first_error_payload("Consulta_DNPRC", payload)
        if error:
            return error

        if "lrcdnp" in payload:
            items = [_multi_location_item(item) for item in _ensure_list(payload.get("lrcdnp", {}).get("rcdnp"))]
            return {"items": items}

        bico = payload.get("bico") or {}
        bi = bico.get("bi") or {}
        finca = bico.get("finca") or {}
        lcons = bico.get("lcons")
        return _property_payload_from_bi(bi, finca, lcons)

    def get_property_by_location(
        self,
        province: str,
        municipality: str,
        street_type_code: str,
        street_name: str,
        number: str,
    ) -> dict[str, Any]:
        normalized_type, normalized_name = normalize_street_query(street_name, street_type_code)
        data = self._get_json(
            CALLEJERO_BASE_URL,
            "/json/Consulta_DNPLOC",
            {
                "Provincia": normalize_text(province),
                "Municipio": normalize_text(municipality),
                "Sigla": normalized_type,
                "Calle": normalized_name,
                "Numero": normalize_text(number),
            },
        )
        payload = data["consulta_dnplocResult"]
        error = _first_error_payload("Consulta_DNPLOC", payload)
        if error:
            return error

        if "lrcdnp" in payload:
            items = [_multi_location_item(item) for item in _ensure_list(payload.get("lrcdnp", {}).get("rcdnp"))]
            return {"items": items}

        bico = payload.get("bico") or {}
        bi = bico.get("bi") or {}
        finca = bico.get("finca") or {}
        lcons = bico.get("lcons")
        return _property_payload_from_bi(bi, finca, lcons)

    def get_refcat_from_coordinates(self, srs: str, x: float, y: float) -> dict[str, Any]:
        data = self._get_json(
            COORDINATES_BASE_URL,
            "/json/Consulta_RCCOOR",
            {
                "SRS": normalize_text(srs),
                "CoorX": x,
                "CoorY": y,
            },
        )
        payload = data["Consulta_RCCOORResult"]
        error = _first_error_payload("Consulta_RCCOOR", payload)
        if error:
            return error

        coord = _ensure_list(payload.get("coordenadas", {}).get("coord"))[0]
        return {
            "refcat": _compose_refcat(coord.get("pc")),
            "coordinates": {
                "x": _parse_number((coord.get("geo") or {}).get("xcen")),
                "y": _parse_number((coord.get("geo") or {}).get("ycen")),
                "srs": _null_if_blank((coord.get("geo") or {}).get("srs")),
            },
            "address_label": _null_if_blank(coord.get("ldt")),
        }

    def get_coordinates_from_refcat(
        self,
        refcat: str,
        srs: str | None = None,
    ) -> dict[str, Any]:
        data = self._get_json(
            COORDINATES_BASE_URL,
            "/json/Consulta_CPMRC",
            {
                "RefCat": normalize_text(refcat),
                "SRS": normalize_text(srs),
            },
        )
        payload = data["Consulta_CPMRCResult"]
        error = _first_error_payload("Consulta_CPMRC", payload)
        if error:
            return error

        coord = _ensure_list(payload.get("coordenadas", {}).get("coord"))[0]
        return {
            "refcat": _compose_refcat(coord.get("pc")),
            "coordinates": {
                "x": _parse_number((coord.get("geo") or {}).get("xcen")),
                "y": _parse_number((coord.get("geo") or {}).get("ycen")),
                "srs": _null_if_blank((coord.get("geo") or {}).get("srs")),
            },
            "address_label": _null_if_blank(coord.get("ldt")),
        }

    def get_property_by_polygon_parcel(
        self,
        province: str,
        municipality: str,
        polygon: str,
        parcel: str,
    ) -> dict[str, Any]:
        data = self._get_json(
            CALLEJERO_BASE_URL,
            "/json/Consulta_DNPPP",
            {
                "Provincia": normalize_text(province),
                "Municipio": normalize_text(municipality),
                "Poligono": normalize_text(polygon),
                "Parcela": normalize_text(parcel),
            },
        )
        payload = data["consulta_dnpppResult"]
        error = _first_error_payload("Consulta_DNPPP", payload)
        if error:
            return error

        if "lrcdnp" in payload:
            items = [_multi_location_item(item) for item in _ensure_list(payload.get("lrcdnp", {}).get("rcdnp"))]
            return {"items": items}

        bico = payload.get("bico") or {}
        bi = bico.get("bi") or {}
        finca = bico.get("finca") or {}
        lcons = bico.get("lcons")
        result = _property_payload_from_bi(bi, finca, lcons)
        result["rural_location"] = _extract_rural_location(bi)
        return result

    def get_nearby_refcats(self, srs: str, x: float, y: float) -> dict[str, Any]:
        data = self._get_json(
            COORDINATES_BASE_URL,
            "/json/Consulta_RCCOOR_Distancia",
            {
                "SRS": normalize_text(srs),
                "CoorX": x,
                "CoorY": y,
            },
        )
        payload = data["Consulta_RCCOOR_DistanciaResult"]
        error = _first_error_payload("Consulta_RCCOOR_Distancia", payload)
        if error:
            return error

        coordd = _ensure_list(payload.get("coordenadas_distancias", {}).get("coordd"))
        if not coordd:
            return {"items": []}

        items = []
        for item in _ensure_list(coordd[0].get("lpcd")):
            items.append(
                {
                    "refcat": _compose_refcat(item.get("pc")),
                    "distance_m": _parse_number(item.get("dis")),
                    "address_label": _null_if_blank(item.get("ldt")),
                }
            )
        return {"items": items}


_default_client = httpx.Client(
    timeout=httpx.Timeout(20.0, connect=10.0),
    follow_redirects=True,
    headers={"Accept": "application/json"},
)
atexit.register(_default_client.close)

default_service = CatastroService(client=_default_client)
