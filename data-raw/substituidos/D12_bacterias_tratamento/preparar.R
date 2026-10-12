# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D12_bacterias_tratamento"
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
e <- new.env(parent = emptyenv())
load(file.path(fonte, "MASS__bacteria.rda"), e)
brutos <- as.data.frame(e$bacteria)
s <- read.csv(file.path(fonte, "MASS__bacteria.csv"), check.names = FALSE)
stopifnot(isTRUE(all.equal(normalizar(brutos), normalizar(s), check.attributes = FALSE)))
x <- brutos
names(x) <- c("presenca_bacteria", "intervencao", "adesao", "semana", "id_individuo", "tratamento")
x$presenca_bacteria <- factor(x$presenca_bacteria, levels=c("n","y"), labels=c("ausente","presente"))
x$intervencao <- factor(x$intervencao, levels=c("a","p"), labels=c("medicamento","placebo"))
x$adesao <- factor(x$adesao, levels=c("hi","lo"), labels=c("alta","baixa"))
x$id_individuo <- as.character(x$id_individuo)
x$tratamento <- factor(x$tratamento, levels=c("placebo","drug","drug+"), labels=c("placebo","medicamento","medicamento_incentivo"))
a <- x[x$semana==0, c("id_individuo","presenca_bacteria")]
b <- x[x$semana==11, c("id_individuo","presenca_bacteria")]
pares <- merge(a,b,by="id_individuo",suffixes=c("_inicial","_final"))
stopifnot(nrow(pares)==44L, identical(as.integer(table(pares[[2]],pares[[3]])),c(2L,10L,2L,30L)))

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
bacterias_tratamento <- x
stopifnot(identical(dim(bacterias_tratamento),c(220L,6L)),
          identical(names(bacterias_tratamento),c("presenca_bacteria","intervencao","adesao","semana","id_individuo","tratamento")))
medicao <- tempfile(fileext=".rda")
save(bacterias_tratamento,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(bacterias_tratamento,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
