# =============================================================================
#  ClaRa: formatar e exibir
# =============================================================================
#
#  Números e p-valores escritos como no português (formatar_numero(),
#  formatar_p()) e tabelas prontas para o Word ou para o Viewer
#  (exibir_tabela()). As tabelas de um resultado da ClaRa, a do teste e a
#  do resumo por grupo, ficam em clara_qualquer_analise.R (exibir_teste()
#  e exibir_resumo()), porque cada análise traz a sua receita.
#
#  Duas aparências de tabela, as mesmas do livro EAPA:
#    "ocean" ... tabela numerada e citada no texto (relatório Word): Times
#                New Roman, cabeçalho azul-marinho, linhas só em cima e embaixo;
#    "cinza" ... tabela só para olhar o resultado (Viewer do RStudio): letra
#                de console, fundo verde acinzentado, sem linhas.
# =============================================================================


# Formatar e exibir ------------------------------------------------------------

# formatar_numero() ------------------------------------------------------------
#' Como escrever um número como no português?
#'
#' Escreve números com vírgula decimal e o mesmo número de casas, como se
#' escreve num artigo ou numa tabela: `86.25` vira `"86,25"`. Onde não há
#' número (`NA`), escreve um traço, como nas tabelas de artigo.
#'
#' @param x um número ou um vetor de números
#' @param casas casas decimais (padrão 2); use a precisão da medição
#'
#' @return Um texto para cada número.
#'
#' @examples
#' formatar_numero(86.254)
#' formatar_numero(c(3.14159, 2, NA), casas = 1)
#'
#' @concept Formatar e exibir
#' @export
formatar_numero <- function(x,
                            casas = 2) {

  # formatC com format = "f" mantém as casas fixas e não vira notação científica.
  texto <- formatC(x, format = "f", digits = casas, decimal.mark = ",")

  # Onde não há número, um traço; "NA" não aparece numa tabela de artigo.
  texto[is.na(x)] <- "-"

  texto
}


# formatar_p() -----------------------------------------------------------------
#' Como escrever um p-valor no texto ou na tabela?
#'
#' Escreve o p-valor com vírgula e três casas (`"0,032"`). Um p muito
#' pequeno aparece como `"< 0,001"`, nunca como zero: o p nunca é zero, só
#' pequeno demais para três casas. Com `no_texto = TRUE`, já vem com a letra
#' p e o sinal certo, pronto para o meio de uma frase (`"p = 0,032"`,
#' `"p < 0,001"`). Onde não há p (a linha dos resíduos na ANOVA), um traço.
#'
#' @param p um p-valor ou um vetor deles
#' @param casas casas decimais (padrão 3)
#' @param no_texto FALSE (padrão) para tabela; TRUE para frase
#'
#' @return Um texto para cada p-valor.
#'
#' @examples
#' formatar_p(0.0321)
#' formatar_p(0.0004)
#' formatar_p(c(0.0321, 0.0004), no_texto = TRUE)
#'
#' @concept Formatar e exibir
#' @export
formatar_p <- function(p,
                       casas    = 3,
                       no_texto = FALSE) {

  # Conferimos a escolha antes de escrever.
  conferir_sim_ou_nao(no_texto, "no_texto")

  # Abaixo do menor valor que as casas mostram, escrevemos "< 0,001".
  limite <- 10^(-casas)
  texto  <- dplyr::case_when(
    p < limite ~ paste("<", formatar_numero(limite, casas)),
    .default   = formatar_numero(p, casas)
  )

  # Para o meio de uma frase, a letra p e o sinal: "p = 0,032" ou "p < 0,001".
  if (no_texto) {
    texto <- dplyr::case_when(p < limite ~ paste("p", texto),
                              .default   = paste("p =", texto))
  }

  # Onde não há p, um traço, como em formatar_numero().
  texto[is.na(p)] <- "-"

  texto
}


# exibir_tabela() --------------------------------------------------------------
#' Como mostrar uma tabela no relatório ou no Viewer?
#'
#' Transforma uma tabela (um data.frame ou tibble, já com os nomes de coluna
#' finais) numa tabela do flextable, com uma de duas aparências:
#'
#' - **ocean**: a tabela numerada e citada no texto do relatório Word,
#'   com Times New Roman, cabeçalho azul-marinho e linhas só em cima e
#'   embaixo, como pedem as revistas;
#' - **cinza**: a tabela só para olhar o resultado no Viewer do RStudio,
#'   com letra de console e fundo verde acinzentado.
#'
#' Para as tabelas de um resultado da ClaRa, use [exibir_teste()] e
#' [exibir_resumo()], que já trazem os nomes em português e os números com
#' vírgula.
#'
#' @param tabela a tabela, com uma linha por item e os nomes de coluna finais
#' @param tema "ocean" (padrão, relatório Word) ou "cinza" (Viewer)
#' @param mostrar_codigo TRUE imprime o código R antes da tabela
#'
#' @return Uma tabela do flextable. Ajustes extras entram com o pipe, como
#'   `flextable::bold(i = 1)`.
#'
#' @examples
#' resumo <- data.frame(Tratamento = c("ctrl", "trt1", "trt2"),
#'                      Média      = formatar_numero(c(5.032, 4.661, 5.526)))
#' exibir_tabela(resumo)
#' exibir_tabela(resumo, tema = "cinza")
#'
#' @concept Formatar e exibir
#' @export
exibir_tabela <- function(tabela,
                          tema           = c("ocean", "cinza"),
                          mostrar_codigo = FALSE) {

  # Guardamos o nome da tabela, como o aluno a chamou.
  nome_tabela <- nome_do_objeto(substitute(tabela), padrao = "tabela")

  # Conferimos as escolhas antes de montar a tabela.
  tema <- escolher_opcao(tema, c("ocean", "cinza"), "tema")
  conferir_sim_ou_nao(mostrar_codigo, "mostrar_codigo")
  if (!is.data.frame(tabela)) {
    stop("exibir_tabela() recebe uma tabela (data.frame ou tibble), ",
         "como resultado$resumo.", call. = FALSE)
  }

  # A receita: a tabela seguida do tema escolhido.
  receita <- paste0("# A tabela no tema ", tema, ".\n", nome_tabela, " |>\n  ",
                    temas_tabela[[tema]])

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(tabela), nome_tabela),
    pacotes        = "flextable",
    mostrar_codigo = mostrar_codigo
  )
}


# Peças das tabelas ------------------------------------------------------------
#
# Trechos de receita usados por exibir_tabela(), exibir_teste() e
# exibir_resumo(). Ficam dentro das receitas, para o código mostrado rodar
# copiado numa sessão sem a ClaRa.

# Os dois temas, como trecho de receita: tudo o que vem depois de "tabela |>".
temas_tabela <- list(
  ocean = "flextable() |>
  theme_booktabs() |>
  bg(part = \"header\", bg = \"#0F3B5F\") |>
  color(part = \"header\", color = \"white\") |>
  bold(part = \"header\") |>
  font(fontname = \"Times New Roman\", part = \"all\") |>
  fontsize(size = 10, part = \"all\") |>
  align(align = \"center\", part = \"all\") |>
  align(j = 1, align = \"left\", part = \"all\") |>
  padding(padding = 4, part = \"all\") |>
  autofit()",
  cinza = "flextable() |>
  border_remove() |>
  bg(bg = \"#E7EFEA\", part = \"body\") |>
  bg(bg = \"#C5D8CF\", part = \"header\") |>
  bold(part = \"header\") |>
  align(align = \"center\", part = \"all\") |>
  font(fontname = \"Consolas\", part = \"all\") |>
  fontsize(size = 9, part = \"all\") |>
  padding(padding = 5, part = \"all\") |>
  autofit()"
)

# A fonte de cada tema, para a nota de rodapé acompanhar a tabela.
fontes_tabela <- list(ocean = "Times New Roman", cinza = "Consolas")

# As duas funções pequenas que escrevem os números das tabelas, no começo
# das receitas. Na tabela, onde não há número fica a célula vazia.
trecho_numeros_tabela <- "# 1. Duas funções pequenas para escrever os números como no português.
com_virgula <- function(x, casas = 2) {
  case_when(is.na(x) ~ \"\",
            .default = formatC(x, format = \"f\", digits = casas, decimal.mark = \",\"))
}
texto_p <- function(p) {
  case_when(is.na(p)  ~ \"\",
            p < 0.001 ~ \"< 0,001\",
            .default  = com_virgula(p, 3))
}
"

# A nota de rodapé, quando o aluno passa uma: o código dela como ele o
# escreveu (textos$nota_tabela), em letra menor.
trecho_nota <- function(codigo_nota, tema) {
  if (is.null(codigo_nota)) return("")
  paste0("|>
  add_footer_lines(", codigo_nota, ") |>
  font(fontname = \"", fontes_tabela[[tema]], "\", part = \"footer\") |>
  fontsize(size = 9, part = \"footer\")")
}
