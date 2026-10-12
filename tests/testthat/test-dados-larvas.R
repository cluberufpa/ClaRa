test_that("larvas preservam contagens, duração e delineamento da fonte", {
  x <- carregar_dados("larvas_peixes_captura")
  expect_identical(dim(x), c(58L, 7L))
  expect_s3_class(x$data, "Date")
  expect_type(x$id_evento, "character")
  expect_type(x$numero_larvas, "integer")
  expect_false(anyNA(x))
  expect_false(anyDuplicated(x$id_evento) > 0L)
  expect_equal(sum(x$numero_larvas), 15919)
  expect_equal(sum(x$numero_larvas == 0), 8)
  expect_equal(range(x$esforco_h), c(8 + 10/60, 18 + 50/60))
  expect_equal(x$numero_larvas[x$id_evento == "BFC-006"], 5739L)
  expect_equal(as.integer(table(x$local)), c(22L, 17L, 19L))
  expect_equal(as.integer(table(x$estacao)), c(13L, 45L))
  expect_equal(sum(x$ano == "2018" & x$estacao == "Primavera"), 0L)
  registro <- catalogo_dados[catalogo_dados$nome == "larvas_peixes_captura", ]
  expect_equal(nrow(registro), 1L)
  expect_identical(registro$codigo, "D61")
  expect_identical(registro$fonte_dados, "clara")
  expect_match(registro$licenca, "CC0")
  # No check os fontes de data-raw ficam fora do tarball.
  fonte <- test_path("..", "..", "data-raw", "D61_larvas_captura", "fonte",
                     "Dale_Light_Trap_Data_Dryad.csv")
  if (file.exists(fonte)) {
    brutos <- read.csv(fonte)
    expect_identical(x$id_evento, brutos$sample)
    expect_identical(x$numero_larvas, brutos$n_fish)
    expect_equal(x$esforco_h, brutos$soak_hours + brutos$soak_min/60)
    expect_identical(x$data, as.Date(brutos$date_deployed, "%m/%d/%Y"))
  }
})
