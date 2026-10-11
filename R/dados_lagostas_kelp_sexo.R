#' D28 - Lagostas: sexo em dois sítios de kelp
#'
#' Dados provisórios da passada 1. Unidade amostral: lagosta capturada em um evento e sítio.
#'
#' @format Um `data.frame` com 1457 linhas e 8 colunas:
#' \describe{
#'   \item{id_lagosta}{Texto: identificador da lagosta.}
#'   \item{data_amostragem}{Data: data do evento de amostragem.}
#'   \item{ano}{Inteiro: ano da coleta.}
#'   \item{mes}{Inteiro: mês da coleta (número).}
#'   \item{mes_nome}{Fator com níveis em ordem da temporada; não é ordered.}
#'   \item{sitio}{Fator: sítio/ambiente de kelp (\code{DIAZ}, \code{SWB}) — os dois ambientes (floresta natural e área de cultivo).}
#'   \item{sexo}{Fator: \code{femea}, \code{macho}.}
#'   \item{comprimento_cefalotorax_mm}{Numérico: comprimento do cefalotórax (mm).}
#' }
#'
#' @details
#' Confirmar DOI, autoria, licença e qual código DIAZ/SWB representa kelp natural ou cultivo. Não inventar nomes. Registrar filtro herdado de sexo/sítio, sem novo corte. Considerar armadilhas e eventos para independência; meses são fator com ordem de níveis sazonal, não ordered.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.
#'
#' @source
#' Abundance, Size Structure, and Sex Ratio Variation of West Coast Rock Lobster (Jasus lalandii) in Cultivated and Natural Kelp Forests off Lüderitz, Namibia; depósito Mendeley, identificador a completar.
#' Licença: Licença específica do depósito Mendeley a confirmar.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D28_lagostas_kelp/.
#'
#' @examples
#' summary(lagostas_kelp_sexo)
#'
#' @docType data
#' @keywords datasets
"lagostas_kelp_sexo"
