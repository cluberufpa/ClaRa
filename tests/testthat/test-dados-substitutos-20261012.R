test_that("D12 garoupa reproduz as tabelas 2 x 2 publicadas de PCR e histologia", {
  x <- garoupa_pcr_histologia
  expect_identical(dim(x), c(123L, 4L))
  expect_identical(names(x), c("id_peixe", "replica", "histologia", "pcr"))
  expect_type(x$id_peixe, "character")
  expect_false(anyNA(x))
  expect_false(anyDuplicated(x$id_peixe) > 0L)
  expect_identical(levels(x$replica), c("1", "2"))
  expect_identical(levels(x$pcr), c("negativo", "positivo"))
  expect_identical(as.integer(table(x$replica)), c(74L, 49L))
  tab <- function(r) {
    y <- x[x$replica == r, ]
    table(y$histologia, y$pcr)
  }
  # Tabela 32 (réplica 1): histologia nas linhas, PCR nas colunas, negativo primeiro.
  expect_equal(as.integer(tab("1")), c(4L, 2L, 50L, 18L))
  # Tabela 34 (réplica 2).
  expect_equal(as.integer(tab("2")), c(3L, 3L, 28L, 15L))
  m1 <- mcnemar.test(tab("1"))
  expect_equal(unname(m1$statistic), 42.48077, tolerance = 1e-6)
  expect_equal(m1$p.value, 7.138e-11, tolerance = 1e-3)
  expect_lt(mcnemar.test(tab("2"))$p.value, 1e-4)
})

test_that("D52 secagem conserva códigos e séries", {
  expect_identical(dim(secagem_beterraba_gengibre), c(594L, 7L))
  expect_identical(levels(secagem_beterraba_gengibre$produto_codigo), c("B", "G"))
  expect_identical(levels(secagem_beterraba_gengibre$tratamento_codigo), c("C", "E"))
  expect_equal(nlevels(secagem_beterraba_gengibre$serie), 36L)
  expect_false(anyNA(secagem_beterraba_gengibre$razao_umidade))
})

test_that("D60 esgana-gata é um quadrado latino 4 x 4 repetido em 144 peixes", {
  x <- esgana_gata_ruido
  expect_identical(dim(x), c(576L, 11L))
  expect_identical(names(x), c("id_peixe", "sequencia", "periodo", "ruido_visual",
    "distancia_cardume_mm", "tamanho_peixe_mm", "velocidade_mm_s",
    "preferencia_cardume_maior", "ensaio", "cardume_maior_n", "cardume_menor_n"))
  expect_false(anyNA(x))
  expect_identical(levels(x$ruido_visual), c("estático", "lento", "médio", "rápido"))
  expect_true(all(table(x$id_peixe, x$ruido_visual) == 1L))
  cel <- aggregate(distancia_cardume_mm ~ sequencia + periodo + ruido_visual, data = x, FUN = mean)
  uma_vez <- function(a, b) all(table(a, b) == 1L)
  expect_identical(nrow(cel), 16L)
  expect_true(uma_vez(cel$ruido_visual, cel$sequencia))
  expect_true(uma_vez(cel$ruido_visual, cel$periodo))
  a <- summary(aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo, data = cel))[[1]]
  expect_equal(a$Df, c(3, 3, 3, 6))
  expect_equal(a[["F value"]][1], 16.233, tolerance = 1e-3)
  r <- summary(aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo + Error(id_peixe),
    data = x))[["Error: Within"]][[1]]
  expect_equal(r$Df, c(3, 3, 426))
  expect_lt(r[["Pr(>F)"]][1], 1e-5)
})
