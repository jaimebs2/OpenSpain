from __future__ import annotations

import argparse
from typing import Any

from mcp.server.fastmcp import FastMCP

from .service import SnczServiceError, default_service


def check_flood_zone(lat: float, lon: float) -> dict[str, Any]:
    try:
        return default_service.check_flood_zone(lat, lon)
    except SnczServiceError as exc:
        return exc.to_dict()


def check_flood_zone_by_refcat(refcat: str) -> dict[str, Any]:
    return default_service.check_flood_zone_by_refcat(refcat)


def check_flood_zone_by_address(
    province: str,
    municipality: str,
    street_type_code: str,
    street_name: str,
    number: str,
) -> dict[str, Any]:
    return default_service.check_flood_zone_by_address(
        province=province,
        municipality=municipality,
        street_type_code=street_type_code,
        street_name=street_name,
        number=number,
    )


def check_zona_policia_servidumbre(
    lat: float,
    lon: float,
    police_buffer_m: int = 100,
    easement_buffer_m: int = 5,
) -> dict[str, Any]:
    try:
        return default_service.check_zona_policia_servidumbre(
            lat=lat,
            lon=lon,
            police_buffer_m=police_buffer_m,
            easement_buffer_m=easement_buffer_m,
        )
    except SnczServiceError as exc:
        return exc.to_dict()


def get_snczi_report(lat: float, lon: float) -> dict[str, Any]:
    try:
        return default_service.get_snczi_report(lat, lon)
    except SnczServiceError as exc:
        return exc.to_dict()


def get_snczi_report_by_refcat(refcat: str) -> dict[str, Any]:
    return default_service.get_snczi_report_by_refcat(refcat)


def create_server(host: str = "127.0.0.1", port: int = 8000) -> FastMCP:
    mcp = FastMCP(
        name="OpenSpain SNCZI",
        instructions=(
            "Spanish flood-zone and Public Hydraulic Domain (DPH) lookup "
            "using the SNCZI WMS endpoints published by MITECO. "
            "Accepts coordinates (EPSG:4326), cadastral references (refcat), "
            "or postal address (province, municipality, street, number)."
        ),
        host=host,
        port=port,
    )

    mcp.tool(
        name="check_flood_zone",
        description=(
            "Check if a (lat, lon) point in Spain is inside the SNCZI flood "
            "zones (T=10, T=100, T=500) and the DPH cartográfico."
        ),
        structured_output=True,
    )(check_flood_zone)

    mcp.tool(
        name="check_flood_zone_by_refcat",
        description=(
            "Resolve a Catastro refcat to coordinates and run the SNCZI "
            "flood-zone + DPH check on that point."
        ),
        structured_output=True,
    )(check_flood_zone_by_refcat)

    mcp.tool(
        name="check_flood_zone_by_address",
        description=(
            "Resolve an address (province, municipality, street, number) via "
            "Catastro and run the SNCZI flood-zone + DPH check on that point."
        ),
        structured_output=True,
    )(check_flood_zone_by_address)

    mcp.tool(
        name="check_zona_policia_servidumbre",
        description=(
            "Estimate if a point is likely inside the 100 m police zone or "
            "the 5 m easement zone around the DPH cartográfico (RD 849/1986)."
        ),
        structured_output=True,
    )(check_zona_policia_servidumbre)

    mcp.tool(
        name="get_snczi_report",
        description=(
            "Combined SNCZI report for a point: flood zones, DPH, police and "
            "easement zones, plus legal disclaimer."
        ),
        structured_output=True,
    )(get_snczi_report)

    mcp.tool(
        name="get_snczi_report_by_refcat",
        description=(
            "Combined SNCZI report starting from a Catastro refcat."
        ),
        structured_output=True,
    )(get_snczi_report_by_refcat)

    return mcp


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="openspain-snczi-mcp",
        description="OpenSpain SNCZI MCP server",
    )
    parser.add_argument(
        "--transport",
        choices=("stdio", "streamable-http", "sse"),
        default="stdio",
        help="MCP transport. Use stdio for local agent integration and streamable-http for manual/remote testing.",
    )
    parser.add_argument(
        "--host",
        default="127.0.0.1",
        help="Bind host for HTTP transports.",
    )
    parser.add_argument(
        "--port",
        type=int,
        default=8000,
        help="Bind port for HTTP transports.",
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    mcp = create_server(host=args.host, port=args.port)
    try:
        mcp.run(transport=args.transport)
    except KeyboardInterrupt:
        return 130
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
