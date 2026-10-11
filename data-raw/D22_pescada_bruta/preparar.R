# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D22_pescada_bruta"
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
load(file.path(fonte,"captura_pescada_amarela_bruta.rda"),e)
brutos <- as.data.frame(e$captura_pescada_amarela_bruta)
s <- as.data.frame(suppressWarnings(readxl::read_excel(file.path(fonte,"dados_brutos_eapadados.xlsx"),sheet="captura_pescada_amarela_bruta")))
ch <- s[["Data de Chegada"]]
ch_txt <- format(as.Date(suppressWarnings(as.numeric(ch)),origin="1899-12-30"),"%d/%m/%Y")
ch_txt[is.na(ch_txt)] <- ch[is.na(ch_txt)]
s[["Data de Chegada"]] <- ch_txt
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
captura_pescada_amarela_bruta <- x
stopifnot(identical(dim(captura_pescada_amarela_bruta),c(252L,16L)),
          identical(names(captura_pescada_amarela_bruta),c("Embarcacao","Tamanho (m)","Precipita\u00e7\u00e3o","M\u00eas","Ano","Per\u00edodo sazonal","M\u00eas/ano","Data de Saida","Data de Chegada","Dias ao mar","CPUE pescada","CPUE","Pessoal Embarcado","Peso Balanca","Nome Aparelho Pesca","Quantidade Aparelho Pesca")))
medicao <- tempfile(fileext=".rda")
save(captura_pescada_amarela_bruta,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(captura_pescada_amarela_bruta,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
