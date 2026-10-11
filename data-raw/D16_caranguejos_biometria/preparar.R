# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D16_caranguejos_biometria"
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
e <- new.env(parent = emptyenv())
load(file.path(fonte,"biometria_caranguejos.rda"), e)
brutos <- as.data.frame(e$biometria_caranguejos)
s <- as.data.frame(readxl::read_excel(file.path(fonte,"dados_brutos_eapadados.xlsx"), sheet="src_caranguejos"))
stopifnot(isTRUE(all.equal(normalizar(brutos), normalizar(s), check.attributes=FALSE, tolerance=1e-12)))
x <- brutos
names(x) <- c("local","sexo","estacao","largura_carapaca","comprimento_carapaca")
levels(x$sexo) <- c("fêmea","macho")
levels(x$estacao) <- c("chuvosa","seca")

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
caranguejos_biometria <- x
stopifnot(identical(dim(caranguejos_biometria),c(993L,5L)),
          identical(names(caranguejos_biometria),c("local","sexo","estacao","largura_carapaca","comprimento_carapaca")))
medicao <- tempfile(fileext=".rda")
save(caranguejos_biometria,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(caranguejos_biometria,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
