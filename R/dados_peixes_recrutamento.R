#' D59 - Peixes: índice mensal de recrutamento
#'
#' Dados provisórios da passada 1. Unidade amostral: mês da série de índice de recrutamento, janeiro de 1950 a setembro de 1987.
#'
#' @format Um `data.frame` com 453 linhas e 2 colunas:
#' \describe{
#'   \item{data}{Primeiro dia do mês representado, classe Date; convenção para a série mensal.}
#'   \item{indice_recrutamento}{Índice original de recrutamento, escala e construção a confirmar; não contagem de peixes.}
#' }
#'
#' @details
#' O valor é índice de recrutamento, não número bruto de peixes. Espécie, área, construção e escala do índice não são especificadas na ajuda resumida: confirmar na documentação primária. Série ts com frequência 12, início 1950 e 453 valores termina em setembro de 1987; limite arredondado 1988 da impressão não é data de coleta. Primeiro dia do mês é convenção de representação, não dia observado. Preservados valores repetidos. Dependência temporal exige métodos adequados; não inventar variáveis ambientais nem parear automaticamente com SOI.
#'
#' @section Adaptações:
#' Série ts transformada em data.frame mensal com data e indice_recrutamento; frequência e início usados para reconstruir o calendário. Primeiro dia representa o mês, não dia real de coleta. Valores e ordem da série preservados; sem interpolação ou novas variáveis ambientais.
#'
#' @source
#' Roy Mendelssohn, Pacific Fisheries Environmental Laboratory, NOAA, comunicação pessoal, conforme astsa::rec; Shumway e Stoffer, Time Series Analysis and Its Applications.
#' Licença: GPL (>= 2), astsa 2.5.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D59_peixes_recrutamento/.
#'
#' @examples
#' summary(peixes_recrutamento)
#'
#' @docType data
#' @keywords datasets
"peixes_recrutamento"
