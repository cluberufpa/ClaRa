test_that("lebistes preservam sexo, infecção e as linhas da fonte", {
  x <- carregar_dados("lebistes_parasitos")
  expect_identical(dim(x), c(4715L, 9L))
  expect_false(any(is.na(x[-7])))
  expect_equal(sum(is.na(x$peso_g)), 113L)
  expect_type(x$contagem_parasitos, "integer")
  expect_true(all(x$presenca_parasito %in% 0:1))
  expect_equal(as.integer(table(x$sexo)), c(1951L, 1520L, 1244L))
  expect_equal(as.integer(table(x$sexo, x$presenca_parasito)),
               c(1229L, 1019L, 1067L, 722L, 501L, 177L))
  expect_equal(sum(x$presenca_parasito), 1400L)
  expect_equal(sum(x$presenca_parasito == 1L & x$contagem_parasitos == 0L), 3L)
  expect_equal(nrow(unique(x[c("bacia", "rio", "sitio", "ano")])), 69L)
  qui <- suppressWarnings(chisq.test(table(x$sexo, x$presenca_parasito)))
  expect_gt(min(qui$expected), 300)
  expect_equal(unname(qui$statistic), 200.28, tolerance = 1e-3)
  registro <- catalogo_dados[catalogo_dados$nome == "lebistes_parasitos", ]
  expect_equal(nrow(registro), 1L)
  expect_identical(registro$codigo, "D19")
  expect_identical(registro$fonte_dados, "clara")
  expect_match(registro$licenca, "CC0")
  expect_false("camaroes_sexo" %in% catalogo_dados$nome)
  fonte <- test_path("..", "..", "data-raw", "D19_lebistes_parasitos", "fonte",
                     "peixes_parasitismo_individuos_tidy.xlsx")
  if (file.exists(fonte) && requireNamespace("readxl", quietly = TRUE)) {
    brutos <- as.data.frame(readxl::read_excel(fonte, sheet = "dados_brutos_tidy"))
    expect_equal(x$peso_g, brutos$peso_g)
    expect_equal(x$contagem_parasitos, as.integer(brutos$contagem_parasitos))
    expect_equal(x$presenca_parasito, as.integer(brutos$presenca_parasito))
    expect_identical(x$rio, brutos$rio)
  }
})
