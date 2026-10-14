#' D64 - Tiger flathead: idade, comprimento e sexo
#'
#' Idade (lida nos anéis do otólito), comprimento e sexo de 402 peixes de
#' *Platycephalus richardsoni* (tiger flathead), capturados em 2000 na pesca de
#' arrasto de fundo do sudeste da Austrália. É o conjunto da curva de crescimento
#' de von Bertalanffy: o comprimento sobe com a idade e vai se achatando, e as
#' fêmeas crescem mais que os machos.
#'
#' @format Um `data.frame` com 402 linhas (uma por peixe) e 6 colunas:
#' \describe{
#'   \item{id_peixe}{Texto: identificador do peixe na fonte (`fish121`).}
#'   \item{mes_captura}{Inteiro: mês da captura em 2000 (1, 3, 4, 6, 9 ou 11).}
#'   \item{sexo}{Fator: `femea` (252) ou `macho` (150).}
#'   \item{idade_anos}{Inteiro: idade em anos inteiros, de 2 a 16, pelos anéis do otólito.}
#'   \item{idade_decimal}{Numérico: idade em anos, com a data da captura em relação ao nascimento.}
#'   \item{comprimento_cm}{Inteiro: comprimento em cm, arredondado para baixo.}
#' }
#'
#' @details Com `idade_anos` e `comprimento_cm`, o modelo de von Bertalanffy,
#' `comprimento_cm ~ Linf * (1 - exp(-K * (idade_anos - t0)))`, se ajusta com
#' `nls()` em cada sexo: as fêmeas têm L∞ de cerca de 47 cm (erro-padrão de 1 cm) e
#' K de 0,32 por ano; os machos, L∞ de cerca de 44 cm e K de 0,24. Sem separar o
#' sexo, L∞ é de cerca de 45 cm. As duas curvas diferem (F = 46 para três
#' parâmetros, p < 0,001).
#'
#' **Um recorte de uma pescaria e de um ano.** O depósito original tem 4.318 peixes
#' de 1981 a 2010, em duas áreas e com dois aparelhos de pesca. Uma curva de crescimento
#' não precisa de tanto, e misturar anos e aparelhos tem um custo: o crescimento muda
#' de um ano para outro, e a curva do conjunto inteiro (L∞ de cerca de 70 cm) não
#' representa nenhuma das pescarias. Aqui ficaram os peixes da área EBS, pescados com
#' arrasto de fundo em 2000, o recorte com mais peixes de uma pescaria e de um ano em
#' que as duas curvas se ajustam bem. O recorte não é uma amostra aleatória, e as
#' conclusões valem para essa pescaria e esse ano. Amostras aleatórias pequenas do
#' conjunto inteiro dão curvas instáveis, porque os peixes velhos são raros.
#'
#' A idade é inteira e o comprimento é arredondado para baixo, então os pontos formam
#' colunas no gráfico. Só 21 peixes passam de 10 anos: L∞ é estimado com pouca
#' informação sobre os peixes maiores, e o intervalo de confiança mostra isso.
#'
#' @section Adaptações:
#' O arquivo da fonte tem uma linha por anel do otólito (22.941 linhas); aqui há
#' uma linha por peixe. A largura de cada anel, o raio do otólito e o ano de
#' nascimento não entraram: são outro exercício, o do crescimento de cada peixe ao
#' longo da vida. As colunas de área, aparelho e ano, constantes no recorte, saíram.
#' Nomes traduzidos; valores observados não foram alterados.
#'
#' @section Usos secundários:
#' Teste t em uma idade fixa: `comparar_medias()` em
#' `subset(platycephalus_crescimento, idade_anos == 5)` compara fêmeas e machos de
#' mesma idade. Distribuição do comprimento por idade e por mês de captura.
#'
#' @source Morrongiello, J. R.; Thresher, R. E. (2014). Data from: A statistical
#' framework to explore ontogenetic growth variation among individuals and
#' populations: a marine fish example. Dryad. \doi{10.5061/dryad.q9h64}. Licença
#' CC0 1.0, conferida em 13/10/2026. Artigo: *Ecological Monographs*,
#' \doi{10.1890/13-2355.1}. Fonte e preparo em
#' `data-raw/D64_platycephalus_crescimento/`.
#'
#' @examples
#' ajuste <- nls(comprimento_cm ~ Linf * (1 - exp(-K * (idade_anos - t0))),
#'               data = platycephalus_crescimento,
#'               start = list(Linf = 50, K = 0.3, t0 = 0))
#' coef(ajuste)
#' @docType data
#' @keywords datasets
"platycephalus_crescimento"
