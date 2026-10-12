# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D46_carros_frenagem"
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
load(file.path(fonte,"datasets__cars_confirmado.rda"),e)
stopifnot(identical(ls(e),"cars"))
brutos <- as.data.frame(e[["cars"]])
z <- new.env(parent=emptyenv());load(file.path(fonte,"datasets__cars.rda"),z)
stopifnot(isTRUE(all.equal(e[["cars"]],z[["cars"]],check.attributes=TRUE,tolerance=1e-12)))
stopifnot(identical(names(brutos),c("speed","dist")))
# Remover apenas atributos de groupedData da casca; valores e tipos das colunas ficam.
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("velocidade_mph","distancia_parada_ft")

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
carros_frenagem <- x
stopifnot(identical(dim(carros_frenagem),c(50L,2L)),
          identical(names(carros_frenagem),c("velocidade_mph","distancia_parada_ft")))
medicao <- tempfile(fileext=".rda")
save(carros_frenagem,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(carros_frenagem,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
