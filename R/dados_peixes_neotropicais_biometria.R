#' D15 - Peixes neotropicais: comprimento e peso
#'
#' Dados provisórios da passada 1. Unidade amostral: peixe amostrado.
#'
#' @format Um `data.frame` com 306 linhas e 9 colunas:
#' \describe{
#'   \item{id_registro}{Texto: identificador original no, convertido sem renumerar.}
#'   \item{especie}{Espécie ou grupo taxonômico, com nove níveis originais.}
#'   \item{peso_g}{Peso do indivíduo, em gramas.}
#'   \item{comprimento_padrao_mm}{Comprimento padrão, em milímetros.}
#'   \item{comprimento_total_mm}{Comprimento total, em milímetros; ausências preservadas.}
#'   \item{pais}{País de coleta, com categorias originais.}
#'   \item{localidade}{Localidade de coleta, com nomes próprios preservados.}
#'   \item{latitude}{Latitude em graus decimais; ausências preservadas.}
#'   \item{longitude}{Longitude em graus decimais; ausências preservadas.}
#' }
#'
#' @details
#' Preservar 306 indivíduos e ausências de comprimento total. Não confundir nove rótulos taxonômicos com as sete espécies do título do artigo. Revisar desequilíbrio entre espécies e a identificação dos dois grupos sp. Nome definitivo sugerido nesta passada: peixes_neotropicais_biometria.
#'
#' @section Adaptações:
#' Decisão anterior aprovada: retirar log_peso_g, log_sl_mm, nadadeira_dorsal, nadadeira_caudal e sexo; no → id_registro (texto). Todas as 306 linhas preservadas. Duas diferenças de espaço final em red fin no CSV explicadas pela transformação str_squish já documentada no preparo original.
#'
#' @source
#' Bagley, Breitman e Johnson (2022); DOI 10.3897/aiep.52.86467; Mendeley DOI 10.17632/kphrvvgwwz.1.
#' Licença: CC BY 4.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D15_peixes_neotropicais/.
#'
#' @section Usos secundários:
#' ANCOVA: com `log(peso_g)` e `log(comprimento_padrao_mm)`, o modelo
#' `lm(log_peso ~ log_comp * especie)` testa se as espécies têm a mesma
#' inclinação (alometria) e, sem interação, o mesmo intercepto. Cada linha é
#' um peixe.
#'
#' @examples
#' summary(peixes_neotropicais_biometria)
#'
#' @docType data
#' @keywords datasets
"peixes_neotropicais_biometria"
