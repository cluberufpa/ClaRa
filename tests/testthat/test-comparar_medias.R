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
