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
#  Como carregar no analise.R:
#
#      source(here::here("R", "clara.R"), encoding = "UTF-8")
#
#  Seções deste arquivo (Ctrl+Shift+O no RStudio mostra o sumário):
#    1. Comparar médias ........... comparar_medias()
#    2. Depois da comparação ...... medir_efeito(), grafico_medias()
#    3. Exibição no console ....... como o resultado aparece ao ser impresso
#    4. Motor das receitas ........ peças internas; o aluno não precisa abrir
#
#  As colunas podem ser escritas sem aspas (peso_g) ou com aspas ("peso_g").
# =============================================================================



# 1. Comparar médias -----------------------------------------------------------

# comparar_medias() ------------------------------------------------------------
#
# Pergunta: a média da resposta difere entre os grupos?
#
# Faz a análise completa da ANOVA de um fator, na ordem em que a estudamos:
# resumo dos grupos, ANOVA, pressupostos, comparações de Tukey e letras.
#
# Devolve uma lista. Cada parte se abre com $:
#   resultado$resumo        n, média, DP, EP, IC e letra de cada grupo
#   resultado$anova         a tabela da ANOVA
#   resultado$pressupostos  Shapiro-Wilk e Levene, com uma leitura de cada um
#   resultado$pares         todas as comparações de Tukey
#   resultado$modelo        o modelo aov(), para quem quiser ir além
#   resultado$dados         as observações usadas na análise
#
# Exemplo:
#   resultado <- plantas |>
#     comparar_medias(resposta = peso, grupos = tratamento)
#
comparar_medias <- function(dados,
                            resposta,
                            grupos,
                            confianca      = 0.95,
                            mostrar_codigo = FALSE) {

  # Guardamos o nome da tabela que o aluno usou (plantas, por exemplo).
  nome_dados <- nome_do_objeto(substitute(dados), padrao = "dados")

  # Guardamos os nomes das duas colunas, como o aluno as escreveu.
  coluna_resposta <- rlang::as_name(rlang::ensym(resposta))
  coluna_grupos   <- rlang::as_name(rlang::ensym(grupos))

  # Antes de calcular, conferimos se as colunas existem e servem para a ANOVA.
  conferir_colunas(dados, coluna_resposta, coluna_grupos)

  # A receita completa, com marcadores <<...>> que recebem os nomes acima.
  receita <- "
# 1. As observações da análise: só as linhas com resposta e grupo.
dados_analise <- <<DADOS>> |>
  filter(!is.na(<<RESPOSTA>>), !is.na(<<GRUPOS>>)) |>
  mutate(<<GRUPOS>> = factor(<<GRUPOS>>))

# 2. Resumo de cada grupo: tamanho, centro e dispersão da resposta.
resumo <- dados_analise |>
  group_by(<<GRUPOS>>) |>
  summarise(
    n      = n(),
    media  = mean(<<RESPOSTA>>),
    dp     = sd(<<RESPOSTA>>),
    ep     = dp / sqrt(n),
    ic_inf = media - qt(<<QUANTIL>>, df = n - 1) * ep,
    ic_sup = media + qt(<<QUANTIL>>, df = n - 1) * ep
  )

# 3. ANOVA de um fator: <<RESPOSTA>> explicado por <<GRUPOS>>.
modelo <- aov(<<RESPOSTA>> ~ <<GRUPOS>>, data = dados_analise)

anova <- modelo |>
  tidy() |>
  transmute(
    fonte = if_else(term == \"Residuals\", \"Resíduos\", term),
    gl    = df,
    sq    = sumsq,
    qm    = meansq,
    f     = statistic,
    p     = p.value
  )

# 4. Pressupostos: normalidade dos resíduos e igualdade das variâncias.
normalidade <- shapiro.test(residuals(modelo)) |> tidy()
variancias  <- leveneTest(<<RESPOSTA>> ~ <<GRUPOS>>, data = dados_analise) |> tidy()

pressupostos <- tibble(
  pressuposto = c(\"Normalidade dos resíduos\", \"Homogeneidade das variâncias\"),
  teste       = c(\"Shapiro-Wilk\", \"Levene\"),
  estatistica = c(normalidade$statistic, variancias$statistic),
  p           = c(normalidade$p.value, variancias$p.value)
) |>
  mutate(leitura = case_when(
    p >= <<ALFA>> ~ \"sem evidência contra o pressuposto\",
    p <  <<ALFA>> ~ \"pressuposto rejeitado: interpretar com cautela\"
  ))

# 5. Tukey: todos os pares de grupos, com p ajustado.
tukey <- TukeyHSD(modelo, conf.level = <<CONFIANCA>>)

pares <- tukey |>
  tidy() |>
  transmute(
    comparacao = contrast,
    diferenca  = estimate,
    ic_inf     = conf.low,
    ic_sup     = conf.high,
    p_ajustado = adj.p.value
  )

# 6. Letras: grupos com a mesma letra não diferiram. A maior média leva \"a\".
letras <- multcompLetters4(modelo, tukey, threshold = <<ALFA>>)$<<GRUPOS>>$Letters

resumo <- resumo |>
  mutate(letra = letras[as.character(<<GRUPOS>>)])

# 7. Tudo junto, numa lista com partes nomeadas.
list(
  resumo       = resumo,
  anova        = anova,
  pressupostos = pressupostos,
  pares        = pares,
  modelo       = modelo,
  dados        = dados_analise
)"

  # Trocamos os marcadores pelos nomes desta análise.
  receita <- preencher_receita(receita, list(
    DADOS     = nome_dados,
    RESPOSTA  = coluna_resposta,
    GRUPOS    = coluna_grupos,
    CONFIANCA = confianca,
    ALFA      = 1 - confianca,
    QUANTIL   = 1 - (1 - confianca) / 2
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  resultado <- executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(dados), nome_dados),
    pacotes        = c("dplyr", "broom", "car", "multcompView"),
    mostrar_codigo = mostrar_codigo
  )

  # Anotamos no resultado o que foi analisado; as outras funções vão precisar.
  resultado$nomes <- list(
    dados     = nome_dados,
    resposta  = coluna_resposta,
    grupos    = coluna_grupos,
    confianca = confianca
  )

  # Damos ao resultado uma etiqueta, para o console saber como exibi-lo.
  structure(resultado, class = "clara_medias")
}



# 2. Depois da comparação ------------------------------------------------------

# medir_efeito() ---------------------------------------------------------------
#
# Pergunta: a diferença entre os grupos é grande ou pequena?
#
# O p-valor diz se há evidência de diferença; o tamanho de efeito diz quanto
# da variação da resposta acompanha os grupos. η² é essa fração; ω² corrige
# o exagero do η² em amostras pequenas. A leitura segue a convenção de Cohen,
# uma referência estatística, não biológica.
#
# Exemplo:  resultado |> medir_efeito()
#
medir_efeito <- function(resultado,
                         mostrar_codigo = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # A receita: η² e ω² com intervalo de confiança, e a leitura de Cohen.
  receita <- "
# Tamanho de efeito da ANOVA, com intervalo de confiança.
eta   <- eta_squared(<<RESULTADO>>$modelo, partial = FALSE, ci = <<CONFIANCA>>)
omega <- omega_squared(<<RESULTADO>>$modelo, partial = FALSE, ci = <<CONFIANCA>>)

tibble(
  medida = c(\"η²\", \"ω²\"),
  valor  = c(eta$Eta2, omega$Omega2),
  ic_inf = c(eta$CI_low, omega$CI_low),
  ic_sup = c(eta$CI_high, omega$CI_high)
) |>
  mutate(leitura = case_when(
    valor < 0.01 ~ \"muito pequeno\",
    valor < 0.06 ~ \"pequeno\",
    valor < 0.14 ~ \"médio\",
    .default     = \"grande\"
  ))"

  # Trocamos os marcadores pelos nomes desta análise.
  receita <- preencher_receita(receita, list(
    RESULTADO = nome_resultado,
    CONFIANCA = resultado$nomes$confianca
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "effectsize"),
    mostrar_codigo = mostrar_codigo
  )
}


# grafico_medias() -------------------------------------------------------------
#
# Pergunta: como mostrar a comparação numa só figura?
#
# Cada ponto colorido é uma observação; o losango é a média do grupo; a haste
# é o intervalo de confiança da média; a letra vem do Tukey.
#
# Exemplo:
#   resultado |>
#     grafico_medias(rotulo_resposta = "Peso seco (g)",
#                    rotulo_grupos   = "Tratamento")
#
grafico_medias <- function(resultado,
                           rotulo_resposta = NULL,
                           rotulo_grupos   = NULL,
                           mostrar_codigo  = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Sem rótulo informado, os eixos mostram o próprio nome da coluna.
  rotulo_resposta <- ou_entao(rotulo_resposta, resultado$nomes$resposta)
  rotulo_grupos   <- ou_entao(rotulo_grupos,   resultado$nomes$grupos)

  # A receita do gráfico, camada por camada.
  receita <- "
# A letra fica acima do que estiver mais alto: o IC ou o maior ponto do grupo.
pontos <- <<RESULTADO>>$dados

posicao_letras <- pontos |>
  group_by(<<GRUPOS>>) |>
  summarise(ponto_mais_alto = max(<<RESPOSTA>>))

medias <- <<RESULTADO>>$resumo |>
  left_join(posicao_letras, by = \"<<GRUPOS>>\") |>
  mutate(altura_letra = pmax(ic_sup, ponto_mais_alto))

# Pontos das observações, média, intervalo de confiança e letras.
ggplot(medias, aes(x = <<GRUPOS>>)) +
  geom_jitter(
    data = pontos,
    aes(y = <<RESPOSTA>>, colour = <<GRUPOS>>),
    width = 0.10, size = 2.2, alpha = 0.7
  ) +
  geom_errorbar(
    aes(ymin = ic_inf, ymax = ic_sup),
    width = 0.15, linewidth = 0.8, colour = \"#0F3B5F\"
  ) +
  geom_point(aes(y = media), shape = 18, size = 4.4, colour = \"#0F3B5F\") +
  geom_text(
    aes(y = altura_letra, label = letra),
    vjust = -0.9, fontface = \"bold\", size = 4
  ) +
  scale_colour_manual(values = cores_ocean, guide = \"none\") +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.12))) +
  labs(x = \"<<ROTULO_GRUPOS>>\", y = \"<<ROTULO_RESPOSTA>>\") +
  theme_classic(base_size = 12)"

  # Trocamos os marcadores pelos nomes desta análise.
  receita <- preencher_receita(receita, list(
    RESULTADO       = nome_resultado,
    RESPOSTA        = resultado$nomes$resposta,
    GRUPOS          = resultado$nomes$grupos,
    ROTULO_RESPOSTA = rotulo_resposta,
    ROTULO_GRUPOS   = rotulo_grupos
  ))

  # Uma cor para cada grupo, mesmo quando há mais grupos que cores na paleta.
  quantos_grupos <- nrow(resultado$resumo)
  cores <- grDevices::colorRampPalette(cores_ocean)(max(quantos_grupos, 8))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado, cores),
                                      c(nome_resultado, "cores_ocean")),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}

# A paleta Ocean Gradient, ampliada para oito grupos.
cores_ocean <- c("#0F3B5F", "#2E7D8F", "#62B6B7", "#E89B3C",
                 "#E76F51", "#6A4C93", "#1B998B", "#B23A48")



# 3. Exibição no console -------------------------------------------------------
#
# Ao digitar o nome do resultado no console, o R chama esta função.
# Ela mostra a análise como um pequeno relatório, na ordem do estudo.

print.clara_medias <- function(x, ...) {

  # Separamos as peças que o relatório vai usar.
  nomes   <- x$nomes
  linha_f <- x$anova[1, ]
  alfa    <- 1 - nomes$confianca

  # A conclusão da ANOVA, escrita conforme o p-valor.
  conclusao <- dplyr::case_when(
    linha_f$p <  alfa ~ "há evidência de diferença entre as médias dos grupos.",
    linha_f$p >= alfa ~ "não há evidência de diferença entre as médias dos grupos."
  )

  # Título e tamanho da amostra.
  cat("\nComparação de médias:", nomes$resposta, "por", nomes$grupos, "\n")
  cat(nrow(x$dados), "observações em", nrow(x$resumo), "grupos\n")

  # Resumo dos grupos, com as letras do Tukey.
  cat("\n# Resumo dos grupos\n")
  print(x$resumo)

  # O resultado da ANOVA numa frase.
  cat("\n# ANOVA\n")
  cat("F(", linha_f$gl, ", ", x$anova$gl[2], ") = ", numero(linha_f$f), "; ",
      escrever_p(linha_f$p), ": ", conclusao, "\n", sep = "")

  # Os pressupostos, com a leitura de cada teste.
  cat("\n# Pressupostos\n")
  print(x$pressupostos)

  # Os pares do Tukey.
  cat("\n# Comparações de Tukey\n")
  print(x$pares)

  # Um lembrete das partes que podem ser abertas com $.
  cat("\nPartes do resultado: $resumo $anova $pressupostos $pares $modelo $dados\n")

  invisible(x)
}



# 4. Motor das receitas ---------------------------------------------------------
#
# Peças internas usadas pelas funções acima: conferir colunas, descobrir
# nomes, preencher a receita, mostrá-la e rodá-la.

# Confere, antes da análise, se as colunas existem e servem para a ANOVA.
conferir_colunas <- function(dados, coluna_resposta, coluna_grupos) {
  colunas_que_faltam <- setdiff(c(coluna_resposta, coluna_grupos), names(dados))
  nomes_com_simbolos <- make.names(c(coluna_resposta, coluna_grupos)) !=
    c(coluna_resposta, coluna_grupos)

  problema <- dplyr::case_when(
    length(colunas_que_faltam) > 0 ~
      paste("Coluna não encontrada nos dados:", toString(colunas_que_faltam)),
    any(nomes_com_simbolos) ~
      "Use nomes de coluna sem espaços nem símbolos, como peso_g. Renomeie com rename().",
    !is.numeric(dados[[coluna_resposta]]) ~
      "A resposta precisa ser numérica. Confira o tipo da coluna no preparo.",
    any(grepl("-", dados[[coluna_grupos]], fixed = TRUE)) ~
      "Há hífen no nome de um grupo; ele atrapalha as letras do Tukey. Renomeie os grupos.",
    dplyr::n_distinct(dados[[coluna_grupos]], na.rm = TRUE) < 2 ~
      "A comparação precisa de pelo menos dois grupos com dados.",
    .default = "nenhum"
  )

  if (problema != "nenhum") stop(problema, call. = FALSE)
}

# Descobre o nome do objeto que o aluno passou (plantas, resultado...).
# Se ele passou uma expressão longa, usamos um nome padrão.
nome_do_objeto <- function(expressao, padrao) {
  if (is.symbol(expressao)) deparse(expressao) else padrao
}

# Troca cada marcador <<NOME>> da receita pelo valor correspondente.
preencher_receita <- function(receita, valores) {
  for (marcador in names(valores)) {
    receita <- gsub(paste0("<<", marcador, ">>"), valores[[marcador]],
                    receita, fixed = TRUE)
  }
  trimws(receita)
}

# Imprime a receita com uma moldura, para o aluno copiar para o script.
mostrar_receita <- function(receita) {
  cat("\n# ---- Código R por trás da ClaRa: copie, cole e rode ----------\n\n")
  cat(receita, "\n")
  cat("\n# --------------------------------------------------------------\n\n")
}

# Roda a receita num espaço próprio, onde os objetos têm os nomes do aluno.
# Assim, o código mostrado e o código executado são o mesmo texto.
executar_receita <- function(receita, objetos, pacotes, mostrar_codigo) {
  for (pacote in pacotes) {
    suppressPackageStartupMessages(library(pacote, character.only = TRUE))
  }
  if (mostrar_codigo) mostrar_receita(receita)
  ambiente <- list2env(objetos, parent = globalenv())
  eval(parse(text = receita, keep.source = FALSE), envir = ambiente)
}

# Devolve o valor informado ou, se ele estiver vazio (NULL), a alternativa.
ou_entao <- function(valor, alternativa) {
  if (is.null(valor)) alternativa else valor
}

# Escreve um número com vírgula decimal, como no português.
numero <- function(x, casas = 2) {
  formatC(x, format = "f", digits = casas, decimal.mark = ",")
}

# Escreve o p-valor como no texto científico; um p muito pequeno nunca vira zero.
escrever_p <- function(p) {
  dplyr::case_when(
    p < 0.001 ~ "p < 0,001",
    .default  = paste("p =", numero(p, 3))
  )
}
