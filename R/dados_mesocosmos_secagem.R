#' D41 - Mesocosmos: crescimento de peixes e secagem prévia
#'
#' Dados provisórios da passada 1. Unidade amostral: peixe por tanque experimental com medidas inicial e final disponíveis na fonte.
#'
#' @format Um `data.frame` com 30 linhas e 12 colunas:
#' \describe{
#'   \item{id_tanque}{Texto: identificador do tanque, um peixe por tanque.}
#'   \item{presenca_anfibios}{Presença de anfíbios: sim ou não.}
#'   \item{secagem}{Secagem prévia: seco e reabastecido ou não seco.}
#'   \item{tratamento}{Código original combinado: F:DR/F:ND/FA:DR/FA:ND.}
#'   \item{comprimento_padrao_inicial_cm}{Comprimento padrão inicial, cm.}
#'   \item{biomassa_inicial_estimada_g}{Biomassa calculada por regressão comprimento-peso, g.}
#'   \item{data_final}{Data da medição final, variável entre tanques.}
#'   \item{comprimento_padrao_final_cm}{Comprimento padrão final, cm.}
#'   \item{biomassa_final_estimada_g}{Biomassa calculada por regressão comprimento-peso, g.}
#'   \item{crescimento_absoluto_cm}{Diferença final menos inicial do comprimento padrão, cm.}
#'   \item{crescimento_relativo}{Razão (final - inicial)/inicial, sem dimensão; preservada da fonte.}
#' }
#'
#' @details
#' Selecionada a tabela de crescimento de peixes para o fatorial presença de anfíbios × secagem; todas as seis tabelas e scripts originais ficam preservados. A fonte contém 30 peixes de 32 introduzidos; confirmar razão das duas ausências, sem adicionar/remover linhas. Biomassas calculadas de regressão comprimento-peso, não pesagens diretas. Crescimento relativo é razão sem dimensão, embora README atribua cm. Datas finais variam: revisar duração antes da comparação. Dois pontos por peixe não sustentam curva de Gompertz.
#'
#' @section Adaptações:
#' Fish Growth, de Fish_Data_Dryad.xlsx → tabela principal. Tank/A_Pres/Drying/Treatment/Initial_Date/Initial_SL/Initial_Biomass/Final_Date/Final_SL/Final_Biomass/Abs_SLGrowth/Rel_SLGrowth → id_tanque, presenca_anfibios, secagem, tratamento, data_inicial, comprimento_padrao_inicial_cm, biomassa_inicial_estimada_g, data_final, comprimento_padrao_final_cm, biomassa_final_estimada_g, crescimento_absoluto_cm, crescimento_relativo. Y/N → sim/não; DR/ND → seco e reabastecido/não seco; datas sem horário. Todas as 30 linhas e medidas originais preservadas; nenhuma exclusão nova. Outros cinco conjuntos e scripts preservados na fonte, sem juntá-los por unidades incompatíveis.
#'
#' @source
#' Ward (2023), An analysis of the effects of prior drying and vertebrate colonization on ecological functioning and vertebrate fitness, Dryad v3, DOI 10.5061/dryad.hx3ffbgkn, Fish_Data_Dryad.xlsx.
#' Licença: CC0-1.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D41_mesocosmos_secagem/.
#'
#' @examples
#' summary(mesocosmos_secagem)
#'
#' @docType data
#' @keywords datasets
"mesocosmos_secagem"
