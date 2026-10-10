# =============================================================================
#  ClaRa: o R escrito com clareza
# =============================================================================
#
#  Cada função da ClaRa responde a uma pergunta da pesquisa, em português.
#  Por trás de cada uma há uma "receita": código R comum, no estilo do
#  tidyverse. Com mostrar_codigo = TRUE, a função imprime a receita com os
#  nomes das suas colunas e depois a executa. O código mostrado é exatamente
#  o código que rodou.
#
#  No roteiro, carregue o pacote:
#
#      library(clara)
#
#  A pasta R/ tem um arquivo por pergunta da pesquisa. Quem quiser estudar
#  uma pergunta abre um arquivo só e encontra tudo dela (Ctrl+Shift+O mostra
#  o sumário):
#    clara_medias.R ............. comparar_medias(), grafico_medias(),
#                                 grafico_boxplot(), grafico_pares()
#    clara_medianas.R ........... comparar_medianas(), grafico_medianas()
#    clara_regressao.R .......... relacionar_variaveis(), grafico_reta()
#    clara_qualquer_analise.R ... medir_efeito(), escrever_resultados(),
#                                 grafico_residuos(), grafico_qq(),
#                                 salvar_tabelas(), salvar_figuras(),
#                                 registrar_ambiente()
#    clara_motor.R .............. ajuda() e as peças internas
#
#  A ordem de carga está no campo Collate do DESCRIPTION: o motor primeiro,
#  porque os outros usam as peças dele; depois "qualquer análise", com as
#  listas de receitas vazias; por fim cada pergunta, que acrescenta as suas
#  receitas a essas listas.
#
#  As colunas podem ser escritas sem aspas (peso_g) ou com aspas ("peso_g").
#  Para ver a lista de funções: ajuda(). Para uma delas: ajuda(comparar_medias)
#  ou ?comparar_medias.
# =============================================================================

#' ClaRa: o R escrito com clareza
#'
#' Cada função da ClaRa responde a uma pergunta da pesquisa, em português:
#' [comparar_medias()], [comparar_medianas()], [grafico_medias()],
#' [escrever_resultados()]. Por trás de cada uma há uma receita de R comum,
#' no estilo do tidyverse, que aparece com `mostrar_codigo = TRUE`: o código
#' mostrado é exatamente o código que rodou.
#'
#' Para ver a lista de funções, agrupadas por pergunta: [ajuda()].
#'
#' @keywords internal
#' @importFrom broom tidy
#' @importFrom car leveneTest
#' @importFrom effectsize eta_squared
#' @importFrom flextable flextable
#' @importFrom multcompView multcompLetters
#' @importFrom pwr pwr.anova.test
#' @importFrom stringr str_wrap
"_PACKAGE"

# Os pacotes acima são usados dentro das receitas, que são texto; o
# @importFrom os declara para o R CMD check saber que são usados.
