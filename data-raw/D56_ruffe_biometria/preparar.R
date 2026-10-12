# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D56_ruffe_biometria"
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
e <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__RuffeSLRH92_confirmado.rda"),e)
stopifnot(identical(ls(e),"RuffeSLRH92"))
z <- new.env(parent=emptyenv());load(file.path(fonte,"FSAdata__RuffeSLRH92.rda"),z)
stopifnot(isTRUE(all.equal(e[["RuffeSLRH92"]],z[["RuffeSLRH92"]],check.attributes=TRUE,tolerance=1e-12)))
q <- new.env(parent=emptyenv());load(file.path(fonte,"RuffeSLRH92.rdata"),q)
stopifnot(identical(q[["RuffeSLRH92"]],e[["RuffeSLRH92"]]))
brutos <- as.data.frame(e[["RuffeSLRH92"]])
stopifnot(identical(names(brutos),c("fish.id","month","day","year","indiv","location","length","weight","sex","maturity","age")))
x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
names(x) <- c("id_peixe","mes","dia","ano","id_individuo","localizacao","comprimento_total_mm","peso_g","sexo","maturidade","idade_anos")
x$id_peixe <- as.character(x$id_peixe)
x$id_individuo <- as.character(x$id_individuo)
x$localizacao <- as.character(x$localizacao)
stopifnot(setequal(levels(x$sexo),c("female","male","unknown")))
x$sexo <- factor(x$sexo,levels=c("female","male","unknown"),labels=c("femea","macho","desconhecido"),ordered=is.ordered(x$sexo))
stopifnot(setequal(levels(x$maturidade),c("developing","immature","mature","nearly.ripe","nearly.spent","recovering","ripe","running","spent","unknown","yoy")))
x$maturidade <- factor(x$maturidade,levels=c("developing","immature","mature","nearly.ripe","nearly.spent","recovering","ripe","running","spent","unknown","yoy"),labels=c("em_desenvolvimento","imaturo","maduro","quase_maduro","quase_esgotado","em_recuperacao","pronto_desova","em_desova","esgotado","desconhecido","jovem_ano"),ordered=is.ordered(x$maturidade))
stopifnot(isTRUE(all.equal(as.numeric(x$id_peixe),brutos$fish.id)),sum(is.na(x$idade_anos))==726L,sum(is.na(x$peso_g))==2L)

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
ruffe_biometria <- x
stopifnot(identical(dim(ruffe_biometria),c(738L,11L)),
          identical(names(ruffe_biometria),c("id_peixe","mes","dia","ano","id_individuo","localizacao","comprimento_total_mm","peso_g","sexo","maturidade","idade_anos")))
medicao <- tempfile(fileext=".rda")
save(ruffe_biometria,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(ruffe_biometria,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
