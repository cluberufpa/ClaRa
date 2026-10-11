# Executar na raiz da ClaRa. Fonte congelada; não executar scripts herdados.
pasta <- file.path("data-raw", "D02_barbo_morfometria")
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
for (linha in manifesto) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(pasta, "fonte", partes[2])
  bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), partes[1]))
}
origem <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "morfometria_barbo.rda"), envir = origem)
morfometria_barbo <- as.data.frame(origem$morfometria_barbo)
# Somente os atributos de tibble saem; valores, fatores, datas e ordem ficam.
stopifnot(identical(dim(morfometria_barbo), c(100L, 13L)),
          isTRUE(all.equal(morfometria_barbo, as.data.frame(origem$morfometria_barbo))))
# Nenhuma renomeação nova nesta passada.
# Codificação Latin-1 como no D01; não altera o texto das categorias.
for (coluna in names(morfometria_barbo)) {
  x <- morfometria_barbo[[coluna]]
  if (is.factor(x)) {
    levels(x) <- iconv(enc2utf8(levels(x)), from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(levels(x)))
    morfometria_barbo[[coluna]] <- x
  } else if (is.character(x)) {
    convertido <- iconv(enc2utf8(x), from = "UTF-8", to = "latin1")
    stopifnot(identical(is.na(convertido), is.na(x)))
    morfometria_barbo[[coluna]] <- convertido
  }
}
stopifnot(identical(dim(morfometria_barbo), c(100L, 13L)))
usethis::use_data(morfometria_barbo, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
