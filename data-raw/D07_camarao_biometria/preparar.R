# Executar na raiz da ClaRa. Fonte congelada; não executar scripts herdados.
pasta <- file.path("data-raw", "D07_camarao_biometria")
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
for (linha in manifesto) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(pasta, "fonte", partes[2])
  bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), partes[1]))
}
origem <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "camarao_vannamei_biometria.rda"), envir = origem)
camarao_vannamei_biometria <- as.data.frame(origem$camarao_vannamei_biometria)
# Somente os atributos de tibble saem; valores, fatores, datas e ordem ficam.
stopifnot(identical(dim(camarao_vannamei_biometria), c(170L, 9L)),
          isTRUE(all.equal(camarao_vannamei_biometria, as.data.frame(origem$camarao_vannamei_biometria))))
# Nenhuma renomeação nova nesta passada.
# Codificação Latin-1 como no D01; não altera o texto das categorias.
for (coluna in names(camarao_vannamei_biometria)) {
  x <- camarao_vannamei_biometria[[coluna]]
  if (is.factor(x)) {
    levels(x) <- iconv(enc2utf8(levels(x)), from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(levels(x)))
    camarao_vannamei_biometria[[coluna]] <- x
  } else if (is.character(x)) {
    convertido <- iconv(enc2utf8(x), from = "UTF-8", to = "latin1")
    stopifnot(identical(is.na(convertido), is.na(x)))
    camarao_vannamei_biometria[[coluna]] <- convertido
  }
}
stopifnot(identical(dim(camarao_vannamei_biometria), c(170L, 9L)))
usethis::use_data(camarao_vannamei_biometria, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
