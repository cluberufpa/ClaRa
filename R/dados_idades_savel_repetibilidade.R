#' D27 - Sável: repetibilidade das leituras de idade
#'
#' Dados provisórios da passada 1. Unidade amostral: peixe com leituras de idade repetidas por leitor.
#'
#' @format Um `data.frame` com 53 linhas e 8 colunas:
#' \describe{
#'   \item{fish_id}{Texto: identificação do peixe.}
#'   \item{true_age}{Inteiro: idade verdadeira (anos), conhecida por marcação prévia.}
#'   \item{reader_a_1}{Inteiro: idade estimada pelo leitor A na 1ª leitura.}
#'   \item{reader_a_2}{Inteiro: idade estimada pelo leitor A na 2ª leitura.}
#'   \item{reader_b_1}{Inteiro: idade estimada pelo leitor B na 1ª leitura (com ausências).}
#'   \item{reader_b_2}{Inteiro: idade estimada pelo leitor B na 2ª leitura (com ausências).}
#'   \item{reader_c_1}{Inteiro: idade estimada pelo leitor C na 1ª leitura.}
#'   \item{reader_c_2}{Inteiro: idade estimada pelo leitor C na 2ª leitura.}
#' }
#'
#' @details
#' Não traduzir novamente cabeçalhos herdados nesta passada. Parear por fish_id; remover ausências somente do par usado. Leitor B tem 20 ausências em cada leitura. Falta de diferença em Wilcoxon não demonstra concordância perfeita.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.
#'
#' @source
#' McBride, Hendricks e Olney (2005), Fisheries 30:10–18; FSAdata::ShadCR.
#' Licença: GPL-2 | GPL-3, FSAdata.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D27_savel_idades/.
#'
#' @examples
#' summary(idades_savel_repetibilidade)
#'
#' @docType data
#' @keywords datasets
"idades_savel_repetibilidade"
