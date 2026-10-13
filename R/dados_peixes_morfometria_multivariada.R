#' D29 - Peixes: morfometria para análises multivariadas
#'
#' Dados provisórios da passada 1. Unidade amostral: peixe individual com 35 medidas corporais.
#'
#' @format Um `data.frame` com 299 linhas e 39 colunas:
#' \describe{
#'   \item{especie}{Fator: \code{Barbus petenyi}, \code{Gobio sp.}, \code{Lepomis gibbosus}.}
#'   \item{populacao}{Fator: população de origem (\code{POP01} a \code{POP15}).}
#'   \item{id_individuo}{Texto: identificador do indivíduo.}
#'   \item{da}{Numérico: medida morfométrica (mm).}
#'   \item{dalc}{Numérico: medida morfométrica (mm).}
#'   \item{dauc}{Numérico: medida morfométrica (mm).}
#'   \item{dlc}{Numérico: medida morfométrica (mm).}
#'   \item{dod}{Numérico: medida morfométrica (mm).}
#'   \item{dopl}{Numérico: medida morfométrica (mm).}
#'   \item{dpc}{Numérico: medida morfométrica (mm).}
#'   \item{dpl}{Numérico: medida morfométrica (mm).}
#'   \item{dso}{Numérico: medida morfométrica (mm).}
#'   \item{dsv}{Numérico: medida morfométrica (mm).}
#'   \item{duc}{Numérico: medida morfométrica (mm).}
#'   \item{dvpl}{Numérico: medida morfométrica (mm).}
#'   \item{eh}{Numérico: medida morfométrica (mm).}
#'   \item{ev}{Numérico: medida morfométrica (mm).}
#'   \item{fl}{Numérico: medida morfométrica (mm).}
#'   \item{hd}{Numérico: medida morfométrica (mm).}
#'   \item{hh}{Numérico: medida morfométrica (mm).}
#'   \item{hl}{Numérico: medida morfométrica (mm).}
#'   \item{hmax}{Numérico: altura máxima do corpo (mm).}
#'   \item{hmin}{Numérico: altura mínima do corpo (mm).}
#'   \item{la}{Numérico: medida morfométrica (mm).}
#'   \item{lbd}{Numérico: medida morfométrica (mm).}
#'   \item{ld}{Numérico: medida morfométrica (mm).}
#'   \item{llc}{Numérico: medida morfométrica (mm).}
#'   \item{lpec}{Numérico: medida morfométrica (mm).}
#'   \item{lpl}{Numérico: medida morfométrica (mm).}
#'   \item{luc}{Numérico: medida morfométrica (mm).}
#'   \item{mo}{Numérico: medida morfométrica (mm).}
#'   \item{pa}{Numérico: medida morfométrica (mm).}
#'   \item{pd}{Numérico: medida morfométrica (mm).}
#'   \item{poo}{Numérico: medida morfométrica (mm).}
#'   \item{ppec}{Numérico: medida morfométrica (mm).}
#'   \item{ppl}{Numérico: medida morfométrica (mm).}
#'   \item{pre}{Numérico: medida morfométrica (mm).}
#'   \item{sl}{Numérico: comprimento padrão (mm).}
#' }
#'
#' @details
#' Preservar as 35 medidas; especie_codigo (repetia especie) foi removido em 12/10/2026. Expandir códigos anatômicos só com dicionário. Seleção e padronização alteram PCA/HCA. Conferir créditos com metadados primários, como na base do barbo.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.
#'
#' @source
#' Raw morphometric data of three freshwater fish species, Mendeley Data, DOI 10.17632/c8856zg4hj.1; créditos herdados Bánó e Takács (2022), completar conferência bibliográfica.
#' Licença: CC BY 4.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D29_peixes_morfometria/.
#'
#' @examples
#' summary(peixes_morfometria_multivariada)
#'
#' @docType data
#' @keywords datasets
"peixes_morfometria_multivariada"
