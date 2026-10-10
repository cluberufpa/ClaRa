# =============================================================================
#  ClaRa: relacionar variáveis
# =============================================================================
#
#  Tudo da pergunta "uma variável acompanha a outra?": a análise
#  (relacionar_variaveis(), uma regressão linear simples), a figura principal
#  (grafico_reta()), as receitas que as funções para qualquer análise usam
#  com a regressão e o relatório no console.
# =============================================================================


# Relacionar variáveis ---------------------------------------------------------
#
# Pergunta: uma variável acompanha a outra?
# relacionar_variaveis() ajusta a reta; grafico_reta() a mostra com as
# observações. A regressão linear simples estima quanto a resposta muda, em
# média, a cada unidade do preditor, e quanto da variação da resposta a reta
# explica.

# relacionar_variaveis() -------------------------------------------------------
#' Uma variável acompanha a outra?
#'
#' Ajusta uma reta pela regressão linear simples: quanto a resposta muda, em média, a cada unidade do preditor (a inclinação), e quanto da variação da resposta a reta explica (o R²). Use quando as duas medidas são numéricas e a dispersão mostra uma relação que se parece com uma reta.
#'
#' Faz a análise na ordem em que a estudamos: as observações, a reta e os seus coeficientes, o ajuste do modelo inteiro, os pressupostos e as observações que merecem conferência.
#'
#' - **Pressupostos**: resíduos com distribuição normal (Shapiro-Wilk) e com variância constante (Breusch-Pagan). A independência vem do delineamento; o teste de Durbin-Watson só entra com `avaliar_autocorrelacao = TRUE`, quando a ordem das linhas é a ordem da coleta.
#' - **Influência**: observações com resíduo padronizado acima de 3, alavancagem acima de 2p/n ou distância de Cook acima de 4/n. São sinais para investigar, nunca ordens para apagar linhas.
#'
#' @param dados a tabela, com uma linha por observação
#' @param resposta a coluna numérica que se quer explicar (peso, altura...)
#' @param preditor a coluna numérica que acompanha a resposta (comprimento, idade...)
#' @param rotulo_resposta como chamar a resposta nos gráficos e nos textos (ex.: "Peso (g)"); sem ele, vai o nome da coluna.
#' @param rotulo_preditor como chamar o preditor nos gráficos e nos textos (ex.: "Comprimento (cm)"); sem ele, vai o nome da coluna. Os rótulos ficam guardados no resultado: as funções que vêm depois já os usam, sem precisar repeti-los
#' @param confianca nível de confiança dos intervalos (padrão 0.95); a significância dos testes é 1 - confianca
#' @param avaliar_autocorrelacao TRUE testa a independência pela ordem das linhas (Durbin-Watson). Use só quando a ordem das linhas é a ordem da coleta; FALSE (padrão) deixa a independência para o delineamento
#' @param mostrar_codigo TRUE imprime o código R antes do resultado
#'
#' @return Devolve uma lista. Cada parte se abre com $:
#'
#' - `resultado$coeficientes`: intercepto e inclinação, com erro padrão, intervalo de confiança, t e p
#' - `resultado$ajuste`: n, R², R² ajustado, erro padrão dos resíduos e o teste F do modelo
#' - `resultado$pressupostos`: os testes dos resíduos, com a leitura de cada um
#' - `resultado$influencia`: as observações que merecem conferência e por quê (vazia quando não há nenhuma)
#' - `resultado$amostra`: observações no total, usadas e excluídas
#' - `resultado$dados`: as observações usadas, com `linha_da_base` (a posição de cada uma na tabela original)
#' - `resultado$modelo`: o modelo do R (lm), para quem quiser ir além
#'
#' @examples
#' # Consumo de combustível e peso de carros (mtcars, do R).
#' resultado <- mtcars |>
#'   relacionar_variaveis(resposta        = mpg,
#'                        preditor        = wt,
#'                        rotulo_resposta = "Milhas por galão",
#'                        rotulo_preditor = "Peso (1000 lb)")
#'
#' resultado
#' resultado$coeficientes
#'
#' @concept Relacionar variáveis
#' @export
relacionar_variaveis <- function(dados,
                                 resposta,
                                 preditor,
                                 rotulo_resposta        = NULL,
                                 rotulo_preditor        = NULL,
                                 confianca              = 0.95,
                                 avaliar_autocorrelacao = FALSE,
                                 mostrar_codigo         = FALSE) {

  # Guardamos o nome da tabela que o aluno usou (peixes, por exemplo).
  nome_dados <- nome_do_objeto(substitute(dados), padrao = "dados")

  # Guardamos os nomes das duas colunas, como o aluno as escreveu.
  coluna_resposta <- rlang::as_name(rlang::ensym(resposta))
  coluna_preditor <- rlang::as_name(rlang::ensym(preditor))

  # Antes de calcular, conferimos se as colunas existem e servem para a reta.
  conferir_colunas_reta(dados, coluna_resposta, coluna_preditor)
  conferir_rotulo(rotulo_resposta, "rotulo_resposta")
  conferir_rotulo(rotulo_preditor, "rotulo_preditor")
  conferir_sim_ou_nao(avaliar_autocorrelacao, "avaliar_autocorrelacao")

  # O teste de independência entra na receita só quando o aluno pede.
  trecho_independencia <- variantes_regressao[[dplyr::case_when(
    avaliar_autocorrelacao ~ "com_durbin_watson",
    .default               = "sem_durbin_watson"
  )]]

  # Trocamos os marcadores da receita pelos nomes desta análise. O trecho da
  # independência entra primeiro, porque também tem marcadores.
  receita <- preencher_receita(receita_regressao, list(
    INDEPENDENCIA = trecho_independencia
  ))
  receita <- preencher_receita(receita, list(
    DADOS     = nome_dados,
    RESPOSTA  = coluna_resposta,
    PREDITOR  = coluna_preditor,
    CONFIANCA = confianca,
    ALFA      = 1 - confianca
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  resultado <- executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(dados), nome_dados),
    pacotes        = c("car", "dplyr", "broom"),
    mostrar_codigo = mostrar_codigo
  )

  # Anotamos no resultado o que foi analisado; as outras funções vão precisar.
  # Os rótulos também ficam: gráficos e textos os usam sem o aluno repeti-los.
  resultado$nomes <- list(
    dados                  = nome_dados,
    resposta               = coluna_resposta,
    preditor               = coluna_preditor,
    rotulo_resposta        = ou_entao(rotulo_resposta, coluna_resposta),
    rotulo_preditor        = ou_entao(rotulo_preditor, coluna_preditor),
    confianca              = confianca,
    avaliar_autocorrelacao = avaliar_autocorrelacao,
    analise                = "regressao"
  )

  # Damos ao resultado uma etiqueta, para o console saber como exibi-lo.
  structure(resultado, class = "clara_regressao")
}


# A receita de relacionar_variaveis() ------------------------------------------
#
# Uma receita só; o que muda é o teste de independência, que entra ou não
# conforme avaliar_autocorrelacao.

receita_regressao <- "
# 1. As observações da análise: só as linhas com resposta e preditor.
#    linha_da_base guarda a posição de cada observação na tabela original,
#    para achá-la de novo se ela merecer conferência.
dados_analise <- <<DADOS>> |>
  mutate(linha_da_base = row_number()) |>
  filter(!is.na(<<RESPOSTA>>), !is.na(<<PREDITOR>>))

# Quantas observações havia, quantas entraram e quantas ficaram de fora.
amostra <- tibble(
  total     = nrow(<<DADOS>>),
  usadas    = nrow(dados_analise),
  excluidas = total - usadas
)

# 2. A reta: lm() ajusta resposta = intercepto + inclinação × preditor pelos
#    mínimos quadrados (a reta que deixa a menor soma dos resíduos ao quadrado).
modelo <- lm(<<RESPOSTA>> ~ <<PREDITOR>>, data = dados_analise)

# 3. Os coeficientes, com o intervalo de confiança. A inclinação diz quanto a
#    resposta muda, em média, a cada unidade do preditor; t e p testam se ela
#    difere de zero.
coeficientes <- modelo |>
  tidy(conf.int = TRUE, conf.level = <<CONFIANCA>>) |>
  transmute(
    termo      = case_when(term == \"(Intercept)\" ~ \"intercepto\",
                           .default              = term),
    estimativa = estimate,
    ep         = std.error,
    ic_inf     = conf.low,
    ic_sup     = conf.high,
    t          = statistic,
    p          = p.value
  )

# 4. O ajuste do modelo inteiro: R² (a fração da variação da resposta que a
#    reta explica), o erro padrão dos resíduos (o tamanho típico do erro da
#    reta, na unidade da resposta) e o teste F.
ajuste <- modelo |>
  glance() |>
  transmute(
    n           = nobs,
    r2          = r.squared,
    r2_ajustado = adj.r.squared,
    erro_padrao = sigma,
    f           = statistic,
    gl_modelo   = df,
    gl_residuos = df.residual,
    p           = p.value
  )

# 5. Pressupostos: resíduos com distribuição normal (Shapiro-Wilk) e com
#    variância constante ao longo da reta (Breusch-Pagan).
normalidade <- shapiro.test(residuals(modelo)) |> tidy()
variancia   <- ncvTest(modelo)

pressupostos <- tibble(
  pressuposto = c(\"Normalidade dos resíduos\", \"Variância constante dos resíduos\"),
  teste       = c(\"Shapiro-Wilk\", \"Breusch-Pagan\"),
  estatistica = c(normalidade$statistic, variancia$ChiSquare),
  p           = c(normalidade$p.value, variancia$p)
)
<<INDEPENDENCIA>>

pressupostos <- pressupostos |>
  mutate(leitura = case_when(
    p >= <<ALFA>> ~ \"sem evidência contra o pressuposto\",
    p <  <<ALFA>> ~ \"pressuposto rejeitado\"
  ))

# 6. Influência: observações que puxam a reta ou ficam longe dela. São
#    sinais para conferir na planilha, nunca ordens para apagar linhas.
#    Limites usuais: resíduo padronizado acima de 3, alavancagem acima de
#    2p/n (p = 2 coeficientes) e distância de Cook acima de 4/n.
n_usadas <- nrow(dados_analise)

influencia <- dados_analise |>
  mutate(
    residuo_padronizado = rstandard(modelo),
    alavancagem         = hatvalues(modelo),
    cook                = cooks.distance(modelo),
    residuo_extremo     = abs(residuo_padronizado) > 3,
    alavancagem_alta    = alavancagem > 2 * 2 / n_usadas,
    cook_alto           = cook > 4 / n_usadas
  ) |>
  filter(residuo_extremo | alavancagem_alta | cook_alto) |>
  select(linha_da_base, <<PREDITOR>>, <<RESPOSTA>>, residuo_padronizado,
         alavancagem, cook, residuo_extremo, alavancagem_alta, cook_alto)

# 7. Tudo junto, numa lista com partes nomeadas.
list(
  coeficientes = coeficientes,
  ajuste       = ajuste,
  pressupostos = pressupostos,
  influencia   = influencia,
  amostra      = amostra,
  dados        = dados_analise,
  modelo       = modelo
)"

# O teste de independência, que entra na receita só quando o aluno pede.
variantes_regressao <- list(
  sem_durbin_watson = "
# A independência das observações vem do delineamento (cada linha, um peixe
# diferente, por exemplo); por isso não há teste para ela aqui.",
  com_durbin_watson = "
# Independência na ordem das linhas (Durbin-Watson): só faz sentido quando a
# ordem das linhas é a ordem da coleta. O p vem de reamostragem (bootstrap);
# a semente faz o resultado se repetir a cada execução.
set.seed(1)
independencia <- durbinWatsonTest(modelo, reps = 1000)

pressupostos <- pressupostos |>
  bind_rows(tibble(
    pressuposto = \"Independência na ordem das linhas\",
    teste       = \"Durbin-Watson\",
    estatistica = independencia$dw,
    p           = independencia$p
  ))"
)


# grafico_reta() ---------------------------------------------------------------
#' Como mostrar a reta ajustada numa só figura?
#'
#' A figura principal da regressão. Por padrão: cada ponto é uma observação; a linha é a reta ajustada; a faixa sombreada é o intervalo de confiança da reta (onde deve estar a média da resposta para cada valor do preditor); no canto, a equação da reta e o R². A explicação no topo cita só as partes que aparecem.
#'
#' Com `colorir_por`, os pontos ganham uma cor por grupo (sexo, local, população), só para a leitura da figura: a reta continua uma só, a de todos os pontos juntos.
#'
#' @param resultado o que relacionar_variaveis() devolveu
#' @param rotulo_resposta texto do eixo y; sem ele, vai o de relacionar_variaveis()
#' @param rotulo_preditor texto do eixo x; sem ele, vai o de relacionar_variaveis()
#' @param titulo título da figura (padrão: sem título)
#' @param explicacao TRUE (padrão) escreve no topo o que cada elemento mostra; FALSE tira, para a explicação ir para a legenda do artigo
#' @param mostrar_faixa TRUE (padrão) desenha o intervalo de confiança da reta
#' @param mostrar_equacao TRUE (padrão) escreve a equação da reta e o R² no canto
#' @param colorir_por uma coluna dos dados para colorir os pontos (ex.: sexo), sem aspas ou com aspas; sem ela (NULL, o padrão), todos os pontos têm a mesma cor
#' @param rotulo_cores o título da legenda das cores; sem ele, vai o nome da coluna de colorir_por
#' @param cores "ocean" (padrão), "cinza" (para impressão em preto e branco) ou um vetor de cores, como c("darkgreen", "orange"); Tab mostra as paletas
#' @param casas casas decimais dos coeficientes na equação (padrão 2)
#' @param tamanho_texto tamanho base do texto (padrão 12); a equação e a explicação acompanham
#' @param fonte "sans" (padrão; Arial no Windows) ou "serif" (Times New Roman no Windows), para todos os textos
#' @param mostrar_codigo TRUE imprime o código R antes do gráfico
#'
#' @return Devolve um gráfico do ggplot2; ajustes extras entram com +.
#'
#' @examples
#' # Consumo de combustível e peso de carros (mtcars, do R).
#' resultado <- mtcars |>
#'   relacionar_variaveis(resposta        = mpg,
#'                        preditor        = wt,
#'                        rotulo_resposta = "Milhas por galão",
#'                        rotulo_preditor = "Peso (1000 lb)")
#'
#' resultado |>
#'   grafico_reta()
#'
#' # Os pontos coloridos pelo número de cilindros; a reta continua uma só.
#' resultado |>
#'   grafico_reta(colorir_por  = cyl,
#'                rotulo_cores = "Cilindros")
#'
#' @concept Relacionar variáveis
#' @export
grafico_reta <- function(resultado,
                         rotulo_resposta = NULL,
                         rotulo_preditor = NULL,
                         titulo          = NULL,
                         explicacao      = TRUE,
                         mostrar_faixa   = TRUE,
                         mostrar_equacao = TRUE,
                         colorir_por     = NULL,
                         rotulo_cores    = NULL,
                         cores           = c("ocean", "cinza"),
                         casas           = 2,
                         tamanho_texto   = 12,
                         fonte           = c("sans", "serif"),
                         mostrar_codigo  = FALSE) {

  # Guardamos o nome do resultado, como o aluno o chamou.
  nome_resultado <- nome_do_objeto(substitute(resultado), padrao = "resultado")

  # Este gráfico desenha o resultado de relacionar_variaveis().
  conferir_resultado(resultado, "clara_regressao",
                     "grafico_reta() desenha o resultado de relacionar_variaveis(). Para as médias, use grafico_medias().")

  # A coluna das cores, escrita com ou sem aspas; sem ela, uma cor só.
  coluna_cores <- if (missing(colorir_por) || is.null(substitute(colorir_por))) {
    NULL
  } else {
    rlang::as_name(rlang::ensym(colorir_por))
  }
  if (!is.null(coluna_cores) && !is.element(coluna_cores, names(resultado$dados))) {
    stop("Coluna não encontrada nos dados: ", coluna_cores, ".", call. = FALSE)
  }

  # Conferimos as escolhas antes de desenhar. Nas opções listadas no padrão
  # (que o Tab do RStudio mostra), sem escolha vale a primeira.
  fonte <- escolher_opcao(fonte, c("sans", "serif"), "fonte")
  if (identical(cores, c("ocean", "cinza"))) cores <- "ocean"
  conferir_sim_ou_nao(explicacao,      "explicacao")
  conferir_sim_ou_nao(mostrar_faixa,   "mostrar_faixa")
  conferir_sim_ou_nao(mostrar_equacao, "mostrar_equacao")
  conferir_rotulo(rotulo_cores, "rotulo_cores")
  if (!is.numeric(casas) || length(casas) != 1 || casas < 0) {
    stop("casas aceita um número inteiro, como 1 ou 2.", call. = FALSE)
  }
  vetor_cores <- escolher_cores(cores)

  # Sem rótulo informado aqui, valem os que a análise guardou.
  rotulo_resposta <- ou_entao(rotulo_resposta, resultado$nomes$rotulo_resposta)
  rotulo_preditor <- ou_entao(rotulo_preditor, resultado$nomes$rotulo_preditor)

  # A explicação do topo cita só as partes que aparecem na figura.
  nivel  <- format(resultado$nomes$confianca * 100)
  partes <- c("pontos: observações",
              "linha: reta ajustada",
              if (mostrar_faixa) paste0("faixa: intervalo de confiança de ", nivel, "% da reta"))
  texto_explicacao <- paste0(paste(partes, collapse = "; "), ".")
  texto_explicacao <- paste0(toupper(substr(texto_explicacao, 1, 1)),
                             substring(texto_explicacao, 2))

  # O preparo: só os objetos que as camadas pedidas vão usar.
  t <- trechos_grafico_reta
  preparo <- c(
    if (!is.null(coluna_cores)) trecho_de_cores(vetor_cores),
    t$pontos,
    if (mostrar_faixa) t$reta_com_faixa else t$reta_sem_faixa,
    if (mostrar_equacao) t$equacao
  )

  # Os textos da figura: título, explicação, eixos e a legenda das cores.
  linhas_labs <- c(
    if (!is.null(titulo)) "    title    = \"<<TITULO>>\",",
    if (explicacao) "    subtitle = \"<<EXPLICACAO>>\",",
    if (!is.null(coluna_cores)) "    colour   = \"<<ROTULO_CORES>>\",",
    "    x        = \"<<ROTULO_PREDITOR>>\",",
    "    y        = \"<<ROTULO_RESPOSTA>>\""
  )

  # As camadas pedidas, na ordem em que se empilham, ligadas por +.
  camadas <- c(
    t$base,
    if (mostrar_faixa) t$faixa,
    if (is.null(coluna_cores)) t$pontos_uma_cor else t$pontos_coloridos,
    t$linha,
    if (mostrar_equacao) t$texto_equacao,
    if (!is.null(coluna_cores)) t$escala_cor,
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
    PREDITOR           = resultado$nomes$preditor,
    GRUPOS             = coluna_cores,
    CORES_POR          = coluna_cores,
    ROTULO_RESPOSTA    = rotulo_resposta,
    ROTULO_PREDITOR    = rotulo_preditor,
    ROTULO_CORES       = ou_entao(rotulo_cores, ou_entao(coluna_cores, "")),
    TITULO             = ou_entao(titulo, ""),
    EXPLICACAO         = texto_explicacao,
    CONFIANCA          = resultado$nomes$confianca,
    CASAS              = casas,
    TAMANHO            = tamanho_texto,
    FAMILIA_TEXTO      = dplyr::case_when(fonte == "serif" ~ ", family = \"serif\"",
                                          .default         = ""),
    FAMILIA_TEMA       = dplyr::case_when(fonte == "serif" ~ ", base_family = \"serif\"",
                                          .default         = ""),
    TAMANHO_EQUACAO    = round(4 * tamanho_texto / 12, 1),
    TAMANHO_EXPLICACAO = round(10 * tamanho_texto / 12, 1)
  ))

  # Rodamos a receita, mostrando o código antes, se o aluno pediu.
  executar_receita(
    receita        = receita,
    objetos        = rlang::set_names(list(resultado), nome_resultado),
    pacotes        = c("dplyr", "ggplot2"),
    mostrar_codigo = mostrar_codigo
  )
}

# Os trechos da receita de grafico_reta(). A função escolhe os que a figura
# pedida usa e os junta, na ordem, numa receita só.
trechos_grafico_reta <- list()

# Preparo: as observações.
trechos_grafico_reta$pontos <- "
# As observações usadas na reta.
pontos <- <<RESULTADO>>$dados"

# Preparo: a reta numa grade de 100 valores do preditor, com a faixa.
trechos_grafico_reta$reta_com_faixa <- "
# A reta e o seu intervalo de confiança, calculados pelo modelo numa grade de
# 100 valores do preditor, do menor ao maior observado: fit é a reta; lwr e
# upr, os limites da faixa.
grade <- tibble(<<PREDITOR>> = seq(min(pontos$<<PREDITOR>>), max(pontos$<<PREDITOR>>),
                                   length.out = 100))
reta  <- bind_cols(grade, as_tibble(predict(<<RESULTADO>>$modelo,
                                            newdata  = grade,
                                            interval = \"confidence\",
                                            level    = <<CONFIANCA>>)))"

trechos_grafico_reta$reta_sem_faixa <- "
# A reta, calculada pelo modelo numa grade de 100 valores do preditor, do
# menor ao maior observado.
grade <- tibble(<<PREDITOR>> = seq(min(pontos$<<PREDITOR>>), max(pontos$<<PREDITOR>>),
                                   length.out = 100))
reta  <- grade |>
  mutate(fit = predict(<<RESULTADO>>$modelo, newdata = grade))"

# Preparo: a equação e o R², com vírgula decimal.
trechos_grafico_reta$equacao <- "
# A equação da reta e o R², escritos com vírgula decimal.
com_virgula <- function(x, casas = 2) {
  formatC(x, format = \"f\", digits = casas, decimal.mark = \",\")
}
intercepto  <- <<RESULTADO>>$coeficientes$estimativa[1]
inclinacao  <- <<RESULTADO>>$coeficientes$estimativa[2]
sinal       <- if_else(inclinacao < 0, \" - \", \" + \")
texto_reta  <- paste0(\"y = \", com_virgula(intercepto, <<CASAS>>), sinal,
                      com_virgula(abs(inclinacao), <<CASAS>>), \"x\\n\",
                      \"R² = \", com_virgula(<<RESULTADO>>$ajuste$r2, 3))"

# Camadas da figura, uma por trecho.
trechos_grafico_reta$base <- "ggplot(reta, aes(x = <<PREDITOR>>))"

trechos_grafico_reta$faixa <- "  geom_ribbon(aes(ymin = lwr, ymax = upr), fill = \"#62B6B7\", alpha = 0.3)"

trechos_grafico_reta$pontos_uma_cor <- "  geom_point(
    data   = pontos,
    aes(y = <<RESPOSTA>>),
    size   = 2.2,
    alpha  = 0.7,
    colour = \"#2E7D8F\"
  )"

trechos_grafico_reta$pontos_coloridos <- "  geom_point(
    data  = pontos,
    aes(y = <<RESPOSTA>>, colour = factor(<<CORES_POR>>)),
    size  = 2.2,
    alpha = 0.7
  )"

trechos_grafico_reta$linha <- "  geom_line(aes(y = fit), colour = \"#0F3B5F\", linewidth = 1)"

trechos_grafico_reta$texto_equacao <- "  annotate(
    \"text\", label = texto_reta,
    x = min(pontos$<<PREDITOR>>), y = max(pontos$<<RESPOSTA>>),
    hjust = 0, vjust = 1, lineheight = 1.1,
    size = <<TAMANHO_EQUACAO>>, colour = \"#0F3B5F\"<<FAMILIA_TEXTO>>
  )"

trechos_grafico_reta$escala_cor <- "  scale_colour_manual(values = cores)"

trechos_grafico_reta$tema <- "  theme_classic(base_size = <<TAMANHO>><<FAMILIA_TEMA>>) +
  theme(
    plot.title          = element_text(colour = \"#0F3B5F\"),
    plot.subtitle       = element_text(size = <<TAMANHO_EXPLICACAO>>, colour = \"grey30\"),
    plot.title.position = \"plot\"
  )"


# As receitas da regressão para qualquer análise ------------------------------
#
# medir_efeito(), escrever_resultados(), grafico_residuos(), grafico_qq(),
# exibir_teste() e exibir_resumo() moram em clara_qualquer_analise.R e
# escolhem a receita pela análise feita. Estas são as receitas da regressão.

# r de Pearson e R², com intervalo de confiança, e a leitura de Cohen.
receitas_efeito$regressao <- "
# Tamanho de efeito da regressão, com intervalo de confiança.
# r de Pearson: de -1 a 1, o sinal é o da inclinação. R²: a fração da
# variação da resposta que a reta explica; numa reta só, R² = r². O R² sai
# de eta_squared(), que lê o modelo como uma ANOVA; alternative = \"two.sided\"
# dá os dois limites, como na ANOVA.
correlacao <- cor.test(<<RESULTADO>>$dados$<<RESPOSTA>>, <<RESULTADO>>$dados$<<PREDITOR>>,
                       conf.level = <<CONFIANCA>>)
r2         <- eta_squared(<<RESULTADO>>$modelo,
                          partial     = FALSE,
                          ci          = <<CONFIANCA>>,
                          alternative = \"two.sided\")

# Os limites de Cohen para r (0,1; 0,3; 0,5) valem, ao quadrado, para o R²
# (0,01; 0,09; 0,25): as duas leituras concordam.
tibble(
  medida = c(\"r de Pearson\", \"R²\"),
  valor  = c(unname(correlacao$estimate), r2$Eta2),
  ic_inf = c(correlacao$conf.int[1], r2$CI_low),
  ic_sup = c(correlacao$conf.int[2], r2$CI_high),
  r      = sqrt(c(valor[1]^2, valor[2]))
) |>
  mutate(leitura = case_when(
    r < 0.1  ~ \"muito pequeno\",
    r < 0.3  ~ \"pequeno\",
    r < 0.5  ~ \"médio\",
    .default = \"grande\"
  )) |>
  select(-r)"

# Amostra, inclinação, equação, R², pressupostos, influência, alerta, poder,
# síntese, nota da tabela e legenda da figura.
receitas_textos$regressao <- "
# 1. Números com vírgula decimal, e o p como se escreve em texto científico.
com_virgula <- function(x, casas = 2) {
  formatC(x, format = \"f\", digits = casas, decimal.mark = \",\")
}
texto_p <- function(p) {
  case_when(p < 0.001 ~ \"*p* < 0,001\",
            .default  = paste(\"*p* =\", com_virgula(p, 3)))
}

# 2. As peças do resultado que as frases usam.
alfa         <- <<ALFA>>
amostra      <- <<RESULTADO>>$amostra
ajuste       <- <<RESULTADO>>$ajuste
intercepto   <- <<RESULTADO>>$coeficientes[1, ]
inclinacao   <- <<RESULTADO>>$coeficientes[2, ]
pressupostos <- <<RESULTADO>>$pressupostos
influencia   <- <<RESULTADO>>$influencia

# 3. A amostra: quantas observações entraram e quantas ficaram de fora.
excluidas <- case_when(
  amostra$excluidas == 0 ~ \"nenhuma foi excluída\",
  amostra$excluidas == 1 ~ \"1 foi excluída por não ter resposta ou preditor\",
  .default = paste(amostra$excluidas,
                   \"foram excluídas por não terem resposta ou preditor\")
)
texto_amostra <- case_when(
  amostra$excluidas == 0 ~
    paste0(\"O conjunto final de dados reuniu \", amostra$usadas,
           \" observações com <<ROTULO_RESPOSTA>> e <<ROTULO_PREDITOR>>.\"),
  .default =
    paste0(\"De \", amostra$total, \" observações, \", excluidas, \"; o conjunto final \",
           \"reuniu \", amostra$usadas, \" observações com <<ROTULO_RESPOSTA>> e <<ROTULO_PREDITOR>>.\")
)

# 4. A inclinação numa frase: o sentido, o tamanho por unidade do preditor,
#    o intervalo e o teste, com a conclusão escrita conforme o p.
sentido <- if_else(inclinacao$estimativa > 0, \"aumentou\", \"diminuiu\")
evidencia <- case_when(
  inclinacao$p <  alfa ~ \"houve evidência de relação linear\",
  inclinacao$p >= alfa ~ \"não houve evidência de relação linear\"
)
texto_teste <- case_when(
  inclinacao$p < alfa ~
    paste0(\"Pela regressão linear simples, <<ROTULO_RESPOSTA>> \", sentido, \", em média, \",
           com_virgula(abs(inclinacao$estimativa), <<CASAS>>), \" a cada unidade de \",
           \"<<ROTULO_PREDITOR>> (IC <<NIVEL>>%: \", com_virgula(inclinacao$ic_inf, <<CASAS>>),
           \" a \", com_virgula(inclinacao$ic_sup, <<CASAS>>), \"; *t*(\", ajuste$gl_residuos,
           \") = \", com_virgula(inclinacao$t), \"; \", texto_p(inclinacao$p), \").\"),
  .default =
    paste0(\"Pela regressão linear simples, não houve evidência de relação linear entre \",
           \"<<ROTULO_PREDITOR>> e <<ROTULO_RESPOSTA>> (inclinação = \",
           com_virgula(inclinacao$estimativa, <<CASAS>>), \"; IC <<NIVEL>>%: \",
           com_virgula(inclinacao$ic_inf, <<CASAS>>), \" a \", com_virgula(inclinacao$ic_sup, <<CASAS>>),
           \"; *t*(\", ajuste$gl_residuos, \") = \", com_virgula(inclinacao$t), \"; \",
           texto_p(inclinacao$p), \").\")
)

# 5. A equação da reta, com os rótulos da análise.
sinal <- if_else(inclinacao$estimativa < 0, \" - \", \" + \")
texto_equacao <- paste0(
  \"A reta ajustada foi <<ROTULO_RESPOSTA>> = \", com_virgula(intercepto$estimativa, <<CASAS>>),
  sinal, com_virgula(abs(inclinacao$estimativa), <<CASAS>>), \" × <<ROTULO_PREDITOR>>.\"
)

# 6. Tamanho de efeito: o R² e o r, com a leitura de Cohen para r.
r <- sign(inclinacao$estimativa) * sqrt(ajuste$r2)
classe <- case_when(
  abs(r) < 0.1 ~ \"muito pequeno\",
  abs(r) < 0.3 ~ \"pequeno\",
  abs(r) < 0.5 ~ \"médio\",
  .default     = \"grande\"
)
texto_efeito <- str_glue(
  \"A reta explicou {com_virgula(100 * ajuste$r2, 1)}% da variação de <<ROTULO_RESPOSTA>> \",
  \"(R² = {com_virgula(ajuste$r2, 3)}; r = {com_virgula(r)}), um efeito {classe} pelos \",
  \"critérios de referência de Cohen.\"
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

# 8. Influência: quantas observações merecem conferência, e em que linhas.
linhas <- paste(influencia$linha_da_base, collapse = \", \")
texto_influencia <- case_when(
  nrow(influencia) == 0 ~
    \"Nenhuma observação ultrapassou os limites usuais de resíduo, alavancagem ou distância de Cook.\",
  nrow(influencia) == 1 ~
    paste0(\"Uma observação (linha \", linhas, \" da base) ultrapassou um dos limites usuais de \",
           \"resíduo, alavancagem ou distância de Cook; ela merece conferência na planilha \",
           \"antes de qualquer decisão, sem exclusão automática.\"),
  .default =
    paste0(nrow(influencia), \" observações (linhas \", linhas, \" da base) ultrapassaram algum \",
           \"dos limites usuais de resíduo, alavancagem ou distância de Cook; elas merecem \",
           \"conferência na planilha antes de qualquer decisão, sem exclusão automática.\")
)

# 9. Alerta: o que pede cuidado antes de concluir. Com amostra grande (regra
#    prática: 30 ou mais), a reta é pouco sensível a desvios moderados da
#    normalidade.
p_normal    <- pressupostos$p[pressupostos$teste == \"Shapiro-Wilk\"]
p_variancia <- pressupostos$p[pressupostos$teste == \"Breusch-Pagan\"]
p_ordem     <- pressupostos$p[pressupostos$teste == \"Durbin-Watson\"]
texto_alerta <- case_when(
  any(p_ordem < alfa) ~
    paste0(\"Os resíduos mostraram dependência na ordem das linhas (Durbin-Watson). \",
           \"Observações vizinhas parecidas tornam o intervalo e o p otimistas; confira \",
           \"o delineamento antes de concluir.\"),
  any(p_variancia < alfa) ~
    paste0(\"A variância dos resíduos mudou ao longo da reta (Breusch-Pagan). O intervalo \",
           \"e o p podem ficar otimistas; confira o funil no gráfico dos resíduos e \",
           \"considere uma transformação, como o logaritmo da resposta.\"),
  any(p_normal < alfa) & amostra$usadas >= 30 ~
    paste0(\"Os resíduos se afastaram da normalidade, mas com 30 ou mais observações \",
           \"a reta é pouco sensível a esse desvio. Confira no gráfico Q-Q se não há \",
           \"assimetria forte ou valores extremos.\"),
  any(p_normal < alfa) ~
    paste0(\"Os resíduos se afastaram da normalidade. Avalie o tamanho do desvio no \",
           \"gráfico Q-Q e confira se a relação não é curva.\"),
  .default =
    paste0(\"Os testes formais não detectaram os desvios examinados, mas o gráfico dos \",
           \"resíduos continua necessário, porque é nele que aparece uma relação curva, \",
           \"assim como o delineamento.\")
)

# 10. Poder do teste: só entra no texto quando muda a leitura, isto é, sem
#     evidência e com poder abaixo de 80%. f² = R² / (1 - R²).
poder <- pwr.f2.test(
  u         = ajuste$gl_modelo,
  v         = ajuste$gl_residuos,
  f2        = ajuste$r2 / (1 - ajuste$r2),
  sig.level = alfa
)$power
texto_poder <- case_when(
  inclinacao$p >= alfa & poder < 0.80 ~
    paste0(\"A ausência de evidência não deve ser lida como ausência de relação: \",
           \"para o tamanho de efeito observado, o poder do teste foi de apenas \",
           com_virgula(100 * poder, 0), \"%. Uma amostra maior daria mais segurança à conclusão.\"),
  .default = \"\"
)

# 11. Síntese: o resultado principal numa frase só.
texto_sintese <- str_glue(
  \"Na amostra de {amostra$usadas} observações, {evidencia} entre <<ROTULO_PREDITOR>> \",
  \"e <<ROTULO_RESPOSTA>> (inclinação = {com_virgula(inclinacao$estimativa, <<CASAS>>)}; \",
  \"{texto_p(inclinacao$p)}; R² = {com_virgula(ajuste$r2, 3)}). A interpretação deve \",
  \"considerar os pressupostos, a faixa observada de <<ROTULO_PREDITOR>> e o delineamento.\"
)

# 12. A nota da tabela dos coeficientes e a legenda da figura principal.
texto_nota_tabela <- str_glue(
  \"EP: erro padrão; IC: intervalo de confiança de <<NIVEL>>%. O *t* e o *p* de cada \",
  \"linha testam se o coeficiente difere de zero (α = {com_virgula(alfa)}).\"
)
texto_legenda_figura <- str_glue(
  \"Relação entre <<ROTULO_PREDITOR>> e <<ROTULO_RESPOSTA>>. Os pontos representam as \",
  \"observações; a linha, a reta ajustada por mínimos quadrados; a faixa sombreada, o \",
  \"intervalo de confiança de <<NIVEL>>% da reta (R² = {com_virgula(ajuste$r2, 3)}).\"
)

# 13. Todas as frases, numa lista com partes nomeadas.
list(
  amostra        = texto_amostra,
  teste          = texto_teste,
  equacao        = texto_equacao,
  efeito         = texto_efeito,
  pressupostos   = texto_pressupostos,
  influencia     = texto_influencia,
  alerta         = texto_alerta,
  poder          = texto_poder,
  sintese        = texto_sintese,
  nota_tabela    = texto_nota_tabela,
  legenda_figura = texto_legenda_figura
) |>
  lapply(as.character)"

# Regressão: os resíduos vêm do modelo, como na ANOVA.
trechos_diagnostico$preparo_regressao <- trechos_diagnostico$preparo_anova

# Resíduos contra ajustados na regressão: uma nuvem só, com uma curva que
# acompanha os pontos para mostrar se a relação é curva.
trechos_diagnostico$residuos_regressao <- "
# Resíduos contra os ajustados: a curva laranja acompanha os pontos.
ggplot(diagnostico, aes(x = ajustado, y = residuo)) +
  geom_hline(yintercept = 0, linetype = \"dashed\", colour = \"grey40\") +
  geom_point(size = 2.2, alpha = 0.7, colour = \"#2E7D8F\") +
  geom_smooth(method = \"loess\", formula = y ~ x, se = FALSE, colour = \"#E76F51\") +
  labs(
    title = paste(\"Pontos espalhados em torno do zero, sem curva e sem funil:\",
                  \"a reta serve e a variância é constante.\",
                  sep = \"\\n\"),
    x     = \"Valores ajustados (pela reta)\",
    y     = \"Resíduos\"
  ) +
  theme_classic(base_size = 12) +
  theme(plot.title = element_text(size = 10, colour = \"grey30\"),
        plot.title.position = \"plot\")"

# As receitas de grafico_residuos() e grafico_qq() da regressão.
receitas_residuos$regressao <- paste(trimws(c(trechos_diagnostico$preparo_regressao,
                                              trechos_diagnostico$residuos_regressao)), collapse = "\n\n")
receitas_qq$regressao       <- paste(trimws(c(trechos_diagnostico$preparo_regressao,
                                              trechos_diagnostico$qq_anova)), collapse = "\n\n")

# As receitas de exibir_teste() e exibir_resumo(). O trecho dos números
# (<<NUMEROS>>) e o do tema (<<TEMA>>) vêm de clara_formatar.R.
receitas_tabela_teste$regressao <- "<<NUMEROS>>

# 2. A tabela dos coeficientes: o intercepto e a inclinação, com o erro
#    padrão, o intervalo de confiança, t e p.
tabela <- <<RESULTADO>>$coeficientes |>
  transmute(Termo         = c(\"Intercepto\", \"<<ROTULO_PREDITOR>>\"),
            Estimativa    = com_virgula(estimativa, <<CASAS>>),
            EP            = com_virgula(ep, <<CASAS>>),
            `<<ROTULO_IC>>`      = paste(com_virgula(ic_inf, <<CASAS>>), \"a\", com_virgula(ic_sup, <<CASAS>>)),
            t             = com_virgula(t),
            p             = texto_p(p))

# 3. A tabela no tema escolhido.
tabela |>
  <<TEMA>> <<NOTA>>"

receitas_tabela_resumo$regressao <- "<<NUMEROS>>

# 2. O ajuste do modelo numa linha: n, R², R² ajustado, o erro padrão dos
#    resíduos (na unidade da resposta) e o teste F.
tabela <- <<RESULTADO>>$ajuste |>
  transmute(n,
            `R²`                      = com_virgula(r2, 3),
            `R² ajustado`             = com_virgula(r2_ajustado, 3),
            `Erro padrão dos resíduos` = com_virgula(erro_padrao, <<CASAS>>),
            F                         = com_virgula(f),
            GL                        = paste0(gl_modelo, \"; \", gl_residuos),
            p                         = texto_p(p))

# 3. A tabela no tema escolhido.
tabela |>
  <<TEMA>> <<NOTA>>"


# Exibição no console ----------------------------------------------------------
#
# Ao digitar o nome do resultado no console, o R chama esta função.
# Ela mostra a análise como um pequeno relatório, na ordem do estudo.

#' @export
print.clara_regressao <- function(x, ...) {

  # Título e tamanho da amostra.
  cat("\nRegressão linear simples:", x$nomes$rotulo_resposta, "em função de",
      x$nomes$rotulo_preditor, "\n")
  cat(nrow(x$dados), "observações")

  # Avisamos quando linhas ficaram de fora por falta de resposta ou preditor.
  if (x$amostra$excluidas > 0) {
    cat(" (", x$amostra$excluidas, " de ", x$amostra$total,
        " excluídas por falta de resposta ou preditor)", sep = "")
  }
  cat("\n")

  # Os coeficientes, e a inclinação numa frase.
  cat("\n# Coeficientes\n")
  print(x$coeficientes)
  inclinacao <- x$coeficientes[2, ]
  cat("Inclinação = ", formatar_numero(inclinacao$estimativa), " (",
      rotulo_ic(x$nomes$confianca), ": ", formatar_numero(inclinacao$ic_inf), " a ",
      formatar_numero(inclinacao$ic_sup), "); ", formatar_p(inclinacao$p, no_texto = TRUE),
      ": ", concluir_regressao(inclinacao$p, x$nomes$confianca), "\n", sep = "")

  # O ajuste do modelo inteiro.
  cat("\n# Ajuste\n")
  cat("R² = ", formatar_numero(x$ajuste$r2, 3), "; R² ajustado = ",
      formatar_numero(x$ajuste$r2_ajustado, 3), "; erro padrão dos resíduos = ",
      formatar_numero(x$ajuste$erro_padrao), "\n", sep = "")

  # Os pressupostos, com a leitura de cada teste.
  cat("\n# Pressupostos\n")
  print(x$pressupostos)
  if (!x$nomes$avaliar_autocorrelacao) {
    cat("A independência vem do delineamento; para testá-la pela ordem das linhas, ",
        "use avaliar_autocorrelacao = TRUE.\n", sep = "")
  }

  # As observações que merecem conferência.
  cat("\n# Influência\n")
  if (nrow(x$influencia) == 0) {
    cat("Nenhuma observação passou dos limites de resíduo, alavancagem ou Cook.\n")
  } else {
    print(x$influencia)
    cat("Sinais para conferir na planilha, não para apagar linhas.\n")
  }

  # Um lembrete das partes que podem ser abertas com $.
  cat("\nPartes do resultado: $coeficientes $ajuste $pressupostos $influencia",
      "$amostra $dados $modelo\n")

  invisible(x)
}

# A conclusão da regressão, escrita conforme o p da inclinação.
concluir_regressao <- function(p, confianca) {
  dplyr::case_when(
    p <  1 - confianca ~ "há evidência de relação linear.",
    p >= 1 - confianca ~ "não há evidência de relação linear."
  )
}
