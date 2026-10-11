#' D18 - Cabritos: ácidos graxos sob quatro dietas
#'
#' Dados provisórios da passada 1. Unidade amostral: animal; valores resumem repetições analíticas conforme origem.
#'
#' @format Um `data.frame` com 32 linhas e 10 colunas:
#' \describe{
#'   \item{amostra}{Identificador numérico original do animal, de 1 a 32.}
#'   \item{tratamento}{Fator: dieta_1, dieta_2, dieta_3 ou dieta_4.}
#'   \item{energia_mj_kg}{Energia metabolizável da dieta, em MJ/kg.}
#'   \item{omega_3_pct}{Ômega-3 total, em porcentagem dos ácidos graxos conforme origem.}
#'   \item{omega_6_pct}{Ômega-6 total, em porcentagem dos ácidos graxos conforme origem.}
#'   \item{razao_omega_6_omega_3}{Razão entre ômega-6 e ômega-3.}
#'   \item{saturados_pct}{Ácidos graxos saturados, em porcentagem conforme origem.}
#'   \item{monoinsaturados_pct}{Ácidos graxos monoinsaturados, em porcentagem conforme origem.}
#'   \item{poli_insaturados_pct}{Ácidos graxos poli-insaturados, em porcentagem conforme origem.}
#'   \item{razao_poli_insaturados_saturados}{Razão entre poli-insaturados e saturados.}
#' }
#'
#' @details
#' Completar autorização e conferir extração contra artigo original. Não inserir automaticamente razões junto com componentes na PCA. Repetições analíticas não são animais adicionais. Nome definitivo sugerido: cabritos_acidos_graxos.
#'
#' @section Adaptações:
#' Decisão anterior aprovada: n3/n6/sfa/mufa/pufa → omega_3_pct/omega_6_pct/saturados_pct/monoinsaturados_pct/poli_insaturados_pct; n6_n3/pufa_sfa → razao_omega_6_omega_3/razao_poli_insaturados_saturados; T1…T4 → dieta_1…dieta_4. energia_mj_kg preservada.
#'
#' @source
#' Coltro et al. (2005); Meat Science 71(2), 358-363; DOI 10.1016/j.meatsci.2005.04.016.
#' Licença: Licença específica dos dados não localizada; autorização a confirmar.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D18_cabritos_dietas/.
#'
#' @examples
#' summary(cabritos_acidos_graxos)
#'
#' @docType data
#' @keywords datasets
"cabritos_acidos_graxos"
