#' D13 - Artêmia: biomassa sob suplementação com fitoesteróis
#'
#' Dados provisórios da passada 1. Unidade amostral: recipiente experimental de 4 L, com resposta agregada por recipiente.
#'
#' @format Um `data.frame` com 69 linhas e 5 colunas:
#' \describe{
#'   \item{experimento}{Código do experimento, preservado da fonte.}
#'   \item{esterol}{Nome químico do esterol; grafia e espaços originais preservados.}
#'   \item{esterol_rotulo}{Fator: o mesmo nome, com hífens, vírgulas, parênteses e espaços trocados por `_` (`24_methylenecholesterol`); use-o como grupo na ClaRa.}
#'   \item{biomassa_mg}{Biomassa seca final por recipiente, em mg.}
#'   \item{massa_individual_ug}{Massa seca média individual, em microgramas por indivíduo.}
#' }
#'
#' @details
#' São quatro experimentos, com três recipientes por tratamento; o quarto começa suplementação em idade diferente. Não combinar experimentos como réplicas. Teste t exige escolher dois tratamentos por justificativa biológica dentro do mesmo experimento. As respostas são massa seca final, não taxa em mg/dia. Para comparar os esteróis de um experimento com `comparar_medias()`, filtre o experimento e use `esterol_rotulo` como grupo: a ClaRa recusa grupos com hífen.
#'
#' @section Adaptações:
#' Nomes químicos da fonte preservados em `esterol`. Em 13/10/2026, por decisão do professor, entrou `esterol_rotulo`, sem hífen, para a ClaRa. Nenhuma transformação de massa em taxa de crescimento.
#'
#' @source
#' Hassett e Giner (2021); BCO-DMO, versão 1 de 19/01/2018; DOI 10.26008/1912/bco-dmo.724179.1.
#' Licença: CC BY 4.0.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D13_artemia_fitoesterois/.
#'
#' @examples
#' exp1 <- droplevels(subset(artemia_fitoesterois, experimento == "exp_1"))
#' tapply(exp1$biomassa_mg, exp1$esterol_rotulo, mean)
#'
#' @docType data
#' @keywords datasets
"artemia_fitoesterois"
