#' D50 - Molinésias: carga de parasitos
#'
#' Contagens individuais de parasitos em duas espécies de Poecilia coletadas
#' em dois locais do Texas. Fonte real, CC0. Curadoria fina provisória.
#'
#' @format Um `data.frame` com 128 linhas e 8 colunas:
#' \describe{
#'   \item{id_registro}{Chave técnica REG_001 a REG_128, criada pela ordem das linhas; não é ID biológico.}
#'   \item{local}{Local de coleta: Brownsville ou Weslaco.}
#'   \item{especie}{Espécie: P. formosa ou P. latipinna.}
#'   \item{sexo}{Fator: \code{fêmea} ou \code{macho}; dois NA.}
#'   \item{comprimento_padrao_cm}{Comprimento padrão, da boca ao pedúnculo caudal, em cm; dez NA.}
#'   \item{parasitos_total_n}{Contagem inteira de trematódeos e parasitos não identificados por peixe.}
#'   \item{infectado_01}{Indicador derivado: 1 se parasitos_total_n > 0; 0 em caso contrário.}
#' }
#'
#' @details
#' Unidade amostral: peixe individual dissecado. Estudo observacional,
#' desbalanceado: 11, 27, 58 e 32 indivíduos nas combinações
#' Brownsville/formosa, Brownsville/latipinna, Weslaco/formosa e Weslaco/latipinna.
#' Todas as P. formosa são fêmeas; sexo e espécie não formam um cruzamento completo.
#' Preservados todos os valores, incluindo 31 zeros e o máximo de 644 parasitos.
#' Não há exposição para offset; comprimento é covariável, não offset automático.
#' Os modelos com comprimento usam 118 casos completos. O artigo analisa
#' separadamente presença/ausência e contagens positivas; incluir os zeros em
#' uma binomial negativa responde a uma pergunta diferente sobre abundância.
#' Kruskal-Wallis compara distribuições dos quatro grupos, sem separar os
#' efeitos de local e espécie nem estabelecer causalidade.
#'
#' @section Adaptações:
#' Tradução dos cinco cabeçalhos originais. Criados id_registro
#' e infectado_01; grupo_local_especie (repetia local e espécie) foi removido em
#' 12/10/2026. Categorias originais preservadas.
#' Nenhuma linha excluída, reordenada ou simulada. Substitui escolares_ausencias
#' (MASS::quine), reutilizando D50, por autorização do professor em 11/10/2026.
#'
#' @source
#' Sheehy, K.; Aguiñaga, J.; Janecka, M.; Stephenson, J.; Laskowski, K. (2026).
#' Differences in parasite infection status and behavior between a clonal fish
#' and her sexually reproducing heterospecifics. Dryad.
#' \doi{10.5061/dryad.jsxksn0r9}. Artigo: Ecology and Evolution 16(9), e74288,
#' \doi{10.1002/ece3.74288}.
#' Licença dos dados: CC0, com consentimento registrado no README do depósito.
#' Fontes e preparo: data-raw/D50_molinesias_parasitos/.
#'
#' @section Usos secundários:
#' Regressão logística: `glm(infectado_01 ~ comprimento_padrao_cm, family =
#' binomial)` relaciona a chance de infecção ao tamanho do peixe; há
#' comprimentos ausentes.
#'
#' @examples
#' summary(molinesias_parasitos)
#' with(molinesias_parasitos, table(local, especie))
#'
#' @docType data
#' @keywords datasets
"molinesias_parasitos"
