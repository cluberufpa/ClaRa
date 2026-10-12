test_that("lago_vitoria conserva as leituras, os NA e o D04", {
  x <- carregar_dados("lago_vitoria")
  expect_identical(dim(x), c(217L, 25L))
  expect_type(x$id_amostra, "character")
  expect_identical(levels(x$local), c("Dunga", "Ndere", "Naya", "Mfangano"))
  expect_identical(levels(x$estacao), c("Gaiolas", "Controle"))
  expect_identical(levels(x$ano), c("2023", "2024"))
  expect_equal(sum(is.na(x$profundidade_local_m)), 81L)
  expect_true(all(x$ano[is.na(x$profundidade_local_m)] == "2024"))
  expect_equal(sum(is.na(x[-6])), 0L)
  expect_false(anyDuplicated(x[c("id_amostra", "ano", "profundidade_m")]) > 0L)
  expect_equal(as.integer(table(x$estacao)), c(117L, 100L))
  expect_equal(sum(x$turbidez_ftu < 0), 24L)
  expect_equal(sum(x$clorofila_a == 0), 1L)
  expect_equal(range(x$oxigenio_dissolvido_mgl), c(5.06, 9.93))
  expect_equal(range(x$profundidade_m), c(0, 10))
  expect_gt(min(cor(x[c("condutividade_uscm", "solidos_dissolvidos_mgl",
                        "salinidade_ppt")])), 0.9)
  registro <- catalogo_dados[catalogo_dados$codigo == "D04", ]
  expect_equal(nrow(registro), 1L)
  expect_identical(registro$nome, "lago_vitoria")
  expect_identical(registro$fonte_dados, "clara")
  expect_match(registro$licenca, "CC0")
  expect_false("doubs_ambiente" %in% catalogo_dados$nome)
  expect_error(carregar_dados("doubs_ambiente"), "Conjunto n")

  # A fonte fica fora do tarball; quando disponível, conferir cada valor.
  fonte <- test_path("..", "..", "data-raw", "D04_lago_vitoria", "fonte",
                     "2023_2024_water_quality_data.xlsx")
  if (file.exists(fonte) && requireNamespace("readxl", quietly = TRUE)) {
    bruto <- as.data.frame(readxl::read_excel(fonte))
    expect_identical(as.character(x$local), bruto$Site)
    expect_identical(x$id_amostra, bruto$Stations_sample)
    expect_equal(x$fosforo_total_ugl, bruto$TP, tolerance = 1e-12)
    expect_equal(x$oxigenio_dissolvido_mgl, bruto$DO, tolerance = 1e-12)
    expect_equal(x$turbidez_ftu, bruto$Turbidity, tolerance = 1e-12)
    expect_equal(x$profundidade_local_m, bruto$total_depth, tolerance = 1e-12)
  }
})
