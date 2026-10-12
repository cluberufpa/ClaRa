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
#' @section De-para da receita:
#' fishID -> fish_id (texto); trueAge -> true_age; agerA1/agerA2 -> reader_a_1/reader_a_2; agerB1/agerB2 -> reader_b_1/reader_b_2; agerC1/agerC2 -> reader_c_1/reader_c_2. Leituras como inteiros; NA preservados.
#'
#' @section Leitura do pacote:
#' Adaptado de `FSAdata::ShadCR`, versão 0.4.1. Autoria do pacote: Derek Ogle.
#' As observações são lidas na hora por `carregar_dados("idades_savel_repetibilidade")`.
#' Não há cópia deste conjunto em data/ da ClaRa.
#'
#' @source
#' McBride, Hendricks e Olney (2005), Fisheries 30:10–18; FSAdata::ShadCR.
#' Licença do pacote fornecedor: GPL (>= 2).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D27_savel_idades/.
#'
#' @examples
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   dados <- carregar_dados("idades_savel_repetibilidade")
#'   summary(dados)
#' }
#'
#' @name idades_savel_repetibilidade
#' @keywords datasets
NULL
