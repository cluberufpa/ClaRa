test_that("pollock conserva zeros, extremos, coordenadas e o D47", {
  x <- carregar_dados("pollock_alasca")
  expect_identical(dim(x), c(523L, 6L))
  expect_type(x$id_lance, "character")
  expect_false(anyNA(x))
  expect_false(anyDuplicated(x$id_lance) > 0L)
  expect_equal(nrow(unique(x[c("latitude_graus", "longitude_graus")])), 523L)
  expect_false(any(c("ano", "especie") %in% names(x)))  # constantes, removidas em 12/10/2026
  expect_s3_class(x$estrato, "factor")
  expect_equal(nlevels(x$estrato), 54L)
  expect_equal(sum(x$cpue_kg_ha == 0), 91L)
  expect_equal(range(x$cpue_kg_ha), c(0, 1345.89633822))
  expect_equal(median(x$cpue_kg_ha), 2.52302846)
  expect_equal(range(x$profundidade_m), c(19, 584))
  expect_equal(range(x$latitude_graus), c(52.46348, 60.27113), tolerance = 1e-7)
  expect_equal(range(x$longitude_graus), c(-169.89803, -133.13862), tolerance = 1e-7)
  registro <- catalogo_dados[catalogo_dados$codigo == "D47", ]
  expect_equal(nrow(registro), 1L)
  expect_identical(registro$nome, "pollock_alasca")
  expect_identical(registro$fonte_dados, "clara")
  expect_match(registro$licenca, "CC0")
  expect_false("terremotos_fiji" %in% catalogo_dados$nome)
  expect_error(carregar_dados("terremotos_fiji"), "Conjunto n")

  # Os fontes ficam fora do tarball; quando disponíveis, conferir cada valor.
  fonte <- test_path("..", "..", "data-raw", "D47_pollock_alasca", "fonte",
                     "noaa_pollock_2023_conferencia.csv")
  if (file.exists(fonte)) {
    bruto <- read.csv(fonte, colClasses = c(SampleID = "character", Stratum = "character"))
    expect_identical(x$id_lance, bruto$SampleID)
    expect_equal(x$cpue_kg_ha, bruto$WTCPUE, tolerance = 1e-12)
    expect_equal(x$profundidade_m, bruto$Depth)
    expect_equal(x$latitude_graus, bruto$latitude_wgs84, tolerance = 1e-12)
    expect_equal(x$longitude_graus, bruto$longitude_wgs84, tolerance = 1e-12)
    expect_identical(as.character(x$estrato), bruto$Stratum)
  }
})
