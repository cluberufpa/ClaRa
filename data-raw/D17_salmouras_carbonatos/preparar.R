# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D17_salmouras_carbonatos"
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
load(file.path(fonte,"brine_carbonatos.rda"), e)
brutos <- as.data.frame(e$brine_carbonatos)
s <- as.data.frame(readxl::read_excel(file.path(fonte,"dados_brutos_eapadados.xlsx"), sheet="brine_carbonatos"))
stopifnot(isTRUE(all.equal(normalizar(brutos), normalizar(s), check.attributes=FALSE, tolerance=1e-12)))
x <- brutos
names(x) <- c("amostra","grupo","bicarbonato_ppm","sulfato_ppm","cloreto_ppm","calcio_ppm","magnesio_ppm","sodio_ppm")
levels(x$grupo) <- gsub("_"," ",levels(x$grupo),fixed=TRUE)

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
salmouras_carbonatos <- x
stopifnot(identical(dim(salmouras_carbonatos),c(19L,8L)),
          identical(names(salmouras_carbonatos),c("amostra","grupo","bicarbonato_ppm","sulfato_ppm","cloreto_ppm","calcio_ppm","magnesio_ppm","sodio_ppm")))
medicao <- tempfile(fileext=".rda")
save(salmouras_carbonatos,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(salmouras_carbonatos,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
