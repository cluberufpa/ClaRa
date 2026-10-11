# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D13_artemia_fitoesterois"
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
brutos <- read.csv(file.path(fonte,"Artemia_growth_sterols.csv"),check.names=FALSE,stringsAsFactors=FALSE,strip.white=FALSE)
x <- brutos
stopifnot(identical(names(x),c("experiment","sterol_id","sterol_name","biomass_mg","ind_weight_ug")),
          identical(as.integer(table(x$experiment)),c(18L,18L,18L,15L)), !anyNA(x))

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
artemia_fitoesterois <- x
stopifnot(identical(dim(artemia_fitoesterois),c(69L,5L)),
          identical(names(artemia_fitoesterois),c("experiment","sterol_id","sterol_name","biomass_mg","ind_weight_ug")))
medicao <- tempfile(fileext=".rda")
save(artemia_fitoesterois,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(artemia_fitoesterois,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
