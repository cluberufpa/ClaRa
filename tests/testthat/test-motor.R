# O código mostrado é o código que rodou --------------------------------------

test_that("a receita da ANOVA, copiada para uma sessão sem a ClaRa, dá o mesmo resultado", {
  bagres <- ler_treino("real_bagre_racoes")
  saida  <- capture.output(
    resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao,
                                 mostrar_codigo = TRUE)
  )
  receita <- receita_mostrada(saida)
  expect_match(receita, "library(dplyr)", fixed = TRUE)

  copia <- rodar_receita_copiada(receita, list(bagres = bagres))
  expect_equal(copia$resumo, resultado$resumo)
  expect_equal(copia$anova, resultado$anova)
  expect_equal(copia$pares, resultado$pares)
  expect_equal(copia$pressupostos, resultado$pressupostos)
})

test_that("a receita da ANOVA de Welch, copiada, dá o mesmo resultado", {
  peixes <- ler_treino("sint_variancias_desiguais")
  saida  <- capture.output(
    resultado <- comparar_medias(peixes, resposta = comprimento_cm, grupos = densidade,
                                 variancias_iguais = FALSE, mostrar_codigo = TRUE)
  )
  copia <- rodar_receita_copiada(receita_mostrada(saida), list(peixes = peixes))
  expect_equal(copia$anova, resultado$anova)
  expect_equal(copia$pares, resultado$pares)
})

test_that("a receita do Kruskal-Wallis, copiada, dá o mesmo resultado", {
  capturas <- ler_treino("sint_residuos_assimetricos")
  saida    <- capture.output(
    resultado <- comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho,
                                   mostrar_codigo = TRUE)
  )
  copia <- rodar_receita_copiada(receita_mostrada(saida), list(capturas = capturas))
  expect_equal(copia$teste, resultado$teste)
  expect_equal(copia$pares, resultado$pares)
})


# A ClaRa não mexe na sessão do aluno -----------------------------------------

test_that("as análises não carregam pacotes no caminho de busca", {
  antes  <- search()
  bagres <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  medir_efeito(resultado)
  grafico_medias(resultado)
  expect_equal(search(), antes)
})

test_that("a semente aleatória do aluno não muda, mesmo com set.seed() na receita", {
  capturas <- ler_treino("sint_residuos_assimetricos")
  resultado <- comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho)

  set.seed(2026)
  semente <- .Random.seed
  medir_efeito(resultado)
  expect_identical(.Random.seed, semente)
})


# Ajuda ------------------------------------------------------------------------

test_that("a lista da ajuda() traz todas as funções exportadas, com a pergunta", {
  funcoes <- clara:::funcoes_da_clara()
  expect_setequal(funcoes$funcao, getNamespaceExports("clara"))
  expect_true(all(grepl("[?]$", funcoes$pergunta)))
  expect_equal(funcoes$funcao[1], "comparar_medias")
  expect_equal(funcoes$secao[nrow(funcoes)], "Ajuda")
})

test_that("ajuda() de uma função que não é da ClaRa explica quais existem", {
  expect_error(ajuda(mean), "As funções da ClaRa são")
})
