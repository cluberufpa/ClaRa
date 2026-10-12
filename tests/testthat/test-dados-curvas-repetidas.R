test_that("molinésias preservam medidas observadas e lacunas do acompanhamento", {
  x <- carregar_dados("molinesias_crescimento")
  expect_identical(dim(x), c(1178L, 4L))
  expect_equal(length(unique(x$id_peixe)), 34L)
  expect_false(anyNA(x))
  expect_equal(range(table(x$id_peixe)), c(30, 38))
  expect_false(anyDuplicated(x[c("id_peixe", "idade_dias")]) > 0L)
  expect_false(266L %in% x$idade_dias)
  idades <- as.integer(names(which(table(x$idade_dias) == 34L)))
  expect_identical(idades, c(0L, 14L, 21L, 42L, 49L, 56L, 77L, 154L, 224L, 280L))
  expect_equal(sum(x$idade_dias %in% idades), 340)
  fonte <- test_path("..", "..", "data-raw", "D48_molinesias_crescimento",
                     "fonte", "growth.csv")
  if (file.exists(fonte)) {
    b <- read.csv(fonte)
    expect_identical(x$id_peixe, as.character(b$test_fish_ID))
    expect_identical(x$id_mae, as.character(b$mother_ID))
    expect_identical(x$idade_dias, as.integer(b$fish_age_in_days))
    expect_identical(x$comprimento_padrao_cm, b$standard_length_in_cm)
  }
})

test_that("percas preservam grupos, exposição e respostas ausentes", {
  x <- carregar_dados("percas_hipoxia")
  expect_identical(dim(x), c(449L, 4L))
  expect_equal(length(unique(x$id_peixe)), 40L)
  expect_equal(as.integer(table(unique(x[c("id_peixe", "grupo")])$grupo)),
               c(13L, 11L, 16L))
  expect_false(anyNA(x[1:3]))
  expect_equal(sum(is.na(x$consumo_o2_mg_kg_h)), 23L)
  expect_equal(sum(x$saturacao_ar_pct == 100), 3L)
  expect_true(all(is.na(x$consumo_o2_mg_kg_h[x$saturacao_ar_pct == 100])))
  expect_false(anyDuplicated(x[c("id_peixe", "saturacao_ar_pct")]) > 0L)
  expect_true(all(x$grupo[x$saturacao_ar_pct == 15] == levels(x$grupo)[2]))
  n <- tapply(!is.na(x$consumo_o2_mg_kg_h), x$id_peixe, sum)
  expect_equal(range(n), c(8, 12))
})

test_that("D44 e D48 apontam para os substitutos aquáticos", {
  for (par in list(c("D44", "percas_hipoxia"), c("D48", "molinesias_crescimento"))) {
    r <- catalogo_dados[catalogo_dados$codigo == par[1], ]
    expect_equal(nrow(r), 1L)
    expect_identical(r$nome, par[2])
    expect_identical(r$fonte_dados, "clara")
    expect_identical(r$verbo_clara, "")
    expect_match(r$licenca, "CC")
  }
  expect_false(any(c("plantas_absorcao_co2", "laranjeiras_crescimento") %in%
                     catalogo_dados$nome))
})

