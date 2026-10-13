#' D42 - Artêmia: crescimento com duas rações
#'
#' Taxas de crescimento de *Artemia salina* com duas rações, dez valores por
#' ração. É o exercício 82 de Ivo e Fonteles Filho (1997): uma fábrica afirma, em
#' propaganda, que a ração de farelo de arroz (A) acelera o crescimento mais que a
#' de farelo de babaçu (B). O livro pede um teste t unilateral com
#' \eqn{\alpha = 0,05}.
#'
#' @format Um `data.frame` com 20 linhas e 2 colunas:
#' \describe{
#'   \item{racao}{Fator: `A` (farelo de arroz) ou `B` (farelo de babaçu), nessa ordem.}
#'   \item{taxa_crescimento_mg_dia}{Taxa de crescimento, em mg/dia.}
#' }
#'
#' @details As médias são 4,10 mg/dia (A) e 3,42 mg/dia (B). O teste t com
#' `alternativa = "maior"` responde à afirmação da fábrica; como `A` vem antes de
#' `B`, "maior" quer dizer A > B. O livro não descreve o experimento (quantos
#' animais, recipientes ou dias): cada valor é tratado como uma unidade
#' independente, como no exercício, e as conclusões valem para o exercício, não
#' como evidência sobre as rações.
#'
#' @section Adaptações:
#' Tabela do exercício transcrita sem alteração de valores. O antigo
#' `EAPADados::artemia` trazia só os sete primeiros valores de cada ração e se
#' dizia fictício; a fonte agora está identificada, e o conjunto tem as 20 linhas.
#' Ocupa o D42, antes `plantas_crescimento`.
#'
#' @source Ivo, C. T. C.; Fonteles Filho, A. A. (1997). *Estatística pesqueira:
#' aplicação em Engenharia de Pesca*. Fortaleza: Tom Gráfica e Editora. Exercício
#' 82. Obra com direitos reservados; valores transcritos para uso didático, com
#' autorização do professor. Cite o livro ao usar os dados. Fonte e preparo em
#' `data-raw/D42_artemia_racao/`.
#'
#' @examples
#' tapply(artemia_racao$taxa_crescimento_mg_dia, artemia_racao$racao, mean)
#' t.test(taxa_crescimento_mg_dia ~ racao, data = artemia_racao,
#'        alternative = "greater")
#' @docType data
#' @keywords datasets
"artemia_racao"
