# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D33_ostras_recifes"
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
load(file.path(fonte,"recifes_ostras_heatmap.rda"),e)
brutos <- as.data.frame(e$recifes_ostras_heatmap)
s <- read.csv(file.path(fonte,"recifes_ostras_heatmap.csv"),check.names=FALSE,na.strings=c("","NA"))
s$id_recife <- as.character(s$id_recife)
s$id_levantamento <- as.character(s$id_levantamento)
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
recifes_ostras_heatmap <- x
stopifnot(identical(dim(recifes_ostras_heatmap),c(301L,26L)),
          identical(names(recifes_ostras_heatmap),c("id_recife","id_levantamento","sitio","numero_recife","zona_recife","estacao","ano","avaliador_video","duracao_video_min","visibilidade_media_m","pradaria_marinha_pct","riqueza_especies_zona","indice_shannon_h","abundancia_total","area_2d","indice_forma","indice_isometria","indice_circularidade","indice_fractal","indice_para","perimetro","razao_perimetro_area","distancia_media_recifes_proximos","distancia_vizinho_mais_proximo","rugosidade","area_3d")))
medicao <- tempfile(fileext=".rda")
save(recifes_ostras_heatmap,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(recifes_ostras_heatmap,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
