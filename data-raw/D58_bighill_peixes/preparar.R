# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D58_bighill_peixes"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__BGHRfish_confirmado.rda"),e)
stopifnot(identical(ls(e),"BGHRfish"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__BGHRfish.rda"),z)
stopifnot(isTRUE(all.equal(e[["BGHRfish"]],z[["BGHRfish"]],check.attributes=TRUE,tolerance=1e-12)))
q <- new.env(parent=emptyenv());load(file.path(fonte,"BGHRfish.rdata"),q)
stopifnot(identical(q[["BGHRfish"]],e[["BGHRfish"]]))
brutos <- as.data.frame(e[["BGHRfish"]])
stopifnot(identical(names(brutos),c("UID","fishID","specCode","length","weight","count")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("id_amostra","id_peixe","codigo_especie","comprimento_total_mm","peso_g","contagem")
x$id_amostra <- as.character(x$id_amostra)
x$id_peixe <- as.character(x$id_peixe)
x$codigo_especie <- as.character(x$codigo_especie)
stopifnot(sum(is.na(x$id_peixe))==81L,sum(is.na(x$peso_g))==91L,all(x$contagem>=1L & x$contagem<=3L))

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
bighill_peixes <- x
stopifnot(identical(dim(bighill_peixes),c(266L,6L)),
          identical(names(bighill_peixes),c("id_amostra","id_peixe","codigo_especie","comprimento_total_mm","peso_g","contagem")))
medicao <- tempfile(fileext=".rda")
save(bighill_peixes,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(bighill_peixes,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
