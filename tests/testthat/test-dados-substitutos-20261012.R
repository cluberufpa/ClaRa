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

test_that("D60 vacas fistuladas é um quadrado latino 4 x 4 que reproduz o artigo", {
  x <- vacas_fistuladas
  expect_identical(dim(x), c(16L, 8L))
  expect_identical(names(x), c("id_vaca", "periodo", "oferta_forragem", "suplemento",
    "tratamento", "ph_ruminal", "nh3_n_mmol_l", "agv_total_mmol_l"))
  expect_type(x$id_vaca, "character")
  expect_false(anyNA(x))
  expect_identical(levels(x$oferta_forragem), c("20 kg", "30 kg"))
  expect_identical(levels(x$suplemento), c("milho úmido", "trigo moído"))
  uma_vez <- function(a, b) all(table(a, b) == 1L)
  expect_true(uma_vez(x$id_vaca, x$periodo))
  expect_true(uma_vez(x$tratamento, x$id_vaca))
  expect_true(uma_vez(x$tratamento, x$periodo))
  a <- summary(aov(ph_ruminal ~ tratamento + id_vaca + periodo, data = x))[[1]]
  expect_equal(a$Df, c(3, 3, 3, 6))
  expect_equal(a[["Pr(>F)"]][1], 0.9044, tolerance = 1e-3)
  expect_equal(a[["Pr(>F)"]][3], 0.00479, tolerance = 1e-2)
  # Modelo fatorial do artigo (Tabela 4): oferta 0,810, suplemento 0,856, interação 0,528.
  f <- summary(aov(ph_ruminal ~ periodo + id_vaca + oferta_forragem * suplemento, data = x))[[1]]
  expect_equal(round(f[["Pr(>F)"]][3:5], 3), c(0.810, 0.856, 0.528))
})
