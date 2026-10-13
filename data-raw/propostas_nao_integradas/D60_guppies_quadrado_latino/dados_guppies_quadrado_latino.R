#' D60 - Guppies: coesão em quadrado latino 4 x 4
#'
#' Distância média ao vizinho mais próximo em grupos de guppies submetidos a
#' quatro combinações de temperatura e turbidez. As 16 linhas são médias de
#' células do quadrado latino, derivadas de 94 ensaios reais publicados.
#'
#' @format Um `data.frame` com 16 linhas e 5 colunas:
#' \describe{
#'   \item{grupo}{Fator: grupo de origem dos guppies (1 a 4); bloco de linhas.}
#'   \item{etapa}{Fator: etapa de teste (1 a 4); bloco de colunas.}
#'   \item{tratamento}{Fator: `controle`, `temperatura`, `turbidez` ou
#'     `temperatura_turbidez`.}
#'   \item{dist_vizinho_px}{Média da distância ao vizinho mais próximo, em
#'     pixels, nos ensaios daquela célula; resposta.}
#'   \item{n_ensaios}{Número de ensaios válidos usados na média: 5 ou 6.}
#' }
#'
#' @details Cada tratamento aparece uma vez em cada grupo e em cada etapa.
#' As condições-alvo no estudo foram 22 ou 29 graus Celsius e 0 ou 5 NTU.
#' Dois dos 96 ensaios planejados foram excluídos pelos autores por falha da
#' câmera; as 16 células ainda têm observações. Valores menores de distância
#' indicam peixes localmente mais próximos.
#'
#' A ANOVA de um quadrado latino sobre estas 16 médias é **apenas didática**.
#' O artigo analisou os 94 ensaios com modelos mistos e incluiu a estrutura
#' fatorial de temperatura e turbidez. O valor de p da ANOVA agregada não
#' reproduz os testes publicados nem substitui o modelo original. As células
#' com 5 e 6 ensaios recebem o mesmo peso nesta demonstração.
#'
#' @source Allibhai I, Zanghi C, How MJ, Ioannou CC (2023), *Ecology and
#' Evolution* 13:e9958, doi:10.1002/ece3.9958. Dados em Dryad,
#' doi:10.5061/dryad.j3tx95xjv, licença CC0 1.0. O arquivo-fonte e a receita
#' de agregação estão em `data-raw/D60_guppies_quadrado_latino/`.
#'
#' @examples
#' with(guppies_quadrado_latino, table(grupo, tratamento))
#' summary(aov(dist_vizinho_px ~ tratamento + grupo + etapa,
#'   data = guppies_quadrado_latino))
#' @docType data
#' @keywords datasets
"guppies_quadrado_latino"
