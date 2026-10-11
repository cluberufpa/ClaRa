# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D20_cangulo_biometria"
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
load(file.path(fonte,"cangulo_crescimento.rda"), e)
brutos <- as.data.frame(e$cangulo_crescimento)
s <- as.data.frame(readxl::read_excel(file.path(fonte,"dados_brutos_eapadados.xlsx"), sheet="src_cangulo"))
stopifnot(isTRUE(all.equal(normalizar(brutos), normalizar(s), check.attributes=FALSE, tolerance=1e-12)))
x <- brutos
# Pedido explícito da Trilha: se os logaritmos entrarem, devem entrar certos.
x$ln_peso <- brutos$ln_comp
x$ln_comp <- brutos$ln_peso
stopifnot(max(abs(x$ln_peso-log(x$peso_g))) < 0.0001,
          max(abs(x$ln_comp-log(x$comprimento_cm))) < 0.0001)

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
cangulo_crescimento <- x
stopifnot(identical(dim(cangulo_crescimento),c(16L,7L)),
          identical(names(cangulo_crescimento),c("comprimento_cm","p1","p2","p3","peso_g","ln_peso","ln_comp")))
medicao <- tempfile(fileext=".rda")
save(cangulo_crescimento,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(cangulo_crescimento,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
