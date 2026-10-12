# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D35_tilapia_microalgas"
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
load(file.path(fonte,"tilapia_microalgas.rda"),e)
brutos <- as.data.frame(e$tilapia_microalgas)
s <- read.csv(file.path(fonte,"tilapia_microalgas.csv"),check.names=FALSE,na.strings=c("","NA"))
s$id_tanque <- as.character(s$id_tanque)
stopifnot(identical(names(brutos),names(s)),isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
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
tilapia_microalgas <- x
stopifnot(identical(dim(tilapia_microalgas),c(15L,32L)),
          identical(names(tilapia_microalgas),c("id_tanque","tratamento_codigo","tipo_microalga","nivel_substituicao_pct","repeticao","sgr_pct_dia","sobrevivencia_pct","peso_inicial_medio_g","peso_final_medio_g","peixes_estocados","peixes_colhidos","temperatura_c","oxigenio_dissolvido_mg_l","ph","tan_mg_l","no2_n_mg_l","srp_mg_l","rbc_10_6_ul","hemoglobina_g_dl","pcv_pct","wbc_10_3_ul","linfocitos_pct","plaquetas_10_3_ul","proteina_total_g_dl","albumina_g_dl","globulina_g_dl","razao_albumina_globulina","glicose_mg_dl","triglicerideos_mg_dl","colesterol_mg_dl","ureia_mg_dl","bun_mg_dl")))
medicao <- tempfile(fileext=".rda")
save(tilapia_microalgas,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(tilapia_microalgas,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
