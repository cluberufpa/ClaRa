test_that("salvar_tabelas() grava um CSV por tabela, com o nome antes do =", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  pasta     <- withr::local_tempdir()

  expect_message(
    arquivos <- salvar_tabelas(resumo = resultado$resumo, anova = resultado$anova, pasta = pasta),
    "Tabelas salvas"
  )
  expect_equal(basename(arquivos), c("resumo.csv", "anova.csv"))
  expect_true(all(file.exists(arquivos)))
  lido <- read.csv2(arquivos[1], encoding = "UTF-8")
  expect_equal(nrow(lido), 4)
})

test_that("salvar_figuras() grava um PNG por gráfico", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  figura    <- grafico_boxplot(resultado)
  pasta     <- withr::local_tempdir()

  arquivos <- suppressMessages(salvar_figuras(caixas = figura, pasta = pasta))
  expect_true(file.exists(arquivos))
  expect_equal(basename(arquivos), "caixas.png")
})

test_that("registrar_ambiente() grava a versão da ClaRa na primeira linha", {
  arquivo <- file.path(withr::local_tempdir(), "sessionInfo.txt")
  suppressMessages(registrar_ambiente(arquivo = arquivo))
  primeira <- readLines(arquivo, n = 1)
  expect_equal(primeira, paste("ClaRa", as.character(utils::packageVersion("clara"))))
})

test_that("um item sem nome que não é objeto pede um nome", {
  bagres    <- ler_treino("real_bagre_racoes")
  resultado <- comparar_medias(bagres, resposta = peso_g, grupos = racao)
  expect_error(salvar_tabelas(resultado$anova, pasta = withr::local_tempdir()),
               "Dê um nome")
})
