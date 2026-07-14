from __future__ import annotations

import unittest

import httpx

from snczi.server import build_parser, create_server
from snczi.service import (
    SnczService,
    SnczServiceError,
    _degrees_for_meters,
    _is_point_inside,
)


NO_DATA_HTML = (
    "<html><body><div class='msg'>No se han encontrado datos en la "
    "ubicación seleccionada.</div></body></html>"
)
FEATURE_HTML = (
    "<html><body><table><tr><th>FID</th><th>RETURNPERIOD</th></tr>"
    "<tr><td>NZ.RiskZone.1</td><td>100</td></tr></table></body></html>"
)
ERROR_XML = (
    "<?xml version='1.0'?>"
    "<ServiceExceptionReport><ServiceException>"
    "Referencia a objeto no establecida como instancia de un objeto"
    "</ServiceException></ServiceExceptionReport>"
)


def _build_service(handler) -> SnczService:
    client = httpx.Client(transport=httpx.MockTransport(handler))
    return SnczService(client=client)


class InterpretationTests(unittest.TestCase):
    def test_no_data_is_outside(self) -> None:
        self.assertFalse(_is_point_inside(NO_DATA_HTML))

    def test_feature_row_is_inside(self) -> None:
        self.assertTrue(_is_point_inside(FEATURE_HTML))

    def test_service_exception_is_outside(self) -> None:
        self.assertFalse(_is_point_inside(ERROR_XML))

    def test_meters_to_degrees_handles_latitude(self) -> None:
        offset_equator = _degrees_for_meters(100, 0)
        offset_north = _degrees_for_meters(100, 60)
        self.assertGreater(offset_north, offset_equator)


class ServerShapeTests(unittest.TestCase):
    def test_server_parser_defaults(self) -> None:
        args = build_parser().parse_args([])
        self.assertEqual(args.transport, "stdio")
        self.assertEqual(args.host, "127.0.0.1")
        self.assertEqual(args.port, 8000)

    def test_create_server_registers_tools(self) -> None:
        server = create_server(host="127.0.0.1", port=8123)
        self.assertEqual(server.name, "OpenSpain SNCZI")
        tool_names = {tool.name for tool in server._tool_manager.list_tools()}
        expected = {
            "check_flood_zone",
            "check_flood_zone_by_refcat",
            "check_flood_zone_by_address",
            "check_zona_policia_servidumbre",
            "get_snczi_report",
            "get_snczi_report_by_refcat",
        }
        self.assertTrue(expected.issubset(tool_names))


class FloodZoneLookupTests(unittest.TestCase):
    def test_flood_zone_aggregates_layers(self) -> None:
        responses = {
            "ZI_LaminasQ10/": NO_DATA_HTML,
            "ZI_LaminasQ100/": FEATURE_HTML,
            "ZI_LaminasQ500/": FEATURE_HTML,
            "DPHCartografico/": NO_DATA_HTML,
        }

        def handler(request: httpx.Request) -> httpx.Response:
            for fragment, body in responses.items():
                if fragment in str(request.url):
                    return httpx.Response(200, text=body)
            raise AssertionError(f"Unexpected request: {request.url}")

        service = _build_service(handler)
        result = service.check_flood_zone(39.4735, -0.3821)

        self.assertEqual(result["coordinates"], {"lat": 39.4735, "lon": -0.3821, "crs": "EPSG:4326"})
        self.assertEqual(
            result["flood_zones"],
            {
                "t10_high_probability": False,
                "t100_medium_probability": True,
                "t500_low_probability": True,
            },
        )
        self.assertFalse(result["dph_cartografico"])
        self.assertEqual(result["risk_level"], "medium")

    def test_flood_zone_out_of_range_raises(self) -> None:
        def handler(request: httpx.Request) -> httpx.Response:
            return httpx.Response(200, text=NO_DATA_HTML)

        service = _build_service(handler)
        with self.assertRaises(SnczServiceError):
            service.check_flood_zone(120.0, -0.3821)

    def test_report_combines_flood_and_restriction(self) -> None:
        calls: list[str] = []

        def handler(request: httpx.Request) -> httpx.Response:
            calls.append(str(request.url))
            if "DPHCartografico" in str(request.url):
                return httpx.Response(200, text=FEATURE_HTML)
            return httpx.Response(200, text=NO_DATA_HTML)

        service = _build_service(handler)
        report = service.get_snczi_report(39.4735, -0.3821)

        self.assertTrue(report["dph_cartografico"])
        self.assertTrue(report["zona_policia"]["likely_inside"])
        self.assertTrue(report["zona_servidumbre"]["likely_inside"])
        self.assertIn("RD 849/1986", report["zona_policia"]["legal_basis"])

    def test_by_refcat_resolves_coordinates_before_querying_wms(self) -> None:
        refcat = "2749704YJ0624N0001DI"
        recorded: list[str] = []

        def handler(request: httpx.Request) -> httpx.Response:
            url = str(request.url)
            recorded.append(url)
            if "Consulta_CPMRC" in url:
                return httpx.Response(
                    200,
                    json={
                        "Consulta_CPMRCResult": {
                            "control": {"cucoor": 1},
                            "coordenadas": {
                                "coord": [
                                    {
                                        "pc": {"pc1": "2749704", "pc2": "YJ0624N"},
                                        "geo": {
                                            "xcen": "-0.3821",
                                            "ycen": "39.4735",
                                            "srs": "EPSG:4326",
                                        },
                                        "ldt": "AVDA CAUCE 1 VALENCIA",
                                    }
                                ]
                            },
                        }
                    },
                )
            return httpx.Response(200, text=FEATURE_HTML)

        service = _build_service(handler)
        result = service.check_flood_zone_by_refcat(refcat)

        self.assertEqual(result["input"]["refcat"], "2749704YJ0624N")
        self.assertEqual(result["coordinates"]["lat"], 39.4735)
        self.assertEqual(result["coordinates"]["lon"], -0.3821)
        self.assertTrue(result["flood_zones"]["t10_high_probability"])

    def test_by_refcat_propagates_not_found(self) -> None:
        def handler(request: httpx.Request) -> httpx.Response:
            if "Consulta_CPMRC" in str(request.url):
                return httpx.Response(
                    200,
                    json={
                        "Consulta_CPMRCResult": {
                            "control": {"cuerr": 1},
                            "lerr": {"err": {"cod": "17", "des": "NO EXISTE LA REFERENCIA CATASTRAL"}},
                        }
                    },
                )
            raise AssertionError("should not call WMS on lookup error")

        service = _build_service(handler)
        result = service.check_flood_zone_by_refcat("0000000AA0000A0000AA")

        self.assertEqual(result["error"]["code"], "NOT_FOUND")


if __name__ == "__main__":
    unittest.main()
