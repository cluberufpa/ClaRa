# Executar na raiz da ClaRa. Fonte congelada; não executar scripts herdados.
pasta <- file.path("data-raw", "D04_doubs_ambiente")
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
for (linha in manifesto) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(pasta, "fonte", partes[2])
  bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), partes[1]))
}
origem <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "doubs_ambiente.rda"), envir = origem)
doubs_ambiente <- as.data.frame(origem$doubs_ambiente)
# Conferir os valores ambientais e a riqueza contra a fonte original congelada.
original_doubs <- readRDS(file.path(pasta, "fonte", "ade4_1.7-24_doubs.rds"))
stopifnot(identical(unname(as.matrix(doubs_ambiente[1:11])),
                    unname(as.matrix(original_doubs$env))),
          identical(doubs_ambiente$riqueza, as.integer(rowSums(original_doubs$fish > 0))))
# Somente os atributos de tibble saem; valores, fatores, datas e ordem ficam.
stopifnot(identical(dim(doubs_ambiente), c(30L, 13L)),
          isTRUE(all.equal(doubs_ambiente, as.data.frame(origem$doubs_ambiente))))
# Nenhuma renomeação nova nesta passada.
# Codificação Latin-1 como no D01; não altera o texto das categorias.
for (coluna in names(doubs_ambiente)) {
  x <- doubs_ambiente[[coluna]]
  if (is.factor(x)) {
    levels(x) <- iconv(enc2utf8(levels(x)), from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(levels(x)))
    doubs_ambiente[[coluna]] <- x
  } else if (is.character(x)) {
    convertido <- iconv(enc2utf8(x), from = "UTF-8", to = "latin1")
    stopifnot(identical(is.na(convertido), is.na(x)))
    doubs_ambiente[[coluna]] <- convertido
  }
}
stopifnot(identical(dim(doubs_ambiente), c(30L, 13L)))
usethis::use_data(doubs_ambiente, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
