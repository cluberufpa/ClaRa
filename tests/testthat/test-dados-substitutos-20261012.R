test_that("D12 búfalos preserva o pareamento e as linhas sem par", {
  expect_identical(dim(bufalos_estrongilos), c(418L, 6L))
  expect_identical(levels(bufalos_estrongilos$tratamento), c("controle", "fenbendazol"))
  expect_identical(levels(bufalos_estrongilos$momento), c("antes", "depois"))
  expect_equal(length(unique(bufalos_estrongilos$id_bufalo)), 216L)
  expect_equal(sum(is.na(bufalos_estrongilos$presenca_ovos_estrongilos)), 6L)
})

test_that("D52 secagem conserva códigos e séries", {
  expect_identical(dim(secagem_beterraba_gengibre), c(594L, 8L))
  expect_identical(levels(secagem_beterraba_gengibre$produto_codigo), c("B", "G"))
  expect_identical(levels(secagem_beterraba_gengibre$tratamento_codigo), c("C", "E"))
  expect_equal(nlevels(secagem_beterraba_gengibre$serie), 36L)
  expect_false(anyNA(secagem_beterraba_gengibre$razao_umidade))
})
