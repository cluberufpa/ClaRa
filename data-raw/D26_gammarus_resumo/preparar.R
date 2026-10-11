# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D26_gammarus_resumo"
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
load(file.path(fonte,"gammarus_dieta_temperatura_resumo.rda"),e)
brutos <- as.data.frame(e$gammarus_dieta_temperatura_resumo)
s <- read.csv(file.path(fonte,"gammarus_dieta_temperatura_resumo.csv"),check.names=FALSE,na.strings=c("","NA"))
stopifnot(isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
x <- brutos

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
gammarus_dieta_temperatura_resumo <- x
stopifnot(identical(dim(gammarus_dieta_temperatura_resumo),c(12L,11L)),
          identical(names(gammarus_dieta_temperatura_resumo),c("dieta","temperatura_c","n_repeticoes","sobrevivencia_media_pct","sobrevivencia_dp_pct","biomassa_media_mg","biomassa_dp_mg","comprimento_final_medio_mm","comprimento_final_dp_mm","taxa_crescimento_especifica_media_pct_dia","taxa_crescimento_especifica_dp_pct_dia")))
medicao <- tempfile(fileext=".rda")
save(gammarus_dieta_temperatura_resumo,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(gammarus_dieta_temperatura_resumo,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
