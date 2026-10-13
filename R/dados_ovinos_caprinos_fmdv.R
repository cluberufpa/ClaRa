#' D12 - Ovinos e caprinos: febre aftosa em soro e swab oral
#'
#' Resultado da rRT-PCR para o vírus da febre aftosa (FMDV) no soro e no swab oral
#' de ovinos e caprinos do norte da Nigéria, março a outubro de 2021, mais o
#' resultado do ELISA de anticorpos contra proteínas não estruturais (NSP). Cada
#' linha é um par de amostras do **mesmo animal** em uma visita: dois exames
#' binários pareados, o desenho do teste de McNemar.
#'
#' @format Um `data.frame` com 418 linhas e 11 colunas:
#' \describe{
#'   \item{id_animal}{Texto: identificador individual do animal.}
#'   \item{id_local}{Texto: rebanho, domicílio, mercado ou local de origem do animal (23 locais).}
#'   \item{data_coleta}{Data da coleta (Date).}
#'   \item{visita}{Fator: visita de amostragem, `V1` a `V7`.}
#'   \item{especie}{Fator: `ovino` ou `caprino`.}
#'   \item{idade_meses}{Idade, em meses.}
#'   \item{sexo}{Fator: `fêmea` ou `macho`.}
#'   \item{origem_animal}{Fator: `mesma propriedade`, `mercado de gado` ou `vizinhos`.}
#'   \item{pcr_soro}{Fator: rRT-PCR para FMDV no soro, `negativo` ou `positivo`.}
#'   \item{pcr_swab_oral}{Fator: rRT-PCR para FMDV no swab oral, `negativo` ou `positivo`.}
#'   \item{elisa_nsp}{Fator: ELISA de anticorpos contra proteínas não estruturais do
#'   FMDV no soro, `negativo` ou `positivo`; dois NA.}
#' }
#'
#' @details São **418 pares em 323 animais**: 152 linhas são de animais amostrados em
#' mais de uma visita (até cinco). Com todas as linhas, o McNemar não respeita a
#' independência entre pares do mesmo animal; o conjunto serve para discutir isso
#' e para escolher **uma coleta por animal** ou **uma visita**.
#'
#' Tabelas 2 x 2 (negativo primeiro):
#'
#' - PCR do soro x PCR do swab oral, 418 pares: 400, 9, 8 e 1 (soro negativo e swab
#'   positivo: 8; soro positivo e swab negativo: 9). McNemar p = 1, kappa de cerca de
#'   0,09. O artigo relata p > 0,9 e kappa = 0,08 para o contraste completo.
#' - A primeira coleta de cada animal (323 pares): 308, 8, 6 e 1; McNemar p = 0,79.
#' - ELISA NSP x PCR do soro: a discordância vai quase toda para um lado (178
#'   animais com anticorpo e sem vírus no soro, contra 6 ao contrário). O ELISA
#'   mede exposição passada, e a PCR, o vírus no momento; por isso os dois
#'   exames não medem a mesma coisa.
#'
#' Há poucos positivos (10 soros e 9 swabs em 418 pares) e só 1 par positivo nos
#' dois exames: a concordância alta vem dos negativos, e o kappa fica perto de
#' zero. Nenhum dos dois exames é padrão-ouro. As visitas V1 a V7 não incluem
#' agosto (sem coleta por segurança), e os animais vêm de 23 locais, o que cria
#' agrupamento que o McNemar ignora.
#'
#' @section Adaptações:
#' Recorte didático montado pelo professor a partir da aba `Animals` do arquivo
#' suplementar do artigo: só ovinos e caprinos com resultado válido de PCR no soro
#' e no swab oral. Nesta versão: tradução dos nomes e dos rótulos para o português,
#' exames como fatores `negativo`/`positivo`, e remoção das colunas duplicadas
#' (versões 0/1 dos exames), da indicação de amostragem repetida (se calcula
#' pelo `id_animal`) e de `lesoes_fmd` (todas "No"). Preparo e conferências em
#' `data-raw/D12_ovinos_fmdv/preparar.R`. Substitui `cabras_toxoplasma`.
#'
#' @source Gubbins, S.; Brown, E.; Wungak, Y.; Oyekan, O. et al. (2025).
#' Longitudinal study of foot-and-mouth disease virus in Northern Nigeria:
#' implications for the roles of small ruminants and environmental contamination in
#' endemic settings. *Veterinary Research* 56:76. \doi{10.1186/s13567-025-01502-2}.
#' Artigo CC BY 4.0; dados (Additional file 13) sob CC0 1.0, conferido em
#' 12/10/2026. Fonte e preparo em `data-raw/D12_ovinos_fmdv/`.
#'
#' @examples
#' table(ovinos_caprinos_fmdv$pcr_soro, ovinos_caprinos_fmdv$pcr_swab_oral)
#' mcnemar.test(table(ovinos_caprinos_fmdv$pcr_soro, ovinos_caprinos_fmdv$pcr_swab_oral))
#' @docType data
#' @keywords datasets
"ovinos_caprinos_fmdv"
