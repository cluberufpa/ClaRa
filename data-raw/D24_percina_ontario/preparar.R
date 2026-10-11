# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D24_percina_ontario"
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
load(file.path(fonte,"darter_ontario.rda"),e)
brutos <- as.data.frame(e$darter_ontario)
a <- new.env();load(file.path(fonte,"DarterOnt.rdata"),a)
z <- a$DarterOnt
s <- data.frame(idade_anos=as.integer(z$age),comprimento_total_mm=as.numeric(z$tl),rio=factor(z$river,levels=c("Salmon","Trent")))
stopifnot(isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
x <- brutos

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
darter_ontario <- x
stopifnot(identical(dim(darter_ontario),c(54L,3L)),
          identical(names(darter_ontario),c("idade_anos","comprimento_total_mm","rio")))
medicao <- tempfile(fileext=".rda")
save(darter_ontario,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(darter_ontario,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
