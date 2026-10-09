# Lê uma base de treino (cópia de dados_treino/, só para os testes).
ler_treino <- function(nome) {
  readRDS(test_path("dados", paste0(nome, ".rds")))
}

# Separa a receita que mostrar_codigo = TRUE imprimiu, entre as duas molduras.
receita_mostrada <- function(saida) {
  inicio <- grep("^# ---- Código R por trás da ClaRa", saida)
  fim    <- grep("^# -{20,}$", saida)
  fim    <- fim[fim > inicio][1]
  paste(saida[(inicio + 1):(fim - 1)], collapse = "\n")
}

# Roda a receita copiada como o aluno rodaria, numa sessão sem a ClaRa: só
# os objetos dele e os library() que a própria receita traz.
rodar_receita_copiada <- function(receita, objetos) {
  ambiente <- list2env(objetos, parent = globalenv())
  suppressPackageStartupMessages(
    eval(parse(text = receita, keep.source = FALSE), envir = ambiente)
  )
}
