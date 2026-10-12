#' D46 - Carros: velocidade e distância de parada
#'
#' Dados provisórios da passada 1. Unidade amostral: registro histórico de velocidade e distância de parada de automóvel.
#'
#' @format Um `data.frame` com 50 linhas e 2 colunas:
#' \describe{
#'   \item{velocidade_mph}{Velocidade em milhas por hora.}
#'   \item{distancia_parada_ft}{Distância de parada em pés; termo original stopping distance.}
#' }
#'
#' @details
#' Preservadas as unidades originais: milhas por hora e pés, sem conversão. São dados históricos, inadequados para recomendar distâncias de segurança atuais. Não presumir medições independentes em carros diferentes; protocolo e identidade dos veículos a revisar. Não extrapolar curvas além do intervalo observado.
#'
#' @section Adaptações:
#' speed → velocidade_mph; dist → distancia_parada_ft. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.
#'
#' @source
#' Ezekiel (1930), Methods of Correlation Analysis; McNeil (1977); dados coletados na década de 1920; datasets::cars.
#' Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D46_carros_frenagem/.
#'
#' @examples
#' summary(carros_frenagem)
#'
#' @docType data
#' @keywords datasets
"carros_frenagem"
