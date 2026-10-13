test_that("D12 cabras reproduz as tabelas 2 x 2 publicadas", {
  x <- cabras_toxoplasma
  expect_identical(dim(x), c(106L, 4L))
  expect_identical(names(x), c("id_cabra", "elisa_soro", "pcr_sangue", "pcr_leite"))
  expect_false(anyNA(x))
  expect_false(anyDuplicated(x$id_cabra) > 0L)
  expect_identical(levels(x$pcr_sangue), c("negativo", "positivo"))
  tab <- function(a, b) matrix(table(factor(a, c("positivo", "negativo")), factor(b, c("positivo", "negativo"))), 2)
  expect_equal(c(tab(x$pcr_sangue, x$pcr_leite)), c(7, 8, 9, 82))
  expect_equal(c(tab(x$elisa_soro, x$pcr_leite)), c(13, 2, 38, 53))
  expect_equal(c(tab(x$elisa_soro, x$pcr_sangue)), c(15, 1, 36, 54))
  seropos <- x[x$elisa_soro == "positivo", ]
  expect_equal(c(tab(seropos$pcr_sangue, seropos$pcr_leite)), c(6, 7, 9, 29))
  # O McNemar roda, com discordantes equilibrados no sangue x leite.
  expect_equal(mcnemar.test(table(x$pcr_sangue, x$pcr_leite))$p.value, 1)
  expect_lt(mcnemar.test(table(x$elisa_soro, x$pcr_leite))$p.value, 1e-6)
})

test_that("D52 secagem conserva códigos e séries", {
  expect_identical(dim(secagem_beterraba_gengibre), c(594L, 8L))
  expect_identical(levels(secagem_beterraba_gengibre$produto_codigo), c("B", "G"))
  expect_identical(levels(secagem_beterraba_gengibre$tratamento_codigo), c("C", "E"))
  expect_equal(nlevels(secagem_beterraba_gengibre$serie), 36L)
  expect_false(anyNA(secagem_beterraba_gengibre$razao_umidade))
})
