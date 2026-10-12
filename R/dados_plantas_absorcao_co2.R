#' D44 - Plantas: absorção de CO2 e resfriamento
#'
#' Dados provisórios da passada 1. Unidade amostral: medição em uma planta sob concentração de CO2; sete medições por planta.
#'
#' @format Um `data.frame` com 84 linhas e 5 colunas:
#' \describe{
#'   \item{id_planta}{Texto: identificador original da planta; ordem do fator original não é variável resposta.}
#'   \item{origem}{Origem: Quebec ou Mississippi, nomes próprios preservados.}
#'   \item{resfriamento}{Condição: sem_resfriamento ou com_resfriamento, aplicado durante a noite.}
#'   \item{concentracao_co2}{Concentração ambiental de CO2; ajuda registra mL/L, unidade a confirmar.}
#'   \item{absorcao_co2_umol_m2_s}{Taxa de absorção de CO2, em micromoles por metro quadrado por segundo.}
#' }
#'
#' @details
#' Doze plantas, seis de cada origem; três por combinação origem × resfriamento, com sete concentrações por planta. As 84 medições não são réplicas independentes. A ajuda registra conc em mL/L; confirmar a unidade na fonte primária antes de converter ou acrescentar sufixo ao nome. Não confundir CO2 (experimento de plantas) com co2 (série atmosférica). Cópia do levantamento corrigida a partir do objeto nomeado da distribuição R.
#'
#' @section Adaptações:
#' Plant → id_planta; Type → origem; Treatment → resfriamento; conc → concentracao_co2; uptake → absorcao_co2_umol_m2_s. id_planta convertido em texto, mantendo códigos originais. Categorias de resfriamento: nonchilled → sem_resfriamento, chilled → com_resfriamento. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.
#'
#' @source
#' Potvin, Lechowicz e Tardif (1990), Ecology 71:1389–1400, DOI 10.2307/1938276; Pinheiro e Bates (2000), apêndice A.5; datasets::CO2.
#' Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D44_plantas_absorcao/.
#'
#' @examples
#' summary(plantas_absorcao_co2)
#'
#' @docType data
#' @keywords datasets
"plantas_absorcao_co2"
