# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D60_trigo_quadrado"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"agridat__cochran.latin_confirmado.rda"),e)
stopifnot(identical(ls(e),"cochran.latin"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"agridat__cochran.latin.rda"),z)
stopifnot(isTRUE(all.equal(e[["cochran.latin"]],z[["cochran.latin"]],check.attributes=TRUE,tolerance=1e-12)))
stopifnot(isTRUE(all.equal(read.delim(file.path(fonte,"cochran.latin.txt")),e[["cochran.latin"]],check.attributes=TRUE)))
brutos <- as.data.frame(e[["cochran.latin"]])
stopifnot(identical(names(brutos),c("row","col","operator","diff")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("linha","coluna","operador","diferenca_altura")

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
trigo_quadrado_latino <- x
stopifnot(identical(dim(trigo_quadrado_latino),c(36L,4L)),
          identical(names(trigo_quadrado_latino),c("linha","coluna","operador","diferenca_altura")))
medicao <- tempfile(fileext=".rda")
save(trigo_quadrado_latino,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(trigo_quadrado_latino,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
