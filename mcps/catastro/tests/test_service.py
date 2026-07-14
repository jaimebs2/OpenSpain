from __future__ import annotations

import unittest

import httpx

from catastro.service import CatastroService
from catastro.server import build_parser, create_server


def build_service(payloads: dict[str, dict]) -> CatastroService:
    def handler(request: httpx.Request) -> httpx.Response:
        key = f"{request.url.path}?{request.url.query.decode()}"
        payload = payloads.get(key)
        if payload is None:
            raise AssertionError(f"Unexpected request: {key}")
        return httpx.Response(200, json=payload)

    client = httpx.Client(transport=httpx.MockTransport(handler))
    return CatastroService(client=client)


class CatastroServiceTests(unittest.TestCase):
    def test_server_parser_defaults(self) -> None:
        args = build_parser().parse_args([])
        self.assertEqual(args.transport, "stdio")
        self.assertEqual(args.host, "127.0.0.1")
        self.assertEqual(args.port, 8000)

    def test_create_server_registers_tools(self) -> None:
        server = create_server(host="127.0.0.1", port=8123)
        self.assertEqual(server.name, "OpenSpain Catastro")
        self.assertEqual(server.settings.host, "127.0.0.1")
        self.assertEqual(server.settings.port, 8123)
        self.assertTrue(
            any(tool.name == "list_provinces" for tool in server._tool_manager.list_tools())
        )

    def test_list_provinces(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/ObtenerProvincias?": {
                    "consulta_provincieroResult": {
                        "control": {"cuprov": 1},
                        "provinciero": {"prov": [{"cpine": "28", "np": "MADRID"}]},
                    }
                }
            }
        )

        self.assertEqual(
            service.list_provinces(),
            {"items": [{"province_name": "MADRID", "province_ine_code": "28"}]},
        )

    def test_search_municipalities(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/ObtenerMunicipios?Provincia=MADRID&Municipio=MAD": {
                    "consulta_municipieroResult": {
                        "control": {"cumun": 1},
                        "municipiero": {
                            "muni": [
                                {
                                    "locat": {"cd": "28", "cmc": "900"},
                                    "loine": {"cp": "28", "cm": "079"},
                                    "nm": "MADRID",
                                }
                            ]
                        },
                    }
                }
            }
        )

        result = service.search_municipalities("madrid", "mad")
        self.assertEqual(
            result,
            {
                "items": [
                    {
                        "province_name": "MADRID",
                        "municipality_name": "MADRID",
                        "municipality_catastro_codes": {
                            "delegation": "28",
                            "municipality": "900",
                        },
                        "municipality_ine_codes": {
                            "province": "28",
                            "municipality": "079",
                        },
                    }
                ]
            },
        )

    def test_search_streets_detects_common_prefix(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/ObtenerCallejero?Provincia=MADRID&Municipio=MADRID&TipoVia=CL&NomVia=ATOCHA": {
                    "consulta_callejeroResult": {
                        "control": {"cuca": 1},
                        "callejero": {
                            "calle": [
                                {
                                    "dir": {"cv": "645", "tv": "CL", "nv": "ATOCHA"},
                                    "dirine": {
                                        "ecine": "00",
                                        "esine": "01",
                                        "nucine": "01",
                                        "sine": "CALLE",
                                        "vine": "00645",
                                        "deine": "ATOCHA",
                                    },
                                }
                            ]
                        },
                    }
                }
            }
        )

        result = service.search_streets("Madrid", "Madrid", "Calle Atocha")
        self.assertEqual(
            result,
            {
                "items": [
                    {
                        "street_catastro_code": "645",
                        "street_type_code": "CL",
                        "street_name": "ATOCHA",
                        "street_ine": {
                            "collective_entity_code": "00",
                            "singular_entity_code": "01",
                            "nucleus_code": "01",
                            "street_code": "00645",
                            "street_type_code": "CALLE",
                            "street_name": "ATOCHA",
                        },
                    }
                ]
            },
        )

    def test_search_numbers_by_street_code(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejeroCodigos.svc/json/ObtenerNumereroCodigos?CodigoProvincia=28&CodigoMunicipio=900&CodigoVia=645&Numero=20": {
                    "consulta_numereroResult": {
                        "control": {"cunum": 1},
                        "nump": [{"pc": {"pc1": "0440302", "pc2": "VK4704A"}, "num": {"pnp": "20"}}],
                    }
                }
            }
        )

        result = service.search_numbers_by_street_code(
            province_code="28",
            municipality_code="900",
            street_catastro_code="645",
            number="20",
        )
        self.assertEqual(
            result,
            {
                "items": [
                    {
                        "refcat": "0440302VK4704A",
                        "street_number": "20",
                        "street_number_dup": None,
                    }
                ]
            },
        )

    def test_get_property_by_refcat(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/Consulta_DNPRC?RefCat=2749704YJ0624N0001DI": {
                    "consulta_dnprcResult": {
                        "control": {"cudnp": 1, "cucons": 3},
                        "bico": {
                            "bi": {
                                "idbi": {
                                    "cn": "UR",
                                    "rc": {
                                        "pc1": "2749704",
                                        "pc2": "YJ0624N",
                                        "car": "0001",
                                        "cc1": "D",
                                        "cc2": "I",
                                    },
                                },
                                "dt": {
                                    "np": "VALENCIA",
                                    "nm": "GODELLETA",
                                    "locs": {
                                        "lous": {
                                            "lourb": {
                                                "dir": {
                                                    "tv": "CL",
                                                    "nv": "GUAYANA-MOJONERA",
                                                    "pnp": "3",
                                                }
                                            }
                                        }
                                    },
                                },
                                "debi": {
                                    "luso": "Residencial",
                                    "sfc": "94",
                                    "cpt": "100,000000",
                                    "ant": "1976",
                                },
                            },
                            "finca": {"dff": {"ss": "839"}},
                            "lcons": [],
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_property_by_refcat("2749704YJ0624N0001DI"),
            {
                "refcat": "2749704YJ0624N0001DI",
                "asset_type": "UR",
                "address": {
                    "street_type_code": "CL",
                    "street_name": "GUAYANA-MOJONERA",
                    "number": "3",
                    "municipality": "GODELLETA",
                    "province": "VALENCIA",
                },
                "property": {
                    "use": "Residencial",
                    "built_area_m2": 94,
                    "year_built": 1976,
                    "participation_coefficient": 100,
                },
                "plot": {
                    "plot_area_m2": 839,
                    "common_elements_area_m2": None,
                },
            },
        )

    def test_get_property_by_location_multiple(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/Consulta_DNPLOC?Provincia=MADRID&Municipio=MADRID&Sigla=CL&Calle=ATOCHA&Numero=21": {
                    "consulta_dnplocResult": {
                        "control": {"cudnp": 2},
                        "lrcdnp": {
                            "rcdnp": [
                                {
                                    "rc": {
                                        "pc1": "0541215",
                                        "pc2": "VK4704B",
                                        "car": "0002",
                                        "cc1": "H",
                                        "cc2": "F",
                                    },
                                    "dt": {
                                        "locs": {
                                            "lous": {
                                                "lourb": {"loint": {"pt": "01", "pu": "A"}}
                                            }
                                        }
                                    },
                                }
                            ]
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_property_by_location("Madrid", "Madrid", "CL", "Atocha", "21"),
            {
                "items": [
                    {
                        "refcat": "0541215VK4704B0002HF",
                        "block": None,
                        "stair": None,
                        "floor": "01",
                        "door": "A",
                    }
                ]
            },
        )

    def test_get_refcat_from_coordinates(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc/json/Consulta_RCCOOR?SRS=EPSG%3A25830&CoorX=440343.49&CoorY=4473923.42": {
                    "Consulta_RCCOORResult": {
                        "control": {"cucoor": 1},
                        "coordenadas": {
                            "coord": [
                                {
                                    "pc": {"pc1": "0440302", "pc2": "VK4704A"},
                                    "geo": {
                                        "xcen": "440343.49",
                                        "ycen": "4473923.42",
                                        "srs": "EPSG:25830",
                                    },
                                    "ldt": "CL ATOCHA 20 MADRID (MADRID)",
                                }
                            ]
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_refcat_from_coordinates("EPSG:25830", 440343.49, 4473923.42),
            {
                "refcat": "0440302VK4704A",
                "coordinates": {
                    "x": 440343.49,
                    "y": 4473923.42,
                    "srs": "EPSG:25830",
                },
                "address_label": "CL ATOCHA 20 MADRID (MADRID)",
            },
        )

    def test_get_property_by_refcat_multiple(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/Consulta_DNPRC?RefCat=0541215VK4704B": {
                    "consulta_dnprcResult": {
                        "control": {"cudnp": 2},
                        "lrcdnp": {
                            "rcdnp": [
                                {
                                    "rc": {
                                        "pc1": "0541215",
                                        "pc2": "VK4704B",
                                        "car": "0002",
                                        "cc1": "H",
                                        "cc2": "F",
                                    },
                                    "dt": {
                                        "locs": {
                                            "lous": {
                                                "lourb": {
                                                    "loint": {
                                                        "bq": "1",
                                                        "es": "A",
                                                        "pt": "01",
                                                        "pu": "A",
                                                    }
                                                }
                                            }
                                        }
                                    },
                                }
                            ]
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_property_by_refcat("0541215VK4704B"),
            {
                "items": [
                    {
                        "refcat": "0541215VK4704B0002HF",
                        "block": "1",
                        "stair": "A",
                        "floor": "01",
                        "door": "A",
                    }
                ]
            },
        )

    def test_get_coordinates_from_refcat(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc/json/Consulta_CPMRC?RefCat=0440302VK4704A&SRS=EPSG%3A25830": {
                    "Consulta_CPMRCResult": {
                        "control": {"cucoor": 1},
                        "coordenadas": {
                            "coord": [
                                {
                                    "pc": {"pc1": "0440302", "pc2": "VK4704A"},
                                    "geo": {
                                        "xcen": "440343.49",
                                        "ycen": "4473923.42",
                                        "srs": "EPSG:25830",
                                    },
                                    "ldt": "CL ATOCHA 20 MADRID (MADRID)",
                                }
                            ]
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_coordinates_from_refcat("0440302VK4704A", "EPSG:25830"),
            {
                "refcat": "0440302VK4704A",
                "coordinates": {
                    "x": 440343.49,
                    "y": 4473923.42,
                    "srs": "EPSG:25830",
                },
                "address_label": "CL ATOCHA 20 MADRID (MADRID)",
            },
        )

    def test_get_property_by_polygon_parcel(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/Consulta_DNPPP?Provincia=VALENCIA&Municipio=GODELLETA&Poligono=12&Parcela=34": {
                    "consulta_dnpppResult": {
                        "control": {"cudnp": 1},
                        "bico": {
                            "bi": {
                                "idbi": {
                                    "cn": "RU",
                                    "rc": {
                                        "pc1": "1234567",
                                        "pc2": "YJ0624N",
                                        "car": "0001",
                                        "cc1": "D",
                                        "cc2": "I",
                                    },
                                },
                                "dt": {
                                    "np": "VALENCIA",
                                    "nm": "GODELLETA",
                                    "locs": {
                                        "lors": {
                                            "lorus": {
                                                "cpp": {"cpo": "12", "cpa": "34"}
                                            }
                                        }
                                    },
                                },
                                "debi": {
                                    "luso": "Agrario",
                                    "sfc": "94",
                                    "cpt": "100,000000",
                                    "ant": "1976",
                                },
                            },
                            "finca": {"dff": {"ssf": {"ss": "839"}}},
                            "lcons": [],
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_property_by_polygon_parcel("VALENCIA", "GODELLETA", "12", "34"),
            {
                "refcat": "1234567YJ0624N0001DI",
                "asset_type": "RU",
                "address": {
                    "street_type_code": None,
                    "street_name": None,
                    "number": None,
                    "municipality": "GODELLETA",
                    "province": "VALENCIA",
                },
                "property": {
                    "use": "Agrario",
                    "built_area_m2": 94,
                    "year_built": 1976,
                    "participation_coefficient": 100,
                },
                "plot": {
                    "plot_area_m2": 839,
                    "common_elements_area_m2": None,
                },
                "rural_location": {"polygon": "12", "parcel": "34"},
            },
        )

    def test_get_nearby_refcats(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCoordenadas.svc/json/Consulta_RCCOOR_Distancia?SRS=EPSG%3A25830&CoorX=440343.49&CoorY=4473923.42": {
                    "Consulta_RCCOOR_DistanciaResult": {
                        "control": {"cucoor": 1},
                        "coordenadas_distancias": {
                            "coordd": [
                                {
                                    "lpcd": [
                                        {
                                            "pc": {"pc1": "0440302", "pc2": "VK4704A"},
                                            "ldt": "CL ATOCHA 20 MADRID (MADRID)",
                                            "dis": "0",
                                        }
                                    ]
                                }
                            ]
                        },
                    }
                }
            }
        )

        self.assertEqual(
            service.get_nearby_refcats("EPSG:25830", 440343.49, 4473923.42),
            {
                "items": [
                    {
                        "refcat": "0440302VK4704A",
                        "distance_m": 0,
                        "address_label": "CL ATOCHA 20 MADRID (MADRID)",
                    }
                ]
            },
        )

    def test_errors_are_structured(self) -> None:
        service = build_service(
            {
                "/OVCServWeb/OVCWcfCallejero/COVCCallejero.svc/json/ObtenerCallejero?Provincia=MADRID&Municipio=MADRID&TipoVia=CL&NomVia=NOEXISTE": {
                    "consulta_callejeroResult": {
                        "control": {"cuerr": 1},
                        "lerr": {"err": [{"cod": "10", "des": "NO HAY COINCIDENCIAS EN LA BÚSQUEDA DE VÍAS"}]},
                    }
                }
            }
        )

        self.assertEqual(
            service.search_streets("Madrid", "Madrid", "NoExiste", "CL"),
            {
                "error": {
                    "code": "NOT_FOUND",
                    "message": "NO HAY COINCIDENCIAS EN LA BÚSQUEDA DE VÍAS",
                    "upstream": {
                        "service": "ObtenerCallejero",
                        "code": "10",
                        "description": "NO HAY COINCIDENCIAS EN LA BÚSQUEDA DE VÍAS",
                    },
                }
            },
        )


if __name__ == "__main__":
    unittest.main()
