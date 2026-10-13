#' D60 - Suínos: idade de castração em quadrados latinos repetidos
#'
#' Ganho de peso de leitões aos 252 dias sob quatro idades de castração, em
#' dois quadrados latinos 4 x 4. Em cada quadrado, as linhas são leitegadas e
#' as colunas são posições de peso inicial dentro de cada leitegada. Cada
#' tratamento ocorre uma vez em cada linha e em cada coluna.
#'
#' @format Um `data.frame` com 32 linhas e 5 colunas:
#' \describe{
#'   \item{quadrado}{Fator: primeiro ou segundo experimento.}
#'   \item{leitegada}{Fator: leitegada, aninhada no quadrado.}
#'   \item{posicao_peso_inicial}{Fator: posição do leitão no ordenamento por peso inicial dentro da leitegada.}
#'   \item{tratamento}{Fator: A, B, C ou D; as idades de castração são descritas nos detalhes.}
#'   \item{ganho_peso_kg}{Ganho de peso, em kg, ao final de 252 dias; variável de resposta.}
#' }
#'
#' @details Os tratamentos são A = castração aos 56 dias; B = inteiro, não
#' castrado; C = castração aos 7 dias; e D = castração aos 21 dias. O primeiro
#' quadrado reúne as leitegadas 1 a 4 e o segundo, as leitegadas 5 a 8.
#'
#' Como as leitegadas e os pesos iniciais são diferentes nos dois experimentos,
#' a análise conjunta é o caso 3 de quadrados latinos repetidos. Um modelo
#' compatível é `aov(ganho_peso_kg ~ tratamento + quadrado +
#' quadrado:leitegada + quadrado:posicao_peso_inicial, data = suinos_castracao)`.
#' O livro informa, para a análise conjunta, F = 5,77 e p = 0,0079 para
#' tratamento, com 15 graus de liberdade residuais; A tem ganho médio menor
#' que B, C e D.
#'
#' A coluna de peso inicial é uma posição ordinal, não uma medida de peso. Ela
#' serve ao bloqueio; não deve ser interpretada como uma covariável contínua.
#' A fonte não descreve a randomização nem identifica a base primária; portanto,
#' este é um conjunto didático reconstruído fielmente das tabelas publicadas.
#'
#' @source Costa, S. *Estatística Experimental com o uso do software R*, cap.
#' 5, Tabelas 5.1, 5.6 e 5.8. Dados transcritos para uso didático; a fonte
#' primária e a licença de redistribuição não são informadas no livro.
#'
#' @examples
#' summary(aov(ganho_peso_kg ~ tratamento + quadrado +
#'   quadrado:leitegada + quadrado:posicao_peso_inicial,
#' data = suinos_castracao))
#' @docType data
#' @keywords datasets
"suinos_castracao"
