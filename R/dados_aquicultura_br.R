#' D14 - Aquicultura brasileira: produção por estado e ano
#'
#' Dados provisórios da passada 1. Unidade amostral: unidade da Federação e ano.
#'
#' @format Um `data.frame` com 216 linhas e 5 colunas:
#' \describe{
#'   \item{uf}{Sigla da unidade da Federação.}
#'   \item{estado}{Nome do estado, com caixa original preservada.}
#'   \item{posicao}{Posição no ranking de produção do ano.}
#'   \item{producao_t}{Produção anual de peixes de cultivo, em toneladas.}
#'   \item{ano}{Ano de referência, de 2016 a 2023.}
#' }
#'
#' @details
#' Completar edições, páginas e licença específica da fonte; acesso público não equivale a domínio público. Preservar caixa herdada dos estados nesta passada. Oito anos por UF não sustentam decomposição sazonal mensal.
#'
#' @section Adaptações:
#' Identidade: nomes, categorias e valores herdados preservados.
#'
#' @source
#' Peixe-BR, Anuários da Piscicultura; produção de 2016 a 2023.
#' Licença: Dados publicados pela Peixe-BR; licença específica de redistribuição a confirmar.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D14_aquicultura_brasil/.
#'
#' @examples
#' summary(aquicultura_br)
#'
#' @docType data
#' @keywords datasets
"aquicultura_br"
