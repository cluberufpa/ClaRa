#' D50 - Escolares: dias de ausência em Walgett
#'
#' Dados provisórios da passada 1. Unidade amostral: criança com número de dias ausente em um ano escolar.
#'
#' @format Um `data.frame` com 146 linhas e 5 colunas:
#' \describe{
#'   \item{origem_cultural}{Classificação histórica da fonte: aborigene ou nao_aborigene, sem interpretação causal.}
#'   \item{sexo}{Fator: feminino ou masculino, segundo a fonte.}
#'   \item{etapa_escolar}{Etapa escolar: primario (F0) ou códigos F1, F2, F3; não idade numérica.}
#'   \item{classe_aprendizagem}{Classificação histórica: aprendizagem_media ou aprendizagem_lenta; não diagnóstico.}
#'   \item{dias_ausencia}{Número de dias ausente no ano escolar observado.}
#' }
#'
#' @details
#' Dados observacionais históricos de Walgett, Nova Gales do Sul; classificações culturais e de aprendizagem são as da fonte, não diagnósticos atuais nem medidas de capacidade. Não interpretar associações como efeitos causais de origem cultural. Age é etapa escolar, não idade em anos. Confirmar equivalência de forms F1/F2/F3 antes de tradução adicional. Não há número de dias de exposição por criança; não inventar offset.
#'
#' @section Adaptações:
#' Eth → origem_cultural; Sex → sexo; Age → etapa_escolar; Lrn → classe_aprendizagem; Days → dias_ausencia. Categorias de origem_cultural: A → aborigene, N → nao_aborigene. Categorias de sexo: F → feminino, M → masculino. Categorias de etapa_escolar: F0 → primario, F1 → F1, F2 → F2, F3 → F3. Categorias de classe_aprendizagem: AL → aprendizagem_media, SL → aprendizagem_lenta. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.
#'
#' @source
#' S. Quine, citado em Aitkin (1978), The analysis of unbalanced cross classifications, Journal of the Royal Statistical Society A 141:195–223; Venables e Ripley (2002); MASS::quine.
#' Licença: GPL-2 | GPL-3, conforme MASS 7.3-65.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D50_escolares_ausencias/.
#'
#' @examples
#' summary(escolares_ausencias)
#'
#' @docType data
#' @keywords datasets
"escolares_ausencias"
