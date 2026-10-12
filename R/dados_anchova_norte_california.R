#' D61 - Anchova-do-norte: desembarques mensais na Califórnia
#'
#' Série mensal de desembarques da categoria comercial "Anchovy, Northern",
#' agregada para todos os portos da Califórnia, de janeiro de 1971 a dezembro
#' de 1991. Os valores estão em libras e vêm da série California Fish Market
#' Catch Landings distribuída pelo NOAA ERDDAP.
#'
#' @format Um `data.frame` com 252 linhas e 6 colunas:
#' \describe{
#'   \item{data}{Data de referência do mês, no primeiro dia.}
#'   \item{ano}{Ano do desembarque.}
#'   \item{mes}{Mês, fator ordenado de janeiro a dezembro.}
#'   \item{categoria_mercado}{Categoria comercial; neste recorte, sempre
#'     `anchova-do-norte`.}
#'   \item{porto}{Agregação geográfica; neste recorte, sempre
#'     `todos_os_portos`.}
#'   \item{desembarque_lb}{Desembarque mensal em libras.}
#' }
#'
#' @details A observação é o mês agregado, e não uma captura individual, uma
#' embarcação ou um estoque biológico. A categoria comercial e o total de todos
#' os portos devem permanecer explícitos ao interpretar a série.
#'
#' @section Utilidade no ecossistema:
#' Na **Trilha**, este é o exemplo da tela de Séries Temporais: permite explorar
#' ordem mensal, sazonalidade, tendência e autocorrelação sem esconder os
#' desembarques originais. Na **ClaRa**, o conjunto aparece no catálogo para
#' leitura e estudo do formato de uma série mensal. A ClaRa ainda não tem verbo
#' próprio para séries temporais; não se deve forçar esta série em comparações de
#' médias ou regressões que tratem os meses como observações independentes.
#'
#' @section Adaptações:
#' A fonte oficial contém uma primeira linha de unidades, retirada na leitura. A
#' data de referência fornecida no dia 16 de cada mês foi normalizada para o
#' primeiro dia do respectivo mês. Os valores de desembarque não foram alterados.
#' Este objeto reproduz o conjunto curado `EAPADados::anchova_norte_california`.
#'
#' @source California Department of Fish and Game. *California Fish Market
#' Catch Landings, Short List, 1928-2002, Monthly*, distribuído pelo NOAA
#' Southwest Fisheries Science Center ERDDAP.
#' <https://coastwatch.pfeg.noaa.gov/erddap/info/erdCAMarCatSM/index.html>.
#'
#' Dados distribuídos pelo ERDDAP com permissão de uso e redistribuição gratuita;
#' nenhuma licença Creative Commons específica é nomeada na fonte.
#'
#' @examples
#' summary(anchova_norte_california)
#'
#' @docType data
#' @keywords datasets
"anchova_norte_california"
