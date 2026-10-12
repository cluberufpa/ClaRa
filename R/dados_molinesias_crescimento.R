#' D48 - Molinésias: crescimento individual
#'
#' Comprimento padrão de fêmeas clonais acompanhadas desde o nascimento, em um
#' recorte com as mesmas dez idades para todos os 34 peixes.
#'
#' @format Um `data.frame` com 340 linhas e 4 colunas:
#' \describe{
#'   \item{peixe}{Texto: identificador do peixe acompanhado.}
#'   \item{mae}{Fator: código materno m1, m2 ou m4.}
#'   \item{idade_dias}{Inteiro: idade observada, de 0 a 280 dias.}
#'   \item{comprimento_cm}{Numérico: comprimento padrão observado, em cm.}
#' }
#'
#' @details Cada peixe aparece em dez idades: 0, 14, 21, 42, 49, 56, 77, 154,
#' 224 e 280 dias. Há 14, 4 e 16 peixes dos grupos maternos m1, m2 e m4. Mãe
#' não é tratamento: as mães são aparentadas e não permitem inferência geral
#' sobre efeito materno. As linhas são medidas repetidas, não réplicas
#' independentes para uma curva única.
#'
#' @section Adaptações:
#' De `growth.csv`, foram preservadas as medidas observadas de peixe, mãe, idade
#' e comprimento. Predições e intervalos já calculados pelos autores ficaram
#' fora. O recorte de dez datas completas é explícito; a fonte integral de 1.178
#' linhas permanece congelada. Substitui `laranjeiras_crescimento`
#' (`datasets::Orange`), reutilizando D48.
#'
#' @source Scherer, U. et al. (2023). Figshare.
#' \doi{10.6084/m9.figshare.23971599.v1}. Artigo: *Nature Communications* 14,
#' 7652, \doi{10.1038/s41467-023-43069-6}. Licença CC BY 4.0, conferida em
#' 12/10/2026. Fontes e preparo: `data-raw/D48_molinesias_crescimento/`.
#'
#' @examples
#' summary(molinesias_crescimento)
#' @docType data
#' @keywords datasets
"molinesias_crescimento"
