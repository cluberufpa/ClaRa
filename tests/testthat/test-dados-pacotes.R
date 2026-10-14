test_that("carregar_dados aceita apenas nomes do catálogo e mantém os dados próprios", {
  expect_identical(carregar_dados("bagre_racao_isoproteica"), bagre_racao_isoproteica)
  expect_error(carregar_dados("DarterOnt"), "Consulte catalogo_dados")
  expect_error(carregar_dados("objeto_inexistente"), "não encontrado")
  for (entrada in list(NA_character_, character(), c("a", "b"), 42, "")) {
    expect_error(carregar_dados(entrada), "nome entre aspas")
  }
})

test_that("só os sete registros aprovados usam fornecedores externos", {
  receitas <- getFromNamespace("receitas_dados_pacotes", "clara")
  externos <- catalogo_dados[catalogo_dados$fonte_dados != "clara", ]
  expect_equal(nrow(externos), 7L)
  expect_setequal(externos$nome, names(receitas))
  expect_equal(sum(externos$fonte_dados == "FSAdata"), 6L)
  expect_identical(externos$nome[externos$fonte_dados == "MASS"], "crabs_morfometria")
})

# Cada conjunto tem seu próprio skip, sem desativar testes dos dados internos.
estruturas <- dget(test_path("estrutura-dados-pacotes.txt"))
for (nome_conjunto in names(estruturas)) {
  local({
    nome <- nome_conjunto
    esperado <- estruturas[[nome]]
    pacote <- catalogo_dados$fonte_dados[match(nome, catalogo_dados$nome)]
    test_that(paste("a leitura de", nome, "preserva a estrutura e as categorias da ficha"), {
      skip_if_not_installed(pacote)
      dados <- carregar_dados(nome)
      expect_s3_class(dados, "data.frame")
      expect_identical(dim(dados), esperado$dim)
      expect_identical(names(dados), esperado$nomes)
      expect_identical(unname(vapply(dados, typeof, character(1))), unlist(esperado$tipos))
      expect_identical(lapply(dados, class), esperado$classes)
      expect_identical(lapply(Filter(is.factor, dados), levels), esperado$niveis)
      expect_identical(unname(vapply(dados, function(x) sum(is.na(x)), integer(1))), unlist(esperado$na))
      for (coluna in names(esperado$categorias)) {
        expect_identical(sort(unique(dados[[coluna]])), esperado$categorias[[coluna]])
      }
    })
  })
}
