# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D40_whitefish_salinidade"
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
s <- read.csv(file.path(fonte,"File_A.csv"),check.names=FALSE,na.strings=c("","NA"))
stopifnot(identical(trimws(names(s)),trimws(c("Source Tank","Tank ","Salinity","Fish ID ","Day","Temp","Relative condition factor","Lactate (mmol/L)","Glucose (mmol/L)","Plasma Cortisol (ng/L) ","Total Osmolarity (mOsm)"))))
x <- s
names(x) <- c("id_tanque_origem","id_tanque","salinidade_ppt","id_peixe","dia","grupo_temperatura","fator_condicao_relativo","lactato_mmol_l","glicose_mmol_l","cortisol_plasma_ng_l","osmolaridade_total_mosm")
for(n in c("id_tanque_origem","id_tanque","id_peixe"))x[[n]] <- as.character(x[[n]])
stopifnot(all(x$grupo_temperatura %in% c("Cool","Warm")))
x$grupo_temperatura <- factor(x$grupo_temperatura,levels=c("Cool","Warm"),labels=c("frio","quente"))
stopifnot(!anyDuplicated(paste(x$dia,x$id_peixe)),identical(is.na(x$cortisol_plasma_ng_l),is.na(s[[10]])),identical(is.na(x$osmolaridade_total_mosm),is.na(s[[11]])))

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
whitefish_salinidade <- x
stopifnot(identical(dim(whitefish_salinidade),c(59L,11L)),
          identical(names(whitefish_salinidade),c("id_tanque_origem","id_tanque","salinidade_ppt","id_peixe","dia","grupo_temperatura","fator_condicao_relativo","lactato_mmol_l","glicose_mmol_l","cortisol_plasma_ng_l","osmolaridade_total_mosm")))
medicao <- tempfile(fileext=".rda")
save(whitefish_salinidade,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(whitefish_salinidade,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
