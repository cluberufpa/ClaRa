#' D38 - Truta-de-riacho: ração, temperatura e crescimento
#'
#' Dados provisórios da passada 1. Unidade amostral: peixe individual agrupado em tanque.
#'
#' @format Um `data.frame` com 69 linhas e 8 colunas:
#' \describe{
#'   \item{id_peixe}{Identificador do peixe (texto).}
#'   \item{tanque}{Fator: tanque experimental (agrupamento; possível pseudorrepetição).}
#'   \item{crescimento_especifico_pct_dia}{Numérico: taxa de crescimento específico (% por dia). Variável resposta.}
#'   \item{temperatura_c}{Inteiro: temperatura da água (°C).}
#'   \item{racao_g}{Numérico: ração fornecida (g).}
#'   \item{massa_inicial_g}{Numérico: massa inicial do peixe (g).}
#'   \item{eficiencia_conversao}{Numérico: eficiência de conversão alimentar.}
#'   \item{racao_fator}{Fator: nível de ração (\code{high}, \code{low}).}
#' }
#'
#' @details
#' Preservado o subconjunto herdado de 69 peixes, já sem ração zero. Ração/temperatura são compartilhadas por tanque: não tratar os 69 indivíduos como réplicas independentes dos tratamentos. Confirmar alocação e número de tanques por combinação. eficiencia_conversao pode incorporar a própria resposta; não a usar como preditor sem revisar a fórmula. high/low preservados, tradução ainda pendente.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores e ordem herdados preservados; nenhuma exclusão nova.
#'
#' @source
#' Rutledge, Nislow, Fuller, McCormick, Chen e Chadwick (2025), Dryad, DOI 10.5061/dryad.v6wwpzh86.
#' Licença: CC0-1.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D38_truta_crescimento/.
#'
#' @examples
#' summary(truta_riacho_crescimento)
#'
#' @docType data
#' @keywords datasets
"truta_riacho_crescimento"
