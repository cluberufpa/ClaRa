#' D12 - Bactérias: presença após tratamentos em crianças
#'
#' Dados provisórios da passada 1. Unidade amostral: observação de uma criança em uma semana; medidas repetidas.
#'
#' @format Um `data.frame` com 220 linhas e 6 colunas:
#' \describe{
#'   \item{presenca_bacteria}{Fator: ausente ou presente para H. influenzae.}
#'   \item{intervencao}{Fator: medicamento ou placebo.}
#'   \item{adesao}{Fator: alta ou baixa, conforme classificação original.}
#'   \item{semana}{Semana da observação: 0, 2, 4, 6 ou 11.}
#'   \item{id_individuo}{Texto: identificador da criança.}
#'   \item{tratamento}{Fator: placebo, medicamento ou medicamento_incentivo.}
#' }
#'
#' @details
#' Para McNemar selecionar semanas 0 e 11 e parear por id_individuo: 44 pares completos, sem imputar as seis perdas. Não tratar 220 registros como crianças independentes. Confirmar a interpretação dos campos de adesão e incentivo no protocolo.
#'
#' @section Adaptações:
#' y/ap/hilo/week/ID/trt → presenca_bacteria/intervencao/adesao/semana/id_individuo/tratamento; n/y → ausente/presente; a/p → medicamento/placebo; hi/lo → alta/baixa; drug/drug+ → medicamento/medicamento_incentivo. ID como texto. Todas as 220 observações preservadas.
#'
#' @source
#' Amanda Leach via James McBroom; Venables e Ripley (2002); MASS::bacteria, MASS 7.3-65.
#' Licença: GPL-2 | GPL-3, conforme MASS; não relicenciado como MIT.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D12_bacterias_tratamento/.
#'
#' @examples
#' summary(bacterias_tratamento)
#'
#' @docType data
#' @keywords datasets
"bacterias_tratamento"
