#' D52 - Paciente: peso durante programa de redução
#'
#' Dados provisórios da passada 1. Unidade amostral: medição ao longo do tempo de um único paciente.
#'
#' @format Um `data.frame` com 52 linhas e 2 colunas:
#' \describe{
#'   \item{dias}{Dias desde o início do programa, incluindo tempos repetidos.}
#'   \item{peso_kg}{Peso do paciente em quilogramas.}
#' }
#'
#' @details
#' São 52 medições de um único paciente durante 246 dias; não são 52 pacientes independentes. Dias repetidos preservados. Não inferir efeito causal do programa ou generalizar a outros pacientes. Sem detalhes clínicos adicionais na ajuda. Candidato prioritário à substituição por série de crescimento ou perda de massa em contexto aquático, preservando a finalidade de ajuste não linear.
#'
#' @section Adaptações:
#' Days → dias; Weight → peso_kg.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @source
#' Dr. T. Davies, Adelaide; Venables e Ripley (2002), Modern Applied Statistics with S.; MASS::wtloss.
#' Licença: GPL-2 | GPL-3, MASS 7.3-65.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D52_paciente_peso/.
#'
#' @examples
#' summary(paciente_peso)
#'
#' @docType data
#' @keywords datasets
"paciente_peso"
