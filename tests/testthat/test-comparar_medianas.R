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
