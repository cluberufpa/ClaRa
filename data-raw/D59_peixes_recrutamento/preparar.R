# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D59_peixes_recrutamento"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"astsa__rec_confirmado.rda"),e)
stopifnot(identical(ls(e),"rec"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"astsa__rec.rda"),z)
stopifnot(isTRUE(all.equal(e[["rec"]],z[["rec"]],check.attributes=TRUE,tolerance=1e-12)))
q <- new.env(parent=emptyenv());load(file.path(fonte,"rec.rda"),q)
stopifnot(identical(q[["rec"]],e[["rec"]]))
serie <- e$rec
stopifnot(is.ts(serie),length(serie)==453L,frequency(serie)==12,start(serie)[1]==1950L,start(serie)[2]==1L,end(serie)[1]==1987L,end(serie)[2]==9L)
x <- data.frame(data=seq(as.Date("1950-01-01"),by="month",length.out=length(serie)),indice_recrutamento=as.numeric(serie))
stopifnot(tail(x$data,1)==as.Date("1987-09-01"),identical(x$indice_recrutamento,as.numeric(serie)))

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
peixes_recrutamento <- x
stopifnot(identical(dim(peixes_recrutamento),c(453L,2L)),
          identical(names(peixes_recrutamento),c("data","indice_recrutamento")))
medicao <- tempfile(fileext=".rda")
save(peixes_recrutamento,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(peixes_recrutamento,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
