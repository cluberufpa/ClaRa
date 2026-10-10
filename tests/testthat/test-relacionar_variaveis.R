test_that("os coeficientes, o R² e o F são os do lm()", {
  barbos    <- ler_treino("real_barbo_morfometria")
  resultado <- relacionar_variaveis(barbos,
                                    resposta = altura_maxima_corpo,
                                    preditor = distancia_dorsal_pelvica)

  referencia <- lm(altura_maxima_corpo ~ distancia_dorsal_pelvica, data = barbos)
  resumo     <- summary(referencia)
  expect_s3_class(resultado, "clara_regressao")
  expect_equal(resultado$coeficientes$estimativa, unname(coef(referencia)))
  expect_equal(resultado$coeficientes$ic_inf, unname(confint(referencia)[, 1]))
  expect_equal(resultado$ajuste$r2, resumo$r.squared)
  expect_equal(resultado$ajuste$f, unname(resumo$fstatistic[1]), ignore_attr = TRUE)
  expect_equal(resultado$coeficientes$termo, c("intercepto", "distancia_dorsal_pelvica"))
})

test_that("os pressupostos são os mesmos testes da Trilha", {
  barbos    <- ler_treino("real_barbo_morfometria")
  resultado <- relacionar_variaveis(barbos,
                                    resposta = altura_maxima_corpo,
                                    preditor = distancia_dorsal_pelvica)
  modelo    <- lm(altura_maxima_corpo ~ distancia_dorsal_pelvica, data = barbos)

  expect_equal(resultado$pressupostos$teste, c("Shapiro-Wilk", "Breusch-Pagan"))
  expect_equal(resultado$pressupostos$p[1], shapiro.test(residuals(modelo))$p.value)
  expect_equal(resultado$pressupostos$p[2], car::ncvTest(modelo)$p)

  # O Durbin-Watson só entra quando o aluno pede, e se repete pela semente.
  com_ordem <- relacionar_variaveis(barbos,
                                    resposta               = altura_maxima_corpo,
                                    preditor               = distancia_dorsal_pelvica,
                                    avaliar_autocorrelacao = TRUE)
  de_novo   <- relacionar_variaveis(barbos,
                                    resposta               = altura_maxima_corpo,
                                    preditor               = distancia_dorsal_pelvica,
                                    avaliar_autocorrelacao = TRUE)
  expect_equal(nrow(com_ordem$pressupostos), 3)
  expect_equal(com_ordem$pressupostos$p[3], de_novo$pressupostos$p[3])
})

test_that("a receita copiada dá o mesmo resultado, sem a ClaRa", {
  barbos <- ler_treino("real_barbo_morfometria")
  saida  <- capture.output(
    resultado <- relacionar_variaveis(barbos,
                                      resposta       = altura_maxima_corpo,
                                      preditor       = distancia_dorsal_pelvica,
                                      mostrar_codigo = TRUE)
  )
  copiado <- rodar_receita_copiada(receita_mostrada(saida), list(barbos = barbos))

  expect_equal(copiado$coeficientes, resultado$coeficientes)
  expect_equal(copiado$pressupostos, resultado$pressupostos)
  expect_equal(copiado$influencia, resultado$influencia)
})

test_that("linhas sem resposta ou preditor ficam de fora e são contadas", {
  barbos <- ler_treino("real_barbo_morfometria")
  barbos$altura_maxima_corpo[c(2, 5)] <- NA
  resultado <- relacionar_variaveis(barbos,
                                    resposta = altura_maxima_corpo,
                                    preditor = distancia_dorsal_pelvica)

  expect_equal(resultado$amostra$excluidas, 2)
  # linha_da_base guarda a posição na tabela original, mesmo com linhas fora.
  expect_false(is.element(5, resultado$dados$linha_da_base))
  expect_equal(resultado$dados$linha_da_base[5], 7)
})

test_that("a relação curva aparece nos textos e o gráfico de resíduos roda", {
  cangulos  <- ler_treino("real_cangulo_peso_comprimento")
  resultado <- relacionar_variaveis(cangulos, resposta = peso_g, preditor = comprimento_cm)
  textos    <- escrever_resultados(resultado)

  expect_match(textos$teste, "aumentou")
  expect_true(all(nzchar(unlist(textos[c("amostra", "teste", "equacao", "efeito",
                                         "pressupostos", "influencia", "sintese",
                                         "nota_tabela", "legenda_figura")]))))
  expect_s3_class(grafico_residuos(resultado), "ggplot")
  expect_s3_class(grafico_qq(resultado), "ggplot")
})

test_that("efeito, tabelas e figura servem à regressão", {
  barbos    <- ler_treino("real_barbo_morfometria")
  resultado <- relacionar_variaveis(barbos,
                                    resposta        = altura_maxima_corpo,
                                    preditor        = distancia_dorsal_pelvica,
                                    rotulo_preditor = "Distância dorsal-pélvica")

  efeito <- medir_efeito(resultado)
  expect_equal(efeito$medida, c("r de Pearson", "R²"))
  expect_equal(efeito$valor[2], resultado$ajuste$r2)
  expect_equal(efeito$valor[1]^2, resultado$ajuste$r2)

  coeficientes <- exibir_teste(resultado)
  expect_s3_class(coeficientes, "flextable")
  expect_equal(coeficientes$body$dataset$Termo, c("Intercepto", "Distância dorsal-pélvica"))
  expect_s3_class(exibir_resumo(resultado, nota = "Nota."), "flextable")

  expect_s3_class(grafico_reta(resultado), "ggplot")
  expect_s3_class(grafico_reta(resultado, colorir_por = populacao), "ggplot")
  expect_s3_class(grafico_reta(resultado, colorir_por = "populacao",
                               mostrar_faixa = FALSE, mostrar_equacao = FALSE), "ggplot")
})

test_that("as conferências explicam o problema em português", {
  barbos <- ler_treino("real_barbo_morfometria")

  expect_error(relacionar_variaveis(barbos, resposta = altura, preditor = distancia_dorsal_pelvica),
               "não encontrada")
  expect_error(relacionar_variaveis(barbos, resposta = altura_maxima_corpo, preditor = populacao),
               "comparar_medias")
  expect_error(relacionar_variaveis(barbos, resposta = altura_maxima_corpo,
                                    preditor = altura_maxima_corpo),
               "diferentes")
  expect_error(grafico_reta(comparar_medias(ler_treino("real_bagre_racoes"),
                                            resposta = peso_g, grupos = racao)),
               "relacionar_variaveis")
  resultado <- relacionar_variaveis(barbos, resposta = altura_maxima_corpo,
                                    preditor = distancia_dorsal_pelvica)
  expect_error(grafico_reta(resultado, colorir_por = sexo), "não encontrada")
  expect_error(grafico_medias(resultado), "comparar_medias")
})

test_that("exibir_teste() aceita a nota de rodapé, como exibir_resumo()", {
  barbos    <- ler_treino("real_barbo_morfometria")
  resultado <- relacionar_variaveis(barbos, resposta = altura_maxima_corpo,
                                    preditor = distancia_dorsal_pelvica)
  textos    <- escrever_resultados(resultado)

  com_nota <- exibir_teste(resultado, nota = textos$nota_tabela)
  expect_equal(nrow(com_nota$footer$dataset), 1)
  expect_equal(nrow(exibir_teste(resultado)$footer$dataset), 0)
  expect_error(exibir_teste(resultado, nota = 1), "nota aceita")
})
