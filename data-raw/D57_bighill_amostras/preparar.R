# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D57_bighill_amostras"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__BGHRsample_confirmado.rda"),e)
stopifnot(identical(ls(e),"BGHRsample"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__BGHRsample.rda"),z)
stopifnot(isTRUE(all.equal(e[["BGHRsample"]],z[["BGHRsample"]],check.attributes=TRUE,tolerance=1e-12)))
q <- new.env(parent=emptyenv());load(file.path(fonte,"BGHRsample.rdata"),q)
stopifnot(identical(q[["BGHRsample"]],e[["BGHRsample"]]))
brutos <- as.data.frame(e[["BGHRsample"]])
stopifnot(identical(names(brutos),c("UID","date","loc","effort")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("id_amostra","data","localizacao","esforco_min")
x$id_amostra <- as.character(x$id_amostra)
x$localizacao <- as.character(x$localizacao)
x$data <- as.Date(as.character(x$data),format="%m/%d/%Y")
stopifnot(!anyNA(x$data))
stopifnot(!anyDuplicated(x$id_amostra),all(x$esforco_min==10L))

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
bighill_amostras <- x
stopifnot(identical(dim(bighill_amostras),c(20L,4L)),
          identical(names(bighill_amostras),c("id_amostra","data","localizacao","esforco_min")))
medicao <- tempfile(fileext=".rda")
save(bighill_amostras,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(bighill_amostras,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
