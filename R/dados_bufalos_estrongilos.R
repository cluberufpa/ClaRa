#' D12 - Búfalos-africanos: ovos de estrongilídeos
#'
#' Presença de ovos de estrongilídeos antes e depois de fenbendazol em
#' búfalos-africanos identificados. A cópia mantém as linhas sem par para que
#' o preparo longo → largo faça parte do exercício de McNemar.
#'
#' @format Um `data.frame` com 418 linhas e 6 colunas:
#' \describe{
#'   \item{id_bufalo}{Texto: identificador do búfalo.}
#'   \item{id_captura}{Texto: identificador original da captura.}
#'   \item{tratamento}{Fator: controle ou fenbendazol.}
#'   \item{momento}{Fator: antes ou depois da intervenção.}
#'   \item{presenca_ovos_estrongilos}{Inteiro: 0 ausente, 1 presente; seis NA basais.}
#'   \item{dias_apos_intervencao}{Inteiro: 0 antes e 25 a 180 depois.}
#' }
#'
#' @details São 216 observações basais e 202 recapturas; 196 búfalos têm os
#' dois resultados disponíveis. Para cada animal, foi escolhida a primeira
#' recaptura com resultado válido até 180 dias, sem misturar redoses posteriores.
#' Não tratar as 418 linhas como animais independentes. A ausência de pós válido
#' não identifica morte, emigração ou outro motivo.
#'
#' @section Adaptações:
#' Tradução e recorte didático da receita `EAPADados::bufalos_estrongilos`.
#' Linhas sem par e seis respostas basais ausentes foram preservadas. Substitui
#' `bacterias_tratamento` (`MASS::bacteria`), reutilizando D12.
#'
#' @source Ezenwa, V. O.; Jolles, A. E. (2015). *Science*.
#' \doi{10.1126/science.1261714}. Dados Dryad/Zenodo:
#' \doi{10.5061/dryad.q2m38}, licença CC0 1.0, conferida em 12/10/2026.
#' Fontes e preparo: `data-raw/D12_bufalos_estrongilos/`.
#'
#' @examples
#' summary(bufalos_estrongilos)
#' @docType data
#' @keywords datasets
"bufalos_estrongilos"
