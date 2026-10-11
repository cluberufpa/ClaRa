#' D11 - Puromicina: concentração e velocidade de reação
#'
#' Dados provisórios da passada 1. Unidade amostral: medição de reação; um experimento por condição.
#'
#' @format Um `data.frame` com 23 linhas e 4 colunas:
#' \describe{
#'   \item{registro_original}{Texto: índice da linha na planilha fornecida, sem identificar unidade biológica.}
#'   \item{concentracao_ppm}{Concentração de substrato, em ppm.}
#'   \item{velocidade_contagens_min2}{Velocidade instantânea, em contagens/min/min.}
#'   \item{condicao}{Fator: com_puromicina ou sem_puromicina.}
#' }
#'
#' @details
#' Não presumir réplicas biológicas: um experimento por condição, seis concentrações distintas. Modelo logarítmico é aproximação empírica, sem assíntota. A retirada do índice da planilha fica para revisão.
#'
#' @section Adaptações:
#' `rownames` → `registro_original` (texto); `conc` → `concentracao_ppm`; `rate` → `velocidade_contagens_min2`; `state` → `condicao`; treated/untreated → com_puromicina/sem_puromicina. Índice preservado por ainda não haver aprovação de retirada.
#'
#' @source
#' Treloar (1974); Bates e Watts (1988), apêndice A1.3; datasets::Puromycin, R 4.6.1.
#' Licença: GPL-2 | GPL-3 da distribuição R; licença da origem preservada.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D11_puromicina_reacao/.
#'
#' @examples
#' summary(puromicina_reacao)
#'
#' @docType data
#' @keywords datasets
"puromicina_reacao"
