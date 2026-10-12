# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D11_puromicina_reacao"
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
load(file.path(fonte, "datasets__Puromycin.rda"), e)
s <- as.data.frame(readxl::read_excel(file.path(fonte, "Puromycin_documentado.xlsx"), sheet = "Dados"))
stopifnot(isTRUE(all.equal(normalizar(s[-1]), normalizar(e$Puromycin), check.attributes = FALSE)))
brutos <- s
x <- s
names(x) <- c("registro_original", "concentracao_ppm", "velocidade_contagens_min2", "condicao")
x$registro_original <- as.character(x$registro_original)
x$condicao <- factor(x$condicao, levels = c("treated", "untreated"), labels = c("com_puromicina", "sem_puromicina"))

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
puromicina_reacao <- x
stopifnot(identical(dim(puromicina_reacao),c(23L,4L)),
          identical(names(puromicina_reacao),c("registro_original","concentracao_ppm","velocidade_contagens_min2","condicao")))
medicao <- tempfile(fileext=".rda")
save(puromicina_reacao,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(puromicina_reacao,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
