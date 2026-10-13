#' D12 - Garoupa: PCR e histologia nos mesmos peixes
#'
#' Resultado do PCR e da histologia para *Streptococcus agalactiae* nos mesmos juvenis de
#' garoupa-de-Queensland (*Epinephelus lanceolatus*), em um desafio por coabitação, em duas
#' réplicas. Cada linha é um peixe com os dois exames: duas respostas binárias pareadas, o
#' desenho do teste de McNemar.
#'
#' @format Um `data.frame` com 123 linhas (74 na réplica 1 e 49 na réplica 2) e 4 colunas:
#' \describe{
#'   \item{id_peixe}{Texto: identificador artificial do peixe (`peixe_001` a `peixe_123`).}
#'   \item{replica}{Fator: réplica (sistema) do desafio, `1` ou `2`.}
#'   \item{histologia}{Fator: histologia (cocos Gram-positivos e lesões compatíveis), `negativo` ou `positivo`.}
#'   \item{pcr}{Fator: PCR, `negativo` ou `positivo`.}
#' }
#'
#' @details **As linhas são reconstruídas.** O relatório de origem publica as tabelas 2 x 2
#' (Tabelas 32 e 34); este conjunto expande as contagens em linhas, com identificadores
#' artificiais e ordem sorteada. Só as contagens são reais. Nada além delas (tanque, razão de
#' coabitação, tratamento, órgão, identidade do peixe) existe aqui.
#'
#' Para cada peixe, os órgãos foram agrupados: o peixe é positivo se o cérebro, o coração ou o
#' baço derem positivo no exame.
#'
#' Tabelas (histologia nas linhas, PCR nas colunas):
#'
#' - réplica 1, 74 peixes: histologia positiva e PCR positivo, 18; histologia positiva e PCR
#'   negativo, 2; histologia negativa e PCR positivo, 50; os dois negativos, 4. O PCR dá 91,9% de
#'   positivos, e a histologia, 27,0%. O McNemar com correção dá χ² = 42,48 e p = 7,1e-11;
#' - réplica 2, 49 peixes: 15, 3, 28 e 3; PCR 87,8% e histologia 36,7%, p da ordem de 1e-5.
#'
#' A discordância vai quase toda para um lado: o PCR acusa muitos peixes que a histologia não
#' acusa, e quase nenhum no sentido contrário. A leitura certa é que o PCR **detecta mais**
#' positivos, e não que tenha sensibilidade absoluta maior: nenhum dos dois exames é padrão-ouro.
#' Os peixes compartilhavam tanques, e o McNemar trata cada peixe como independente. As duas
#' réplicas são sistemas diferentes e devem ser analisadas separadas.
#'
#' @section Adaptações:
#' Contagens transcritas das Tabelas 32 e 34 do relatório; tradução dos rótulos para o
#' português; a réplica 1 usa as linhas da planilha do professor e a réplica 2 é expandida das
#' contagens, com semente fixa, em `data-raw/D12_garoupa_pcr/preparar.R`, que confere as duas
#' tabelas e o χ² de McNemar. Os resultados por peixe e por órgão estão nos
#' Apêndices 8 e 9 do relatório e poderão tornar o conjunto real. Substitui
#' `ovinos_caprinos_fmdv`.
#'
#' @source Bowater, R. O. (2015). Investigation of an emerging bacterial disease in wild
#' Queensland grouper, marine fish and stingrays, with production of diagnostic tools to reduce
#' the spread of disease to other states of Australia. Final report, FRDC Project No.
#' 2010/034, Department of Agriculture, Fisheries and Forestry, Brisbane. Tabelas 32 e 34
#' (p. 123). \url{https://www.frdc.com.au/sites/default/files/products/2010-034-DLD.pdf}.
#' Licença Creative Commons Attribution 3.0 Australia, conferida em 13/10/2026. Fonte e
#' preparo em `data-raw/D12_garoupa_pcr/`.
#'
#' @examples
#' r1 <- subset(garoupa_pcr_histologia, replica == "1")
#' table(r1$histologia, r1$pcr)
#' mcnemar.test(table(r1$histologia, r1$pcr))
#' @docType data
#' @keywords datasets
"garoupa_pcr_histologia"
