#' D58 - Big Hill: peixes e contagens por amostra
#'
#' Dados provisórios da passada 1. Unidade amostral: registro individual ou agrupado de espécie e comprimento dentro de amostra.
#'
#' @format Um `data.frame` com 266 linhas e 6 colunas:
#' \describe{
#'   \item{id_amostra}{Texto do UID que referencia bighill_amostras.}
#'   \item{id_peixe}{Texto de fishID, local à amostra; 81 ausências preservadas.}
#'   \item{codigo_especie}{Texto: 116 Smallmouth Bass, 118 Largemouth Bass, 122 Bluegill, segundo a ajuda.}
#'   \item{comprimento_total_mm}{Comprimento total em milímetros.}
#'   \item{peso_g}{Peso em gramas; 91 ausências preservadas.}
#'   \item{contagem}{Número de peixes dessa espécie e comprimento no registro, de 1 a 3.}
#' }
#'
#' @details
#' 266 linhas não equivalem necessariamente a 266 peixes: contagem varia de 1 a 3 e deve ser somada para captura. fishID tem 81 ausências e é local à amostra, não chave global; peso tem 91 NA. Manter todas as linhas e não expandir contagens em réplicas fictícias. UID referencia bighill_amostras; esforço fica naquela tabela e não deve ser somado após repetição por peixe. Códigos de espécie 116/118/122 preservados como texto; nomes comuns ingleses da ajuda não são inferidos como novos nomes científicos.
#'
#' @section Adaptações:
#' UID → id_amostra; fishID → id_peixe; specCode → codigo_especie; length → comprimento_total_mm; weight → peso_g; count → contagem. id_amostra em texto, mantendo códigos e ausências originais. id_peixe em texto, mantendo códigos e ausências originais. codigo_especie em texto, mantendo códigos e ausências originais.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @source
#' Dados obtidos diretamente de Ben Neely; Introductory Fisheries Analyses with R; FSAdata::BGHRfish.
#' Licença: GPL (>= 2), FSAdata 0.4.1.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D58_bighill_peixes/.
#'
#' @examples
#' summary(bighill_peixes)
#'
#' @docType data
#' @keywords datasets
"bighill_peixes"
