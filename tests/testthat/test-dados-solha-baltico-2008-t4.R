test_that("solha_baltico_2008_t4 preserva o recorte D17 para regressão múltipla", {
  x <- carregar_dados("solha_baltico_2008_t4")
  expect_identical(dim(x), c(179L, 9L))
  expect_false(anyNA(x))
  expect_identical(sum(x$cpue_g == 0), 37L)
  expect_identical(x$linha_fonte[1], 14L)
  expect_identical(x$linha_fonte[nrow(x)], 9702L)
  expect_equal(x$log_cpue_g, log1p(x$cpue_g), tolerance = 1e-12)

  ajuste <- lm(log_cpue_g ~ temperatura_fundo_c + salinidade +
    oxigenio_dissolvido_mg_l + profundidade_m + latitude_graus +
    longitude_graus, data = x)
  expect_equal(summary(ajuste)$r.squared, 0.6456858, tolerance = 1e-6)
  expect_false(anyNA(coef(ajuste)))
  expect_equal(max(car::vif(ajuste)), 4.208623, tolerance = 1e-6)
  expect_equal(cor(x$salinidade, x$longitude_graus), -0.670082, tolerance = 1e-6)

  registro <- catalogo_dados[catalogo_dados$codigo == "D17", ]
  expect_equal(nrow(registro), 1L)
  expect_identical(registro$nome, "solha_baltico_2008_t4")
  expect_match(registro$licenca, "CC0")
  expect_false("camarao_ecogreen" %in% catalogo_dados$nome)
  expect_error(carregar_dados("camarao_ecogreen"), "Conjunto n")
})
