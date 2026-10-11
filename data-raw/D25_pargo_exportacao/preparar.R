# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D25_pargo_exportacao"
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
load(file.path(fonte,"exportacao_pargo.rda"),e)
brutos <- as.data.frame(e$exportacao_pargo)
s <- as.data.frame(readxl::read_excel(file.path(fonte,"exportacao_pargo_comexstat.xlsx"),sheet="Resultado"),check.names=FALSE)
medidas <- grep("^[0-9]{4} - ",names(s),value=TRUE)
for(n in names(s)) s[[n]] <- if(n %in% medidas) as.numeric(s[[n]]) else as.character(s[[n]])
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
exportacao_pargo <- x
stopifnot(identical(dim(exportacao_pargo),c(4L,48L)),
          identical(names(exportacao_pargo),c("Pa\u00edses","C\u00f3digo NCM","Descri\u00e7\u00e3o NCM","C\u00f3digo ISIC Grupo","Descri\u00e7\u00e3o ISIC Grupo","UF do Produto","2025 - Valor US$ FOB","2025 - Quilograma L\u00edquido","2024 - Valor US$ FOB","2024 - Quilograma L\u00edquido","2023 - Valor US$ FOB","2023 - Quilograma L\u00edquido","2022 - Valor US$ FOB","2022 - Quilograma L\u00edquido","2021 - Valor US$ FOB","2021 - Quilograma L\u00edquido","2020 - Valor US$ FOB","2020 - Quilograma L\u00edquido","2019 - Valor US$ FOB","2019 - Quilograma L\u00edquido","2018 - Valor US$ FOB","2018 - Quilograma L\u00edquido","2017 - Valor US$ FOB","2017 - Quilograma L\u00edquido","2016 - Valor US$ FOB","2016 - Quilograma L\u00edquido","2015 - Valor US$ FOB","2015 - Quilograma L\u00edquido","2014 - Valor US$ FOB","2014 - Quilograma L\u00edquido","2013 - Valor US$ FOB","2013 - Quilograma L\u00edquido","2012 - Valor US$ FOB","2012 - Quilograma L\u00edquido","2011 - Valor US$ FOB","2011 - Quilograma L\u00edquido","2010 - Valor US$ FOB","2010 - Quilograma L\u00edquido","2009 - Valor US$ FOB","2009 - Quilograma L\u00edquido","2008 - Valor US$ FOB","2008 - Quilograma L\u00edquido","2007 - Valor US$ FOB","2007 - Quilograma L\u00edquido","2006 - Valor US$ FOB","2006 - Quilograma L\u00edquido","2005 - Valor US$ FOB","2005 - Quilograma L\u00edquido")))
medicao <- tempfile(fileext=".rda")
save(exportacao_pargo,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(exportacao_pargo,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
