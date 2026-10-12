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

test_that("D48 molinésias usa as dez datas completas", {
  expect_identical(dim(molinesias_crescimento), c(340L, 4L))
  expect_identical(levels(molinesias_crescimento$mae), c("m1", "m2", "m4"))
  expect_equal(length(unique(molinesias_crescimento$peixe)), 34L)
  expect_identical(sort(unique(molinesias_crescimento$idade_dias)),
                   c(0L, 14L, 21L, 42L, 49L, 56L, 77L, 154L, 224L, 280L))
  expect_false(anyNA(molinesias_crescimento))
})

test_that("D44 percas preserva ausências e níveis de hipoxia", {
  expect_identical(dim(percas_respirometria), c(449L, 4L))
  expect_identical(levels(percas_respirometria$grupo), c("Baltic", "Biotest", "Balt@Bio"))
  expect_equal(length(unique(percas_respirometria$peixe)), 40L)
  expect_equal(sum(is.na(percas_respirometria$consumo_o2_mg_kg_h)), 23L)
  expect_true(100 %in% percas_respirometria$saturacao_ar_pct)
})
