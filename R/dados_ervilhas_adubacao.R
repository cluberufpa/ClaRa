#' D43 - Ervilhas: adubação NPK em blocos
#'
#' Dados provisórios da passada 1. Unidade amostral: parcela de 1/70 acre em experimento fatorial fracionado, com seis blocos.
#'
#' @format Um `data.frame` com 24 linhas e 5 colunas:
#' \describe{
#'   \item{bloco}{Fator: bloco experimental, códigos 1 a 6.}
#'   \item{nitrogenio}{Fator: aplicação de nitrogênio, nao_aplicado ou aplicado.}
#'   \item{fosfato}{Fator: aplicação de fosfato, nao_aplicado ou aplicado.}
#'   \item{potassio}{Fator: aplicação de potássio, nao_aplicado ou aplicado.}
#'   \item{producao_lb_parcela}{Produção de ervilhas em libras por parcela de 1/70 acre.}
#' }
#'
#' @details
#' Não é um fatorial completo de oito combinações em cada bloco: são quatro parcelas por bloco. Metades do fatorial foram usadas em blocos diferentes e a interação NPK fica confundida com blocos. Respeitar o delineamento e termos estimáveis; não aplicar ANOVA simples ignorando blocos. Manter libras/parcela e confirmar procedência histórica do experimento.
#'
#' @section Adaptações:
#' block → bloco; N → nitrogenio; P → fosfato; K → potassio; yield → producao_lb_parcela. Categorias de nitrogenio: 0 → nao_aplicado, 1 → aplicado. Categorias de fosfato: 0 → nao_aplicado, 1 → aplicado. Categorias de potassio: 0 → nao_aplicado, 1 → aplicado. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.
#'
#' @source
#' Imperial College, London, folha de exercícios de mestrado; Venables e Ripley (2002); datasets::npk.
#' Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D43_ervilhas_adubacao/.
#'
#' @examples
#' summary(ervilhas_adubacao)
#'
#' @docType data
#' @keywords datasets
"ervilhas_adubacao"
