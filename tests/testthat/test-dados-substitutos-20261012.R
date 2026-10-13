test_that("D12 ovinos e caprinos reproduz o recorte pareado de soro e swab oral", {
  x <- ovinos_caprinos_fmdv
  expect_identical(dim(x), c(418L, 11L))
  expect_identical(names(x), c("id_animal", "id_local", "data_coleta", "visita", "especie",
    "idade_meses", "sexo", "origem_animal", "pcr_soro", "pcr_swab_oral", "elisa_nsp"))
  expect_type(x$id_animal, "character")
  expect_s3_class(x$data_coleta, "Date")
  expect_identical(levels(x$pcr_soro), c("negativo", "positivo"))
  expect_identical(levels(x$especie), c("ovino", "caprino"))
  expect_equal(sum(is.na(x$elisa_nsp)), 2L)
  expect_false(anyNA(x[setdiff(names(x), "elisa_nsp")]))
  expect_equal(length(unique(x$id_animal)), 323L)
  expect_false(anyDuplicated(x[c("id_animal", "visita")]) > 0L)
  # Tabela 2 x 2 do recorte completo (linhas = soro, colunas = swab).
  tab <- table(x$pcr_soro, x$pcr_swab_oral)
  expect_equal(as.integer(tab), c(400L, 9L, 8L, 1L))
  expect_equal(mcnemar.test(tab)$p.value, 1)
  # Uma coleta por animal: 308, 8, 6 e 1.
  y <- x[order(x$id_animal, x$data_coleta), ]
  y <- y[!duplicated(y$id_animal), ]
  expect_equal(nrow(y), 323L)
  expect_equal(as.integer(table(y$pcr_soro, y$pcr_swab_oral)), c(308L, 8L, 6L, 1L))
  # O ELISA contra a PCR do soro: discordância de um lado só.
  e <- table(x$elisa_nsp, x$pcr_soro)
  expect_lt(mcnemar.test(e)$p.value, 1e-30)
})

test_that("D52 secagem conserva códigos e séries", {
  expect_identical(dim(secagem_beterraba_gengibre), c(594L, 7L))
  expect_identical(levels(secagem_beterraba_gengibre$produto_codigo), c("B", "G"))
  expect_identical(levels(secagem_beterraba_gengibre$tratamento_codigo), c("C", "E"))
  expect_equal(nlevels(secagem_beterraba_gengibre$serie), 36L)
  expect_false(anyNA(secagem_beterraba_gengibre$razao_umidade))
})
