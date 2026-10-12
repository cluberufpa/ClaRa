#' D57 - Big Hill: amostras e esforço de pesca elétrica
#'
#' Dados provisórios da passada 1. Unidade amostral: amostra de pesca elétrica no reservatório Big Hill, maio de 2014.
#'
#' @format Um `data.frame` com 20 linhas e 4 colunas:
#' \describe{
#'   \item{id_amostra}{Texto do UID, chave única desta tabela e referência em bighill_peixes.}
#'   \item{data}{Data de coleta, classe Date, em maio de 2014.}
#'   \item{localizacao}{Texto do código loc original.}
#'   \item{esforco_min}{Esforço da amostra em minutos, 10 em todas as linhas.}
#' }
#'
#' @details
#' Vinte amostras, todas com 10 minutos de esforço; loc é código, não coordenada. UID permite relação com bighill_peixes; não unir nem repetir o esforço por peixe nesta base. Ao estimar CPUE, somar contagem por amostra antes de dividir pelo esforço; incluir amostras sem captura da espécie. Datas da fonte em mês/dia/ano. Relação entre as tabelas e eventual agregação ficam para o exercício, sem criar um conjunto derivado na passada 1.
#'
#' @section Adaptações:
#' UID → id_amostra; date → data; loc → localizacao; effort → esforco_min. id_amostra em texto, mantendo códigos e ausências originais. localizacao em texto, mantendo códigos e ausências originais. data convertido de mês/dia/ano para Date, sem perda de datas.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @section Leitura do pacote:
#' Adaptado de `FSAdata::BGHRsample`, versão 0.4.1. Autoria do pacote: Derek Ogle.
#' As observações são lidas na hora por `carregar_dados("bighill_amostras")`.
#' Não há cópia deste conjunto em data/ da ClaRa.
#'
#' @source
#' Dados obtidos diretamente de Ben Neely; Introductory Fisheries Analyses with R; FSAdata::BGHRsample.
#' Licença do pacote fornecedor: GPL (>= 2).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D57_bighill_amostras/.
#'
#' @examples
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   dados <- carregar_dados("bighill_amostras")
#'   summary(dados)
#' }
#'
#' @name bighill_amostras
#' @keywords datasets
NULL
