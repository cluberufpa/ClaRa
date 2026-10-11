#' D17 - Salmouras de unidades carbonáticas: composição iônica
#'
#' Dados provisórios da passada 1. Unidade amostral: amostra de salmoura ou água de formação.
#'
#' @format Um `data.frame` com 19 linhas e 8 colunas:
#' \describe{
#'   \item{amostra}{Código da amostra original.}
#'   \item{grupo}{Unidade geológica, com espaços no nome próprio.}
#'   \item{bicarbonato_ppm}{Concentração de bicarbonato, em ppm conforme origem.}
#'   \item{sulfato_ppm}{Concentração de sulfato, em ppm conforme origem.}
#'   \item{cloreto_ppm}{Concentração de cloreto, em ppm conforme origem.}
#'   \item{calcio_ppm}{Concentração de cálcio, em ppm conforme origem.}
#'   \item{magnesio_ppm}{Concentração de magnésio, em ppm conforme origem.}
#'   \item{sodio_ppm}{Concentração de sódio, em ppm conforme origem.}
#' }
#'
#' @details
#' Completar licença de redistribuição. Correções herdadas V18: Cl=289,9 e V19: Na=318,1 preservadas. Comparar padronização antes de PCA/HCA. Nome definitivo sugerido: salmouras_carbonatos.
#'
#' @section Adaptações:
#' Decisão anterior aprovada: HCO3/SO4/Cl/Ca/Mg/Na → bicarbonato_ppm/sulfato_ppm/cloreto_ppm/calcio_ppm/magnesio_ppm/sodio_ppm; underscores → espaços nos nomes próprios das formações.
#'
#' @source
#' Davis (2002), Statistics and Data Analysis in Geology; Kansas Geological Survey, BRINE.TXT.
#' Licença: Licença específica não localizada; autorização a confirmar.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D17_salmouras_carbonatos/.
#'
#' @examples
#' summary(salmouras_carbonatos)
#'
#' @docType data
#' @keywords datasets
"salmouras_carbonatos"
