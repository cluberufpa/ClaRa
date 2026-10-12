#' D52 - Secagem de beterraba e gengibre
#'
#' Razão de umidade em 36 séries de secagem, adequada para introduzir uma curva
#' exponencial que se aproxima de um patamar.
#'
#' @format Um `data.frame` com 594 linhas e 8 colunas:
#' \describe{
#'   \item{serie}{Fator: combinação de produto, tratamento, temperatura e réplica.}
#'   \item{id_amostra}{Texto: identificador original da observação.}
#'   \item{produto_codigo}{Fator: código B ou G da fonte.}
#'   \item{tratamento_codigo}{Fator: código C ou E da fonte.}
#'   \item{temperatura_c}{Numérico: temperatura de secagem em °C.}
#'   \item{repeticao}{Inteiro: réplica da série.}
#'   \item{tempo_origem}{Numérico: tempo com unidade não declarada.}
#'   \item{razao_umidade}{Numérico: razão de umidade, sem unidade.}
#' }
#'
#' @details B/G e C/E não foram traduzidos porque o depósito não associa cada
#' código ao produto ou pré-tratamento. `tempo_origem` foi arredondado a três
#' casas para remover artefatos numéricos, mas sua unidade segue pendente.
#' Não interprete meia-vida em minutos ou horas antes dessa confirmação.
#'
#' @section Adaptações:
#' Seleção de sete das oito colunas da planilha, com `serie` derivada. Não
#' houve exclusão de linhas ou imputação. Substitui `paciente_peso`
#' (`MASS::wtloss`), reutilizando D52.
#'
#' @source Granella, S. (2025). *Drying kinetics (MR) data and AI model scripts
#' for ethanol-pretreated beetroot and ginger*. Mendeley Data.
#' \doi{10.17632/zkvb73tn79.1}. Licença CC BY 4.0, conferida em 12/10/2026.
#' Fontes e preparo: `data-raw/D52_secagem_vegetais/`.
#'
#' @examples
#' summary(secagem_beterraba_gengibre)
#' @docType data
#' @keywords datasets
"secagem_beterraba_gengibre"
