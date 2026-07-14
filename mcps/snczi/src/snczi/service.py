from __future__ import annotations

import atexit
import re
from dataclasses import dataclass
from typing import Any

import httpx


WMS_BASES: dict[str, str] = {
    "zi_t10": "https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ10/wms.aspx",
    "zi_t100": "https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ100/wms.aspx",
    "zi_t500": "https://wms.mapama.gob.es/sig/Agua/ZI_LaminasQ500/wms.aspx",
    "dph_cartografico": "https://wms.mapama.gob.es/sig/Agua/DPHCartografico/wms.aspx",
}

WMS_LAYERS: dict[str, str] = {
    "zi_t10": "NZ.RiskZone",
    "zi_t100": "NZ.RiskZone",
    "zi_t500": "NZ.RiskZone",
    "dph_cartografico": "Cauces con DPH cartográfico",
}

CATASTRO_COORDINATES_URL = (
    "https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc"
)
CATASTRO_CALLEJERO_URL = (
    "https://ovc.catastro.meh.es/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc"
)

POINT_BBOX_DEGREES = 0.0001
METERS_PER_DEGREE_LAT = 111_320.0

NO_DATA_MARKERS = (
    "no se han encontrado datos",
    "no hay datos",
    "no features were found",
)
ERROR_MARKERS = (
    "<serviceexceptionreport",
    "nullreferenceexception",
    "referencia a objeto",
)


def _degrees_for_meters(meters: float, latitude_deg: float) -> float:
    import math

    lat_delta = meters / METERS_PER_DEGREE_LAT
    cos_lat = max(math.cos(math.radians(latitude_deg)), 1e-6)
    lon_delta = meters / (METERS_PER_DEGREE_LAT * cos_lat)
    return max(lat_delta, lon_delta)


def _clean_html(text: str) -> str:
    without_tags = re.sub(r"<[^>]+>", " ", text)
    return re.sub(r"\s+", " ", without_tags).strip()


def _is_point_inside(body: str) -> bool:
    lowered = body.lower()
    if any(marker in lowered for marker in ERROR_MARKERS):
        return False
    if any(marker in lowered for marker in NO_DATA_MARKERS):
        return False
    # Any HTML table row with data or GML feature means the layer covers the point.
    if "<tr" in lowered or "<feature" in lowered or "gml:featuremember" in lowered:
        return True
    cleaned = _clean_html(body)
    return bool(cleaned) and "no se han encontrado" not in cleaned.lower()


def _risk_level(flags: dict[str, bool]) -> str:
    if flags.get("zi_t10"):
        return "high"
    if flags.get("zi_t100"):
        return "medium"
    if flags.get("zi_t500"):
        return "low"
    return "none"


def _compose_refcat(rc: dict[str, Any] | None) -> str | None:
    if not rc:
        return None
    parts = [rc.get("pc1"), rc.get("pc2"), rc.get("car"), rc.get("cc1"), rc.get("cc2")]
    joined = "".join(str(part).strip() for part in parts if part is not None and str(part).strip())
    return joined or None


def _parse_number(value: Any) -> float | None:
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
        return float(normalized)
    except ValueError:
        return None


@dataclass(slots=True)
class SnczServiceError(Exception):
    code: str
    message: str

    def to_dict(self) -> dict[str, Any]:
        return {"error": {"code": self.code, "message": self.message}}


@dataclass(slots=True)
class SnczService:
    client: httpx.Client

    def _getfeatureinfo(
        self,
        base_url: str,
        layer_name: str,
        lat: float,
        lon: float,
        bbox_offset_deg: float = POINT_BBOX_DEGREES,
    ) -> str:
        params = {
            "SERVICE": "WMS",
            "VERSION": "1.3.0",
            "REQUEST": "GetFeatureInfo",
            "LAYERS": layer_name,
            "QUERY_LAYERS": layer_name,
            "CRS": "EPSG:4326",
            "BBOX": (
                f"{lat - bbox_offset_deg},{lon - bbox_offset_deg},"
                f"{lat + bbox_offset_deg},{lon + bbox_offset_deg}"
            ),
            "WIDTH": "101",
            "HEIGHT": "101",
            "I": "50",
            "J": "50",
            "INFO_FORMAT": "text/html",
        }
        response = self.client.get(base_url, params=params)
        response.raise_for_status()
        return response.text

    def check_flood_zone(self, lat: float, lon: float) -> dict[str, Any]:
        self._validate_wgs84(lat, lon)

        flags: dict[str, bool] = {}
        for key in ("zi_t10", "zi_t100", "zi_t500", "dph_cartografico"):
            body = self._getfeatureinfo(WMS_BASES[key], WMS_LAYERS[key], lat, lon)
            flags[key] = _is_point_inside(body)

        return {
            "coordinates": {"lat": lat, "lon": lon, "crs": "EPSG:4326"},
            "flood_zones": {
                "t10_high_probability": flags["zi_t10"],
                "t100_medium_probability": flags["zi_t100"],
                "t500_low_probability": flags["zi_t500"],
            },
            "dph_cartografico": flags["dph_cartografico"],
            "risk_level": _risk_level(flags),
            "source": {
                "name": "SNCZI",
                "publisher": "Ministerio para la Transición Ecológica y el Reto Demográfico",
                "viewer": "https://sig.miteco.gob.es/snczi/index.html?herramienta=DPHZI",
            },
        }

    def check_zona_policia_servidumbre(
        self,
        lat: float,
        lon: float,
        police_buffer_m: int = 100,
        easement_buffer_m: int = 5,
    ) -> dict[str, Any]:
        self._validate_wgs84(lat, lon)

        police_offset = _degrees_for_meters(police_buffer_m, lat)
        easement_offset = _degrees_for_meters(easement_buffer_m, lat)

        police_body = self._getfeatureinfo(
            WMS_BASES["dph_cartografico"],
            WMS_LAYERS["dph_cartografico"],
            lat,
            lon,
            bbox_offset_deg=police_offset,
        )
        easement_body = self._getfeatureinfo(
            WMS_BASES["dph_cartografico"],
            WMS_LAYERS["dph_cartografico"],
            lat,
            lon,
            bbox_offset_deg=easement_offset,
        )

        return {
            "coordinates": {"lat": lat, "lon": lon, "crs": "EPSG:4326"},
            "zona_policia": {
                "likely_inside": _is_point_inside(police_body),
                "buffer_m": police_buffer_m,
                "legal_basis": "RD 849/1986 art. 6.2 (100 m desde el DPH)",
            },
            "zona_servidumbre": {
                "likely_inside": _is_point_inside(easement_body),
                "buffer_m": easement_buffer_m,
                "legal_basis": "RD 849/1986 art. 7 (5 m desde el DPH)",
            },
            "method": "bbox_approximation",
            "disclaimer": (
                "Aproximación mediante BBOX ampliado sobre el DPH cartográfico "
                "del SNCZI. Para un dictamen legal exacto consulte a la "
                "Confederación Hidrográfica competente."
            ),
        }

    def get_snczi_report(self, lat: float, lon: float) -> dict[str, Any]:
        flood = self.check_flood_zone(lat, lon)
        restriction = self.check_zona_policia_servidumbre(lat, lon)
        return {
            "coordinates": flood["coordinates"],
            "flood_zones": flood["flood_zones"],
            "dph_cartografico": flood["dph_cartografico"],
            "risk_level": flood["risk_level"],
            "zona_policia": restriction["zona_policia"],
            "zona_servidumbre": restriction["zona_servidumbre"],
            "source": flood["source"],
            "disclaimer": restriction["disclaimer"],
        }

    def coordinates_from_refcat(self, refcat: str) -> dict[str, Any]:
        refcat = (refcat or "").strip().upper()
        if not refcat:
            raise SnczServiceError("INVALID_INPUT", "refcat is required")

        response = self.client.get(
            f"{CATASTRO_COORDINATES_URL}/json/Consulta_CPMRC",
            params={"RefCat": refcat, "SRS": "EPSG:4326"},
        )
        response.raise_for_status()
        payload = response.json().get("Consulta_CPMRCResult") or {}
        control = payload.get("control") or {}
        for key, value in control.items():
            if str(key).startswith("cuerr") and str(value).isdigit() and int(value) > 0:
                lerr = payload.get("lerr") or {}
                err = lerr.get("err") if isinstance(lerr, dict) else None
                if isinstance(err, list):
                    err = err[0] if err else None
                message = (err or {}).get("des") if isinstance(err, dict) else "Catastro upstream error"
                raise SnczServiceError(
                    "NOT_FOUND" if "NO EXIST" in (message or "").upper() else "UPSTREAM_ERROR",
                    message or "Catastro upstream error",
                )

        coord_list = payload.get("coordenadas", {}).get("coord")
        if isinstance(coord_list, dict):
            coord_list = [coord_list]
        if not coord_list:
            raise SnczServiceError("NOT_FOUND", f"no coordinates returned for refcat {refcat}")

        coord = coord_list[0]
        geo = coord.get("geo") or {}
        lon = _parse_number(geo.get("xcen"))
        lat = _parse_number(geo.get("ycen"))
        if lat is None or lon is None:
            raise SnczServiceError("UPSTREAM_ERROR", "Catastro did not return lat/lon for refcat")

        return {
            "refcat": _compose_refcat(coord.get("pc")) or refcat,
            "lat": lat,
            "lon": lon,
            "address_label": coord.get("ldt"),
        }

    def check_flood_zone_by_refcat(self, refcat: str) -> dict[str, Any]:
        try:
            resolved = self.coordinates_from_refcat(refcat)
        except SnczServiceError as exc:
            return exc.to_dict()

        result = self.check_flood_zone(resolved["lat"], resolved["lon"])
        result["input"] = {
            "refcat": resolved["refcat"],
            "address_label": resolved.get("address_label"),
        }
        return result

    def check_flood_zone_by_address(
        self,
        province: str,
        municipality: str,
        street_type_code: str,
        street_name: str,
        number: str,
    ) -> dict[str, Any]:
        refcat = self._refcat_from_address(
            province=province,
            municipality=municipality,
            street_type_code=street_type_code,
            street_name=street_name,
            number=number,
        )
        if isinstance(refcat, dict) and "error" in refcat:
            return refcat
        return self.check_flood_zone_by_refcat(refcat)

    def get_snczi_report_by_refcat(self, refcat: str) -> dict[str, Any]:
        try:
            resolved = self.coordinates_from_refcat(refcat)
        except SnczServiceError as exc:
            return exc.to_dict()

        result = self.get_snczi_report(resolved["lat"], resolved["lon"])
        result["input"] = {
            "refcat": resolved["refcat"],
            "address_label": resolved.get("address_label"),
        }
        return result

    def _refcat_from_address(
        self,
        province: str,
        municipality: str,
        street_type_code: str,
        street_name: str,
        number: str,
    ) -> str | dict[str, Any]:
        response = self.client.get(
            f"{CATASTRO_CALLEJERO_URL}/json/Consulta_DNPLOC",
            params={
                "Provincia": province.strip().upper(),
                "Municipio": municipality.strip().upper(),
                "Sigla": street_type_code.strip().upper(),
                "Calle": street_name.strip().upper(),
                "Numero": str(number).strip(),
            },
        )
        response.raise_for_status()
        payload = response.json().get("consulta_dnplocResult") or {}
        control = payload.get("control") or {}
        for key, value in control.items():
            if str(key).startswith("cuerr") and str(value).isdigit() and int(value) > 0:
                lerr = payload.get("lerr") or {}
                err = lerr.get("err") if isinstance(lerr, dict) else None
                if isinstance(err, list):
                    err = err[0] if err else None
                message = (err or {}).get("des") if isinstance(err, dict) else "Catastro upstream error"
                return {
                    "error": {
                        "code": "NOT_FOUND" if "NO EXIST" in (message or "").upper() else "UPSTREAM_ERROR",
                        "message": message or "Catastro upstream error",
                    }
                }

        list_wrapper = payload.get("lrcdnp") or {}
        rcdnp = list_wrapper.get("rcdnp") if isinstance(list_wrapper, dict) else None
        if isinstance(rcdnp, dict):
            rcdnp = [rcdnp]
        if rcdnp:
            refcat = _compose_refcat(rcdnp[0].get("rc"))
            if refcat:
                return refcat

        bico = payload.get("bico") or {}
        bi = bico.get("bi") or {}
        refcat = _compose_refcat((bi.get("idbi") or {}).get("rc"))
        if refcat:
            return refcat

        return {
            "error": {
                "code": "NOT_FOUND",
                "message": "Catastro did not return a refcat for the supplied address",
            }
        }

    @staticmethod
    def _validate_wgs84(lat: float, lon: float) -> None:
        if not (-90 <= lat <= 90):
            raise SnczServiceError("INVALID_INPUT", f"latitude {lat} out of range [-90, 90]")
        if not (-180 <= lon <= 180):
            raise SnczServiceError("INVALID_INPUT", f"longitude {lon} out of range [-180, 180]")


_default_client = httpx.Client(
    timeout=httpx.Timeout(30.0, connect=10.0),
    follow_redirects=True,
    headers={
        "Accept": "text/html, application/json, text/xml, */*",
        "User-Agent": "openspain-snczi-mcp/0.1",
    },
)
atexit.register(_default_client.close)

default_service = SnczService(client=_default_client)
