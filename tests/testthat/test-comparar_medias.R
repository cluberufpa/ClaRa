# ANOVA de um fator clássica ------------------------------------------------

test_that("a ANOVA clássica dá os mesmos números do aov()", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)

  expect_s3_class(resultado, "clara_medias")
  expect_equal(resultado$nomes$analise, "anova")

  referencia <- summary(aov(peso_g ~ racao, data = bagres))[[1]]
  expect_equal(resultado$anova$gl, unname(referencia$Df))
  expect_equal(resultado$anova$f[1], referencia$`F value`[1])
  expect_equal(resultado$anova$p[1], referencia$`Pr(>F)`[1])
})

test_that("grupos desiguais: o resumo traz o n de cada grupo", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)

  expect_equal(resultado$resumo$n, as.vector(table(bagres$racao)))
  expect_equal(nrow(resultado$pares), choose(4, 2))
  expect_true(all(nzchar(resultado$resumo$letra)))
})

test_that("o Tukey dá os mesmos intervalos do TukeyHSD()", {
  bagres     <- ler_treino("real_bagre_racoes")
  resultado  <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  referencia <- TukeyHSD(aov(peso_g ~ racao, data = bagres))$racao

  expect_equal(resultado$pares$diferenca, unname(referencia[, "diff"]))
  expect_equal(resultado$pares$p_ajustado, unname(referencia[, "p adj"]))
})

test_that("o Levene rejeita quando as variâncias diferem", {
  peixes    <- ler_treino("sint_variancias_desiguais")
  resultado <- comparar_medias(peixes, resposta = comprimento_cm, grupos = densidade)

  levene <- resultado$pressupostos[resultado$pressupostos$teste == "Levene", ]
  expect_lt(levene$p, 0.05)
  expect_match(levene$leitura, "rejeitado")
})

test_that("observações sem resposta ou sem grupo ficam de fora e são contadas", {
  dados     <- ler_treino("sint_com_faltantes")
  resultado <- comparar_medias(dados, resposta = peso_g, grupos = racao)

  expect_equal(resultado$amostra$total, 21)
  expect_equal(resultado$amostra$excluidas, 5)
  expect_equal(resultado$amostra$usadas, nrow(resultado$dados))
})

test_that("sem evidência e com pouco poder, o texto cita o poder", {
  viveiros <- ler_treino("sint_pouco_poder")
  textos   <- comparar_medias(viveiros, resposta = peso_g, grupos = viveiro) |>
    escrever_resultados()

  expect_s3_class(textos, "clara_textos")
  expect_match(textos$poder, "poder do teste")
})


# ANOVA de Welch ---------------------------------------------------------------

test_that("variancias_iguais = FALSE com três grupos dá a ANOVA de Welch", {
  peixes    <- ler_treino("sint_variancias_desiguais")
  resultado <- comparar_medias(peixes,
                               resposta          = comprimento_cm,
                               grupos            = densidade,
                               variancias_iguais = FALSE)

  referencia <- oneway.test(comprimento_cm ~ densidade, data = peixes, var.equal = FALSE)
  expect_equal(resultado$nomes$analise, "anova_welch")
  expect_equal(resultado$anova$f[1], unname(referencia$statistic))
  expect_equal(resultado$anova$gl[2], unname(referencia$parameter[2]))
  expect_equal(resultado$anova$p[1], referencia$p.value)
})


# Teste t -------------------------------------------------------------------------

test_that("com dois grupos, o padrão é o t de Welch", {
  artemias  <- ler_treino("real_artemia_racoes")
  resultado <- comparar_medias(artemias, resposta = taxa_crescimento_mg_dia, grupos = racao)

  referencia <- t.test(taxa_crescimento_mg_dia ~ racao, data = artemias)
  expect_equal(resultado$nomes$analise, "teste_t")
  expect_false(resultado$nomes$variancias_iguais)
  expect_equal(unname(resultado$teste$t), unname(referencia$statistic))
  expect_equal(resultado$teste$p, referencia$p.value)
})

test_that("variancias_iguais = TRUE com dois grupos dá o t de Student", {
  artemias  <- ler_treino("real_artemia_racoes")
  resultado <- comparar_medias(artemias,
                               resposta          = taxa_crescimento_mg_dia,
                               grupos            = racao,
                               variancias_iguais = TRUE)

  referencia <- t.test(taxa_crescimento_mg_dia ~ racao, data = artemias, var.equal = TRUE)
  expect_equal(unname(resultado$teste$gl), unname(referencia$parameter))
  expect_equal(resultado$teste$p, referencia$p.value)
})


# Mensagens amigáveis ----------------------------------------------------------

test_that("colunas que não existem dão mensagem em português", {
  bagres <- ler_treino("real_bagre_racoes")
  expect_error(comparar_medias(bagres, resposta = peso, grupos = racao),
               "Coluna não encontrada")
})

test_that("a resposta precisa ser numérica", {
  bagres <- ler_treino("real_bagre_racoes")
  bagres$peso_g <- as.character(bagres$peso_g)
  expect_error(comparar_medias(bagres, resposta = peso_g, grupos = racao),
               "numérica")
})

test_that("as colunas também podem vir entre aspas, como a Trilha as passa", {
  bagres <- ler_treino("real_bagre_racoes")
  sem_aspas <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  com_aspas <- comparar_medias(bagres, resposta = "peso_g", grupos = "racao")
  expect_equal(com_aspas$anova, sem_aspas$anova)
})

# Teste t unilateral (v0.11.0) ----------------------------------------------

test_that("o unilateral dá o p e o IC do t.test() no mesmo sentido", {
  artemias <- ler_treino("real_artemia_racoes")
  for (alternativa in c("maior", "menor")) {
    resultado  <- comparar_medias(artemias, resposta = taxa_crescimento_mg_dia,
                                  grupos = racao, alternativa = alternativa)
    referencia <- t.test(taxa_crescimento_mg_dia ~ racao, data = artemias,
                         alternative = c(maior = "greater", menor = "less")[[alternativa]])
    expect_equal(resultado$nomes$alternativa, alternativa)
    expect_equal(resultado$teste$p, referencia$p.value)
    expect_equal(c(resultado$teste$ic_inf, resultado$teste$ic_sup),
                 unname(referencia$conf.int[1:2]))
  }
})

test_that("o bilateral continua o padrão e igual ao de antes", {
  artemias  <- ler_treino("real_artemia_racoes")
  padrao    <- comparar_medias(artemias, resposta = taxa_crescimento_mg_dia, grupos = racao)
  bilateral <- comparar_medias(artemias, resposta = taxa_crescimento_mg_dia, grupos = racao,
                               alternativa = "bilateral")
  expect_equal(padrao$nomes$alternativa, "bilateral")
  expect_equal(padrao$teste, bilateral$teste)
  expect_equal(padrao$teste$p,
               t.test(taxa_crescimento_mg_dia ~ racao, data = artemias)$p.value)
})

test_that("com três ou mais grupos, o unilateral é recusado", {
  bagres <- ler_treino("real_bagre_racoes")
  expect_error(comparar_medias(bagres, resposta = peso_g, grupos = racao,
                               alternativa = "maior"),
               "só existe com dois grupos")
  expect_error(comparar_medias(bagres, resposta = peso_g, grupos = racao,
                               alternativa = "acima"),
               "alternativa aceita só")
})

test_that("no unilateral, frases, tabela, console e figura falam do lado aberto", {
  artemias  <- ler_treino("real_artemia_racoes")
  resultado <- comparar_medias(artemias, resposta = taxa_crescimento_mg_dia,
                               grupos = racao, alternativa = "maior")
  textos <- escrever_resultados(resultado)
  expect_match(textos$teste, "maior que a de B pelo teste t de Welch unilateral")
  expect_match(textos$teste, "a +∞", fixed = TRUE)
  expect_match(textos$nota_tabela, "unilateral")
  expect_true(nzchar(textos$legenda_figura))

  tabela <- exibir_teste(resultado)$body$dataset
  expect_true("IC 95% unilateral" %in% names(tabela))
  expect_match(tabela[["IC 95% unilateral"]], "+∞", fixed = TRUE)

  expect_output(print(resultado), "H1: a média de A é maior que a de B")
  expect_s3_class(grafico_pares(resultado), "ggplot")

  # O sentido contrário ao da hipótese é dito, no lugar do poder.
  contrario <- comparar_medias(artemias, resposta = taxa_crescimento_mg_dia,
                               grupos = racao, alternativa = "menor")
  expect_match(escrever_resultados(contrario)$poder, "sentido contrário")
})

test_that("o teste t bilateral também traz a nota da tabela e a legenda", {
  artemias <- ler_treino("real_artemia_racoes")
  textos   <- escrever_resultados(comparar_medias(artemias, resposta = taxa_crescimento_mg_dia,
                                                  grupos = racao))
  expect_match(textos$nota_tabela, "teste t de Welch ao nível")
  expect_match(textos$legenda_figura, "teste t de Welch")
})
