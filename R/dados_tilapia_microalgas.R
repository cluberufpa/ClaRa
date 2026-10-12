#' D35 - Tilápia: dietas com microalgas
#'
#' Dados provisórios da passada 1. Unidade amostral: tanque experimental; 15 tanques, três por dieta.
#'
#' @format Um `data.frame` com 15 linhas e 32 colunas:
#' \describe{
#'   \item{id_tanque}{Identificador do tanque (texto, minúsculas).}
#'   \item{tratamento_codigo}{Fator: código do tratamento/réplica (ex.: \code{CR1}, \code{N25R2}).}
#'   \item{tipo_microalga}{Fator: \code{controle}, \code{nannochloropsis}, \code{tetraselmis}.}
#'   \item{nivel_substituicao_pct}{Inteiro: nível de substituição por microalga (%).}
#'   \item{repeticao}{Inteiro: número da réplica.}
#'   \item{sgr_pct_dia}{Numérico: taxa de crescimento específico (% por dia). Resposta.}
#'   \item{sobrevivencia_pct}{Numérico: sobrevivência (%).}
#'   \item{peso_inicial_medio_g}{Numérico: peso médio inicial (g).}
#'   \item{peso_final_medio_g}{Numérico: peso médio final (g).}
#'   \item{peixes_estocados}{Inteiro: peixes estocados no tanque.}
#'   \item{peixes_colhidos}{Inteiro: peixes colhidos no tanque.}
#'   \item{temperatura_c}{Numérico: temperatura da água (°C).}
#'   \item{oxigenio_dissolvido_mg_l}{Numérico: oxigênio dissolvido (mg/L).}
#'   \item{ph}{Numérico: pH da água.}
#'   \item{tan_mg_l}{Numérico: nitrogênio amoniacal total (mg/L).}
#'   \item{no2_n_mg_l}{Numérico: nitrogênio de nitrito (mg/L).}
#'   \item{srp_mg_l}{Numérico: fósforo reativo solúvel (mg/L).}
#'   \item{rbc_10_6_ul}{Numérico: eritrócitos (10^6/µL).}
#'   \item{hemoglobina_g_dl}{Numérico: hemoglobina (g/dL).}
#'   \item{pcv_pct}{Numérico: hematócrito (%).}
#'   \item{wbc_10_3_ul}{Numérico: leucócitos (10^3/µL).}
#'   \item{linfocitos_pct}{Numérico: linfócitos (%).}
#'   \item{plaquetas_10_3_ul}{Numérico: plaquetas (10^3/µL).}
#'   \item{proteina_total_g_dl}{Numérico: proteína total sérica (g/dL).}
#'   \item{albumina_g_dl}{Numérico: albumina (g/dL).}
#'   \item{globulina_g_dl}{Numérico: globulina (g/dL).}
#'   \item{razao_albumina_globulina}{Numérico: razão albumina/globulina.}
#'   \item{glicose_mg_dl}{Numérico: glicose (mg/dL).}
#'   \item{triglicerideos_mg_dl}{Numérico: triglicerídeos (mg/dL).}
#'   \item{colesterol_mg_dl}{Numérico: colesterol (mg/dL).}
#'   \item{ureia_mg_dl}{Numérico: ureia (mg/dL).}
#'   \item{bun_mg_dl}{Numérico: nitrogênio ureico sanguíneo (mg/dL).}
#' }
#'
#' @details
#' Há apenas 15 tanques; tratamento_codigo inclui a réplica e não define os cinco tratamentos sozinho. Não ajustar modelo múltiplo extenso com todas as respostas. Confirmar siglas e unidades no depósito primário e avaliar derivados/colinearidade. Não aplicadas exclusões e traduções ainda pendentes.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores e ordem herdados preservados; nenhuma exclusão nova.
#'
#' @source
#' Amira et al. (2021), Mendeley Data, DOI 10.17632/hv5fg5r869.1.
#' Licença: CC BY 4.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D35_tilapia_microalgas/.
#'
#' @examples
#' summary(tilapia_microalgas)
#'
#' @docType data
#' @keywords datasets
"tilapia_microalgas"
