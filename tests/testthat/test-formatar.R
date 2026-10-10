# Números e p-valores ----------------------------------------------------------

test_that("formatar_numero() escreve com vírgula e casas fixas, e traço no NA", {
  expect_equal(formatar_numero(86.254), "86,25")
  expect_equal(formatar_numero(c(3.14159, 2, NA), casas = 1), c("3,1", "2,0", "-"))
  expect_equal(formatar_numero(1234567.5, casas = 0), "1234568")
})

test_that("formatar_p() nunca escreve p igual a zero", {
  expect_equal(formatar_p(c(0.0321, 0.0004, 0.5, NA)),
               c("0,032", "< 0,001", "0,500", "-"))
  expect_equal(formatar_p(c(0.0321, 0.0004), no_texto = TRUE),
               c("p = 0,032", "p < 0,001"))
  expect_equal(formatar_p(0.00004, casas = 4), "< 0,0001")
})

test_that("formatar_p() recusa um no_texto que não é TRUE nem FALSE", {
  expect_error(formatar_p(0.03, no_texto = "sim"), "TRUE ou FALSE")
})


# Tabelas ----------------------------------------------------------------------

test_that("exibir_tabela() devolve um flextable nos dois temas", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)

  expect_s3_class(exibir_tabela(resultado$resumo), "flextable")
  expect_s3_class(exibir_tabela(resultado$resumo, tema = "cinza"), "flextable")
  expect_error(exibir_tabela(resultado), "data.frame")
  expect_error(exibir_tabela(resultado$resumo, tema = "azul"), "aceita só")
})

test_that("exibir_teste() da ANOVA traz a tabela com os números do resultado", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao,
                               rotulo_grupos = "Ração")
  tabela <- exibir_teste(resultado)$body$dataset

  expect_equal(names(tabela), c("Fonte", "GL", "SQ", "QM", "F", "p"))
  expect_equal(tabela$Fonte, c("Ração", "Resíduo"))
  expect_equal(tabela$F[1], formatar_numero(resultado$anova$f[1]))
  expect_equal(tabela$p, c("< 0,001", ""))
})

test_that("exibir_teste() da ANOVA de Welch tira SQ e QM e mostra o GL com decimais", {
  peixes    <- ler_treino("sint_variancias_desiguais")
  resultado <- comparar_medias(peixes, resposta = comprimento_cm, grupos = densidade,
                               variancias_iguais = FALSE)
  tabela <- exibir_teste(resultado)$body$dataset

  expect_equal(names(tabela), c("Fonte", "GL", "F", "p"))
  expect_equal(tabela$GL[2], formatar_numero(resultado$anova$gl[2], 2))
})

test_that("exibir_teste() serve ao teste t, ao Kruskal-Wallis e ao Mann-Whitney", {
  artemias <- ler_treino("real_artemia_racoes")
  capturas <- ler_treino("sint_residuos_assimetricos")

  teste_t <- exibir_teste(comparar_medias(artemias, taxa_crescimento_mg_dia, racao))$body$dataset
  expect_equal(names(teste_t), c("Comparação", "Diferença", "IC 95%", "t", "GL", "p"))

  kruskal <- exibir_teste(comparar_medianas(capturas, cpue_kg, petrecho))$body$dataset
  expect_equal(names(kruskal), c("H", "GL", "p"))

  mann_whitney <- exibir_teste(comparar_medianas(artemias, taxa_crescimento_mg_dia, racao))$body$dataset
  expect_equal(names(mann_whitney), c("Comparação", "Deslocamento", "IC 95%", "W", "p"))
})

test_that("exibir_resumo() das médias traz média ± DP, IC e a nota de rodapé", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao,
                               rotulo_grupos = "Ração", confianca = 0.90)
  textos    <- escrever_resultados(resultado)
  tabela    <- exibir_resumo(resultado, casas = 1, nota = textos$nota_tabela)

  expect_equal(names(tabela$body$dataset), c("Ração", "n", "Média ± DP", "IC 90%"))
  expect_equal(tabela$body$dataset$`Média ± DP`[1],
               paste(formatar_numero(resultado$resumo$media[1], 1), "±",
                     formatar_numero(resultado$resumo$dp[1], 1)))
  expect_equal(unname(unlist(tabela$footer$dataset[1, 1])), textos$nota_tabela)
})

test_that("exibir_resumo() das medianas traz mediana e quartis", {
  capturas  <- ler_treino("sint_residuos_assimetricos")
  resultado <- comparar_medianas(capturas, resposta = cpue_kg, grupos = petrecho)
  tabela    <- exibir_resumo(resultado)$body$dataset

  expect_equal(names(tabela), c("petrecho", "n", "Mediana", "Q1 a Q3"))
  expect_equal(tabela$Mediana, formatar_numero(resultado$resumo$mediana))
})

test_that("a receita de exibir_resumo(), copiada, dá a mesma tabela", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  textos    <- escrever_resultados(resultado)
  saida     <- capture.output(
    tabela <- exibir_resumo(resultado, casas = 1, nota = textos$nota_tabela,
                            mostrar_codigo = TRUE)
  )
  receita <- receita_mostrada(saida)
  expect_match(receita, "add_footer_lines(textos$nota_tabela)", fixed = TRUE)

  copia <- rodar_receita_copiada(receita, list(resultado = resultado, textos = textos))
  expect_equal(copia$body$dataset, tabela$body$dataset)
  expect_equal(copia$footer$dataset, tabela$footer$dataset)
})

test_that("exibir_resumo() confere casas e nota", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  expect_error(exibir_resumo(resultado, casas = "um"), "casas")
  expect_error(exibir_resumo(resultado, nota = c("a", "b")), "nota")
})
