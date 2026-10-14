# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D31_predadores_lipideos"
fonte <- file.path(pasta,"fonte")
for (linha in readLines(file.path(fonte,"SHA256.txt"))) {
  partes <- strsplit(linha,"  ",fixed=TRUE)[[1]]
  arquivo <- file.path(fonte,partes[2])
  stopifnot(identical(digest::digest(readBin(arquivo,"raw",n=file.info(arquivo)$size),algo="sha256",serialize=FALSE),partes[1]))
}
normalizar <- function(d) {
  d <- as.data.frame(d)
  for (n in names(d)) if(is.factor(d[[n]])) d[[n]] <- as.character(d[[n]])
  names(d) <- paste0("V",seq_along(d)); rownames(d) <- NULL
  d
}
e <- new.env(parent=emptyenv())
load(file.path(fonte,"qfasa_predadores.rda"),e)
brutos <- as.data.frame(e$qfasa_predadores)
z <- new.env();load(file.path(fonte,"predatorFAs.rda"),z)
s <- as.data.frame(z$predatorFAs)
stopifnot(identical(names(brutos),names(s)),isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
x <- brutos
names(x)[1:4] <- c("id_amostra","id_animal","grupo_amostra","biopsia")

# Como no D01, acentos em Latin-1 quando representáveis. Outros caracteres
# originais, como travessões nos nomes próprios, permanecem em UTF-8.
codificar <- function(v) {
  u <- enc2utf8(v); z <- iconv(u,from="UTF-8",to="latin1")
  z[is.na(z) & !is.na(u)] <- u[is.na(z) & !is.na(u)]
  stopifnot(identical(is.na(z),is.na(v)))
  z
}
for (n in names(x)) {
  if(is.factor(x[[n]])) levels(x[[n]]) <- codificar(levels(x[[n]]))
  else if(is.character(x[[n]])) x[[n]] <- codificar(x[[n]])
}
qfasa_predadores <- x
stopifnot(identical(dim(qfasa_predadores),c(10L,70L)),
          identical(names(qfasa_predadores),c("id_amostra","id_animal","grupo_amostra","biopsia","c12.0","c13.0","Iso14","c14.0","c14.1w9","c14.1w7","c14.1w5","Iso15","Anti15","c15.0","c15.1w8","c15.1w6","Iso16","c16.0","c16.1w11","c16.1w9","c16.1w7","c7Mec16.0","c16.1w5","c16.2w6","Iso17","c16.2w4","c16.3w6","c17.0","c16.3w4","c17.1","c16.4w3","c16.4w1","c18.0","c18.1w13","c18.1w11","c18.1w9","c18.1w7","c18.1w5","c18.2d5.11","c18.2w7","c18.2w6","c18.2w4","c18.3w6","c18.3w4","c18.3w3","c18.3w1","c18.4w3","c18.4w1","c20.0","c20.1w11","c20.1w9","c20.1w7","c20.2w9","c20.2w6","c20.3w6","c20.4w6","c20.3w3","c20.4w3","c20.5w3","c22.1w11","c22.1w9","c22.1w7","c22.2w6","c21.5w3","c22.4w6","c22.5w6","c22.4w3","c22.5w3","c22.6w3","c24.1w9")))
medicao <- tempfile(fileext=".rda")
save(qfasa_predadores,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(qfasa_predadores,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
