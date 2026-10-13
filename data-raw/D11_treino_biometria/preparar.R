# Executar na raiz da ClaRa (precisa do readxl e do digest, só aqui no preparo).
# D11 recebe em 13/10/2026, por decisão do professor, a aba biometria da planilha de
# treino da Trilha: dados sintéticos com defeitos de propósito para o menu de preparo.
# A aba desembarques_largo não entra: repete o exercício do D37 treino_desembarque.
pasta <- "data-raw/D11_treino_biometria"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  stopifnot(identical(
    digest::digest(file.path(fonte, partes[2]), algo = "sha256", file = TRUE),
    tolower(partes[1])
  ))
}

# trim_ws = FALSE: os espaços sobrando nos textos são defeitos do exercício.
x <- as.data.frame(readxl::read_excel(file.path(fonte, "Treino-Transformacoes.xlsx"),
                                      sheet = "biometria", trim_ws = FALSE))
x$id <- as.character(as.integer(x$id))
treino_biometria <- x

# Os defeitos que o exercício promete precisam continuar lá.
stopifnot(
  identical(dim(treino_biometria), c(71L, 10L)),
  identical(names(treino_biometria), c("id", "especie", "local", "sexo", "amostra", "data_coleta",
                                       "comprimento_cm", "peso_g", "cpue", "profundidade_m")),
  sum(is.na(treino_biometria$comprimento_cm)) == 5L,
  sum(is.na(treino_biometria$peso_g)) == 6L,
  sum(duplicated(treino_biometria)) == 3L,
  " Braganca " %in% treino_biometria$local,
  "Pescada  Amarela" %in% treino_biometria$especie,
  setequal(unique(treino_biometria$sexo), c("Femea", "f", "F", "m", "M", "Macho")),
  all(grepl("^[A-Za-z]+_(Seca|Chuvosa)$", treino_biometria$amostra)),
  is.character(treino_biometria$data_coleta)
)

save(treino_biometria, file = "data/treino_biometria.rda", compress = "xz", version = 2)

# O D11 estava vago (puromicina_reacao foi retirado): a linha entra no catálogo.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(setequal(names(novo), names(catalogo_dados)))
catalogo_dados <- catalogo_dados[catalogo_dados$codigo != "D11", ]
catalogo_dados <- rbind(catalogo_dados, novo[names(catalogo_dados)])
catalogo_dados <- catalogo_dados[order(catalogo_dados$codigo), ]
row.names(catalogo_dados) <- NULL
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
