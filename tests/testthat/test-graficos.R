test_that("os gráficos devolvem um ggplot", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)

  expect_true(ggplot2::is_ggplot(grafico_medias(resultado)))
  expect_true(ggplot2::is_ggplot(grafico_boxplot(resultado)))
  expect_true(ggplot2::is_ggplot(grafico_pares(resultado)))
  expect_true(ggplot2::is_ggplot(grafico_residuos(resultado)))
  expect_true(ggplot2::is_ggplot(grafico_qq(resultado)))
})

test_that("com mais de 8 grupos, grafico_medias() avisa e sugere uma tabela", {
  tanques   <- ler_treino("sint_dez_tanques")
  resultado <- comparar_medias(tanques, resposta = peso_g, grupos = tanque)

  expect_warning(grafico_medias(resultado), "tabela")
})

test_that("os rótulos informados na análise chegam aos gráficos", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres,
                               resposta        = peso_g,
                               grupos          = racao,
                               rotulo_resposta = "Peso (g)",
                               rotulo_grupos   = "Ração")
  figura <- grafico_medias(resultado)

  expect_equal(figura$labels$y, "Peso (g)")
  expect_equal(figura$labels$x, "Ração")
})

test_that("uma opção que não existe dá mensagem amigável", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)

  expect_error(grafico_medias(resultado, haste = "erro"), "aceita só")
})
