#' D40 - Whitefish: condição e fisiologia sob salinidade
#'
#' Dados provisórios da passada 1. Unidade amostral: peixe amostrado nos dias 174 ou 252; subamostra de tanque, sem pareamento entre dias.
#'
#' @format Um `data.frame` com 59 linhas e 11 colunas:
#' \describe{
#'   \item{id_tanque_origem}{Texto: tanque de origem entre dias 1 e 116.}
#'   \item{id_tanque}{Texto: tanque após transferência no dia 116.}
#'   \item{salinidade_ppt}{Salinidade do tratamento, ppt.}
#'   \item{id_peixe}{Texto: código do peixe no dia amostrado; não marca individual longitudinal.}
#'   \item{dia}{Dia de coleta: 174 ou 252.}
#'   \item{grupo_temperatura}{Grupo frio ou quente; coincide com o dia de coleta.}
#'   \item{fator_condicao_relativo}{Razão entre massa observada e esperada, sem dimensão.}
#'   \item{lactato_mmol_l}{Lactato no sangue total, mmol/L.}
#'   \item{glicose_mmol_l}{Glicose no sangue total, mmol/L.}
#'   \item{cortisol_plasma_ng_l}{Cortisol plasmático, ng/L segundo a fonte; ausente no grupo frio.}
#'   \item{osmolaridade_total_mosm}{Osmolaridade total do plasma, mOsm segundo a fonte; ausente no grupo frio.}
#' }
#'
#' @details
#' Selecionada a tabela A pronta para análise, com as quatro tabelas originais preservadas na fonte. São 59 peixes, não os 60 mencionados no método; não preencher a linha ausente. Peixes não foram marcados ao longo do experimento, e os grupos dos dias 174 e 252 são de indivíduos diferentes. Temperatura e dia coincidem; não separar seus efeitos causalmente. Conferir replicação/alocação por tanque. Cortisol/osmolaridade ausentes no grupo frio; não imputar. README menciona glicose onde parece descrever osmolaridade; valores e ausências originais preservados.
#'
#' @section Adaptações:
#' File_A.csv → tabela principal. Source Tank/Tank/Salinity/Fish ID/Day/Temp/Relative condition factor/Lactate/Glucose/Plasma Cortisol/Total Osmolarity → id_tanque_origem, id_tanque, salinidade_ppt, id_peixe, dia, grupo_temperatura, fator_condicao_relativo, lactato_mmol_l, glicose_mmol_l, cortisol_plasma_ng_l, osmolaridade_total_mosm. Cool/Warm → frio/quente. Todas as 59 linhas, medições e ausências preservadas; três IDs tratados como texto. As outras tabelas ficam integralmente na fonte, com unidades distintas, sem junção artificial.
#'
#' @source
#' Yeung e colaboradores (2026), Stress, growth, and osmoregulatory data for the Atlantic Whitefish at different salinities, Dryad v3, DOI 10.5061/dryad.bg79cnpph, File_A.csv.
#' Licença: CC0-1.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D40_whitefish_salinidade/.
#'
#' @examples
#' summary(whitefish_salinidade)
#'
#' @docType data
#' @keywords datasets
"whitefish_salinidade"
