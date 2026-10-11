#' D09 - Tilápia: avaliação sensorial de filés
#'
#' Seis notas de 122 avaliadores sobre aroma e sabor de filés de tilápia
#' submetidos a controle, Lippia alba e Ocimum americanum. Dados reais,
#' provisórios na passada 1; a escala observada vai de -3 a +3, mas seus
#' significados e seu sentido ainda precisam ser confirmados no protocolo.
#'
#' @format Um `data.frame` com 122 linhas e 7 colunas:
#' \describe{
#'   \item{id_avaliador}{Texto: identificador do avaliador.}
#'   \item{aroma_controle}{Inteiro: nota de aroma do controle, de -3 a +3.}
#'   \item{aroma_lippia}{Inteiro: nota de aroma sob Lippia alba, de -3 a +3.}
#'   \item{aroma_ocimum}{Inteiro: nota de aroma sob Ocimum americanum, de -3 a +3.}
#'   \item{sabor_controle}{Inteiro: nota de sabor do controle, de -3 a +3.}
#'   \item{sabor_lippia}{Inteiro: nota de sabor sob Lippia alba, de -3 a +3.}
#'   \item{sabor_ocimum}{Inteiro: nota de sabor sob Ocimum americanum, de -3 a +3.}
#' }
#'
#' @details
#' Adaptado da fonte organizada `tilapia_sensorial_organizada.xlsx`, aba
#' sensorial. Todas as 122 linhas, sete cabeçalhos, notas e ordem foram
#' preservados. O identificador foi armazenado como texto, e as notas como
#' inteiros. Nenhuma exclusão, imputação, renomeação ou conversão de escala.
#' A fonte organizada e sua documentação estão congeladas em
#' `data-raw/D09_tilapia_sensorial/fonte/`, com SHA256.
#'
#' Cada linha é um avaliador; as três notas do mesmo atributo são pareadas.
#' Analisar aroma e sabor separadamente. A fonte está em formato largo;
#' empilhar é parte do exercício de preparo para análises de medidas repetidas.
#' Não tratar as seis colunas como grupos independentes nem afirmar que
#' valores maiores representam maior aceitação antes de confirmar a escala.
#'
#' @source
#' Rucinque, D. S.; Viegas, E. M. M.; Lapa-Guimarães, J.; Ferreira, P. F.;
#' Leme, P. R. P. (2020). Data for: Ocimum americanum and Lippia alba
#' essential oils as anaesthetics for Nile tilapia: Induction, recovery
#' of apparent unconsciousness and sensory analysis of fillets.
#' Mendeley Data, versão 5. DOI: 10.17632/knsz9r4vby.5.
#' Artigo: DOI 10.1016/j.aquaculture.2020.735902.
#' Licença dos dados: CC BY 4.0, com atribuição e indicação das adaptações.
#' A licença MIT do código da ClaRa não substitui a licença dos dados.
#'
#' @examples
#' # Conferir as notas antes de preparar a comparação pareada.
#' summary(tilapia_sensorial)
#'
#' @docType data
#' @keywords datasets
"tilapia_sensorial"
