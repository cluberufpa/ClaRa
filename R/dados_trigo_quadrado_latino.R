#' D60 - Trigo: operadores em quadrado latino
#'
#' Dados provisórios da passada 1. Unidade amostral: medição em combinação de parcela, sequência e operador do quadrado latino.
#'
#' @format Um `data.frame` com 36 linhas e 4 colunas:
#' \describe{
#'   \item{linha}{Código original da linha no quadrado, de 1 a 6; significado a confirmar.}
#'   \item{coluna}{Código original da coluna no quadrado, de 1 a 6; significado a confirmar.}
#'   \item{operador}{Código original a a f do operador.}
#'   \item{diferenca_altura}{Altura medida menos altura verdadeira; unidade não informada, negativos preservados.}
#' }
#'
#' @details
#' Seis parcelas de trigo, seis operadores, seis sequências ordenadas; resposta é diferença entre altura medida e verdadeira, não altura nem produção bruta. Preservados valores negativos. Unidade da diferença, interpretação exata de linha/coluna e randomização não informadas na ajuda: confirmar no livro. linha e coluna são códigos numéricos; usar como fatores de blocagem na análise, não tendências quantitativas. Candidato à substituição por experimento de quadrado latino em contexto aquático, preservando dois fatores de blocagem e tratamento.
#'
#' @section Adaptações:
#' row → linha; col → coluna; operator → operador; diff → diferenca_altura.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @source
#' Cochran e Cox (1957), Experimental Designs, 2ª ed., Wiley; agridat::cochran.latin.
#' Licença: MIT + file LICENSE, agridat 1.26.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D60_trigo_quadrado/.
#'
#' @examples
#' summary(trigo_quadrado_latino)
#'
#' @docType data
#' @keywords datasets
"trigo_quadrado_latino"
