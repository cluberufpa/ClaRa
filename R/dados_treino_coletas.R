#' D36 - Coletas: DADOS SINTÉTICOS DE TREINO
#'
#' Dados provisórios da passada 1. Unidade amostral: registro fictício de coleta para praticar separação de colunas.
#'
#' @format Um `data.frame` com 15 linhas e 5 colunas:
#' \describe{
#'   \item{id}{Texto: identificador fictício do registro de treino.}
#'   \item{codigo_coleta}{Código composto ESPECIE-ANO-PORTO (character; ex.: "PARGO-2023-BRA").}
#'   \item{estacao_periodo}{Estação e período compostos (character; ex.: "E03_Seca").}
#'   \item{comprimento_cm}{Comprimento do indivíduo, em centímetros (numeric).}
#'   \item{peso_g}{Peso do indivíduo, em gramas (numeric).}
#' }
#'
#' @details
#' DADOS SINTÉTICOS DE TREINO — não usar para inferência científica. Exceção expressamente autorizada pelo professor no Núcleo 60. Preservadas as colunas compostas para o exercício; não executar nova simulação. Confirmar autoria/licença do material didático.
#'
#' @section Adaptações:
#' Somente id convertido em texto pela convenção de identificadores. Colunas compostas preservadas para o exercício.
#'
#' @source
#' Dados fictícios do ecossistema EAPA; planilha de treino e script de importação preservados.
#' Licença: MIT + file LICENSE, EAPADados 0.1.14.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D36_treino_coletas/.
#'
#' @examples
#' summary(treino_coletas)
#'
#' @docType data
#' @keywords datasets
"treino_coletas"
