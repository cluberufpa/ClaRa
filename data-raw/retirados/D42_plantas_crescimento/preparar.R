# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D42_plantas_crescimento"
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
load(file.path(fonte,"datasets__PlantGrowth_confirmado.rda"),e)
stopifnot(identical(ls(e),"PlantGrowth"))
brutos <- as.data.frame(e[["PlantGrowth"]])
z <- new.env(parent=emptyenv());load(file.path(fonte,"datasets__PlantGrowth.rda"),z)
stopifnot(isTRUE(all.equal(e[["PlantGrowth"]],z[["PlantGrowth"]],check.attributes=TRUE,tolerance=1e-12)))
stopifnot(identical(names(brutos),c("weight","group")))
# Remover apenas atributos de groupedData da casca; valores e tipos das colunas ficam.
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("massa_seca","tratamento")
stopifnot(setequal(levels(x$tratamento),c("ctrl","trt1","trt2")))
x$tratamento <- factor(x$tratamento,levels=c("ctrl","trt1","trt2"),labels=c("controle","tratamento_1","tratamento_2"),ordered=is.ordered(x$tratamento))

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
plantas_crescimento <- x
stopifnot(identical(dim(plantas_crescimento),c(30L,2L)),
          identical(names(plantas_crescimento),c("massa_seca","tratamento")))
medicao <- tempfile(fileext=".rda")
save(plantas_crescimento,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(plantas_crescimento,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
