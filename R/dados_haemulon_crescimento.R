#' D54 - Haemulon plumierii: idade, comprimento e sexo
#'
#' Dados provisórios da passada 1. Unidade amostral: ponto reconstruído aproximadamente de figura de idade e comprimento.
#'
#' @format Um `data.frame` com 465 linhas e 3 colunas:
#' \describe{
#'   \item{idade_anos}{Idade obtida de otólitos, em anos, reconstruída aproximadamente com precisão de 0,1.}
#'   \item{comprimento_total_mm}{Comprimento total em milímetros, reconstruído de figura.}
#'   \item{sexo}{Fator: femea ou macho, segundo a fonte.}
#' }
#'
#' @details
#' 465 pontos reconstruídos aproximadamente da figura 6, conforme a ajuda. Não apresentar como planilha bruta individual dos autores nem como dados sintéticos simulados. A precisão de 0,1 ano e os comprimentos refletem a reconstrução; revisar digitalização antes de interpretar erros finos ou repetidos. Confirmar fonte primária e preferir dados originais do estudo se disponíveis. Contexto pesqueiro adequado, embora distribuído por pacote.
#'
#' @section Adaptações:
#' age → idade_anos; tl → comprimento_total_mm; sex → sexo. Categorias de sexo: female → femea, male → macho.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @section Leitura do pacote:
#' Adaptado de `FSAdata::WhiteGrunt2`, versão 0.4.1. Autoria do pacote: Derek Ogle.
#' As observações são lidas na hora por `carregar_dados("haemulon_crescimento")`.
#' Não há cópia deste conjunto em data/ da ClaRa.
#'
#' @source
#' Araujo e Martins (2007), Age, growth and mortality of white grunt (Haemulon plumierii) from the central coast of Brazil, Scientia Marina 71:793–800, figura 6; FSAdata::WhiteGrunt2.
#' Licença do pacote fornecedor: GPL (>= 2).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D54_haemulon_crescimento/.
#'
#' @examples
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   dados <- carregar_dados("haemulon_crescimento")
#'   summary(dados)
#' }
#'
#' @name haemulon_crescimento
#' @keywords datasets
NULL
