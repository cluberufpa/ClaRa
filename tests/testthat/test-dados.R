test_that("o catálogo corresponde aos objetos e às páginas de ajuda", {
  expect_false(anyDuplicated(catalogo_dados$codigo) > 0L)
  expect_false(anyDuplicated(catalogo_dados$nome) > 0L)
  expect_true(all(grepl("^D[0-9]{2}$", catalogo_dados$codigo)))
  expect_false(anyDuplicated(catalogo_dados$registro) > 0L)
  expect_true(all(grepl("^D[0-9]{2}_[a-z]+(?:_[a-z]+)?$", catalogo_dados$registro, perl = TRUE)))
  expect_true(all(startsWith(catalogo_dados$registro, paste0(catalogo_dados$codigo, "_"))))
  expect_true("nome_eapadados" %in% names(catalogo_dados))
  expect_true("fonte_dados" %in% names(catalogo_dados))
  expect_true(all(is.element(catalogo_dados$fonte_dados, c("clara", "FSAdata", "MASS"))))

  # No desenvolvimento lemos as páginas recém-geradas; no check, a ajuda
  # instalada. Não usamos uma instalação antiga para conferir dados novos.
  pasta_man <- test_path("..", "..", "man")
  if (dir.exists(pasta_man)) {
    arquivos <- list.files(pasta_man, "\\.Rd$", full.names = TRUE)
    ajuda <- setNames(lapply(arquivos, tools::parse_Rd), basename(arquivos))
  } else {
    ajuda <- tools::Rd_db("clara")
  }
  for (i in seq_len(nrow(catalogo_dados))) {
    registro <- catalogo_dados[i, ]
    # Os nove externos têm testes próprios, com dependências opcionais.
    if (registro$fonte_dados != "clara") next
    dados <- carregar_dados(registro$nome)
    expect_s3_class(dados, "data.frame")
    expect_equal(dim(dados), c(registro$linhas, registro$colunas))
    # Nomes em português e minúsculos (arrumação leve de 12/10/2026).
    # Nomes novos são traduzidos no preparo; pendências vão para a ficha.
    expect_true(all(nzchar(names(dados))))
    expect_false(anyDuplicated(names(dados)) > 0L)

    rd <- ajuda[[paste0(registro$nome, ".Rd")]]
    expect_false(is.null(rd))
    formato <- Filter(function(x) identical(attr(x, "Rd_tag"), "\\format"), rd)
    itens <- character()
    ler_itens <- function(x) {
      if (identical(attr(x, "Rd_tag"), "\\item")) {
        itens <<- c(itens, paste(unlist(x[[1]]), collapse = ""))
      } else if (is.list(x)) {
        invisible(lapply(x, ler_itens))
      }
    }
    invisible(lapply(formato, ler_itens))
    expect_identical(itens, names(dados))

    for (nome in names(dados)) {
      coluna <- dados[[nome]]
      if (is.factor(coluna)) {
        expect_setequal(levels(coluna), unique(as.character(coluna[!is.na(coluna)])))
      }
      if (startsWith(nome, "id_")) expect_type(coluna, "character")
    }
  }
})

test_that("os bagres preservam as observações e a pendência de autorização", {
  expect_identical(levels(bagre_racao_isoproteica$racao), c("A", "B", "C", "D"))
  expect_false(is.ordered(bagre_racao_isoproteica$racao))
  expect_identical(as.integer(table(bagre_racao_isoproteica$racao)), c(5L, 5L, 4L, 5L))
  expect_identical(bagre_racao_isoproteica$peso_g,
                   c(86, 83, 91, 84, 87, 88, 87, 94, 86, 89,
                     105, 104, 102, 99, 94, 91, 89, 92, 97))
  expect_false(anyNA(bagre_racao_isoproteica))
  expect_match(catalogo_dados$licenca[catalogo_dados$codigo == "D01"], "autorizado pelo professor")
})

 test_that("a Trilha encontra os bagres pelo nome anterior sem mudar as colunas", {
  linha <- catalogo_dados[catalogo_dados$nome_eapadados == "isoproteica_bagre", ]
  expect_equal(nrow(linha), 1L)
  expect_identical(linha$codigo, "D01")
  expect_identical(linha$registro, "D01_bagre_racao")
  expect_identical(linha$nome, "bagre_racao_isoproteica")
  expect_identical(names(bagre_racao_isoproteica), c("racao", "peso_g"))
})
