from __future__ import annotations

import argparse
from typing import Any

from mcp.server.fastmcp import FastMCP

from .service import default_service


def list_provinces() -> dict[str, Any]:
    return default_service.list_provinces()


def search_municipalities(
    province: str,
    municipality_text: str | None = None,
) -> dict[str, Any]:
    return default_service.search_municipalities(province, municipality_text)


def search_streets(
    province: str,
    municipality: str,
    street_name_text: str | None = None,
    street_type_code: str | None = None,
) -> dict[str, Any]:
    return default_service.search_streets(
        province,
        municipality,
        street_name_text=street_name_text,
        street_type_code=street_type_code,
    )


def search_numbers_by_street_code(
    province_code: str,
    street_catastro_code: str,
    number: str,
    municipality_code: str | None = None,
    municipality_ine_code: str | None = None,
) -> dict[str, Any]:
    return default_service.search_numbers_by_street_code(
        province_code=province_code,
        street_catastro_code=street_catastro_code,
        number=number,
        municipality_code=municipality_code,
        municipality_ine_code=municipality_ine_code,
    )


def get_property_by_refcat(refcat: str) -> dict[str, Any]:
    return default_service.get_property_by_refcat(refcat)


def get_property_by_location(
    province: str,
    municipality: str,
    street_type_code: str,
    street_name: str,
    number: str,
) -> dict[str, Any]:
    return default_service.get_property_by_location(
        province=province,
        municipality=municipality,
        street_type_code=street_type_code,
        street_name=street_name,
        number=number,
    )


def get_refcat_from_coordinates(srs: str, x: float, y: float) -> dict[str, Any]:
    return default_service.get_refcat_from_coordinates(srs=srs, x=x, y=y)


def get_coordinates_from_refcat(refcat: str, srs: str | None = None) -> dict[str, Any]:
    return default_service.get_coordinates_from_refcat(refcat=refcat, srs=srs)


def get_property_by_polygon_parcel(
    province: str,
    municipality: str,
    polygon: str,
    parcel: str,
) -> dict[str, Any]:
    return default_service.get_property_by_polygon_parcel(
        province=province,
        municipality=municipality,
        polygon=polygon,
        parcel=parcel,
    )


def get_nearby_refcats(srs: str, x: float, y: float) -> dict[str, Any]:
    return default_service.get_nearby_refcats(srs=srs, x=x, y=y)


def create_server(host: str = "127.0.0.1", port: int = 8000) -> FastMCP:
    mcp = FastMCP(
        name="OpenSpain Catastro",
        instructions=(
            "Spanish Cadastre MCP using the official public JSON endpoints. "
            "Resolve provinces, municipalities and streets before property lookups."
        ),
        host=host,
        port=port,
    )

    mcp.tool(
        name="list_provinces",
        description="List official Catastro provinces.",
        structured_output=True,
    )(list_provinces)
    mcp.tool(
        name="search_municipalities",
        description="Search municipalities inside a province using the official Catastro callejero.",
        structured_output=True,
    )(search_municipalities)
    mcp.tool(
        name="search_streets",
        description="Search official streets in a municipality using Catastro callejero.",
        structured_output=True,
    )(search_streets)
    mcp.tool(
        name="search_numbers_by_street_code",
        description="Resolve numbers in an official Catastro street by DGC street code.",
        structured_output=True,
    )(search_numbers_by_street_code)
    mcp.tool(
        name="get_property_by_refcat",
        description="Get non-protected cadastral property data by refcat.",
        structured_output=True,
    )(get_property_by_refcat)
    mcp.tool(
        name="get_property_by_location",
        description="Get non-protected cadastral property data by resolved location.",
        structured_output=True,
    )(get_property_by_location)
    mcp.tool(
        name="get_refcat_from_coordinates",
        description="Get the parcel refcat for a coordinate.",
        structured_output=True,
    )(get_refcat_from_coordinates)
    mcp.tool(
        name="get_coordinates_from_refcat",
        description="Get centroid coordinates for a 14-character refcat.",
        structured_output=True,
    )(get_coordinates_from_refcat)
    mcp.tool(
        name="get_property_by_polygon_parcel",
        description="Get non-protected rural property data by polygon and parcel.",
        structured_output=True,
    )(get_property_by_polygon_parcel)
    mcp.tool(
        name="get_nearby_refcats",
        description="Get nearby cadastral references for a point.",
        structured_output=True,
    )(get_nearby_refcats)

    return mcp


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="openspain-catastro-mcp",
        description="OpenSpain Catastro MCP server",
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
