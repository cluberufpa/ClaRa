#' D60 - Esgana-gata: ruído visual em quadrado latino 4 x 4
#'
#' Atração social de esgana-gatas (*Gasterosteus aculeatus*) sob quatro tipos de ruído
#' visual dinâmico, como o tremular da luz na superfície da água. Cada um dos 144 peixes
#' focais viu os quatro ruídos, um em cada período, numa de quatro sequências. Sequência
#' (linhas) x período (colunas) forma um **quadrado latino 4 x 4**: cada ruído aparece uma
#' vez em cada sequência e uma vez em cada período. O quadrado se repete em 36 peixes por
#' sequência.
#'
#' @format Um `data.frame` com 576 linhas (uma por peixe e período) e 11 colunas:
#' \describe{
#'   \item{id_peixe}{Texto: identificador do peixe focal, `P001` a `P144`.}
#'   \item{sequencia}{Fator: ordem dos vídeos, `A` a `D`; as linhas do quadrado.}
#'   \item{periodo}{Fator: posição do vídeo na sequência, `1` a `4`; as colunas do quadrado.}
#'   \item{ruido_visual}{Fator: `estático`, `lento`, `médio` ou `rápido`; o tratamento.}
#'   \item{distancia_cardume_mm}{Distância mediana ao cardume mais próximo, em mm; quanto menor, maior a atração social.}
#'   \item{tamanho_peixe_mm}{Comprimento estimado do peixe focal, em mm.}
#'   \item{velocidade_mm_s}{Velocidade mediana do peixe focal, em mm/s.}
#'   \item{preferencia_cardume_maior}{Proporção do tempo perto do cardume maior menos a do menor; positivo = prefere o maior.}
#'   \item{ensaio}{Inteiro: ensaio (1 a 72); dois peixes filmados juntos, em arenas separadas.}
#'   \item{cardume_maior_n}{Número de peixes no cardume de estímulo maior.}
#'   \item{cardume_menor_n}{Número de peixes no cardume de estímulo menor.}
#' }
#'
#' @details As sequências são as da Tabela A1 do artigo:
#' A = lento, médio, rápido, estático; B = rápido, estático, lento, médio;
#' C = estático, rápido, médio, lento; D = médio, lento, estático, rápido.
#'
#' Quadrado latino clássico, com as médias das 16 células sequência x período:
#' `aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo)` dá ruído F = 16,2
#' (p = 0,003), sequência p = 0,002 e período p = 0,23, com 6 graus de liberdade no
#' resíduo. Com os 144 peixes como blocos,
#' `aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo + Error(id_peixe))`
#' dá ruído F = 10,1 (p = 2e-6). Os peixes ficam mais perto do cardume com ruído médio
#' ou rápido do que com a imagem estática, como no artigo (p < 0,001).
#'
#' As quatro medidas de cada peixe não são independentes: analisar as 576 linhas como
#' observações soltas, sem o peixe no modelo, é erro. O artigo usa modelos mistos, com
#' a transformação inversa da distância; as ANOVAs acima são didáticas. O desenho não
#' equilibra o efeito residual de um vídeo sobre o seguinte.
#'
#' @section Adaptações:
#' Gerado do arquivo `final_statistics.txt` do Dryad. O período não está no arquivo e foi
#' reconstruído pela Tabela A1; distância convertida de pixels para mm pela calibração de
#' cada vídeo; nomes e rótulos traduzidos; colunas auxiliares do arquivo omitidas. Receita e
#' conferências em `data-raw/D60_esgana_ruido/preparar.R`. Substitui `suinos_castracao`
#' (antes, `vacas_fistuladas` e `trigo_quadrado_latino`).
#'
#' @source Matchette, S. R.; Herbert-Read, J. E. (2021). Dynamic visual noise promotes
#' social attraction, but does not affect group size preference, in a shoaling fish.
#' *Animal Behaviour* 177:39-48. \doi{10.1016/j.anbehav.2021.04.017}. Dados: Dryad,
#' \doi{10.5061/dryad.sj3tx962p}, licença CC0 1.0, conferida em 13/10/2026. Fonte e
#' preparo em `data-raw/D60_esgana_ruido/`.
#'
#' @examples
#' celulas <- aggregate(distancia_cardume_mm ~ sequencia + periodo + ruido_visual,
#'                      data = esgana_gata_ruido, FUN = mean)
#' summary(aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo, data = celulas))
#' @docType data
#' @keywords datasets
"esgana_gata_ruido"
