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
#  Como a ClaRa se organiza: cada pergunta da pesquisa tem a sua análise e
#  os seus gráficos (um nome para cada figura); quatro verbos servem para
#  qualquer análise (medir o efeito, escrever os resultados e olhar os
#  resíduos em dois gráficos).
#
#  Seções deste arquivo (Ctrl+Shift+O no RStudio mostra o sumário):
#    1. Comparar médias ........... comparar_medias(), grafico_medias(),
#                                   grafico_boxplot(), grafico_pares()
#    2. Para qualquer análise ..... medir_efeito(), escrever_resultados(),
#                                   grafico_residuos(), grafico_qq()
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
# comparar_medias() faz a análise; três gráficos a mostram, cada um com o
# seu nome: grafico_medias() (a figura principal), grafico_boxplot() (a
# exploração) e grafico_pares() (a diferença de cada par).
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
# A figura principal, a que vai para o relatório, o artigo ou a tese. Por
# padrão: a barra clara vai do zero até a média; cada ponto colorido é uma
# observação; o losango é a média do grupo, com "média ± DP" ao lado; a
# haste é o intervalo de confiança da média; as letras, todas na mesma
# altura, vêm do Tukey (ou do teste t, com dois grupos). Cada parte pode ser
# ligada ou desligada, e a receita mostrada traz só as partes pedidas.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   rotulo_resposta ..... texto do eixo y; sem ele, vai o nome da coluna
#   rotulo_grupos ....... texto do eixo x; sem ele, vai o nome da coluna
#   titulo .............. título da figura (padrão: sem título)
#   explicacao .......... TRUE (padrão) escreve no topo o que cada elemento
#                         mostra; FALSE tira, para a explicação ir para a
#                         legenda do artigo
#   haste ............... o que a haste mostra: "ic" (padrão, intervalo de
#                         confiança da média), "ep" (média ± erro padrão) ou
#                         "dp" (média ± desvio padrão). No RStudio, digite
#                         haste = e aperte Tab para ver as opções
#   mostrar_barras ...... TRUE (padrão) desenha a barra clara até a média
#   largura_barras ...... largura das barras, de 0 a 1 (padrão 0.3; 1 encosta
#                         uma barra na outra); o rótulo em pé acompanha
#   mostrar_pontos ...... TRUE (padrão) desenha cada observação
#   mostrar_media_dp .... TRUE (padrão) escreve "média ± DP" ao lado do losango
#   casas ............... casas decimais do rótulo média ± DP (padrão 2)
#   angulo_rotulo ....... ângulo do rótulo média ± DP, em graus. Sem ele: 0
#                         (deitado, ao lado do losango) até 6 grupos e -90
#                         com mais: em pé, dentro da barra, no meio da
#                         altura dela, lido de cima para baixo, sem invadir
#                         a coluna vizinha (90 lê de baixo para cima). Com
#                         mais de 8 grupos, a função avisa e sugere mostrar
#                         as médias numa tabela.
#   altura_rotulo ....... altura do rótulo em pé dentro da coluna, como
#                         fração da altura dela: 0.5 (padrão) no meio, 0.2
#                         perto da base, 0.8 perto do topo (com haste
#                         longa, valores altos encostam nela)
#                         Sem barras, fica deitado: em pé, sairia cortado
#                         embaixo. Com muitos grupos e sem barras, prefira
#                         mostrar_media_dp = FALSE
#   mostrar_letras ...... TRUE (padrão) escreve as letras das comparações
#   cores ............... "ocean" (padrão), "cinza" (para impressão em preto e
#                         branco) ou um vetor de cores, como
#                         c("darkgreen", "orange"); Tab mostra as paletas
#   tamanho_texto ....... tamanho base do texto (padrão 12); o rótulo, as
#                         letras e a explicação acompanham
#   fonte ............... "sans" (padrão; Arial no Windows) ou "serif"
#                         (Times New Roman no Windows), para todos os textos
#                         da figura, inclusive o rótulo e as letras
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
#   resultado |>
#     grafico_medias(rotulo_resposta = "Peso seco (g)",
#                    explicacao      = FALSE,
#                    haste           = "ep",
#                    cores           = "cinza")
#
grafico_medias <- function(resultado,
                           rotulo_resposta  = NULL,
                           rotulo_grupos    = NULL,
                           titulo           = NULL,
                           explicacao       = TRUE,
                           haste            = c("ic", "ep", "dp"),
                           mostrar_barras   = TRUE,
                           largura_barras   = 0.3,
                           mostrar_pontos   = TRUE,
                           mostrar_media_dp = TRUE,
                           casas            = 2,
                           angulo_rotulo    = NULL,
                           altura_rotulo    = 0.5,
                           mostrar_letras   = TRUE,
                           cores            = c("ocean", "cinza"),
                           tamanho_texto    = 12,
                           fonte            = c("sans", "serif"),
                           mostrar_codigo   = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Conferimos as escolhas antes de desenhar. Nas opções listadas no padrão
  # (que o Tab do RStudio mostra), sem escolha vale a primeira.
  haste <- escolher_opcao(haste, c("ic", "ep", "dp"), "haste")
  fonte <- escolher_opcao(fonte, c("sans", "serif"), "fonte")
  if (identical(cores, c("ocean", "cinza"))) cores <- "ocean"
  conferir_fracao(largura_barras, "largura_barras")
  conferir_fracao(altura_rotulo,  "altura_rotulo")
  conferir_sim_ou_nao(explicacao,       "explicacao")
  conferir_sim_ou_nao(mostrar_barras,   "mostrar_barras")
  conferir_sim_ou_nao(mostrar_pontos,   "mostrar_pontos")
  conferir_sim_ou_nao(mostrar_media_dp, "mostrar_media_dp")
  conferir_sim_ou_nao(mostrar_letras,   "mostrar_letras")
  vetor_cores <- escolher_cores(cores)

  # Sem rótulo informado, os eixos mostram o próprio nome da coluna.
  rotulo_resposta <- ou_entao(rotulo_resposta, resultado$nomes$resposta)
  rotulo_grupos   <- ou_entao(rotulo_grupos,   resultado$nomes$grupos)

  # Com mais de 8 grupos, a figura fica carregada: avisamos e sugerimos tabela.
  quantos_grupos <- nrow(resultado$resumo)
  if (quantos_grupos > 8) {
    warning("Com ", quantos_grupos, " grupos, a figura fica carregada e os rótulos ",
            "ficam pequenos e apertados. Considere mostrar as médias numa tabela ",
            "(resultado$resumo) e usar mostrar_media_dp = FALSE na figura.",
            call. = FALSE)
  }

  # Com muitos grupos, o rótulo fica em pé, para não invadir a coluna vizinha.
  # Deitado, fica ao lado do losango. Em pé, fica dentro da barra, no meio da
  # altura dela, lido de cima para baixo (-90 graus); sem barras, fica ao
  # lado do losango, na altura da média.
  angulo_rotulo <- ou_entao(angulo_rotulo,
                            dplyr::case_when(mostrar_barras & quantos_grupos > 6 ~ -90,
                                             .default = 0))
  deitado      <- angulo_rotulo == 0
  dentro_barra <- !deitado & mostrar_barras

  # Os limites da haste e o nome dela na explicação.
  limites <- list(
    ic = c("ic_inf",     "ic_sup",     paste0("IC ", resultado$nomes$confianca * 100, "% da média")),
    ep = c("media - ep", "media + ep", "média ± EP"),
    dp = c("media - dp", "media + dp", "média ± DP")
  )[[haste]]

  # A explicação do topo cita só as partes que aparecem na figura.
  partes <- c(if (mostrar_pontos) "pontos: observações",
              "losango: média",
              if (mostrar_media_dp) "rótulo: média ± DP",
              paste("hastes:", limites[3]))
  texto_explicacao <- paste0(paste(partes, collapse = "; "), ".",
                             if (mostrar_letras) "\\nLetras iguais: sem diferença significativa.")
  texto_explicacao <- paste0(toupper(substr(texto_explicacao, 1, 1)),
                             substring(texto_explicacao, 2))

  # O preparo: só os objetos que as camadas pedidas vão usar.
  t <- trechos_grafico_medias
  preparo <- c(
    if (mostrar_barras || mostrar_pontos) trecho_de_cores(vetor_cores),
    if (mostrar_pontos) t$pontos,
    t$medias,
    if (mostrar_media_dp) t$media_dp,
    if (mostrar_letras && mostrar_pontos) t$altura_com_pontos,
    if (mostrar_letras && !mostrar_pontos) t$altura_sem_pontos
  )

  # Os textos da figura: título, explicação e eixos.
  linhas_labs <- c(
    if (!is.null(titulo)) "    title    = \"<<TITULO>>\",",
    if (explicacao) "    subtitle = \"<<EXPLICACAO>>\",",
    "    x        = \"<<ROTULO_GRUPOS>>\",",
    "    y        = \"<<ROTULO_RESPOSTA>>\""
  )

  # As camadas pedidas, na ordem em que se empilham, ligadas por +.
  camadas <- c(
    t$base,
    if (mostrar_barras) t$barras,
    if (mostrar_pontos) t$pontos_camada,
    t$haste,
    t$media,
    if (mostrar_media_dp) t$rotulo,
    if (mostrar_letras) t$letras,
    if (mostrar_pontos) t$escala_cor,
    if (mostrar_barras) t$escala_preenchimento,
    t$escala_x,
    t$escala_y,
    paste(c("  labs(", linhas_labs, "  )"), collapse = "\n"),
    t$tema
  )
  receita <- paste(c(trimws(preparo),
                     paste0("# A figura, camada por camada.\n",
                            paste(camadas, collapse = " +\n"))),
                   collapse = "\n\n")

  # Trocamos os marcadores pelos nomes e pelas escolhas desta figura.
  receita <- preencher_receita(receita, list(
    RESULTADO          = nome_resultado,
    RESPOSTA           = resultado$nomes$resposta,
    GRUPOS             = resultado$nomes$grupos,
    ROTULO_RESPOSTA    = rotulo_resposta,
    ROTULO_GRUPOS      = rotulo_grupos,
    TITULO             = ou_entao(titulo, ""),
    EXPLICACAO         = texto_explicacao,
    NOME_HASTE         = limites[3],
    HASTE_INF          = limites[1],
    HASTE_SUP          = limites[2],
    CASAS              = casas,
    ANGULO             = angulo_rotulo,
    Y_ROTULO           = dplyr::case_when(dentro_barra ~ paste("media *", altura_rotulo),
                                          .default     = "media"),
    LARGURA            = largura_barras,
    NUDGE_ROTULO       = dplyr::case_when(deitado      ~ 0.06,
                                          dentro_barra ~ 0,
                                          .default     = 0.2),
    HJUST              = dplyr::case_when(deitado ~ 0, .default = 0.5),
    TAMANHO            = tamanho_texto,
    FAMILIA_TEXTO      = dplyr::case_when(fonte == "serif" ~ ", family = \"serif\"",
                                          .default         = ""),
    FAMILIA_TEMA       = dplyr::case_when(fonte == "serif" ~ ", base_family = \"serif\"",
                                          .default         = ""),
    TAMANHO_ROTULO     = round(3.6 * tamanho_texto / 12, 1),
    TAMANHO_LETRAS     = round(6 * tamanho_texto / 12, 1),
    TAMANHO_EXPLICACAO = round(10 * tamanho_texto / 12, 1),
    FOLGA_BAIXO        = dplyr::case_when(mostrar_barras ~ 0, .default = 0.05)
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}

# Os trechos da receita de grafico_medias(). A função escolhe os que a
# figura pedida usa e os junta, na ordem, numa receita só.
trechos_grafico_medias <- list()

# Preparo: as observações de cada grupo.
trechos_grafico_medias$pontos <- "
# As observações de cada grupo.
pontos <- <<RESULTADO>>$dados"

# Preparo: as médias, com os limites da haste.
trechos_grafico_medias$medias <- "
# As médias de cada grupo, com os limites da haste (<<NOME_HASTE>>).
medias <- <<RESULTADO>>$resumo |>
  mutate(
    haste_inf = <<HASTE_INF>>,
    haste_sup = <<HASTE_SUP>>
  )"

# Preparo: o rótulo média ± DP.
trechos_grafico_medias$media_dp <- "
# O rótulo \"média ± DP\" de cada grupo, com vírgula decimal.
medias <- medias |>
  mutate(
    media_dp = paste(
      formatC(media, format = \"f\", digits = <<CASAS>>, decimal.mark = \",\"),
      \"±\",
      formatC(dp, format = \"f\", digits = <<CASAS>>, decimal.mark = \",\")
    )
  )"

# Preparo: a altura das letras, com e sem os pontos na figura.
trechos_grafico_medias$altura_com_pontos <- "
# Todas as letras na mesma altura, acima do ponto ou da haste mais alta.
altura_letras <- max(pontos$<<RESPOSTA>>, medias$haste_sup)"

trechos_grafico_medias$altura_sem_pontos <- "
# Todas as letras na mesma altura, acima da haste mais alta.
altura_letras <- max(medias$haste_sup)"

# Camadas da figura, uma por trecho.
trechos_grafico_medias$base <- "ggplot(medias, aes(x = <<GRUPOS>>))"

trechos_grafico_medias$barras <- "  geom_col(
    aes(y = media, fill = <<GRUPOS>>),
    width = <<LARGURA>>, alpha = 0.25
  )"

trechos_grafico_medias$pontos_camada <- "  geom_point(
    data     = pontos,
    aes(y = <<RESPOSTA>>, colour = <<GRUPOS>>),
    position = position_jitter(width = 0.08, height = 0, seed = 1),
    size     = 2.2,
    alpha    = 0.7
  )"

trechos_grafico_medias$haste <- "  geom_errorbar(
    aes(ymin = haste_inf, ymax = haste_sup),
    width = 0.08, linewidth = 0.8, colour = \"#0F3B5F\"
  )"

trechos_grafico_medias$media <- "  geom_point(aes(y = media), shape = 18, size = 4.4, colour = \"#0F3B5F\")"

trechos_grafico_medias$rotulo <- "  geom_text(
    aes(y = <<Y_ROTULO>>, label = media_dp),
    nudge_x = <<NUDGE_ROTULO>>, angle = <<ANGULO>>, hjust = <<HJUST>>, vjust = 0.5,
    size = <<TAMANHO_ROTULO>>, fontface = \"bold\", colour = \"#0F3B5F\"<<FAMILIA_TEXTO>>
  )"

trechos_grafico_medias$letras <- "  geom_text(
    aes(label = letra),
    y = altura_letras, vjust = -0.6,
    size = <<TAMANHO_LETRAS>>, fontface = \"bold\", colour = \"#0F3B5F\"<<FAMILIA_TEXTO>>
  )"

trechos_grafico_medias$escala_cor <- "  scale_colour_manual(values = cores, guide = \"none\")"

trechos_grafico_medias$escala_preenchimento <- "  scale_fill_manual(values = cores, guide = \"none\")"

trechos_grafico_medias$escala_x <- "  scale_x_discrete(expand = expansion(add = c(0.6, 0.9)))"

trechos_grafico_medias$escala_y <- "  scale_y_continuous(expand = expansion(mult = c(<<FOLGA_BAIXO>>, 0.15)))"

trechos_grafico_medias$tema <- "  theme_classic(base_size = <<TAMANHO>><<FAMILIA_TEMA>>) +
  theme(
    plot.title          = element_text(colour = \"#0F3B5F\"),
    plot.subtitle       = element_text(size = <<TAMANHO_EXPLICACAO>>, colour = \"grey30\"),
    plot.title.position = \"plot\"
  )"

# grafico_boxplot() ------------------------------------------------------------
#
# Pergunta: como se distribuem as observações em cada grupo?
#
# A figura da exploração, para olhar os dados antes de concluir. A caixa
# mostra a mediana e a metade central dos dados; os pontos são as
# observações. Caixas de alturas muito diferentes sugerem variâncias
# diferentes; pontos muito afastados merecem uma conferência na planilha.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   rotulo_resposta ..... texto do eixo y; sem ele, vai o nome da coluna
#   rotulo_grupos ....... texto do eixo x; sem ele, vai o nome da coluna
#   mostrar_codigo ...... TRUE imprime o código R antes do gráfico
#
# Devolve um gráfico do ggplot2; ajustes extras entram com +.
#
# Exemplo:
#   resultado |>
#     grafico_boxplot(rotulo_resposta = "Peso (g)",
#                     rotulo_grupos   = "Tipo de Ração")
#
grafico_boxplot <- function(resultado,
                            rotulo_resposta = NULL,
                            rotulo_grupos   = NULL,
                            mostrar_codigo  = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Sem rótulo informado, os eixos mostram o próprio nome da coluna.
  rotulo_resposta <- ou_entao(rotulo_resposta, resultado$nomes$resposta)
  rotulo_grupos   <- ou_entao(rotulo_grupos,   resultado$nomes$grupos)

  # Trocamos os marcadores pelos nomes desta análise.
  receita <- preencher_receita(receita_grafico_boxplot, list(
    RESULTADO       = nome_resultado,
    RESPOSTA        = resultado$nomes$resposta,
    GRUPOS          = resultado$nomes$grupos,
    ROTULO_RESPOSTA = rotulo_resposta,
    ROTULO_GRUPOS   = rotulo_grupos
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}

# A receita de grafico_boxplot(): caixas com as observações por cima.
receita_grafico_boxplot <- "
# Caixas com as observações por cima: mediana, metade central dos dados e
# cada observação de cada grupo.
ggplot(<<RESULTADO>>$dados, aes(x = <<GRUPOS>>, y = <<RESPOSTA>>)) +
  geom_boxplot(width = 0.5, outlier.shape = NA, colour = \"grey50\") +
  geom_point(
    position = position_jitter(width = 0.05, height = 0, seed = 1),
    size     = 1.5,
    alpha    = 0.5
  ) +
  labs(
    title = paste(\"Caixa: mediana e metade central dos dados; pontos: as observações.\",
                  \"Confira se as caixas têm alturas parecidas e se há pontos muito afastados.\",
                  sep = \"\\n\"),
    x     = \"<<ROTULO_GRUPOS>>\",
    y     = \"<<ROTULO_RESPOSTA>>\"
  ) +
  theme_classic(base_size = 12) +
  theme(plot.title = element_text(size = 10, colour = \"grey30\"),
        plot.title.position = \"plot\")"

# grafico_pares() --------------------------------------------------------------
#
# Pergunta: quais pares de grupos diferem, e por quanto?
#
# Cada linha compara dois grupos: o ponto é a diferença entre as médias e a
# haste, o seu intervalo de confiança. A linha tracejada vertical marca a
# diferença zero: haste que cruza a linha, sem diferença entre os dois
# grupos; haste toda de um lado, diferença. Em "B-A", a diferença é a média
# de B menos a média de A. Na ANOVA, os pares e os intervalos vêm do Tukey;
# no teste t, há um par só, com o intervalo do próprio teste.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   rotulo_resposta ..... a resposta no texto do eixo x; sem ele, vai o nome da coluna
#   rotulo_grupos ....... os grupos no texto do eixo y; sem ele, vai o nome da coluna
#   mostrar_codigo ...... TRUE imprime o código R antes do gráfico
#
# Devolve um gráfico do ggplot2; ajustes extras entram com +. Com muitos
# grupos (10 grupos dão 45 pares), salve a figura mais alta.
#
# Exemplo:
#   resultado |>
#     grafico_pares(rotulo_resposta = "Peso (g)",
#                   rotulo_grupos   = "Tipo de Ração")
#
grafico_pares <- function(resultado,
                          rotulo_resposta = NULL,
                          rotulo_grupos   = NULL,
                          mostrar_codigo  = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Sem rótulo informado, os eixos mostram o próprio nome da coluna.
  rotulo_resposta <- ou_entao(rotulo_resposta, resultado$nomes$resposta)
  rotulo_grupos   <- ou_entao(rotulo_grupos,   resultado$nomes$grupos)

  # Na ANOVA, os pares vêm do Tukey; no teste t, do próprio teste.
  anova <- resultado$nomes$analise == "anova"
  parte_pares <- dplyr::case_when(anova ~ "pares", .default = "teste")
  metodo <- dplyr::case_when(
    anova                             ~ "Tukey",
    resultado$nomes$variancias_iguais ~ "teste t de Student",
    .default                          = "teste t de Welch"
  )

  # Trocamos os marcadores pelos nomes desta análise.
  receita <- preencher_receita(receita_grafico_pares, list(
    RESULTADO       = nome_resultado,
    ROTULO_RESPOSTA = rotulo_resposta,
    ROTULO_GRUPOS   = rotulo_grupos,
    NIVEL           = resultado$nomes$confianca * 100,
    PARTE_PARES     = parte_pares,
    METODO          = metodo
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}

# A receita de grafico_pares(): a diferença de cada par, com o IC.
receita_grafico_pares <- "
# As comparações entre pares, na ordem da tabela, de cima para baixo.
# Em \"B-A\", a diferença é a média de B menos a média de A.
pares <- <<RESULTADO>>$<<PARTE_PARES>> |>
  mutate(comparacao = factor(comparacao, levels = rev(comparacao)))

# Ponto: a diferença; haste: o IC; linha tracejada: a diferença zero.
ggplot(pares, aes(x = diferenca, y = comparacao)) +
  geom_vline(xintercept = 0, linetype = \"dashed\", colour = \"grey60\") +
  geom_errorbar(
    aes(xmin = ic_inf, xmax = ic_sup),
    width = 0.2, linewidth = 0.8, colour = \"#2E7D8F\", orientation = \"y\"
  ) +
  geom_point(size = 3, colour = \"#0F3B5F\") +
  labs(
    title = paste(\"Ponto: diferença entre as médias do par; haste: IC <<NIVEL>>% (<<METODO>>).\",
                  \"Linha tracejada: diferença zero. Haste que cruza a linha: sem diferença entre os dois grupos.\",
                  sep = \"\\n\"),
    x     = \"Diferença entre as médias de <<ROTULO_RESPOSTA>>\",
    y     = \"Pares de <<ROTULO_GRUPOS>>\"
  ) +
  theme_classic(base_size = 12) +
  theme(plot.title = element_text(size = 10, colour = \"grey30\"),
        plot.title.position = \"plot\")"

# As paletas que o aluno escolhe pelo nome: a Ocean Gradient (oito cores) e
# uma em cinza, para revistas impressas em preto e branco.
paletas_clara <- list(
  ocean = c("#0F3B5F", "#2E7D8F", "#62B6B7", "#E89B3C",
            "#E76F51", "#6A4C93", "#1B998B", "#B23A48"),
  cinza = c("grey25", "grey70")
)

# Escreve um vetor de cores como código R, quatro por linha.
escrever_vetor <- function(valores) {
  textos <- paste0("\"", valores, "\"")
  linhas <- split(textos, ceiling(seq_along(textos) / 4))
  paste0("c(", paste(vapply(linhas, paste, character(1), collapse = ", "),
                     collapse = ",\n           "), ")")
}

# O trecho de cores que abre as receitas de gráfico. Com mais grupos que
# cores, colorRampPalette() cria cores intermediárias. Fica dentro da receita
# para o código mostrado rodar sozinho, sem a ClaRa.
trecho_de_cores <- function(vetor) {
  paste0("
# Cores: uma para cada grupo (intermediárias, se houver mais grupos que cores).
cores <- ", escrever_vetor(vetor), "
cores <- colorRampPalette(cores)(max(length(cores), nlevels(<<RESULTADO>>$dados$<<GRUPOS>>)))")
}

# O trecho com a paleta Ocean, usado pelos gráficos de diagnóstico.
trecho_cores <- trecho_de_cores(paletas_clara$ocean)



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



# grafico_residuos() -----------------------------------------------------------
#
# Pergunta: as variâncias dos grupos são parecidas?
#
# Resíduos contra os valores ajustados (as médias dos grupos): cada grupo
# forma uma faixa vertical. Faixas de alturas parecidas indicam variâncias
# parecidas; uma faixa muito mais alta que as outras pede cautela. O gráfico
# completa o teste de Levene: o teste dá um p, o gráfico mostra qual grupo
# se afasta e quanto.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   rotulo_grupos ....... nome dos grupos na legenda; sem ele, vai o da coluna
#   mostrar_codigo ...... TRUE imprime o código R antes do gráfico
#
# Devolve um gráfico do ggplot2; ajustes extras entram com +.
#
# Exemplo:
#   resultado |>
#     grafico_residuos(rotulo_grupos = "Tipo de Ração")
#
grafico_residuos <- function(resultado,
                             rotulo_grupos  = NULL,
                             mostrar_codigo = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Sem rótulo informado, a legenda mostra o próprio nome da coluna.
  rotulo_grupos <- ou_entao(rotulo_grupos, resultado$nomes$grupos)

  # Trocamos os marcadores da receita da análise feita.
  receita <- preencher_receita(receitas_residuos[[resultado$nomes$analise]], list(
    RESULTADO     = nome_resultado,
    RESPOSTA      = resultado$nomes$resposta,
    GRUPOS        = resultado$nomes$grupos,
    ROTULO_GRUPOS = rotulo_grupos
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}


# grafico_qq() -----------------------------------------------------------------
#
# Pergunta: os resíduos são compatíveis com a distribuição normal?
#
# Gráfico Q-Q: os resíduos contra os quantis da distribuição normal. Pontos
# perto da reta indicam resíduos compatíveis com a normal; caudas que se
# afastam indicam assimetria ou valores extremos. Na ANOVA, usa os resíduos
# padronizados do modelo; no teste t, há um painel por grupo, como o
# Shapiro-Wilk em cada grupo. O gráfico completa o Shapiro-Wilk: o teste dá
# um p, o gráfico mostra onde está o desvio e de que tamanho ele é.
#
# Argumentos:
#   resultado ........... o que comparar_medias() devolveu
#   mostrar_codigo ...... TRUE imprime o código R antes do gráfico
#
# Devolve um gráfico do ggplot2; ajustes extras entram com +.
#
# Exemplo:
#   resultado |>
#     grafico_qq()
#
grafico_qq <- function(resultado,
                       mostrar_codigo = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Trocamos os marcadores da receita da análise feita.
  receita <- preencher_receita(receitas_qq[[resultado$nomes$analise]], list(
    RESULTADO = nome_resultado,
    RESPOSTA  = resultado$nomes$resposta,
    GRUPOS    = resultado$nomes$grupos
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}

# Os trechos das receitas de grafico_residuos() e grafico_qq(): o preparo
# dos resíduos depende da análise; o desenho, do gráfico.
trechos_diagnostico <- list()

# ANOVA: os resíduos vêm do modelo.
trechos_diagnostico$preparo_anova <- "
# Resíduos e valores ajustados do modelo, ao lado de cada observação.
diagnostico <- <<RESULTADO>>$dados |>
  mutate(
    ajustado    = fitted(<<RESULTADO>>$modelo),
    residuo     = residuals(<<RESULTADO>>$modelo),
    padronizado = rstandard(<<RESULTADO>>$modelo)
  )"

# Teste t: o resíduo é a distância de cada observação até a média do grupo.
trechos_diagnostico$preparo_teste_t <- "
# Resíduo: o quanto cada observação se afasta da média do seu grupo.
diagnostico <- <<RESULTADO>>$dados |>
  group_by(<<GRUPOS>>) |>
  mutate(
    ajustado = mean(<<RESPOSTA>>),
    residuo  = <<RESPOSTA>> - ajustado
  ) |>
  ungroup()"

# Resíduos contra ajustados: o mesmo gráfico para as duas análises.
trechos_diagnostico$residuos <- "
# Resíduos contra os ajustados: uma faixa vertical por grupo.
ggplot(diagnostico, aes(x = ajustado, y = residuo, colour = <<GRUPOS>>)) +
  geom_hline(yintercept = 0, linetype = \"dashed\", colour = \"grey40\") +
  geom_point(size = 2.2, alpha = 0.7) +
  scale_colour_manual(values = cores) +
  labs(
    title  = \"Faixas de alturas parecidas indicam variâncias parecidas entre os grupos.\",
    x      = \"Valores ajustados (médias dos grupos)\",
    y      = \"Resíduos\",
    colour = \"<<ROTULO_GRUPOS>>\"
  ) +
  theme_classic(base_size = 12) +
  theme(plot.title = element_text(size = 10, colour = \"grey30\"),
        plot.title.position = \"plot\")"

# Q-Q da ANOVA: todos os resíduos padronizados juntos.
trechos_diagnostico$qq_anova <- "
# Q-Q: os resíduos padronizados contra os quantis da distribuição normal.
ggplot(diagnostico, aes(sample = padronizado)) +
  stat_qq(size = 2.2, alpha = 0.7, colour = \"#2E7D8F\") +
  stat_qq_line(colour = \"#E76F51\") +
  labs(
    title = paste(\"Pontos perto da reta: resíduos compatíveis com a normal.\",
                  \"Caudas que se afastam indicam assimetria ou valores extremos.\",
                  sep = \"\\n\"),
    x     = \"Quantis teóricos\",
    y     = \"Resíduos padronizados\"
  ) +
  theme_classic(base_size = 12) +
  theme(plot.title = element_text(size = 10, colour = \"grey30\"),
        plot.title.position = \"plot\")"

# Q-Q do teste t: um painel por grupo, como o Shapiro-Wilk em cada grupo.
trechos_diagnostico$qq_teste_t <- "
# Q-Q em cada grupo: os resíduos contra os quantis da distribuição normal.
ggplot(diagnostico, aes(sample = residuo, colour = <<GRUPOS>>)) +
  stat_qq(size = 2.2, alpha = 0.7) +
  stat_qq_line() +
  facet_wrap(vars(<<GRUPOS>>)) +
  scale_colour_manual(values = cores, guide = \"none\") +
  labs(
    title = paste(\"Pontos perto da reta: resíduos compatíveis com a normal.\",
                  \"Caudas que se afastam indicam assimetria ou valores extremos.\",
                  sep = \"\\n\"),
    x     = \"Quantis teóricos\",
    y     = \"Resíduos (observação menos a média do grupo)\"
  ) +
  theme_classic(base_size = 12) +
  theme(plot.title = element_text(size = 10, colour = \"grey30\"),
        plot.title.position = \"plot\",
        strip.background = element_blank(),
        panel.spacing = unit(1.5, \"lines\"))"

# As receitas de grafico_residuos(), montadas com os trechos, uma por análise.
receitas_residuos <- list(
  anova   = paste(trimws(c(trecho_cores,
                           trechos_diagnostico$preparo_anova,
                           trechos_diagnostico$residuos)), collapse = "\n\n"),
  teste_t = paste(trimws(c(trecho_cores,
                           trechos_diagnostico$preparo_teste_t,
                           trechos_diagnostico$residuos)), collapse = "\n\n")
)

# As receitas de grafico_qq(), montadas com os trechos, uma por análise.
receitas_qq <- list(
  anova   = paste(trimws(c(trechos_diagnostico$preparo_anova,
                           trechos_diagnostico$qq_anova)), collapse = "\n\n"),
  teste_t = paste(trimws(c(trecho_cores,
                           trechos_diagnostico$preparo_teste_t,
                           trechos_diagnostico$qq_teste_t)), collapse = "\n\n")
)



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
# Mostra o cabeçalho da função, o mesmo que está escrito acima dela neste
# arquivo: a pergunta, o que faz, os argumentos, o que devolve e um exemplo.
# Sem nome de função, lista todas as funções da ClaRa. No RStudio, a ajuda
# abre como página no painel Viewer; fora dele, aparece no console. (O
# painel Help do RStudio só mostra ajuda de pacotes, e a ClaRa ainda não é
# um pacote.)
#
# Argumentos:
#   funcao .............. o nome da função, com ou sem aspas
#   onde ................ "viewer" (padrão: painel Viewer do RStudio) ou
#                         "console"
#
# Exemplo:
#   ajuda()
#   ajuda(comparar_medias)
#   ajuda(grafico_medias, onde = "console")
#
ajuda <- function(funcao,
                  onde = c("viewer", "console")) {

  # Onde mostrar: no painel Viewer do RStudio (padrão) ou no console.
  onde <- escolher_opcao(onde, c("viewer", "console"), "onde")

  # Lemos este arquivo, onde cada função tem seu cabeçalho de ajuda.
  linhas <- readLines(arquivo_clara, encoding = "UTF-8")

  # Cada cabeçalho começa com uma linha como "# comparar_medias() ------".
  inicios <- grep("^# [a-z_]+\\(\\) -+$", linhas)
  funcoes <- sub("^# ([a-z_]+)\\(\\) -+$", "\\1", linhas[inicios])

  # Sem nome de função, mostramos a lista de todas, agrupadas pela seção do
  # arquivo, com a pergunta de cada uma.
  if (missing(funcao)) {
    mostrar_ajuda("Funções da ClaRa", listar_funcoes(linhas, inicios, funcoes), onde)
    return(invisible(funcoes))
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
  mostrar_ajuda(paste0(nome, "()"), texto, onde)

  invisible(nome)
}

# Mostra uma ajuda: no RStudio, como página no painel Viewer; fora dele (ou
# com onde = "console"), como texto no console.
mostrar_ajuda <- function(titulo, linhas, onde) {
  visualizador <- getOption("viewer")
  if (onde == "viewer" && is.function(visualizador)) {
    pagina <- tempfile("ajuda_clara_", fileext = ".html")
    writeLines(enc2utf8(pagina_de_ajuda(titulo, linhas)), pagina, useBytes = TRUE)
    visualizador(pagina)
    cat("A ajuda de ", titulo, " abriu no painel Viewer. ",
        "Para vê-la aqui: ajuda(..., onde = \"console\").\n", sep = "")
  } else {
    cat("\n", titulo, "\n", strrep("=", nchar(titulo)), "\n", sep = "")
    cat(linhas, sep = "\n")
    cat("\n")
  }
}

# Monta a página HTML da ajuda, com as cores da ClaRa. O texto vai num bloco
# de largura fixa, para manter alinhadas as listas de argumentos.
pagina_de_ajuda <- function(titulo, linhas) {
  escapar <- function(x) gsub(">", "&gt;", gsub("<", "&lt;", gsub("&", "&amp;", x, fixed = TRUE), fixed = TRUE), fixed = TRUE)
  corpo <- escapar(linhas)
  # Rótulos de bloco (Pergunta:, Argumentos:, Exemplo: ...) em negrito.
  corpo <- sub("^([A-ZÁÉÍÓÚ][A-Za-zçãõáéíóú ]*:)", "<b>\\1</b>", corpo)
  c("<!DOCTYPE html>",
    "<html lang=\"pt-BR\"><head><meta charset=\"utf-8\">",
    paste0("<title>", escapar(titulo), "</title>"),
    "<style>",
    "body { font-family: Arial, sans-serif; margin: 16px; color: #1d2b36; }",
    "h1 { color: #0F3B5F; font-size: 20px; border-bottom: 2px solid #62B6B7; padding-bottom: 4px; }",
    "pre { font-family: Consolas, 'Courier New', monospace; font-size: 13px; line-height: 1.45; white-space: pre-wrap; }",
    "b { color: #2E7D8F; }",
    "</style></head><body>",
    paste0("<h1>", escapar(titulo), "</h1>"),
    "<pre>", corpo, "</pre>",
    "</body></html>")
}

# Lista as funções da ClaRa, cada uma com a pergunta que responde, agrupadas
# pela seção do arquivo onde moram (como "Comparar médias"). Devolve as
# linhas do texto, para mostrar_ajuda() exibir.
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

  # Um bloco por seção: o nome da seção e as suas funções, alinhadas.
  blocos <- lapply(unique(secoes), function(secao) {
    escolhidas <- secoes == secao
    c("", paste0(secao, ":"),
      paste0("  ", formatC(nomes[escolhidas], width = -largura), "  ",
             perguntas[escolhidas]))
  })
  c(unlist(blocos), "", "Para saber mais sobre uma delas: ajuda(comparar_medias)")
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

# Devolve a opção escolhida num argumento de escolha. O padrão do argumento
# lista todas as opções (assim o Tab do RStudio as mostra); se o aluno não
# escolheu, vale a primeira. Uma opção que não existe vira mensagem amigável.
escolher_opcao <- function(valor, opcoes, nome_argumento) {
  if (identical(valor, opcoes)) return(opcoes[1])
  if (!is.character(valor) || length(valor) != 1 || !is.element(valor, opcoes)) {
    stop(nome_argumento, " aceita só: ",
         paste0("\"", opcoes, "\"", collapse = " ou "), ".", call. = FALSE)
  }
  valor
}

# Confere se um argumento recebeu uma fração: um número maior que 0 e até 1.
conferir_fracao <- function(valor, nome_argumento) {
  if (!is.numeric(valor) || length(valor) != 1 || valor <= 0 || valor > 1) {
    stop(nome_argumento, " aceita um número maior que 0 e até 1, como 0.3 ou 0.6.",
         call. = FALSE)
  }
}

# Transforma a escolha de cores num vetor: o nome de uma paleta da ClaRa
# ("ocean", "cinza") ou um vetor de cores que o R reconheça.
escolher_cores <- function(cores) {
  e_paleta  <- is.character(cores) && length(cores) == 1 &&
    is.element(cores, names(paletas_clara))
  sao_cores <- is.character(cores) &&
    !inherits(try(grDevices::col2rgb(cores), silent = TRUE), "try-error")
  if (!e_paleta && !sao_cores) {
    stop("cores aceita \"ocean\", \"cinza\" ou um vetor de cores, ",
         "como c(\"darkgreen\", \"orange\").", call. = FALSE)
  }
  if (e_paleta) paletas_clara[[cores]] else cores
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
