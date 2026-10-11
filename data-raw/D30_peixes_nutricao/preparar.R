# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D30_peixes_nutricao"
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
load(file.path(fonte,"peixes_nutricao_portugal.rda"),e)
brutos <- as.data.frame(e$peixes_nutricao_portugal)
s <- read.csv(file.path(fonte,"peixes_nutricao_portugal.csv"),check.names=FALSE,na.strings=c("","NA"))
s$cluster_autores <- as.character(s$cluster_autores)
stopifnot(isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
x <- brutos
x$id_base <- as.character(x$id_base)

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
peixes_nutricao_portugal <- x
stopifnot(identical(dim(peixes_nutricao_portugal),c(40L,22L)),
          identical(names(peixes_nutricao_portugal),c("id_base","nome_comum","nome_cientifico","cluster_autores","perfil_nutricional_autores","energia_kcal_100g","proteina_g_100g","lipideos_g_100g","umidade_g_100g","cinzas_g_100g","sfa_g_100g","mufa_g_100g","pufa_g_100g","epa_g_100g","dha_g_100g","sodio_mg_100g","potassio_mg_100g","calcio_mg_100g","fosforo_mg_100g","magnesio_mg_100g","ferro_mg_100g","zinco_mg_100g")))
medicao <- tempfile(fileext=".rda")
save(peixes_nutricao_portugal,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(peixes_nutricao_portugal,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
