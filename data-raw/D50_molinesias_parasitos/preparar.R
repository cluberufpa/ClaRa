# Executar na raiz da ClaRa. Substituição do quine autorizada em 11/10/2026.
pasta <- "data-raw/D50_molinesias_parasitos"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  hash <- digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                         algo = "sha256", serialize = FALSE)
  stopifnot(identical(hash, partes[1]))
}
brutos <- read.csv(file.path(fonte, "texas2022_parasite_20260421.csv"),
                   na.strings = c("", "NA"), stringsAsFactors = FALSE)
stopifnot(identical(dim(brutos), c(128L, 5L)),
          identical(names(brutos), c("site.id", "species", "sex", "standard.length", "totalpara")))
molinesias_parasitos <- data.frame(
  id_registro = sprintf("REG_%03d", seq_len(nrow(brutos))),
  local = factor(brutos$site.id),
  especie = factor(brutos$species),
  grupo_local_especie = factor(paste(brutos$site.id, brutos$species, sep = " / ")),
  sexo = factor(brutos$sex),
  comprimento_padrao_cm = brutos$standard.length,
  parasitos_total_n = as.integer(brutos$totalpara),
  infectado_01 = as.integer(brutos$totalpara > 0)
)
stopifnot(identical(dim(molinesias_parasitos), c(128L, 8L)),
          sum(is.na(molinesias_parasitos$sexo)) == 2L,
          sum(is.na(molinesias_parasitos$comprimento_padrao_cm)) == 10L,
          all(molinesias_parasitos$parasitos_total_n == brutos$totalpara),
          sum(molinesias_parasitos$parasitos_total_n == 0) == 31L)
destino <- "data/molinesias_parasitos.rda"
save(molinesias_parasitos, file = destino, compress = "xz", version = 2)
stopifnot(file.info(destino)$size <= 100000)

# Reutilizar apenas D50, preservando integralmente todos os demais registros.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
antes <- nrow(catalogo_dados)
i <- which(catalogo_dados$codigo == "D50")
stopifnot(length(i) == 1L,
          catalogo_dados$nome[i] %in% c("escolares_ausencias", "molinesias_parasitos"))
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
stopifnot(nrow(catalogo_dados) == antes, !anyDuplicated(catalogo_dados$codigo),
          !anyDuplicated(catalogo_dados$nome))
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
stopifnot(sum(file.info(list.files("data", full.names = TRUE))$size) <= 3000000)
cat("D50 substituído por molinesias_parasitos:", file.info(destino)$size, "bytes\n")
