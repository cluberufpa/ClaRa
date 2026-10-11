test_that("com três grupos, Kruskal-Wallis igual ao kruskal.test()", {
  capturas  <- ler_treino("sint_residuos_assimetricos")
  resultado <- comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho)

  referencia <- kruskal.test(cpue_kg ~ petrecho, data = capturas)
  expect_s3_class(resultado, "clara_medianas")
  expect_equal(unname(resultado$teste$h), unname(referencia$statistic))
  expect_equal(resultado$teste$p, referencia$p.value)
  expect_equal(nrow(resultado$pares), choose(3, 2))
})

test_that("com dois grupos e empates, Mann-Whitney pela aproximação normal", {
  artemias  <- ler_treino("real_artemia_racoes")
  resultado <- comparar_medianas(artemias, resposta = taxa_crescimento_mg_dia, grupos = racao)

  # Há empates: a ClaRa usa a aproximação normal (exact = FALSE).
  referencia <- wilcox.test(taxa_crescimento_mg_dia ~ racao, data = artemias,
                            exact = FALSE, conf.int = TRUE)
  expect_equal(unname(resultado$teste$w), unname(referencia$statistic))
  expect_equal(resultado$teste$p, referencia$p.value)
})

test_that("os gráficos de resíduos não servem às medianas e dizem por quê", {
  capturas  <- ler_treino("sint_residuos_assimetricos")
  resultado <- comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho)

  expect_error(grafico_residuos(resultado), "grafico_boxplot")
  expect_error(grafico_medias(resultado), "medianas")
})

test_that("Mann-Whitney unilateral igual ao wilcox.test(), com o IC aberto", {
  artemias  <- ler_treino("real_artemia_racoes")
  grupos    <- levels(artemias$racao)
  resultado <- comparar_medianas(artemias, resposta = taxa_crescimento_mg_dia,
                                 grupos = racao, alternativa = "maior")

  referencia <- wilcox.test(taxa_crescimento_mg_dia ~ racao, data = artemias,
                            exact = FALSE, conf.int = TRUE, alternative = "greater")
  expect_equal(resultado$teste$p, referencia$p.value)
  expect_equal(resultado$teste$ic_sup, Inf)
  expect_identical(resultado$nomes$alternativa, "maior")

  textos <- escrever_resultados(resultado)
  expect_match(textos$teste, "unilateral")
  expect_match(textos$teste, "+∞", fixed = TRUE)
  expect_match(textos$teste, grupos[1], fixed = TRUE)
  expect_true(nzchar(textos$nota_tabela))
  expect_match(textos$legenda_figura, "Mann-Whitney")
  expect_match(exibir_teste(resultado)$body$dataset[[3]], "+∞", fixed = TRUE)
})

test_that("a alternativa unilateral não existe com três grupos", {
  capturas <- ler_treino("sint_residuos_assimetricos")
  expect_error(comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho,
                                 alternativa = "menor"),
               "Kruskal-Wallis")
  textos <- escrever_resultados(comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho))
  expect_match(textos$nota_tabela, "Dunn")
})

test_that("a receita copiada do Mann-Whitney unilateral dá o mesmo teste", {
  artemias <- ler_treino("real_artemia_racoes")
  saida <- capture.output(
    resultado <- comparar_medianas(artemias, resposta = taxa_crescimento_mg_dia,
                                   grupos = racao, alternativa = "menor",
                                   mostrar_codigo = TRUE)
  )
  copiado <- rodar_receita_copiada(receita_mostrada(saida), list(artemias = artemias))
  expect_equal(copiado$teste, resultado$teste)
})
