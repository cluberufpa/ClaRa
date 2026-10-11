# Executar na raiz da ClaRa. Fonte congelada; não executar scripts herdados.
pasta <- file.path("data-raw", "D05_abalone_biometria")
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
for (linha in manifesto) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(pasta, "fonte", partes[2])
  bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), partes[1]))
}
origem <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "abalone_adultos.rda"), envir = origem)
abalone_adultos <- as.data.frame(origem$abalone_adultos)
# Somente os atributos de tibble saem; valores, fatores, datas e ordem ficam.
stopifnot(identical(dim(abalone_adultos), c(2641L, 9L)),
          isTRUE(all.equal(abalone_adultos, as.data.frame(origem$abalone_adultos))))
# Nenhuma renomeação nova nesta passada.
# Codificação Latin-1 como no D01; não altera o texto das categorias.
for (coluna in names(abalone_adultos)) {
  x <- abalone_adultos[[coluna]]
  if (is.factor(x)) {
    levels(x) <- iconv(enc2utf8(levels(x)), from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(levels(x)))
    abalone_adultos[[coluna]] <- x
  } else if (is.character(x)) {
    convertido <- iconv(enc2utf8(x), from = "UTF-8", to = "latin1")
    stopifnot(identical(is.na(convertido), is.na(x)))
    abalone_adultos[[coluna]] <- convertido
  }
}
stopifnot(identical(dim(abalone_adultos), c(2641L, 9L)))
usethis::use_data(abalone_adultos, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
