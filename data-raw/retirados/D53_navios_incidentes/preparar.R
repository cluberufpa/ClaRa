# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D53_navios_incidentes"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"MASS__ships_confirmado.rda"),e)
stopifnot(identical(ls(e),"ships"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"MASS__ships.rda"),z)
stopifnot(isTRUE(all.equal(e[["ships"]],z[["ships"]],check.attributes=TRUE,tolerance=1e-12)))
brutos <- as.data.frame(e[["ships"]])
stopifnot(identical(names(brutos),c("type","year","period","service","incidents")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("tipo_navio","periodo_construcao","periodo_operacao","servico_meses","incidentes")
stopifnot(setequal(unique(brutos$year),c(60L,65L,70L,75L)),setequal(unique(brutos$period),c(60L,75L)),sum(brutos$service==0)==6L)
x$periodo_construcao <- factor(brutos$year,levels=c(60,65,70,75),labels=c("1960_1964","1965_1969","1970_1974","1975_1979"))
x$periodo_operacao <- factor(brutos$period,levels=c(60,75),labels=c("1960_1974","1975_1979"))

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
navios_incidentes <- x
stopifnot(identical(dim(navios_incidentes),c(40L,5L)),
          identical(names(navios_incidentes),c("tipo_navio","periodo_construcao","periodo_operacao","servico_meses","incidentes")))
medicao <- tempfile(fileext=".rda")
save(navios_incidentes,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(navios_incidentes,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
