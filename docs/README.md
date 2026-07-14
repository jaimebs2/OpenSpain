# Documentación de skills y MCPs

Cada skill del directorio [openspain/skills/](../openspain/skills/) tiene aquí su ficha técnica: qué se puede consultar, requisitos, particularidades de la API y cómo instalarla.

Metadata estructurada (URLs, auth, licencia, rate limits) en el `service.yml` de cada skill.

## MCPs

Servidores [Model Context Protocol](https://modelcontextprotocol.io) en Python, independientes de las skills, para clientes como Codex o Claude Desktop o cuando se necesita lógica que un LLM no puede expresar (buffers geométricos, parsing estructurado, paralelismo).

| MCP | Qué expone | README |
|---|---|---|
| `catastro` | Provincias, municipios, calles, refcat, coordenadas ↔ inmueble, polígono/parcela, inmuebles cercanos | [mcps/catastro/](../mcps/catastro/) |
| `snczi` | Zonas inundables (T=10/100/500), DPH, aproximación zona policía/servidumbre, reporte combinado | [mcps/snczi/](../mcps/snczi/) |

Instalación, transportes (`stdio` / `streamable-http` / `sse`) y ejemplos de configuración en cada README.

## Índice de skills

| Skill | Ficha |
|---|---|
| `aeat` | [aeat.md](services/aeat.md) |
| `aemet` | [aemet.md](services/aemet.md) |
| `aena` | [aena.md](services/aena.md) |
| `bde` | [bde.md](services/bde.md) |
| `bne` | [bne.md](services/bne.md) |
| `boe` | [boe.md](services/boe.md) |
| `borme` | [borme.md](services/borme.md) |
| `catastro` | [catastro.md](services/catastro.md) |
| `cis` | [cis.md](services/cis.md) |
| `cnig` | [cnig.md](services/cnig.md) |
| `cnmc` | [cnmc.md](services/cnmc.md) |
| `congreso` | [congreso.md](services/congreso.md) |
| `cte` | [cte.md](services/cte.md) |
| `dataestur` | [dataestur.md](services/dataestur.md) |
| `datos-gob-es` | [datos-gob-es.md](services/datos-gob-es.md) |
| `dgt/accidentes` | [accidentes.md](services/dgt/accidentes.md) |
| `dgt/trafico` | [trafico.md](services/dgt/trafico.md) |
| `dgt/zbe` | [zbe.md](services/dgt/zbe.md) |
| `fiscalidad/autonomos` | [autonomos.md](services/fiscalidad/autonomos.md) |
| `fiscalidad/facturacion` | [facturacion.md](services/fiscalidad/facturacion.md) |
| `fiscalidad/impuestos-locales` | [impuestos-locales.md](services/fiscalidad/impuestos-locales.md) |
| `fiscalidad/irpf-asalariados` | [irpf-asalariados.md](services/fiscalidad/irpf-asalariados.md) |
| `fiscalidad/irpf-autonomos` | [irpf-autonomos.md](services/fiscalidad/irpf-autonomos.md) |
| `fiscalidad/itp-ajd` | [itp-ajd.md](services/fiscalidad/itp-ajd.md) |
| `fiscalidad/iva` | [iva.md](services/fiscalidad/iva.md) |
| `fiscalidad/modelo-036` | [modelo-036.md](services/fiscalidad/modelo-036.md) |
| `fiscalidad/no-residentes` | [no-residentes.md](services/fiscalidad/no-residentes.md) |
| `fiscalidad/operaciones-intracomunitarias` | [operaciones-intracomunitarias.md](services/fiscalidad/operaciones-intracomunitarias.md) |
| `fiscalidad/retenciones` | [retenciones.md](services/fiscalidad/retenciones.md) |
| `fiscalidad/sociedades` | [sociedades.md](services/fiscalidad/sociedades.md) |
| `fiscalidad/sucesiones-donaciones` | [sucesiones-donaciones.md](services/fiscalidad/sucesiones-donaciones.md) |
| `emprendimiento/alta-autonomo` | [alta-autonomo.md](services/emprendimiento/alta-autonomo.md) |
| `emprendimiento/crear-empresa` | [crear-empresa.md](services/emprendimiento/crear-empresa.md) |
| `emprendimiento/licencias-actividad` | [licencias-actividad.md](services/emprendimiento/licencias-actividad.md) |
| `identidad-digital/autofirma` | [autofirma.md](services/identidad-digital/autofirma.md) |
| `identidad-digital/certificado-digital` | [certificado-digital.md](services/identidad-digital/certificado-digital.md) |
| `identidad-digital/clave` | [clave.md](services/identidad-digital/clave.md) |
| `identidad-digital/dnie` | [dnie.md](services/identidad-digital/dnie.md) |
| `educacion` | [educacion.md](services/educacion.md) |
| `educacion-guia/becas-mec` | [becas-mec.md](services/educacion-guia/becas-mec.md) |
| `educacion-guia/fp` | [fp.md](services/educacion-guia/fp.md) |
| `educacion-guia/oposiciones` | [oposiciones.md](services/educacion-guia/oposiciones.md) |
| `educacion-guia/selectividad` | [selectividad.md](services/educacion-guia/selectividad.md) |
| `extranjeria/arraigo` | [arraigo.md](services/extranjeria/arraigo.md) |
| `extranjeria/asilo` | [asilo.md](services/extranjeria/asilo.md) |
| `extranjeria/familiar-ue` | [familiar-ue.md](services/extranjeria/familiar-ue.md) |
| `extranjeria/nacionalidad` | [nacionalidad.md](services/extranjeria/nacionalidad.md) |
| `extranjeria/nie` | [nie.md](services/extranjeria/nie.md) |
| `extranjeria/reagrupacion` | [reagrupacion.md](services/extranjeria/reagrupacion.md) |
| `extranjeria/residencia` | [residencia.md](services/extranjeria/residencia.md) |
| `extranjeria/trabajo` | [trabajo.md](services/extranjeria/trabajo.md) |
| `esios` | [esios.md](services/esios.md) |
| `ine` | [ine.md](services/ine.md) |
| `infosubvenciones` | [infosubvenciones.md](services/infosubvenciones.md) |
| `jec` | [jec.md](services/jec.md) |
| `laboral/contratos` | [contratos.md](services/laboral/contratos.md) |
| `laboral/convenios` | [convenios.md](services/laboral/convenios.md) |
| `laboral/desempleo` | [desempleo.md](services/laboral/desempleo.md) |
| `laboral/ere-erte` | [ere-erte.md](services/laboral/ere-erte.md) |
| `laboral/inspeccion` | [inspeccion.md](services/laboral/inspeccion.md) |
| `laboral/nominas` | [nominas.md](services/laboral/nominas.md) |
| `justicia/justicia-gratuita` | [justicia-gratuita.md](services/justicia/justicia-gratuita.md) |
| `justicia/testamento` | [testamento.md](services/justicia/testamento.md) |
| `justicia/herencias` | [herencias.md](services/justicia/herencias.md) |
| `justicia/poder-notarial` | [poder-notarial.md](services/justicia/poder-notarial.md) |
| `justicia/registro-civil` | [registro-civil.md](services/justicia/registro-civil.md) |
| `justicia/proteccion-datos` | [proteccion-datos.md](services/justicia/proteccion-datos.md) |
| `miteco` | [miteco.md](services/miteco.md) |
| `placsp` | [placsp.md](services/placsp.md) |
| `puertos` | [puertos.md](services/puertos.md) |
| `rtve` | [rtve.md](services/rtve.md) |
| `sanidad` | [sanidad.md](services/sanidad.md) |
| `seguridad-social` | [seguridad-social.md](services/seguridad-social.md) |
| `seguridad-social-guia/cotizaciones` | [cotizaciones.md](services/seguridad-social-guia/cotizaciones.md) |
| `seguridad-social-guia/incapacidad` | [incapacidad.md](services/seguridad-social-guia/incapacidad.md) |
| `seguridad-social-guia/jubilacion` | [jubilacion.md](services/seguridad-social-guia/jubilacion.md) |
| `seguridad-social-guia/maternidad-paternidad` | [maternidad-paternidad.md](services/seguridad-social-guia/maternidad-paternidad.md) |
| `seguridad-social-guia/vida-laboral` | [vida-laboral.md](services/seguridad-social-guia/vida-laboral.md) |
| `senado` | [senado.md](services/senado.md) |
| `snczi` | [snczi.md](services/snczi.md) |
| `sepe` | [sepe.md](services/sepe.md) |
| `tramites/antecedentes-penales` | [antecedentes-penales.md](services/tramites/antecedentes-penales.md) |
| `tramites/apostilla` | [apostilla.md](services/tramites/apostilla.md) |
| `tramites/cita-previa` | [cita-previa.md](services/tramites/cita-previa.md) |
| `tramites/empadronamiento` | [empadronamiento.md](services/tramites/empadronamiento.md) |
| `tramites/legalizacion-documentos` | [legalizacion-documentos.md](services/tramites/legalizacion-documentos.md) |
| `tramites/tarjeta-sanitaria-europea` | [tarjeta-sanitaria-europea.md](services/tramites/tarjeta-sanitaria-europea.md) |
| `transparencia` | [transparencia.md](services/transparencia.md) |
| `vehiculos/carnet-conducir` | [carnet-conducir.md](services/vehiculos/carnet-conducir.md) |
| `vehiculos/itv` | [itv.md](services/vehiculos/itv.md) |
| `vehiculos/permiso-internacional` | [permiso-internacional.md](services/vehiculos/permiso-internacional.md) |
| `vehiculos/transferencia-vehiculos` | [transferencia-vehiculos.md](services/vehiculos/transferencia-vehiculos.md) |
| `vivienda/alquiler` | [alquiler.md](services/vivienda/alquiler.md) |
| `vivienda/compraventa` | [compraventa.md](services/vivienda/compraventa.md) |
| `vivienda/comunidad-propietarios` | [comunidad-propietarios.md](services/vivienda/comunidad-propietarios.md) |
| `vivienda/hipotecas` | [hipotecas.md](services/vivienda/hipotecas.md) |
| `vivienda/registro-propiedad` | [registro-propiedad.md](services/vivienda/registro-propiedad.md) |
