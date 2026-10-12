#' D55 - Cabezon: comprimento, idade e maturidade de fêmeas
#'
#' Dados provisórios da passada 1. Unidade amostral: fêmea de Scorpaenichthys marmoratus coletada no Oregon.
#'
#' @format Um `data.frame` com 525 linhas e 5 colunas:
#' \describe{
#'   \item{data}{Data de coleta, classe Date; origem em mês/dia/ano.}
#'   \item{comprimento_total_cm}{Comprimento total em centímetros.}
#'   \item{idade}{Idade estimada por otólito, unidade em anos a confirmar; 226 ausências preservadas.}
#'   \item{maturidade}{Fator: imatura, madura ou desconhecida; esta última não vira NA nem resposta binária.}
#'   \item{estagio_maturidade}{Código original: 1 imatura, 2 em maturação, 3 madura, 4 fertilizada, 5 pronta, 6 esgotada, 7 em repouso; interpretação a revisar.}
#' }
#'
#' @details
#' Dados declarados obtidos diretamente dos pesquisadores, relativos apenas a fêmeas de Newport e Depoe Bay, Oregon. Preservados 226 valores ausentes de idade e categoria Unknown (desconhecida) de maturidade, que a descrição resumida não lista. Não codificar desconhecida como imatura ou madura nem excluir da base; selecionar respostas conhecidas no ramo logístico. Datas lidas como mês/dia/ano. Estágios 1 a 7 mantidos como códigos; não converter automaticamente em escala contínua. Confirmar unidade da idade em anos na fonte e seleção de indivíduos com leitura de otólito.
#'
#' @section Adaptações:
#' date → data; length → comprimento_total_cm; age → idade; maturity → maturidade; stage → estagio_maturidade. data convertido de mês/dia/ano para Date, sem perda de datas. Categorias de maturidade: Immature → imatura, Mature → madura, Unknown → desconhecida.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @section Leitura do pacote:
#' Adaptado de `FSAdata::Cabezon`, versão 0.4.1. Autoria do pacote: Derek Ogle.
#' As observações são lidas na hora por `carregar_dados("cabezon_maturidade")`.
#' Não há cópia deste conjunto em data/ da ClaRa.
#'
#' @source
#' Hannah, Blume e Thompson (2009), Length and age at maturity of female yelloweye rockfish and cabezon from Oregon waters based on histological evaluation of maturity, ODFW Information Reports 2009-04; dados obtidos de Bob Hanna, conforme FSAdata::Cabezon.
#' Licença do pacote fornecedor: GPL (>= 2).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D55_cabezon_maturidade/.
#'
#' @examples
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   dados <- carregar_dados("cabezon_maturidade")
#'   summary(dados)
#' }
#'
#' @name cabezon_maturidade
#' @keywords datasets
NULL
