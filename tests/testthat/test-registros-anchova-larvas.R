test_that("anchova e larvas têm registros distintos e dados próprios", {
  a <- carregar_dados("anchova_norte_california")
  l <- carregar_dados("larvas_peixes_captura")
  expect_identical(dim(a), c(252L, 4L))
  expect_identical(dim(l), c(58L, 7L))
  expect_identical(a$data,
    seq.Date(as.Date("1971-01-01"), as.Date("1991-12-01"), by = "month"))
  expect_true(all(a$desembarque_lb > 0))
  expect_equal(sum(l$numero_larvas), 15919)
  expect_identical(catalogo_dados$codigo[
    match(c("anchova_norte_california", "larvas_peixes_captura"), catalogo_dados$nome)],
    c("D61", "D62"))
  expect_false(anyDuplicated(catalogo_dados$codigo) > 0L)
  expect_false(anyDuplicated(catalogo_dados$nome) > 0L)
})
