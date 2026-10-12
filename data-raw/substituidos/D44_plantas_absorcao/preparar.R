# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D44_plantas_absorcao"
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
load(file.path(fonte,"datasets__CO2_confirmado.rda"),e)
stopifnot(identical(ls(e),"CO2"))
brutos <- as.data.frame(e[["CO2"]])
z <- new.env(parent=emptyenv());load(file.path(fonte,"levantamento_co2_atmosferico.rda"),z)
stopifnot(exists("co2",z,inherits=FALSE),is.ts(z$co2),length(z$co2)==468L)
stopifnot(nrow(brutos)==84L,length(unique(brutos$Plant))==12L,all(table(brutos$Plant)==7L))
stopifnot(identical(names(brutos),c("Plant","Type","Treatment","conc","uptake")))
# Remover apenas atributos de groupedData da casca; valores e tipos das colunas ficam.
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("id_planta","origem","resfriamento","concentracao_co2","absorcao_co2_umol_m2_s")
x$id_planta <- as.character(x$id_planta)
stopifnot(setequal(levels(x$resfriamento),c("nonchilled","chilled")))
x$resfriamento <- factor(x$resfriamento,levels=c("nonchilled","chilled"),labels=c("sem_resfriamento","com_resfriamento"),ordered=is.ordered(x$resfriamento))

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
plantas_absorcao_co2 <- x
stopifnot(identical(dim(plantas_absorcao_co2),c(84L,5L)),
          identical(names(plantas_absorcao_co2),c("id_planta","origem","resfriamento","concentracao_co2","absorcao_co2_umol_m2_s")))
medicao <- tempfile(fileext=".rda")
save(plantas_absorcao_co2,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(plantas_absorcao_co2,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
