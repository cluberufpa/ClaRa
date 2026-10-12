#' D37 - Desembarques: DADOS SINTÉTICOS DE TREINO
#'
#' Dados provisórios da passada 1. Unidade amostral: combinação fictícia de porto e espécie, com anos em colunas.
#'
#' @format Um `data.frame` com 12 linhas e 8 colunas:
#' \describe{
#'   \item{Porto}{Porto de desembarque (character; Bragança, Vigia, Belém, Augusto Corrêa).}
#'   \item{Especie}{Espécie desembarcada (character; Pargo, Serra, Pescada).}
#'   \item{2021 - Captura_t}{Captura de 2021, em toneladas (numeric).}
#'   \item{2021 - Receita_mil}{Receita de 2021, em milhares de reais (numeric).}
#'   \item{2022 - Captura_t}{Captura de 2022, em toneladas (numeric).}
#'   \item{2022 - Receita_mil}{Receita de 2022, em milhares de reais (numeric).}
#'   \item{2023 - Captura_t}{Captura de 2023, em toneladas (numeric).}
#'   \item{2023 - Receita_mil}{Receita de 2023, em milhares de reais (numeric).}
#' }
#'
#' @details
#' DADOS SINTÉTICOS DE TREINO — não usar para inferência científica. Exceção expressamente autorizada pelo professor no Núcleo 60. Preservado formato largo e cabeçalhos compostos. Receita fictícia em milhares de reais segundo ajuda herdada; confirmar convenção do exercício.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores e ordem herdados preservados; nenhuma exclusão nova.
#'
#' @source
#' Dados fictícios do ecossistema EAPA; planilha de treino e script de importação preservados.
#' Licença: MIT + file LICENSE, EAPADados 0.1.14.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D37_treino_desembarque/.
#'
#' @examples
#' summary(treino_desembarque)
#'
#' @docType data
#' @keywords datasets
"treino_desembarque"
