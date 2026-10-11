# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D28_lagostas_kelp"
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
load(file.path(fonte,"lagostas_kelp_sexo.rda"),e)
brutos <- as.data.frame(e$lagostas_kelp_sexo)
s <- read.csv2(file.path(fonte,"lagostas_kelp_sexo.csv"),check.names=FALSE,na.strings=c("","NA"))
s <- s[c("id_lagosta","data_amostragem","ano","mes","mes_nome","sitio","sexo","comprimento_cefalotorax_mm")]
s$id_lagosta <- as.character(s$id_lagosta);s$data_amostragem <- as.Date(s$data_amostragem)
s$ano <- as.integer(s$ano);s$mes <- as.integer(s$mes)
s$mes_nome <- factor(s$mes_nome,levels=c("setembro","outubro","dezembro","janeiro","marco","abril"))
s$sitio <- factor(s$sitio);s$sexo <- factor(s$sexo,levels=c("F","M"),labels=c("femea","macho"))
s$comprimento_cefalotorax_mm <- as.numeric(s$comprimento_cefalotorax_mm)
antes <- nrow(s);s <- s[!is.na(s$sexo)&!is.na(s$sitio),]
cat("FILTRO_HERDADO",antes,"->",nrow(s),"\n")
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
lagostas_kelp_sexo <- x
stopifnot(identical(dim(lagostas_kelp_sexo),c(1457L,8L)),
          identical(names(lagostas_kelp_sexo),c("id_lagosta","data_amostragem","ano","mes","mes_nome","sitio","sexo","comprimento_cefalotorax_mm")))
medicao <- tempfile(fileext=".rda")
save(lagostas_kelp_sexo,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(lagostas_kelp_sexo,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
