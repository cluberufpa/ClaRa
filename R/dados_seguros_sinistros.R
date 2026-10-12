#' D51 - Seguros: sinistros e número de segurados
#'
#' Dados provisórios da passada 1. Unidade amostral: célula agregada de distrito, classe do automóvel e faixa etária.
#'
#' @format Um `data.frame` com 64 linhas e 5 colunas:
#' \describe{
#'   \item{distrito}{Fator: distrito 1 a 4; 4 corresponde a grandes cidades.}
#'   \item{classe_cilindrada}{Fator ordenado: grupos de automóvel em litros, limites originais preservados.}
#'   \item{faixa_etaria}{Fator ordenado: menos de 25, 25–29, 30–35 e mais de 35, conforme rótulos originais.}
#'   \item{numero_segurados}{Número de segurados expostos ao risco no trimestre.}
#'   \item{sinistros}{Número de sinistros no terceiro trimestre de 1973.}
#' }
#'
#' @details
#' Contagens agregadas do terceiro trimestre de 1973, não linhas individuais de segurados. Considerar numero_segurados como exposição; não inventar pessoas-ano ou assumir que cada segurado tem no máximo um sinistro. Preservados os fatores ordenados das classes de automóvel e idade, e limites originais. Distrito 4 corresponde a grandes cidades, demais identidades não informadas. Diagnosticar dispersão; catálogo não implica motor de GLM disponível na ClaRa.
#'
#' @section Adaptações:
#' District → distrito; Group → classe_cilindrada; Age → faixa_etaria; Holders → numero_segurados; Claims → sinistros. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos. Classes numéricas de cilindrada e idade preservadas, inclusive ordered; não são palavras inglesas a traduzir.
#'
#' @source
#' Baxter, Coutts e Ross (1980), Applications of linear models in motor insurance, 21st International Congress of Actuaries, Zurich:11–29; Aitkin et al. (1989); MASS::Insurance.
#' Licença: GPL-2 | GPL-3, conforme MASS 7.3-65.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D51_seguros_sinistros/.
#'
#' @examples
#' summary(seguros_sinistros)
#'
#' @docType data
#' @keywords datasets
"seguros_sinistros"
