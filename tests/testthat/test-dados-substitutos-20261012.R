test_that("D12 erva-marinha preserva as plantas focais pareadas", {
  x <- erva_marinha_lesoes
  expect_identical(dim(x), c(180L, 5L))
  expect_type(x$id_planta, "character")
  expect_identical(levels(x$tratamento), c(
    "controle", "dano_artificial", "isopode_herbivoro"
  ))
  expect_identical(levels(x$momento), c("antes", "depois"))
  expect_equal(length(unique(x$id_planta)), 90L)
  expect_false(anyNA(x))
  expect_true(all(table(x$id_planta) == 2L))
  expect_true(all(x$presenca_lesao[x$momento == "antes"] == 0L))
  expect_equal(sum(x$presenca_lesao[x$momento == "depois"]), 69L)
  expect_identical(as.integer(table(
    x$tratamento[x$momento == "depois"],
    x$presenca_lesao[x$momento == "depois"]
  )), c(7L, 5L, 9L, 23L, 25L, 21L))
})

test_that("D52 secagem conserva códigos e séries", {
  expect_identical(dim(secagem_beterraba_gengibre), c(594L, 8L))
  expect_identical(levels(secagem_beterraba_gengibre$produto_codigo), c("B", "G"))
  expect_identical(levels(secagem_beterraba_gengibre$tratamento_codigo), c("C", "E"))
  expect_equal(nlevels(secagem_beterraba_gengibre$serie), 36L)
  expect_false(anyNA(secagem_beterraba_gengibre$razao_umidade))
})
