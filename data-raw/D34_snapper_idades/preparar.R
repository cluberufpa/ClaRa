# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D34_snapper_idades"
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
load(file.path(fonte,"snapper_hg.rda"),e)
brutos <- as.data.frame(e$snapper_hg)
s <- readRDS(file.path(fonte,"snapper_hg.rds"))
stopifnot(identical(names(brutos),names(s)),isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
z <- new.env();load(file.path(fonte,"SnapperHG1.rdata"),z)
a <- z$SnapperHG1; a <- a[!is.na(a$age),]
stopifnot(nrow(a)==nrow(brutos),all(as.numeric(rownames(a))==brutos$id_peixe),all(a$len==brutos$comprimento_cm),all(a$age==brutos$idade_anos),all(a$survey==brutos$levantamento),all(brutos$tem_idade_atribuida))
x <- brutos
x$id_peixe <- as.character(x$id_peixe)

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
snapper_hg <- x
stopifnot(identical(dim(snapper_hg),c(1331L,6L)),
          identical(names(snapper_hg),c("id_peixe","levantamento","comprimento_cm","idade_anos","tem_idade_atribuida","classe_comprimento")))
medicao <- tempfile(fileext=".rda")
save(snapper_hg,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(snapper_hg,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
