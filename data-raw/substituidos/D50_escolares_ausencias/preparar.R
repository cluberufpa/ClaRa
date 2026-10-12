# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D50_escolares_ausencias"
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
load(file.path(fonte,"MASS__quine_confirmado.rda"),e)
stopifnot(identical(ls(e),"quine"))
brutos <- as.data.frame(e[["quine"]])
z <- new.env(parent=emptyenv());load(file.path(fonte,"MASS__quine.rda"),z)
stopifnot(isTRUE(all.equal(e[["quine"]],z[["quine"]],check.attributes=TRUE,tolerance=1e-12)))
stopifnot(identical(names(brutos),c("Eth","Sex","Age","Lrn","Days")))
# Remover apenas atributos de groupedData da casca; valores e tipos das colunas ficam.
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("origem_cultural","sexo","etapa_escolar","classe_aprendizagem","dias_ausencia")
stopifnot(setequal(levels(x$origem_cultural),c("A","N")))
x$origem_cultural <- factor(x$origem_cultural,levels=c("A","N"),labels=c("aborigene","nao_aborigene"),ordered=is.ordered(x$origem_cultural))
stopifnot(setequal(levels(x$sexo),c("F","M")))
x$sexo <- factor(x$sexo,levels=c("F","M"),labels=c("feminino","masculino"),ordered=is.ordered(x$sexo))
stopifnot(setequal(levels(x$etapa_escolar),c("F0","F1","F2","F3")))
x$etapa_escolar <- factor(x$etapa_escolar,levels=c("F0","F1","F2","F3"),labels=c("primario","F1","F2","F3"),ordered=is.ordered(x$etapa_escolar))
stopifnot(setequal(levels(x$classe_aprendizagem),c("AL","SL")))
x$classe_aprendizagem <- factor(x$classe_aprendizagem,levels=c("AL","SL"),labels=c("aprendizagem_media","aprendizagem_lenta"),ordered=is.ordered(x$classe_aprendizagem))

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
escolares_ausencias <- x
stopifnot(identical(dim(escolares_ausencias),c(146L,5L)),
          identical(names(escolares_ausencias),c("origem_cultural","sexo","etapa_escolar","classe_aprendizagem","dias_ausencia")))
medicao <- tempfile(fileext=".rda")
save(escolares_ausencias,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(escolares_ausencias,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
