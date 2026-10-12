# Executar na raiz do pacote. Substituição autorizada em 12/10/2026.
pasta <- "data-raw/D48_molinesias_crescimento"
codigo <- "D48"
nome <- "molinesias_crescimento"
anterior <- "laranjeiras_crescimento"
arquivo <- file.path(pasta, "fonte", "growth.csv")
stopifnot(identical(digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                                  algo = "md5", serialize = FALSE),
                    "d861757ef46947b6a2f1e2f2e423cbdd"))
brutos <- read.csv(arquivo, stringsAsFactors = FALSE, check.names = FALSE)
stopifnot(identical(dim(brutos), c(1178L, 8L)), !anyNA(brutos))
# Comprimento observado: não confundir com a previsão e os IC da fonte.
molinesias_crescimento <- data.frame(
  id_peixe = as.character(brutos$test_fish_ID),
  id_mae = as.character(brutos$mother_ID),
  idade_dias = as.integer(brutos$fish_age_in_days),
  comprimento_padrao_cm = brutos$standard_length_in_cm
)
stopifnot(length(unique(molinesias_crescimento$id_peixe)) == 34L,
          length(unique(molinesias_crescimento$idade_dias)) == 40L,
          !anyDuplicated(molinesias_crescimento[c("id_peixe", "idade_dias")]),
          !anyNA(molinesias_crescimento),
          identical(range(molinesias_crescimento$idade_dias), c(0L, 280L)))

destino <- paste0("data/", nome, ".rda")
save(list = nome, file = destino, compress = "xz", version = 2)
# A substituição mantém o código e todos os demais registros do catálogo.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == codigo)
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c(anterior, nome))
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")),
                      stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
  stopifnot(!anyNA(novo[[n]]))
}
stopifnot(setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
stopifnot(!anyDuplicated(catalogo_dados$codigo), !anyDuplicated(catalogo_dados$nome))
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
stopifnot(file.info(destino)$size <= 100000,
          sum(file.info(list.files("data", full.names = TRUE))$size) <= 3e6)

