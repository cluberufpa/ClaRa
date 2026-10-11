# Executar na raiz da ClaRa. Fonte congelada; não executar scripts herdados.
pasta <- file.path("data-raw", "D06_salvelino_formalina")
manifesto <- readLines(file.path(pasta, "fonte", "SHA256.txt"))
for (linha in manifesto) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(pasta, "fonte", partes[2])
  bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), partes[1]))
}
origem <- new.env(parent = emptyenv())
load(file.path(pasta, "fonte", "salvelino_formalina_remocao.rda"), envir = origem)
salvelino_formalina_remocao <- as.data.frame(origem$salvelino_formalina_remocao)
# Somente os atributos de tibble saem; valores, fatores, datas e ordem ficam.
stopifnot(identical(dim(salvelino_formalina_remocao), c(30L, 7L)),
          isTRUE(all.equal(salvelino_formalina_remocao, as.data.frame(origem$salvelino_formalina_remocao))))
# Nenhuma renomeação nova nesta passada.
# Codificação Latin-1 como no D01; não altera o texto das categorias.
for (coluna in names(salvelino_formalina_remocao)) {
  x <- salvelino_formalina_remocao[[coluna]]
  if (is.factor(x)) {
    levels(x) <- iconv(enc2utf8(levels(x)), from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(levels(x)))
    salvelino_formalina_remocao[[coluna]] <- x
  } else if (is.character(x)) {
    convertido <- iconv(enc2utf8(x), from = "UTF-8", to = "latin1")
    stopifnot(identical(is.na(convertido), is.na(x)))
    salvelino_formalina_remocao[[coluna]] <- convertido
  }
}
stopifnot(identical(dim(salvelino_formalina_remocao), c(30L, 7L)))
usethis::use_data(salvelino_formalina_remocao, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
