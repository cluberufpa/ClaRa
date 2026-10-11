# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D39_cowichan_amostragem"
fonte <- file.path(pasta,"fonte")
for (linha in readLines(file.path(fonte,"SHA256.txt"))) {
  partes <- strsplit(linha,"  ",fixed=TRUE)[[1]]
  arquivo <- file.path(fonte,partes[2])
  stopifnot(identical(digest::digest(readBin(arquivo,"raw",n=file.info(arquivo)$size),algo="sha256",serialize=FALSE),partes[1]))
}
brutos <- as.data.frame(readxl::read_excel(file.path(fonte,"Cowichan_Data.xlsx"),sheet="Dataset",na="NA",trim_ws=FALSE,.name_repair="minimal"))
stopifnot(identical(dim(brutos),c(246L,34L)))
# Professor aprovou a substituição e o recorte; nenhum indivíduo foi excluído.
x <- data.frame(id_registro=as.character(seq_len(nrow(brutos))),
  ano=brutos[["Year"]],local=brutos[["Site name"]],sublocal=brutos[["Sub-site"]],
  ambiente=unname(c(Lake="lago",River="rio",Estuary="estuário")[brutos[["Waterbody type"]]]),
  sexo=unname(c(Female="fêmea",Male="macho")[brutos[["Sex"]]]),
  massa_fresca_g=brutos[["Wet mass (g)"]],comprimento_total_mm=brutos[["Total length (mm)"]],stringsAsFactors=FALSE)
# Registro 234: total 51,09 mm versus padrão 55 mm. Não é extremo na base;
# não sabemos qual medida está errada. Preservar e explicitar a pendência.
stopifnot(x$comprimento_total_mm[234]==51.09,!anyNA(x),sum(duplicated(x))==0)
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
cowichan_amostragem <- x
stopifnot(identical(dim(cowichan_amostragem),c(246L,8L)),
          identical(names(cowichan_amostragem),c("id_registro","ano","local","sublocal","ambiente","sexo","massa_fresca_g","comprimento_total_mm")))
medicao <- tempfile(fileext=".rda")
save(cowichan_amostragem,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(cowichan_amostragem,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
