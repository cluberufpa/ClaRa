# Executar na raiz da ClaRa. Fonte congelada; não executar scripts herdados.
pasta <- file.path("data-raw", "D08_pinguins_biometria")
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
for (linha in manifesto) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(pasta, "fonte", partes[2])
  bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), partes[1]))
}
origem <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "pinguins.rda"), envir = origem)
pinguins <- as.data.frame(origem$pinguins)
# Conferir a tradução herdada contra palmerpenguins 0.1.1 congelado.
fonte_original <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "palmerpenguins__penguins.rda"), envir = fonte_original)
original <- as.data.frame(fonte_original$penguins)
stopifnot(identical(dim(original), dim(pinguins)))
names(original) <- names(pinguins)
original$sexo <- factor(original$sexo, levels = c("female", "male"), labels = c("femea", "macho"))
for (coluna in names(pinguins)) {
  a <- pinguins[[coluna]]; b <- original[[coluna]]
  if (is.factor(a)) stopifnot(identical(as.character(a), as.character(b)))
  else stopifnot(identical(a, b))
}
# Somente os atributos de tibble saem; valores, fatores, datas e ordem ficam.
stopifnot(identical(dim(pinguins), c(344L, 8L)),
          isTRUE(all.equal(pinguins, as.data.frame(origem$pinguins))))
levels(pinguins$sexo)[levels(pinguins$sexo) == "femea"] <- "fêmea"
# Codificação Latin-1 como no D01; não altera o texto das categorias.
for (coluna in names(pinguins)) {
  x <- pinguins[[coluna]]
  if (is.factor(x)) {
    levels(x) <- iconv(enc2utf8(levels(x)), from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(levels(x)))
    pinguins[[coluna]] <- x
  } else if (is.character(x)) {
    convertido <- iconv(enc2utf8(x), from = "UTF-8", to = "latin1")
    stopifnot(identical(is.na(convertido), is.na(x)))
    pinguins[[coluna]] <- convertido
  }
}
stopifnot(identical(dim(pinguins), c(344L, 8L)))
usethis::use_data(pinguins, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
