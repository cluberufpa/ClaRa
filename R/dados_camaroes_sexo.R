#' D19 - Camarões: distribuição por sexo e espécie
#'
#' Dados provisórios da passada 1. Unidade amostral: indivíduo representado por uma linha.
#'
#' @format Um `data.frame` com 170 linhas e 2 colunas:
#' \describe{
#'   \item{sexo}{Fator: fêmea ou macho.}
#'   \item{especie}{Rótulo taxonômico original P.brasiliensis ou P.schimitti, pendente de conferência.}
#' }
#'
#' @details
#' Completar referência do livro e autorização. Nomes científicos P.brasiliensis e P.schimitti preservados: confirmar grafia e identificação antes de expandir gênero. As 166 linhas repetidas representam indivíduos, não exclusões automáticas.
#'
#' @section Adaptações:
#' Decisão anterior aprovada: Fêmea/Macho → fêmea/macho. Rótulos de espécie e 170 linhas preservados, inclusive as 166 repetidas.
#'
#' @source
#' Livro ainda não identificado na documentação herdada.
#' Licença: Dados de livro; referência e autorização pendentes.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D19_camaroes_sexo/.
#'
#' @examples
#' summary(camaroes_sexo)
#'
#' @docType data
#' @keywords datasets
"camaroes_sexo"
