#' D26 - Gammarus: resumo por dieta e temperatura
#'
#' Dados provisórios da passada 1. Unidade amostral: combinação de dieta e temperatura; médias, desvios-padrão e n, não réplicas.
#'
#' @format Um `data.frame` com 12 linhas e 11 colunas:
#' \describe{
#'   \item{dieta}{Fator: Fucus, folhas de cenoura ou polpa de coco.}
#'   \item{temperatura_c}{Numérico: temperatura experimental (°C).}
#'   \item{n_repeticoes}{Inteiro: número de recipientes por combinação (4).}
#'   \item{sobrevivencia_media_pct}{Numérico: média da sobrevivência (%).}
#'   \item{sobrevivencia_dp_pct}{Numérico: desvio-padrão da sobrevivência (%).}
#'   \item{biomassa_media_mg}{Numérico: média da biomassa final (mg).}
#'   \item{biomassa_dp_mg}{Numérico: desvio-padrão da biomassa final (mg).}
#'   \item{comprimento_final_medio_mm}{Numérico: média do comprimento final (mm).}
#'   \item{comprimento_final_dp_mm}{Numérico: desvio-padrão do comprimento final (mm).}
#'   \item{taxa_crescimento_especifica_media_pct_dia}{Numérico: média da taxa de crescimento específico (% por dia).}
#'   \item{taxa_crescimento_especifica_dp_pct_dia}{Numérico: desvio-padrão da taxa de crescimento específico (% por dia).}
#' }
#'
#' @details
#' Tabela agregada: não inventar os 48 valores individuais nem recalcular ANOVA e diagnósticos como se 12 médias fossem réplicas. Revisar transcrição da tabela do artigo na passada 2. Categorias herdadas preservadas.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.
#'
#' @source
#' Ribes-Navarro et al. (2022), Frontiers in Marine Science 9:931991, Table 1, DOI 10.3389/fmars.2022.931991.
#' Licença: CC BY 4.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D26_gammarus_resumo/.
#'
#' @examples
#' summary(gammarus_dieta_temperatura_resumo)
#'
#' @docType data
#' @keywords datasets
"gammarus_dieta_temperatura_resumo"
