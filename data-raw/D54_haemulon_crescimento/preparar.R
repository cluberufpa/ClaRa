# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D54_haemulon_crescimento"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__WhiteGrunt2_confirmado.rda"),e)
stopifnot(identical(ls(e),"WhiteGrunt2"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__WhiteGrunt2.rda"),z)
stopifnot(isTRUE(all.equal(e[["WhiteGrunt2"]],z[["WhiteGrunt2"]],check.attributes=TRUE,tolerance=1e-12)))
q <- new.env(parent=emptyenv());load(file.path(fonte,"WhiteGrunt2.rdata"),q)
stopifnot(identical(q[["WhiteGrunt2"]],e[["WhiteGrunt2"]]))
brutos <- as.data.frame(e[["WhiteGrunt2"]])
stopifnot(identical(names(brutos),c("age","tl","sex")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("idade_anos","comprimento_total_mm","sexo")
stopifnot(setequal(levels(x$sexo),c("female","male")))
x$sexo <- factor(x$sexo,levels=c("female","male"),labels=c("femea","macho"),ordered=is.ordered(x$sexo))

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
haemulon_crescimento <- x
stopifnot(identical(dim(haemulon_crescimento),c(465L,3L)),
          identical(names(haemulon_crescimento),c("idade_anos","comprimento_total_mm","sexo")))
medicao <- tempfile(fileext=".rda")
save(haemulon_crescimento,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(haemulon_crescimento,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
