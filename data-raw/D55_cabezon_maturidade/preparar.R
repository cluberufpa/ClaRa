# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D55_cabezon_maturidade"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__Cabezon_confirmado.rda"),e)
stopifnot(identical(ls(e),"Cabezon"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__Cabezon.rda"),z)
stopifnot(isTRUE(all.equal(e[["Cabezon"]],z[["Cabezon"]],check.attributes=TRUE,tolerance=1e-12)))
q <- new.env(parent=emptyenv());load(file.path(fonte,"Cabezon.rdata"),q)
stopifnot(identical(q[["Cabezon"]],e[["Cabezon"]]))
brutos <- as.data.frame(e[["Cabezon"]])
stopifnot(identical(names(brutos),c("date","length","age","maturity","stage")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("data","comprimento_total_cm","idade","maturidade","estagio_maturidade")
x$data <- as.Date(as.character(x$data),format="%m/%d/%Y")
stopifnot(!anyNA(x$data))
stopifnot(setequal(levels(x$maturidade),c("Immature","Mature","Unknown")))
x$maturidade <- factor(x$maturidade,levels=c("Immature","Mature","Unknown"),labels=c("imatura","madura","desconhecida"),ordered=is.ordered(x$maturidade))
stopifnot(sum(is.na(x$idade))==226L)

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
cabezon_maturidade <- x
stopifnot(identical(dim(cabezon_maturidade),c(525L,5L)),
          identical(names(cabezon_maturidade),c("data","comprimento_total_cm","idade","maturidade","estagio_maturidade")))
medicao <- tempfile(fileext=".rda")
save(cabezon_maturidade,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(cabezon_maturidade,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
