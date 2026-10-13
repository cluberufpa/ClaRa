#' D46 - Lagosta-verde: CPUE e esforço de pesca
#'
#' Captura por unidade de esforço (CPUE) e esforço de pesca com covos do estoque
#' da lagosta-verde (*Panulirus laevicauda*), em 14 períodos de pesca. É o
#' exercício 11.1 de Ivo e Fonteles Filho (1997): verificar se a CPUE cai com o
#' esforço e, nesse caso, ajustar o modelo exponencial \eqn{y = A e^{-bx}}.
#'
#' @format Um `data.frame` com 14 linhas (uma por período) e 2 colunas:
#' \describe{
#'   \item{esforco_mil_covo_dia}{Esforço de pesca, em milhares de covos-dia.}
#'   \item{cpue_kg_covo_dia}{CPUE, em kg por covo-dia.}
#' }
#'
#' @details O modelo exponencial vira uma reta com o logaritmo da CPUE:
#' \eqn{\ln y = \ln A - bx}. Ajustada às 14 linhas, a reta dá \eqn{b = 0,052} por
#' mil covos-dia e \eqn{R^2 = 0,94}; a correlação de Pearson entre CPUE e esforço,
#' sem logaritmo, é \eqn{-0,92}. É a forma do modelo de produção de Fox, usado na
#' avaliação de estoques. Compare com a reta sem logaritmo: a CPUE cai depressa
#' com pouco esforço e quase se estabiliza depois, o que a reta não acompanha.
#'
#' O livro não diz a que anos nem a que local correspondem as linhas; a ordem é a
#' do livro e pode não ser cronológica. Os períodos não são independentes no
#' tempo: trate os valores de p como aproximados.
#'
#' @section Adaptações:
#' Tabela do exercício transcrita sem alteração de valores, com nomes de colunas
#' que dizem a unidade. As colunas vazias do livro, para o aluno preencher
#' (\eqn{\ln y}, \eqn{x^2}, \eqn{y'^2}, \eqn{xy'}), não entraram. Ocupa o D46,
#' antes `carros_frenagem`, que também servia para comparar a reta com uma curva.
#'
#' @source Ivo, C. T. C.; Fonteles Filho, A. A. (1997). *Estatística pesqueira:
#' aplicação em Engenharia de Pesca*. Fortaleza: Tom Gráfica e Editora. Exercício
#' 11.1. Uso didático com citação da obra, sem termo de consentimento
#' (decisão do professor, 13/10/2026). Cite o livro ao usar os dados. Fonte e preparo em
#' `data-raw/D46_lagosta_esforco/`.
#'
#' @examples
#' lagosta <- lagosta_cpue_esforco
#' lagosta$ln_cpue <- log(lagosta$cpue_kg_covo_dia)
#' fox <- lm(ln_cpue ~ esforco_mil_covo_dia, data = lagosta)
#' c(A = exp(coef(fox)[[1]]), b = -coef(fox)[[2]])
#' @docType data
#' @keywords datasets
"lagosta_cpue_esforco"
