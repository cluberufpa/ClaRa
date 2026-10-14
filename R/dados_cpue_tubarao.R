#' D03 - Tubarão: CPUE por embarcação e data
#'
#' @description
#' Captura por unidade de esforço (CPUE) de tubarão registrada por embarcação,
#' mês e ano, entre 1995 e 2007. **Dados reais próprios**, conforme declaração do professor.
#' É um conjunto de dupla utilidade no ecossistema EAPA: serve de exemplo
#' canônico para o **teste de Kruskal-Wallis** (comparar a CPUE entre os anos,
#' com pós-teste de Dunn e letras de significância) e para **análise de série
#' temporal** (CPUE ao longo do tempo, via a coluna `data`). A CPUE varia
#' fortemente entre os anos, com tendência de queda ao longo do período.
#'
#' @format A data frame with 424 observations and 5 variables:
#' \describe{
#'   \item{embarcacao}{Embarcação (factor; *MB*, *MC*, *SB*).}
#'   \item{ano}{Ano do registro (integer; 1995 a 2007).}
#'   \item{mes}{Mês do registro (integer; 1 a 12).}
#'   \item{cpue}{Captura por unidade de esforço (numeric).}
#'   \item{data}{Data do registro (Date).}
#' }
#'
#' @source Dados próprios de monitoramento pesqueiro, publicados em outro formato,
#' conforme declaração do professor em 11/10/2026; referência a completar.
#'
#' @section Migração para a ClaRa:
#' Adaptado de `EAPADados::cpue_tubarao`. Passada 1: conjunto provisório. Todas as linhas, ordem, colunas e ausências preservadas; nenhuma imputação, filtro novo ou conversão de unidade. O texto herdado descreve adaptações anteriores do EAPADados, que não foram repetidas.
#'
#' @section Licença da origem:
#' Uso interno na Trilha e na ClaRa autorizado pelo professor em 12/10/2026; dados próprios do professor, sem licença pública. A licença MIT do código da ClaRa não substitui a licença destes dados.
#'
#' @section Pendências para a curadoria:
#' Procedência própria confirmada. Completar referência bibliográfica, créditos, licença específica, unidade da CPUE e independência. Colunas renomeadas em 12/10/2026 (embarcacao, ano, mes, cpue, data), sem alterar valores.
#'
#' Preparo e fonte congelada: `data-raw/D03_tubarao_cpue/`.
#'
#' @docType data
#' @keywords datasets
#' @section Usos secundários:
#' Kruskal-Wallis: `comparar_medianas(cpue_tubarao, cpue, embarcacao)`
#' compara a CPUE das três embarcações. Os registros de uma embarcação ao
#' longo dos anos não são independentes; leia o valor de p como aproximado.
#'
#' @examples
#' summary(cpue_tubarao)
"cpue_tubarao"
