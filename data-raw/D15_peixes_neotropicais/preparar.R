# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D15_peixes_neotropicais"
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
load(file.path(fonte,"bagley_lwr_central_america.rda"), e)
brutos <- as.data.frame(e$bagley_lwr_central_america)
s <- read.csv(file.path(fonte,"bagley_lwr_central_america.csv"),check.names=FALSE,na.strings=c("","NA"))
# Transformação anterior documentada em preparar_curados_2026.R.
s$nadadeira_dorsal <- trimws(s$nadadeira_dorsal)
s$nadadeira_caudal <- trimws(s$nadadeira_caudal)
stopifnot(isTRUE(all.equal(normalizar(brutos), normalizar(s), check.attributes=FALSE, tolerance=1e-12)))
x <- brutos
x <- x[!names(x) %in% c("log_peso_g","log_sl_mm","nadadeira_dorsal","nadadeira_caudal","sexo")]
names(x)[names(x)=="no"] <- "id_registro"
x$id_registro <- as.character(x$id_registro)

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
peixes_neotropicais_biometria <- x
stopifnot(identical(dim(peixes_neotropicais_biometria),c(306L,9L)),
          identical(names(peixes_neotropicais_biometria),c("id_registro","especie","peso_g","comprimento_padrao_mm","comprimento_total_mm","pais","localidade","latitude","longitude")))
medicao <- tempfile(fileext=".rda")
save(peixes_neotropicais_biometria,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(peixes_neotropicais_biometria,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
