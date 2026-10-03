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
#  Como a ClaRa se organiza: cada pergunta da pesquisa tem dois verbos
#  próprios (a análise e o gráfico); dois verbos servem para qualquer
#  análise (medir o efeito e escrever os resultados).
#
#  Seções deste arquivo (Ctrl+Shift+O no RStudio mostra o sumário):
#    1. Comparar médias ........... comparar_medias(), grafico_medias()
#    2. Para qualquer análise ..... medir_efeito(), escrever_resultados()
#    3. Exibição no console ....... como o resultado aparece ao ser impresso
#    4. Ajuda ..................... ajuda()
#    5. Motor das receitas ........ peças internas; o aluno não precisa abrir
#
#  As colunas podem ser escritas sem aspas (peso_g) ou com aspas ("peso_g").
#  Para ver a lista de funções: ajuda(). Para uma delas: ajuda(comparar_medias).
# =============================================================================



# 1. Comparar médias -----------------------------------------------------------
#
# Pergunta: a média da resposta difere entre os grupos?
# Dois verbos: comparar_medias() faz a análise; grafico_medias() a desenha.
# A ClaRa escolhe o teste: teste t (de Welch ou de Student) com dois grupos,
# ANOVA com três ou mais.

# comparar_medias() ------------------------------------------------------------
#
# Pergunta: a média da resposta difere entre os grupos?
#
# A ClaRa escolhe o teste pelo número de grupos com dados:
#   dois grupos ........ teste t: de Welch (padrão, não supõe variâncias
#                        iguais) ou de Student (com variancias_iguais = TRUE);
#   três ou mais ....... ANOVA de um fator, com Tukey.
# Em qualquer caso, faz a análise na ordem em que a estudamos: resumo dos
# grupos, teste, pressupostos e letras.
#
# Argumentos:
#   dados ............... a tabela, com uma linha por observação
#   resposta ............ a coluna numérica medida (peso, comprimento...)
#   grupos .............. a coluna que diz o grupo de cada observação
#   confianca ........... nível de confiança dos intervalos (padrão 0.95);
#                         a significância dos testes é 1 - confianca
#   variancias_iguais ... só com dois grupos. FALSE (padrão): teste de Welch.
#                         TRUE: teste de Student, que supõe variâncias
#                         iguais; use quando a exploração dos dados já
#                         mostrou dispersões parecidas nos dois grupos
#   mostrar_codigo ...... TRUE imprime o código R antes do resultado
#
# Devolve uma lista. Cada parte se abre com $:
#   resultado$resumo        n, média, DP, EP, IC e letra de cada grupo
#   resultado$pressupostos  testes dos pressupostos, com uma leitura de cada um
#   resultado$amostra       observações no total, usadas e excluídas
#   resultado$dados         as observações usadas na análise
# Com três ou mais grupos (ANOVA):
#   resultado$anova         a tabela da ANOVA
#   resultado$pares         todas as comparações de Tukey
#   resultado$modelo        o modelo aov(), para quem quiser ir além
# Com dois grupos (teste t):
#   resultado$teste         diferença das médias, IC, t, gl e p
#
# Exemplo:
#   resultado <- plantas |>
#     comparar_medias(resposta = peso, grupos = tratamento)
#
comparar_medias <- function(dados,
                            resposta,
                            grupos,
                            confianca         = 0.95,
                            variancias_iguais = FALSE,
                            mostrar_codigo    = FALSE) {

  # Guardamos o nome da tabela que o aluno usou (plantas, por exemplo).
  nome_dados <- nome_do_objeto(substitute(dados), padrao = "dados")

  # Guardamos os nomes das duas colunas, como o aluno as escreveu.
  coluna_resposta <- rlang::as_name(rlang::ensym(resposta))
  coluna_grupos   <- rlang::as_name(rlang::ensym(grupos))

  # Antes de calcular, conferimos se as colunas existem e servem para comparar.
  conferir_colunas(dados, coluna_resposta, coluna_grupos)
  conferir_sim_ou_nao(variancias_iguais, "variancias_iguais")

  # Contamos os grupos que têm resposta: dois pedem o teste t; mais, a ANOVA.
  quantos_grupos <- dplyr::n_distinct(
    dados[[coluna_grupos]][!is.na(dados[[coluna_resposta]])],
    na.rm = TRUE
  )
  analise <- dplyr::case_when(quantos_grupos == 2 ~ "teste_t",
                              .default            = "anova")

  # No teste t, as variâncias decidem entre Welch e Student.
  variante <- dplyr::case_when(variancias_iguais ~ "student",
                               .default          = "welch")

  # Trocamos os marcadores da receita escolhida pelos nomes desta análise.
  # Os trechos da variante vêm primeiro, porque também têm marcadores.
  receita <- preencher_receita(receitas_medias[[analise]], c(
    variantes_teste_t[[variante]],
    list(
      DADOS             = nome_dados,
      RESPOSTA          = coluna_resposta,
      GRUPOS            = coluna_grupos,
      CONFIANCA         = confianca,
      ALFA              = 1 - confianca,
      QUANTIL           = 1 - (1 - confianca) / 2,
      VARIANCIAS_IGUAIS = variancias_iguais
    )
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  resultado <- executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(dados), nome_dados),
    pacotes        = pacotes_medias[[analise]],
    mostrar_codigo = mostrar_codigo
  )

  # Anotamos no resultado o que foi analisado; as outras funções vão precisar.
  resultado$nomes <- list(
    dados             = nome_dados,
    resposta          = coluna_resposta,
    grupos            = coluna_grupos,
    confianca         = confianca,
    analise           = analise,
    variancias_iguais = variancias_iguais
  )

  # Damos ao resultado uma etiqueta, para o console saber como exibi-lo.
  structure(resultado, class = "clara_medias")
}


# As receitas de comparar_medias() ---------------------------------------------
#
# Uma receita para cada caso. comparar_medias() escolhe uma e a preenche.

receitas_medias <- list()

# Três ou mais grupos: ANOVA de um fator, pressupostos, Tukey e letras.
receitas_medias$anova <- "
# 1. As observações da análise: só as linhas com resposta e grupo.
#    O droplevels() tira da lista os grupos que ficaram sem dados.
dados_analise <- <<DADOS>> |>
  filter(!is.na(<<RESPOSTA>>), !is.na(<<GRUPOS>>)) |>
  mutate(<<GRUPOS>> = factor(<<GRUPOS>>)) |>
  droplevels()

# Quantas observações havia, quantas entraram e quantas ficaram de fora.
amostra <- tibble(
  total     = nrow(<<DADOS>>),
  usadas    = nrow(dados_analise),
  excluidas = total - usadas
)

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
  amostra      = amostra,
  dados        = dados_analise
)"

# Dois grupos: teste t de Welch, normalidade em cada grupo e letras.
receitas_medias$teste_t <- "
# 1. As observações da análise: só as linhas com resposta e grupo.
#    O droplevels() tira da lista os grupos que ficaram sem dados.
dados_analise <- <<DADOS>> |>
  filter(!is.na(<<RESPOSTA>>), !is.na(<<GRUPOS>>)) |>
  mutate(<<GRUPOS>> = factor(<<GRUPOS>>)) |>
  droplevels()

# Quantas observações havia, quantas entraram e quantas ficaram de fora.
amostra <- tibble(
  total     = nrow(<<DADOS>>),
  usadas    = nrow(dados_analise),
  excluidas = total - usadas
)

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

# 3. <<TITULO_T>>
#    A diferença é a média do primeiro grupo menos a do segundo.
teste_t <- t.test(<<RESPOSTA>> ~ <<GRUPOS>>,
                  data       = dados_analise,
                  var.equal  = <<VARIANCIAS_IGUAIS>>,
                  conf.level = <<CONFIANCA>>)

teste <- teste_t |>
  tidy() |>
  transmute(
    comparacao = paste(levels(dados_analise$<<GRUPOS>>), collapse = \"-\"),
    diferenca  = estimate,
    ic_inf     = conf.low,
    ic_sup     = conf.high,
    t          = statistic,
    gl         = parameter,
    p          = p.value
  )

<<PRESSUPOSTOS_T>>

# 5. Letras, como no Tukey: grupos com a mesma letra não diferiram.
#    Havendo diferença, a maior média leva \"a\".
resumo <- resumo |>
  mutate(letra = case_when(
    teste$p >= <<ALFA>>     ~ \"a\",
    media == max(media) ~ \"a\",
    .default            = \"b\"
  ))

# 6. Tudo junto, numa lista com partes nomeadas.
list(
  resumo       = resumo,
  teste        = teste,
  pressupostos = pressupostos,
  amostra      = amostra,
  dados        = dados_analise
)"

# O que muda na receita do teste t entre Welch e Student: o título do
# passo 3 e os pressupostos (o Student supõe variâncias iguais e confere
# isso com o Levene; o Welch não precisa).
variantes_teste_t <- list()

variantes_teste_t$welch <- list(
  TITULO_T = "Teste t de Welch: compara as duas médias sem supor variâncias iguais.",
  PRESSUPOSTOS_T = "
# 4. Pressuposto: normalidade da resposta dentro de cada grupo.
#    O teste de Welch não exige variâncias iguais; por isso não há Levene.
pressupostos <- dados_analise |>
  group_by(<<GRUPOS>>) |>
  reframe(tidy(shapiro.test(<<RESPOSTA>>))) |>
  transmute(
    pressuposto = paste(\"Normalidade no grupo\", <<GRUPOS>>),
    teste       = \"Shapiro-Wilk\",
    estatistica = statistic,
    p           = p.value
  ) |>
  mutate(leitura = case_when(
    p >= <<ALFA>> ~ \"sem evidência contra o pressuposto\",
    p <  <<ALFA>> ~ \"pressuposto rejeitado: interpretar com cautela\"
  ))"
)

variantes_teste_t$student <- list(
  TITULO_T = "Teste t de Student: compara as duas médias supondo variâncias iguais.",
  PRESSUPOSTOS_T = "
# 4. Pressupostos: normalidade em cada grupo e igualdade das variâncias,
#    que o teste de Student supõe.
normalidade <- dados_analise |>
  group_by(<<GRUPOS>>) |>
  reframe(tidy(shapiro.test(<<RESPOSTA>>))) |>
  transmute(
    pressuposto = paste(\"Normalidade no grupo\", <<GRUPOS>>),
    teste       = \"Shapiro-Wilk\",
    estatistica = statistic,
    p           = p.value
  )

variancias <- leveneTest(<<RESPOSTA>> ~ <<GRUPOS>>, data = dados_analise) |>
  tidy() |>
  transmute(
    pressuposto = \"Homogeneidade das variâncias\",
    teste       = \"Levene\",
    estatistica = statistic,
    p           = p.value
  )

pressupostos <- bind_rows(normalidade, variancias) |>
  mutate(leitura = case_when(
    p >= <<ALFA>> ~ \"sem evidência contra o pressuposto\",
    p <  <<ALFA>> ~ \"pressuposto rejeitado: interpretar com cautela\"
  ))"
)

# Os pacotes que cada receita usa.
pacotes_medias <- list(
  anova   = c("dplyr", "broom", "car", "multcompView"),
  teste_t = c("dplyr", "broom", "car")
)


# grafico_medias() -------------------------------------------------------------
#
# Pergunta: como mostrar a comparação numa só figura?
#
# A barra clara vai do zero até a média; cada ponto colorido é uma
# observação; o losango é a média do grupo, com "média ± DP" ao lado; a haste
# é o intervalo de confiança da média; as letras, todas na mesma altura, vêm
# do Tukey (ou do teste t, com dois grupos).
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   rotulo_resposta ..... texto do eixo y; sem ele, vai o nome da coluna
#   rotulo_grupos ....... texto do eixo x; sem ele, vai o nome da coluna
#   mostrar_codigo ...... TRUE imprime o código R antes do gráfico
#
# Devolve um gráfico do ggplot2. Por isso dá para continuar com +:
#   resultado |>
#     grafico_medias() +
#     theme(axis.text = element_text(size = 14))
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
# As observações e as médias de cada grupo.
pontos <- <<RESULTADO>>$dados

# O rótulo \"média ± DP\" de cada grupo, com vírgula decimal.
medias <- <<RESULTADO>>$resumo |>
  mutate(
    media_dp = paste(
      formatC(media, format = \"f\", digits = 2, decimal.mark = \",\"),
      \"±\",
      formatC(dp, format = \"f\", digits = 2, decimal.mark = \",\")
    )
  )

# Todas as letras na mesma altura, acima do ponto ou do IC mais alto.
altura_letras <- max(pontos$<<RESPOSTA>>, medias$ic_sup)

# Barra até a média, pontos, IC, losango, rótulo e letras, nesta ordem.
ggplot(medias, aes(x = <<GRUPOS>>)) +
  geom_col(
    aes(y = media, fill = <<GRUPOS>>),
    width = 0.3, alpha = 0.25
  ) +
  geom_point(
    data     = pontos,
    aes(y = <<RESPOSTA>>, colour = <<GRUPOS>>),
    position = position_jitter(width = 0.08, height = 0, seed = 1),
    size     = 2.2,
    alpha    = 0.7
  ) +
  geom_errorbar(
    aes(ymin = ic_inf, ymax = ic_sup),
    width = 0.08, linewidth = 0.8, colour = \"#0F3B5F\"
  ) +
  geom_point(aes(y = media), shape = 18, size = 4.4, colour = \"#0F3B5F\") +
  geom_text(
    aes(y = media, label = media_dp),
    nudge_x = 0.06, hjust = 0,
    size = 3.6, fontface = \"bold\", colour = \"#0F3B5F\"
  ) +
  geom_text(
    aes(label = letra),
    y = altura_letras, vjust = -0.6,
    size = 6, fontface = \"bold\", colour = \"#0F3B5F\"
  ) +
  scale_colour_manual(values = cores_ocean, guide = \"none\") +
  scale_fill_manual(values = cores_ocean, guide = \"none\") +
  scale_x_discrete(expand = expansion(add = c(0.6, 0.9))) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = paste(
      \"Pontos: observações; losango: média; rótulo: média ± DP;\",
      \"hastes: IC <<NIVEL>>% da média.\\nLetras iguais: sem diferença significativa.\"
    ),
    x = \"<<ROTULO_GRUPOS>>\",
    y = \"<<ROTULO_RESPOSTA>>\"
  ) +
  theme_classic(base_size = 12) +
  theme(
    plot.title          = element_text(size = 10, colour = \"grey30\"),
    plot.title.position = \"plot\"
  )"

  # Trocamos os marcadores pelos nomes desta análise.
  receita <- preencher_receita(receita, list(
    RESULTADO       = nome_resultado,
    RESPOSTA        = resultado$nomes$resposta,
    GRUPOS          = resultado$nomes$grupos,
    ROTULO_RESPOSTA = rotulo_resposta,
    ROTULO_GRUPOS   = rotulo_grupos,
    NIVEL           = resultado$nomes$confianca * 100
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



# 2. Para qualquer análise -----------------------------------------------------
#
# Estas funções agem sobre o resultado de qualquer análise da ClaRa. Cada
# uma olha qual análise o resultado guarda e usa a receita daquela análise.
# Uma análise nova não cria funções aqui: só acrescenta receitas às listas.

# medir_efeito() ---------------------------------------------------------------
#
# Pergunta: o efeito encontrado é grande ou pequeno?
#
# O p-valor diz se há evidência de diferença; o tamanho de efeito diz quanto
# ela pesa. A medida depende da análise feita em comparar_medias():
#   ANOVA ....... η² é a fração da variação da resposta que acompanha os
#                 grupos; ω² corrige o exagero do η² em amostras pequenas.
#   teste t ..... d de Cohen é a diferença das médias medida em desvios
#                 padrão; g de Hedges corrige o exagero do d em amostras
#                 pequenas. O sinal segue a ordem da comparação.
# A leitura segue a convenção de Cohen, uma referência estatística, não
# biológica.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   mostrar_codigo ...... TRUE imprime o código R antes do resultado
#
# Devolve uma tabela: medida, valor, intervalo de confiança e leitura.
#
# Exemplo:  resultado |> medir_efeito()
#
medir_efeito <- function(resultado,
                         mostrar_codigo = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Trocamos os marcadores da receita da análise feita pelos nomes dela.
  receita <- preencher_receita(receitas_efeito[[resultado$nomes$analise]], list(
    RESULTADO         = nome_resultado,
    RESPOSTA          = resultado$nomes$resposta,
    GRUPOS            = resultado$nomes$grupos,
    CONFIANCA         = resultado$nomes$confianca,
    VARIANCIAS_IGUAIS = resultado$nomes$variancias_iguais
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "effectsize"),
    mostrar_codigo = mostrar_codigo
  )
}

# As receitas de medir_efeito(), uma para cada análise.
receitas_efeito <- list()

# ANOVA: η² e ω² com intervalo de confiança, e a leitura de Cohen.
receitas_efeito$anova <- "
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

# Teste t: d de Cohen e g de Hedges com intervalo, e a leitura de Cohen.
receitas_efeito$teste_t <- "
# Tamanho de efeito do teste t, com intervalo de confiança.
# pooled_sd = TRUE junta os DPs dos grupos, como o Student; FALSE não junta,
# como o Welch.
d <- cohens_d(<<RESPOSTA>> ~ <<GRUPOS>>,
              data      = <<RESULTADO>>$dados,
              pooled_sd = <<VARIANCIAS_IGUAIS>>,
              ci        = <<CONFIANCA>>)
g <- hedges_g(<<RESPOSTA>> ~ <<GRUPOS>>,
              data      = <<RESULTADO>>$dados,
              pooled_sd = <<VARIANCIAS_IGUAIS>>,
              ci        = <<CONFIANCA>>)

tibble(
  medida = c(\"d de Cohen\", \"g de Hedges\"),
  valor  = c(d$Cohens_d, g$Hedges_g),
  ic_inf = c(d$CI_low, g$CI_low),
  ic_sup = c(d$CI_high, g$CI_high)
) |>
  mutate(leitura = case_when(
    abs(valor) < 0.2 ~ \"muito pequeno\",
    abs(valor) < 0.5 ~ \"pequeno\",
    abs(valor) < 0.8 ~ \"médio\",
    .default         = \"grande\"
  ))"


# escrever_resultados() --------------------------------------------------------
#
# Pergunta: como contar o resultado em frases, para o relatório?
#
# Escreve as frases de um relatório a partir do resultado: a amostra, o
# teste, o tamanho de efeito, as comparações entre pares (ANOVA), os
# pressupostos, um alerta sobre o que pede cuidado e, quando muda a leitura,
# o poder do teste. Os números e as conclusões vêm do resultado: se os dados
# mudam, as frases mudam junto.
#
# É uma função só para todas as análises. Ela olha qual análise o resultado
# guarda (ANOVA ou teste t) e escolhe a receita daquela análise. Por isso,
# com mostrar_codigo = TRUE, aparece só o código da análise que você fez,
# nunca o das outras. Quando a ClaRa ganhar uma análise nova, a função
# continua a mesma: só a lista de receitas cresce.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   rotulo_resposta ..... como chamar a resposta no texto (ex.: "Peso (g)")
#   rotulo_grupos ....... como chamar os grupos no texto (ex.: "Tipo de Ração")
#   mostrar_codigo ...... TRUE imprime o código R antes das frases
#
# Devolve uma lista de frases. Cada parte se abre com $:
#   textos$amostra, textos$teste, textos$efeito, textos$pressupostos,
#   textos$alerta, textos$poder (vazio quando não se aplica), textos$sintese
#   e, na ANOVA, textos$comparacoes.
# No Quarto, a frase entra no meio do parágrafo com `r textos$teste`.
#
# Exemplo:
#   textos <- resultado |>
#     escrever_resultados(rotulo_resposta = "Peso seco (g)",
#                         rotulo_grupos   = "Tratamento")
#
escrever_resultados <- function(resultado,
                                rotulo_resposta = NULL,
                                rotulo_grupos   = NULL,
                                mostrar_codigo  = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Sem rótulo informado, o texto usa o próprio nome da coluna.
  rotulo_resposta <- ou_entao(rotulo_resposta, resultado$nomes$resposta)
  rotulo_grupos   <- ou_entao(rotulo_grupos,   resultado$nomes$grupos)

  # Trocamos os marcadores da receita da análise feita pelos nomes dela.
  receita <- preencher_receita(receitas_textos[[resultado$nomes$analise]], list(
    RESULTADO         = nome_resultado,
    RESPOSTA          = resultado$nomes$resposta,
    GRUPOS            = resultado$nomes$grupos,
    ROTULO_RESPOSTA   = rotulo_resposta,
    ROTULO_GRUPOS     = rotulo_grupos,
    ALFA              = 1 - resultado$nomes$confianca,
    NIVEL             = resultado$nomes$confianca * 100,
    VARIANCIAS_IGUAIS = resultado$nomes$variancias_iguais,
    NOME_T            = dplyr::case_when(resultado$nomes$variancias_iguais ~ "de Student",
                                         .default = "de Welch")
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  textos <- executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "stringr", "effectsize", "pwr"),
    mostrar_codigo = mostrar_codigo
  )

  # Damos às frases uma etiqueta, para o console saber como exibi-las.
  structure(textos, class = "clara_textos")
}

# As receitas de escrever_resultados(), uma para cada análise.
receitas_textos <- list()

# ANOVA: amostra, F, η² e ω², Tukey, pressupostos, alerta, poder e síntese.
receitas_textos$anova <- "
# 1. Números com vírgula decimal, e o p como se escreve em texto científico.
com_virgula <- function(x, casas = 2) {
  formatC(x, format = \"f\", digits = casas, decimal.mark = \",\")
}
texto_p <- function(p) {
  case_when(p < 0.001 ~ \"p < 0,001\",
            .default  = paste(\"p =\", com_virgula(p, 3)))
}

# 2. As peças do resultado que as frases usam.
alfa         <- <<ALFA>>
amostra      <- <<RESULTADO>>$amostra
resumo       <- <<RESULTADO>>$resumo
linha_f      <- <<RESULTADO>>$anova[1, ]
gl_residuos  <- <<RESULTADO>>$anova$gl[2]
pares        <- <<RESULTADO>>$pares
pressupostos <- <<RESULTADO>>$pressupostos

# 3. A amostra: quantas observações entraram e quantas ficaram de fora.
excluidas <- case_when(
  amostra$excluidas == 0 ~ \"nenhuma foi excluída\",
  amostra$excluidas == 1 ~ \"1 foi excluída por não ter resposta ou grupo\",
  .default = paste(amostra$excluidas,
                   \"foram excluídas por não terem resposta ou grupo\")
)
texto_amostra <- str_glue(
  \"Após o preparo, havia {amostra$total} observações. A análise usou \",
  \"{amostra$usadas} delas, em {nrow(resumo)} grupos; {excluidas}.\"
)

# 4. A ANOVA numa frase, com a conclusão escrita conforme o p.
evidencia <- case_when(
  linha_f$p <  alfa ~ \"houve evidência de diferença entre as médias\",
  linha_f$p >= alfa ~ \"não houve evidência de diferença entre as médias\"
)
texto_teste <- str_glue(
  \"Em <<ROTULO_RESPOSTA>>, {evidencia} dos grupos de <<ROTULO_GRUPOS>> \",
  \"(F({linha_f$gl}, {gl_residuos}) = {com_virgula(linha_f$f)}; {texto_p(linha_f$p)}).\"
)

# 5. Tamanho de efeito, com a leitura de Cohen.
eta2   <- eta_squared(<<RESULTADO>>$modelo, partial = FALSE)$Eta2
omega2 <- omega_squared(<<RESULTADO>>$modelo, partial = FALSE)$Omega2
classe <- case_when(
  eta2 < 0.01 ~ \"muito pequeno\",
  eta2 < 0.06 ~ \"pequeno\",
  eta2 < 0.14 ~ \"médio\",
  .default    = \"grande\"
)
texto_efeito <- str_glue(
  \"O tamanho de efeito foi {classe} pela convenção de Cohen \",
  \"(η² = {com_virgula(eta2, 3)}; ω² = {com_virgula(omega2, 3)}), \",
  \"uma referência estatística, não biológica.\"
)

# 6. Tukey: quais pares de grupos diferiram.
diferentes <- pares |>
  filter(p_ajustado < alfa) |>
  mutate(frase = paste0(str_replace(comparacao, \"-\", \" e \"),
                        \" (\", texto_p(p_ajustado), \")\"))
texto_comparacoes <- case_when(
  linha_f$p >= alfa ~
    \"Como a ANOVA não indicou diferença global, as comparações de Tukey servem só para descrição.\",
  nrow(diferentes) == 0 ~
    \"Pelo teste de Tukey, nenhum par de grupos diferiu ao nível adotado, apesar da diferença global indicada pela ANOVA.\",
  nrow(diferentes) == 1 ~
    paste0(\"Pelo teste de Tukey, só diferiram \", diferentes$frase[1],
           \". Grupos que compartilham uma letra não diferiram entre si.\"),
  .default =
    paste0(\"Pelo teste de Tukey, diferiram os pares \",
           paste(diferentes$frase, collapse = \"; \"),
           \". Grupos que compartilham uma letra não diferiram entre si.\")
)

# 7. Pressupostos: o que cada teste mostrou, sem transformar p alto em prova.
frases <- pressupostos |>
  mutate(
    avaliacao = case_when(p >= alfa ~ \"sem evidência contra o pressuposto\",
                          .default  = \"o teste rejeitou o pressuposto\"),
    frase = str_glue(\"{pressuposto}, pelo {teste} (estatística = \",
                     \"{com_virgula(estatistica, 3)}; {texto_p(p)}): {avaliacao}.\")
  )
texto_pressupostos <- paste(
  paste(frases$frase, collapse = \" \"),
  \"Esses testes não comprovam os pressupostos; os gráficos dos resíduos e o delineamento completam a avaliação.\"
)

# 8. Alerta: o que pede cuidado antes de concluir. Com todos os grupos
#    grandes (regra prática: 30 ou mais), a ANOVA é pouco sensível a
#    desvios moderados da normalidade.
p_levene  <- pressupostos$p[pressupostos$teste == \"Levene\"]
p_shapiro <- pressupostos$p[pressupostos$teste == \"Shapiro-Wilk\"]
razao_dp  <- max(resumo$dp) / min(resumo$dp)
texto_alerta <- case_when(
  any(p_levene < alfa) ~
    paste0(\"As variâncias diferiram entre os grupos (o maior desvio padrão é \",
           com_virgula(razao_dp, 1), \" vezes o menor). Antes de concluir, \",
           \"compare com um método que não suponha variâncias iguais, como a ANOVA de Welch.\"),
  any(p_shapiro < alfa) & min(resumo$n) >= 30 ~
    paste0(\"Os resíduos se afastaram da normalidade, mas com todos os grupos grandes \",
           \"(30 ou mais observações) a ANOVA é pouco sensível a esse desvio. Confira no \",
           \"gráfico Q-Q se não há assimetria forte ou valores extremos.\"),
  any(p_shapiro < alfa) ~
    paste0(\"Os resíduos se afastaram da normalidade. Avalie o tamanho do desvio \",
           \"no gráfico Q-Q e, se for preciso, uma alternativa como o teste de Kruskal-Wallis.\"),
  .default =
    \"Os testes formais não detectaram os desvios examinados, mas os gráficos e o delineamento continuam necessários.\"
)

# 9. Poder do teste: só entra no texto quando muda a leitura, isto é, sem
#    evidência e com poder abaixo de 80%. pwr.anova.test() supõe grupos do
#    mesmo tamanho; usamos o n médio por grupo.
poder <- pwr.anova.test(
  k         = nrow(resumo),
  n         = mean(resumo$n),
  f         = sqrt(eta2 / (1 - eta2)),
  sig.level = alfa
)$power
texto_poder <- case_when(
  linha_f$p >= alfa & poder < 0.80 ~
    paste0(\"A ausência de evidência não deve ser lida como ausência de efeito: \",
           \"para o tamanho de efeito observado, o poder do teste foi de apenas \",
           com_virgula(100 * poder, 0), \"%. Uma amostra maior daria mais segurança à conclusão.\"),
  .default = \"\"
)

# 10. Síntese: o resultado principal numa frase só.
texto_sintese <- str_glue(
  \"Na amostra de {amostra$usadas} observações em {nrow(resumo)} grupos, {evidencia} \",
  \"(F({linha_f$gl}, {gl_residuos}) = {com_virgula(linha_f$f)}; {texto_p(linha_f$p)}; \",
  \"η² = {com_virgula(eta2, 3)}). A interpretação deve considerar os pressupostos e o delineamento.\"
)

# 11. Todas as frases, numa lista com partes nomeadas.
list(
  amostra      = texto_amostra,
  teste        = texto_teste,
  efeito       = texto_efeito,
  comparacoes  = texto_comparacoes,
  pressupostos = texto_pressupostos,
  alerta       = texto_alerta,
  poder        = texto_poder,
  sintese      = texto_sintese
) |>
  lapply(as.character)"

# Teste t: amostra, t com a diferença e o IC, d e g, pressupostos, alerta,
# poder e síntese.
receitas_textos$teste_t <- "
# 1. Números com vírgula decimal, e o p como se escreve em texto científico.
com_virgula <- function(x, casas = 2) {
  formatC(x, format = \"f\", digits = casas, decimal.mark = \",\")
}
texto_p <- function(p) {
  case_when(p < 0.001 ~ \"p < 0,001\",
            .default  = paste(\"p =\", com_virgula(p, 3)))
}

# 2. As peças do resultado que as frases usam.
alfa         <- <<ALFA>>
amostra      <- <<RESULTADO>>$amostra
resumo       <- <<RESULTADO>>$resumo
teste        <- <<RESULTADO>>$teste
pressupostos <- <<RESULTADO>>$pressupostos
grupos       <- levels(<<RESULTADO>>$dados$<<GRUPOS>>)

# 3. A amostra: quantas observações entraram e quantas ficaram de fora.
excluidas <- case_when(
  amostra$excluidas == 0 ~ \"nenhuma foi excluída\",
  amostra$excluidas == 1 ~ \"1 foi excluída por não ter resposta ou grupo\",
  .default = paste(amostra$excluidas,
                   \"foram excluídas por não terem resposta ou grupo\")
)
texto_amostra <- str_glue(
  \"Após o preparo, havia {amostra$total} observações. A análise usou \",
  \"{amostra$usadas} delas, em {nrow(resumo)} grupos; {excluidas}.\"
)

# 4. O teste t numa frase, com a diferença entre as médias e seu intervalo.
#    Os graus de liberdade só levam casas decimais quando não são inteiros.
evidencia <- case_when(
  teste$p <  alfa ~ \"houve evidência de diferença entre as médias\",
  teste$p >= alfa ~ \"não houve evidência de diferença entre as médias\"
)
casas_gl <- case_when(teste$gl == round(teste$gl) ~ 0, .default = 2)
texto_teste <- str_glue(
  \"Em <<ROTULO_RESPOSTA>>, {evidencia} de {grupos[1]} e {grupos[2]} \",
  \"pelo teste t <<NOME_T>> (t({com_virgula(teste$gl, casas_gl)}) = \",
  \"{com_virgula(teste$t)}; {texto_p(teste$p)}). A média de {grupos[1]} \",
  \"menos a de {grupos[2]} foi {com_virgula(teste$diferenca)}, com IC <<NIVEL>>% \",
  \"de {com_virgula(teste$ic_inf)} a {com_virgula(teste$ic_sup)}.\"
)

# 5. Tamanho de efeito, com a leitura de Cohen. pooled_sd segue o teste:
#    TRUE junta os DPs dos grupos (Student); FALSE não junta (Welch).
d <- cohens_d(<<RESPOSTA>> ~ <<GRUPOS>>,
              data      = <<RESULTADO>>$dados,
              pooled_sd = <<VARIANCIAS_IGUAIS>>)$Cohens_d
g <- hedges_g(<<RESPOSTA>> ~ <<GRUPOS>>,
              data      = <<RESULTADO>>$dados,
              pooled_sd = <<VARIANCIAS_IGUAIS>>)$Hedges_g
classe <- case_when(
  abs(d) < 0.2 ~ \"muito pequeno\",
  abs(d) < 0.5 ~ \"pequeno\",
  abs(d) < 0.8 ~ \"médio\",
  .default     = \"grande\"
)
texto_efeito <- str_glue(
  \"O tamanho de efeito foi {classe} pela convenção de Cohen \",
  \"(d = {com_virgula(d)}; g = {com_virgula(g)}), \",
  \"uma referência estatística, não biológica.\"
)

# 6. Pressupostos: o que cada teste mostrou, sem transformar p alto em prova.
frases <- pressupostos |>
  mutate(
    avaliacao = case_when(p >= alfa ~ \"sem evidência contra o pressuposto\",
                          .default  = \"o teste rejeitou o pressuposto\"),
    frase = str_glue(\"{pressuposto}, pelo {teste} (estatística = \",
                     \"{com_virgula(estatistica, 3)}; {texto_p(p)}): {avaliacao}.\")
  )
texto_pressupostos <- paste(
  paste(frases$frase, collapse = \" \"),
  \"Esses testes não comprovam os pressupostos; os gráficos e o delineamento completam a avaliação.\"
)

# 7. Alerta: o que pede cuidado antes de concluir. Com os dois grupos
#    grandes (regra prática: 30 ou mais), o teste t é pouco sensível a
#    desvios moderados da normalidade.
p_levene  <- pressupostos$p[pressupostos$teste == \"Levene\"]
p_shapiro <- pressupostos$p[pressupostos$teste == \"Shapiro-Wilk\"]
razao_dp  <- max(resumo$dp) / min(resumo$dp)
texto_alerta <- case_when(
  any(p_levene < alfa) ~
    paste0(\"As variâncias diferiram entre os grupos (o maior desvio padrão é \",
           com_virgula(razao_dp, 1), \" vezes o menor). Prefira o teste t de Welch, \",
           \"que não supõe variâncias iguais (variancias_iguais = FALSE).\"),
  any(p_shapiro < alfa) & min(resumo$n) >= 30 ~
    paste0(\"A resposta se afastou da normalidade, mas com os dois grupos grandes \",
           \"(30 ou mais observações) o teste t é pouco sensível a esse desvio. Confira \",
           \"nos gráficos se não há assimetria forte ou valores extremos.\"),
  any(p_shapiro < alfa) ~
    paste0(\"A resposta se afastou da normalidade em pelo menos um grupo. Avalie o \",
           \"tamanho do desvio nos gráficos e, se for preciso, uma alternativa como o \",
           \"teste de Mann-Whitney.\"),
  .default =
    \"Os testes formais não detectaram os desvios examinados, mas os gráficos e o delineamento continuam necessários.\"
)

# 8. Poder do teste: só entra no texto quando muda a leitura, isto é, sem
#    evidência e com poder abaixo de 80%.
poder <- pwr.t2n.test(
  n1        = resumo$n[1],
  n2        = resumo$n[2],
  d         = abs(d),
  sig.level = alfa
)$power
texto_poder <- case_when(
  teste$p >= alfa & poder < 0.80 ~
    paste0(\"A ausência de evidência não deve ser lida como ausência de efeito: \",
           \"para o tamanho de efeito observado, o poder do teste foi de apenas \",
           com_virgula(100 * poder, 0), \"%. Uma amostra maior daria mais segurança à conclusão.\"),
  .default = \"\"
)

# 9. Síntese: o resultado principal numa frase só.
texto_sintese <- str_glue(
  \"Na amostra de {amostra$usadas} observações em dois grupos, {evidencia} \",
  \"(t({com_virgula(teste$gl, casas_gl)}) = {com_virgula(teste$t)}; {texto_p(teste$p)}; \",
  \"d = {com_virgula(d)}). A interpretação deve considerar os pressupostos e o delineamento.\"
)

# 10. Todas as frases, numa lista com partes nomeadas.
list(
  amostra      = texto_amostra,
  teste        = texto_teste,
  efeito       = texto_efeito,
  pressupostos = texto_pressupostos,
  alerta       = texto_alerta,
  poder        = texto_poder,
  sintese      = texto_sintese
) |>
  lapply(as.character)"



# 3. Exibição no console -------------------------------------------------------
#
# Ao digitar o nome do resultado no console, o R chama esta função.
# Ela mostra a análise como um pequeno relatório, na ordem do estudo.

print.clara_medias <- function(x, ...) {

  # Título e tamanho da amostra.
  cat("\nComparação de médias:", x$nomes$resposta, "por", x$nomes$grupos, "\n")
  cat(nrow(x$dados), "observações em", nrow(x$resumo), "grupos")

  # Avisamos quando linhas ficaram de fora por falta de resposta ou grupo.
  if (x$amostra$excluidas > 0) {
    cat(" (", x$amostra$excluidas, " de ", x$amostra$total,
        " excluídas por falta de resposta ou grupo)", sep = "")
  }
  cat("\n")

  # Resumo dos grupos, com as letras.
  cat("\n# Resumo dos grupos\n")
  print(x$resumo)

  # O restante depende do teste que a ClaRa escolheu.
  if (x$nomes$analise == "teste_t") imprimir_teste_t(x) else imprimir_anova(x)

  invisible(x)
}

# A parte do relatório da ANOVA: F, pressupostos e Tukey.
imprimir_anova <- function(x) {

  # A linha do fator na tabela da ANOVA.
  linha_f <- x$anova[1, ]

  # O resultado da ANOVA numa frase.
  cat("\n# ANOVA\n")
  cat("F(", linha_f$gl, ", ", x$anova$gl[2], ") = ", numero(linha_f$f), "; ",
      escrever_p(linha_f$p), ": ",
      concluir_medias(linha_f$p, x$nomes$confianca), "\n", sep = "")

  # Os pressupostos, com a leitura de cada teste.
  cat("\n# Pressupostos\n")
  print(x$pressupostos)

  # Os pares do Tukey.
  cat("\n# Comparações de Tukey\n")
  print(x$pares)

  # Um lembrete das partes que podem ser abertas com $.
  cat("\nPartes do resultado: $resumo $anova $pressupostos $pares $modelo $amostra $dados\n")
}

# A parte do relatório do teste t: t, diferença com IC e pressupostos.
imprimir_teste_t <- function(x) {

  # A única linha da tabela do teste, e qual dos dois testes t rodou.
  teste <- x$teste
  nome_teste <- dplyr::case_when(x$nomes$variancias_iguais ~ "Student",
                                 .default                  = "Welch")

  # Por que não há ANOVA, e o resultado do teste numa frase.
  cat("\n# Teste t de ", nome_teste, "\n", sep = "")
  cat("Com dois grupos, a ClaRa usa o teste t no lugar da ANOVA.\n")

  # Os graus de liberdade só levam casas decimais quando não são inteiros (Welch).
  casas_gl <- dplyr::case_when(teste$gl == round(teste$gl) ~ 0, .default = 2)
  cat("t(", numero(teste$gl, casas_gl), ") = ", numero(teste$t), "; ",
      escrever_p(teste$p), ": ",
      concluir_medias(teste$p, x$nomes$confianca), "\n", sep = "")

  # A diferença entre as médias, com o intervalo de confiança.
  cat("Diferença ", teste$comparacao, ": ", numero(teste$diferenca),
      " (IC ", x$nomes$confianca * 100, "%: ", numero(teste$ic_inf),
      " a ", numero(teste$ic_sup), ")\n", sep = "")

  # Os pressupostos, com a leitura de cada teste.
  cat("\n# Pressupostos\n")
  print(x$pressupostos)

  # Um lembrete sobre as variâncias, conforme o teste e o que o Levene mostrou.
  levene_rejeitou <- any(x$pressupostos$teste == "Levene" &
                           x$pressupostos$p < 1 - x$nomes$confianca)
  cat(dplyr::case_when(
    !x$nomes$variancias_iguais ~
      "O teste de Welch não exige variâncias iguais; por isso não há Levene.",
    levene_rejeitou ~
      "O Levene rejeitou a igualdade das variâncias: prefira o Welch (variancias_iguais = FALSE).",
    .default =
      "O teste de Student supõe variâncias iguais; o Levene não mostrou evidência contra."
  ), "\n", sep = "")

  # Um lembrete das partes que podem ser abertas com $.
  cat("\nPartes do resultado: $resumo $teste $pressupostos $amostra $dados\n")
}

# As frases de escrever_resultados(), uma parte por bloco, na largura da tela.
print.clara_textos <- function(x, ...) {

  # Título.
  cat("\nTextos para o relatório\n=======================\n")

  # Cada frase com o nome da parte; partes vazias (como $poder) não aparecem.
  for (parte in names(x)) {
    if (nzchar(x[[parte]])) {
      cat("\n$", parte, "\n", sep = "")
      cat(strwrap(x[[parte]], width = 76), sep = "\n")
    }
  }

  # Como levar uma frase para o Quarto.
  cat("\nNo Quarto, use dentro do texto: `r textos$teste` (troque textos pelo nome do seu objeto).\n")

  invisible(x)
}

# A conclusão da comparação, escrita conforme o p-valor.
concluir_medias <- function(p, confianca) {
  dplyr::case_when(
    p <  1 - confianca ~ "há evidência de diferença entre as médias dos grupos.",
    p >= 1 - confianca ~ "não há evidência de diferença entre as médias dos grupos."
  )
}



# 4. Ajuda ---------------------------------------------------------------------

# ajuda() ----------------------------------------------------------------------
#
# Pergunta: o que faz uma função da ClaRa e como usá-la?
#
# Mostra no console o cabeçalho da função, o mesmo que está escrito acima
# dela neste arquivo: a pergunta, o que faz, os argumentos, o que devolve e
# um exemplo. Sem nome de função, lista todas as funções da ClaRa.
#
# Argumentos:
#   funcao .............. o nome da função, com ou sem aspas
#
# Exemplo:
#   ajuda()
#   ajuda(comparar_medias)
#
ajuda <- function(funcao) {

  # Lemos este arquivo, onde cada função tem seu cabeçalho de ajuda.
  linhas <- readLines(arquivo_clara, encoding = "UTF-8")

  # Cada cabeçalho começa com uma linha como "# comparar_medias() ------".
  inicios <- grep("^# [a-z_]+\\(\\) -+$", linhas)
  funcoes <- sub("^# ([a-z_]+)\\(\\) -+$", "\\1", linhas[inicios])

  # Sem nome de função, mostramos a lista de todas, agrupadas pela seção do
  # arquivo, com a pergunta de cada uma.
  if (missing(funcao)) {
    return(listar_funcoes(linhas, inicios, funcoes))
  }

  # O nome que o aluno pediu, escrito com ou sem aspas.
  nome <- rlang::as_name(rlang::ensym(funcao))

  # Se não for uma função da ClaRa, dizemos quais existem.
  if (!is.element(nome, funcoes)) {
    stop("Não há ajuda da ClaRa para ", nome, ". As funções da ClaRa são: ",
         toString(funcoes), ".", call. = FALSE)
  }

  # O cabeçalho é o bloco de comentários logo abaixo da linha de título.
  texto <- bloco_de_comentarios(linhas, inicios[funcoes == nome])

  # Mostramos o título e o cabeçalho, sem os # do começo das linhas.
  cat("\n", nome, "()\n", strrep("=", nchar(nome) + 2), "\n", sep = "")
  cat(texto, sep = "\n")
  cat("\n")

  invisible(nome)
}

# Lista as funções da ClaRa, cada uma com a pergunta que responde, agrupadas
# pela seção do arquivo onde moram (como "Comparar médias").
listar_funcoes <- function(linhas, inicios, funcoes) {
  perguntas <- vapply(inicios, function(inicio) {
    texto <- bloco_de_comentarios(linhas, inicio)
    sub("^Pergunta: ", "", grep("^Pergunta: ", texto, value = TRUE)[1])
  }, character(1))

  # A seção de cada função é o último título "# N. Nome ----" antes dela.
  titulos <- grep("^# [0-9]+\\. .+ -{4,}$", linhas)
  secoes  <- vapply(inicios, function(inicio) {
    sub("^# [0-9]+\\. (.+?) -{4,}$", "\\1", linhas[max(titulos[titulos < inicio])])
  }, character(1))

  nomes   <- paste0(funcoes, "()")
  largura <- max(nchar(nomes))

  cat("\nFunções da ClaRa\n================\n")
  for (secao in unique(secoes)) {
    cat("\n", secao, "\n", sep = "")
    escolhidas <- secoes == secao
    cat(paste0("  ", formatC(nomes[escolhidas], width = -largura), "  ",
               perguntas[escolhidas]),
        sep = "\n")
  }
  cat("\nPara saber mais sobre uma delas: ajuda(comparar_medias)\n\n")

  invisible(funcoes)
}

# Devolve o bloco de comentários que vem logo depois da linha de título,
# sem o "# " do começo e sem linhas vazias nas pontas.
bloco_de_comentarios <- function(linhas, inicio) {
  depois  <- linhas[(inicio + 1):length(linhas)]
  tamanho <- match(FALSE, startsWith(depois, "#")) - 1
  texto   <- sub("^# ?", "", depois[seq_len(tamanho)])
  preenchidas <- which(nzchar(texto))
  texto[min(preenchidas):max(preenchidas)]
}



# 5. Motor das receitas ---------------------------------------------------------
#
# Peças internas usadas pelas funções acima: conferir colunas, descobrir
# nomes, preencher a receita, mostrá-la e rodá-la.

# Confere, antes da análise, se as colunas existem e servem para comparar.
conferir_colunas <- function(dados, coluna_resposta, coluna_grupos) {
  colunas_que_faltam <- setdiff(c(coluna_resposta, coluna_grupos), names(dados))
  nomes_com_simbolos <- make.names(c(coluna_resposta, coluna_grupos)) !=
    c(coluna_resposta, coluna_grupos)
  grupos_com_resposta <- as.character(
    dados[[coluna_grupos]][!is.na(dados[[coluna_resposta]])]
  )

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
    any(table(grupos_com_resposta) < 3) ~
      "Cada grupo precisa de pelo menos 3 observações com resposta.",
    .default = "nenhum"
  )

  if (problema != "nenhum") stop(problema, call. = FALSE)
}

# Confere se um argumento de sim ou não recebeu TRUE ou FALSE.
conferir_sim_ou_nao <- function(valor, nome_argumento) {
  if (!isTRUE(valor) && !isFALSE(valor)) {
    stop(nome_argumento, " aceita só TRUE ou FALSE.", call. = FALSE)
  }
}

# Descobre o nome do objeto que o aluno passou (plantas, resultado...).
# Se ele passou uma expressão longa, usamos um nome padrão.
nome_do_objeto <- function(expressao, padrao) {
  if (is.symbol(expressao)) deparse(expressao) else padrao
}

# Troca cada marcador <<NOME>> da receita pelo valor correspondente.
preencher_receita <- function(receita, valores) {
  for (marcador in names(valores)) {
    receita <- gsub(paste0("<<", marcador, ">>"), trimws(valores[[marcador]]),
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

# Descobre o caminho deste arquivo durante o source(). O source() mais
# recente é o que está lendo a ClaRa, mesmo quando um roteiro chama outro.
caminho_da_clara <- function() {
  for (quadro in rev(sys.frames())) {
    if (is.character(quadro$ofile)) return(normalizePath(quadro$ofile))
  }
  "R/clara.R"
}

# O caminho fica guardado; ajuda() lê os cabeçalhos das funções dele.
arquivo_clara <- caminho_da_clara()
