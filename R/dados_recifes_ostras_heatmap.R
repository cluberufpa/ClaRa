#' D33 - Recifes de ostras e assembleias de peixes
#'
#' Dados provisórios da passada 1. Unidade amostral: levantamento de zona de recife; medidas repetidas por recife.
#'
#' @format Um `data.frame` com 301 linhas e 26 colunas:
#' \describe{
#'   \item{id_recife}{Texto: identificador do recife.}
#'   \item{id_levantamento}{Texto: identificador do levantamento (recife x estação x ano).}
#'   \item{sitio}{Fator: sítio (\code{OP-CR}, \code{SY-PH}, \code{SY-TP}).}
#'   \item{numero_recife}{Inteiro: número do recife.}
#'   \item{zona_recife}{Fator: zona (\code{centro}, \code{borda}, \code{fora}).}
#'   \item{estacao}{Fator: estação (\code{verão}, \code{inverno}).}
#'   \item{ano}{Inteiro: ano do levantamento.}
#'   \item{avaliador_video}{Fator: avaliador do vídeo.}
#'   \item{duracao_video_min}{Inteiro: duração do vídeo (min).}
#'   \item{visibilidade_media_m}{Numérico: visibilidade média (m).}
#'   \item{pradaria_marinha_pct}{Numérico: cobertura de pradaria marinha (%).}
#'   \item{riqueza_especies_zona}{Inteiro: riqueza de espécies na zona.}
#'   \item{indice_shannon_h}{Numérico: índice de diversidade de Shannon (H').}
#'   \item{abundancia_total}{Inteiro: abundância total de peixes.}
#'   \item{area_2d}{Numérico: área 2D do recife.}
#'   \item{indice_forma}{Numérico: índice de forma.}
#'   \item{indice_isometria}{Numérico: índice de isometria.}
#'   \item{indice_circularidade}{Numérico: índice de circularidade.}
#'   \item{indice_fractal}{Numérico: índice de dimensão fractal.}
#'   \item{indice_para}{Numérico: índice perímetro-área (PARA).}
#'   \item{perimetro}{Numérico: perímetro do recife.}
#'   \item{razao_perimetro_area}{Numérico: razão perímetro/área.}
#'   \item{distancia_media_recifes_proximos}{Numérico: distância média aos recifes próximos.}
#'   \item{distancia_vizinho_mais_proximo}{Numérico: distância ao vizinho mais próximo.}
#'   \item{rugosidade}{Numérico: rugosidade do habitat.}
#'   \item{area_3d}{Numérico: área 3D do recife.}
#' }
#'
#' @details
#' Referência herdada Bennett et al. (2025) corrigida pelos metadados do depósito. Os 301 registros conferem diretamente com o CSV primário sem espécies hiperabundantes; a abundância total difere da versão com elas. Esta seleção é da fonte, não novo filtro da migração. Confirmar quais espécies foram excluídas e justificar o recorte didático na passada 2. Unidades de áreas, perímetro e distâncias a confirmar. Medidas de habitat repetidas por recife geram pseudorrepetição. Propostas de retirar avaliador e traduzir categorias ainda não aprovadas.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores e ordem herdados preservados; nenhuma exclusão nova.
#'
#' @source
#' Pine, Erickson, Bugnot, Gribben e Figueira (2026), Patch design principles for oyster reef restoration: Lessons from fish habitat use in natural remnant systems, Zenodo v2, DOI 10.5281/zenodo.19993470, MeanCount.NO.hyperabundants.dat.csv.
#' Licença: CC BY 4.0, registro Zenodo 19993470.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D33_ostras_recifes/.
#'
#' @examples
#' summary(recifes_ostras_heatmap)
#'
#' @docType data
#' @keywords datasets
"recifes_ostras_heatmap"
