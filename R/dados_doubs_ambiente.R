#' D04 - Doubs: ambiente e riqueza de peixes
#'
#' @description
#' Variáveis ambientais medidas em 30 estações ao longo do rio Doubs
#' (Jura francês), acompanhadas da riqueza de espécies de peixes e da
#' classificação de cada estação em trechos do curso (alto, médio, baixo e
#' trecho impactado). É a base clássica dos livros de ecologia numérica
#' (Borcard, Gillet e Legendre, 2018), ideal para a \strong{análise de
#' componentes principais (PCA)} padronizada e para exercícios de
#' \strong{agrupamento hierárquico (HCA)}.
#'
#' @format Um data frame com 30 observações e 13 variáveis. Os nomes das
#' linhas identificam as estações (\code{E01} a \code{E30}, da nascente para
#' a foz). As variáveis ambientais vêm do dataset \code{doubs} do pacote
#' \pkg{ade4}:
#' \describe{
#'   \item{dfs}{Numérico: distância da nascente, na escala original km × 10.}
#'   \item{alt}{Numérico: altitude (m).}
#'   \item{slo}{Numérico: ln(x + 1), com x = declividade (por mil × 100).}
#'   \item{flo}{Numérico: vazão mínima média, na escala original m³/s × 100.}
#'   \item{pH}{Numérico: pH da água multiplicado por 10, na escala original.}
#'   \item{har}{Numérico: dureza total da água (mg/L de cálcio), conforme ade4.}
#'   \item{pho}{Numérico: fosfatos na escala original mg/L × 100.}
#'   \item{nit}{Numérico: nitratos na escala original mg/L × 100.}
#'   \item{amm}{Numérico: nitrogênio amoniacal na escala original mg/L × 100.}
#'   \item{oxy}{Numérico: oxigênio dissolvido na escala original mg/L × 10.}
#'   \item{bdo}{Numérico: demanda biológica de oxigênio na escala original mg/L × 10.}
#'   \item{riqueza}{Inteiro: número de espécies de peixes presentes na
#'     estação (derivada da tabela de abundâncias \code{doubs$fish}).}
#'   \item{trecho}{Fator: trecho do rio, com níveis \code{Alto curso},
#'     \code{Médio curso}, \code{Baixo curso} e \code{Trecho impactado}.}
#' }
#'
#' @details
#' Pergunta sugerida: como as variáveis ambientais se estruturam ao longo do
#' rio? Faça uma PCA padronizada das 11 variáveis ambientais (colunas 1 a 11),
#' deixando \code{riqueza} e \code{trecho} como variáveis suplementares, e
#' projete as estações coloridas por trecho. Compare quantos componentes reter
#' pelo bastão quebrado, pela permutação e pelo critério de Kaiser (este
#' último apenas como referência). O trecho \code{Trecho impactado} tem só
#' duas estações (\code{E23} e \code{E25}): com menos de três pontos não se
#' estima elipse de concentração.
#'
#' Cuidados: as variáveis têm escalas muito diferentes (a altitude vai a mais
#' de 900 m, o pH está armazenado multiplicado por 10), então a PCA deve ser \strong{padronizada}
#' (correlação, não covariância). O sinal dos eixos é arbitrário; leia os
#' resultados pela direção e pela magnitude relativa das setas, não pelo
#' quadrante isolado. As variáveis ambientais são fortemente correlacionadas
#' entre si ao longo do gradiente do rio — a interpretação dos componentes
#' deve considerar esse padrão conjunto, e não cada variável isolada.
#'
#' @source Verneaux, J. (1973). \emph{Cours d'eau de Franche-Comté (massif du
#'   Jura). Recherches écologiques sur le réseau hydrographique du Doubs.
#'   Essai de biotypologie}. Annales Scientifiques de l'Université de
#'   Franche-Comté 3:1-260. Obtido do pacote \pkg{ade4} (dataset
#'   \code{doubs}, componente \code{env}), licença GPL-2 | GPL-3, na
#'   montagem usada por Borcard, Gillet e Legendre (2018), \emph{Numerical
#'   Ecology with R}, 2ª ed., Springer.
#'
#' @section Migração para a ClaRa:
#' Adaptado de `EAPADados::doubs_ambiente`. Passada 1: conjunto provisório. Todas as linhas, ordem, colunas e ausências preservadas; nenhuma imputação, filtro novo ou conversão de unidade. O texto herdado descreve adaptações anteriores do EAPADados, que não foram repetidas.
#'
#' **Escalas:** as descrições de unidades foram conferidas e corrigidas pela ajuda original de ade4 1.7-24; os valores não foram convertidos.
#'
#' @section Licença da origem:
#' GPL (>= 2), conforme ade4 1.7-24; não relicenciado como MIT. A licença MIT do código da ClaRa não substitui a licença destes dados.
#'
#' @section Pendências para a curadoria:
#' Conferir escalas: pH está multiplicado por 10; não interpretar as demais colunas em unidades físicas antes de conferir seus fatores de escala. Preservar estações E01-E30 nos rownames nesta passada; propor coluna de identificação na passada 2. Preservar licença da origem.
#'
#' Preparo e fonte congelada: `data-raw/D04_doubs_ambiente/`.
#'
#' @docType data
#' @keywords datasets
#' @examples
#' summary(doubs_ambiente)
"doubs_ambiente"
