#' D24 - Percina: idade e comprimento em Ontário
#'
#' Dados provisórios da passada 1. Unidade amostral: registro reconstruído aproximadamente de uma figura de indivíduos.
#'
#' @format Um `data.frame` com 54 linhas e 3 colunas:
#' \describe{
#'   \item{idade_anos}{Inteiro: idade estimada pelo otólito, em anos.}
#'   \item{comprimento_total_mm}{Numérico: comprimento total (mm).}
#'   \item{rio}{Fator: rio de captura, com níveis \code{Salmon} e \code{Trent}.}
#' }
#'
#' @details
#' São registros reconstruídos da Figura 2, não planilha primária individual. Manter quatro linhas com valores repetidos. Mann-Whitney exige lidar com empates; interpretar formas das distribuições e seletividade da captura.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.
#'
#' @section De-para da receita:
#' age -> idade_anos (inteiro); tl -> comprimento_total_mm (numérico); river -> rio (fator Salmon/Trent). Sem filtro de linhas.
#'
#' @section Leitura do pacote:
#' Adaptado de `FSAdata::DarterOnt`, versão 0.4.1. Autoria do pacote: Derek Ogle.
#' As observações são lidas na hora por `carregar_dados("darter_ontario")`.
#' Não há cópia deste conjunto em data/ da ClaRa.
#'
#' @source
#' Reid (2004), Journal of Freshwater Ecology 19:441–444, Figura 2; FSAdata::DarterOnt.
#' Licença do pacote fornecedor: GPL (>= 2).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D24_percina_ontario/.
#'
#' @examples
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   dados <- carregar_dados("darter_ontario")
#'   summary(dados)
#' }
#'
#' @name darter_ontario
#' @keywords datasets
NULL
