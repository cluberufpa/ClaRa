#' D54 - Tiger flathead: idade, comprimento e sexo
#'
#' Idade (lida nos anéis do otólito), comprimento e sexo de 4.318 peixes de
#' *Platycephalus richardsoni* (tiger flathead), capturados na pesca comercial de
#' arrasto e de cerco do sudeste da Austrália, de 1981 a 2010. É o conjunto da
#' curva de crescimento de von Bertalanffy: o comprimento sobe com a idade e vai se
#' achatando, e as fêmeas crescem mais que os machos.
#'
#' @format Um `data.frame` com 4318 linhas (uma por peixe) e 9 colunas:
#' \describe{
#'   \item{id_peixe}{Texto: identificador do peixe na fonte (`fish29`).}
#'   \item{area}{Fator: área de pesca, com os códigos da fonte, `EBS` (3.915 peixes) e `ETAS` (403).}
#'   \item{aparelho}{Fator: `arrasto_fundo`, `cerco_dinamarques` ou `desconhecido`.}
#'   \item{ano_captura}{Inteiro: ano da captura, de 1981 a 2010.}
#'   \item{mes_captura}{Inteiro: mês da captura, de 1 a 12.}
#'   \item{sexo}{Fator: `femea` ou `macho`; 444 peixes ficam sem sexo (`NA`), veja Detalhes.}
#'   \item{idade_anos}{Inteiro: idade em anos inteiros, de 2 a 25, pelos anéis do otólito.}
#'   \item{idade_decimal}{Numérico: idade em anos, com a data da captura em relação ao nascimento.}
#'   \item{comprimento_cm}{Inteiro: comprimento em cm, arredondado para baixo; 17 peixes sem comprimento.}
#' }
#'
#' @details Com `idade_anos` e `comprimento_cm`, o modelo de von Bertalanffy,
#' `comprimento_cm ~ Linf * (1 - exp(-K * (idade_anos - t0)))`, se ajusta com
#' `nls()`. Nos peixes de sexo conhecido, as fêmeas têm L∞ de cerca de 79 cm e os
#' machos de cerca de 61 cm, com K parecido (0,06 a 0,07 por ano). A curva única,
#' sem separar o sexo, dá L∞ de cerca de 70 cm, K de 0,07 e t0 de -5,8 anos.
#'
#' **Defeito da fonte: o sexo de 444 peixes.** No arquivo original, em 444 peixes
#' (10%) o sexo muda de um anel do otólito para outro, de modo que o mesmo peixe
#' aparece como fêmea e como macho. Quase todos são de capturas de 2009 e 2010. As
#' outras colunas não mudam dentro do peixe. Aqui o sexo desses peixes é `NA`: não
#' se escolheu um por maioria. É uma chance de praticar dados faltantes; sobram
#' 3.874 peixes com sexo consistente.
#'
#' Os valores de p de uma curva ajustada a milhares de peixes saem sempre muito
#' pequenos; olhe o tamanho da diferença (L∞, K), não só o p. A idade é inteira e o
#' comprimento é arredondado para baixo, então os pontos formam colunas no gráfico.
#' Idades acima de 18 anos têm poucos peixes (de 1 a 2 por idade).
#'
#' @section Adaptações:
#' O arquivo da fonte tem uma linha por anel do otólito (22.941 linhas); aqui há
#' uma linha por peixe. A largura de cada anel (`Increment`), o raio do otólito e o
#' ano de nascimento não entraram: são outro exercício, o do crescimento de cada
#' peixe ao longo da vida. Nomes traduzidos e categorias do aparelho (`OT`, `DS`)
#' escritas por extenso. Valores observados não foram alterados.
#'
#' @section Usos secundários:
#' Teste t ou ANOVA em uma idade fixa: `comparar_medias()` em
#' `subset(platycephalus_crescimento, idade_anos == 5)` compara fêmeas e machos de
#' mesma idade. Comparação de áreas e de aparelhos de pesca. Dados faltantes: o
#' sexo ausente em 444 peixes.
#'
#' @source Morrongiello, J. R.; Thresher, R. E. (2014). Data from: A statistical
#' framework to explore ontogenetic growth variation among individuals and
#' populations: a marine fish example. Dryad. \doi{10.5061/dryad.q9h64}. Licença
#' CC0 1.0, conferida em 13/10/2026. Artigo: *Ecological Monographs*,
#' \doi{10.1890/13-2355.1}. Fonte e preparo em
#' `data-raw/D54_platycephalus_crescimento/`.
#'
#' @examples
#' ajuste <- nls(comprimento_cm ~ Linf * (1 - exp(-K * (idade_anos - t0))),
#'               data = platycephalus_crescimento,
#'               start = list(Linf = 50, K = 0.3, t0 = 0))
#' coef(ajuste)
#' @docType data
#' @keywords datasets
"platycephalus_crescimento"
