# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D21_pescada_captura"
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
load(file.path(fonte,"captura_pescada_amarela.rda"),e)
brutos <- as.data.frame(e$captura_pescada_amarela)
s <- as.data.frame(suppressWarnings(readxl::read_excel(file.path(fonte,"dados_brutos_eapadados.xlsx"),sheet="captura_pescada_amarela_bruta")))
ch <- s[["Data de Chegada"]]
ch_txt <- format(as.Date(suppressWarnings(as.numeric(ch)),origin="1899-12-30"),"%d/%m/%Y")
ch_txt[is.na(ch_txt)] <- ch[is.na(ch_txt)]
s[["Data de Chegada"]] <- ch_txt
names(s) <- c("embarcacao","tamanho_m","precipitacao","mes","ano","periodo_sazonal","mes_ano","data_de_saida","data_de_chegada","dias_ao_mar","cpue_pescada","cpue","pessoal_embarcado","peso_balanca","nome_aparelho_pesca","quantidade_aparelho_pesca")
s$periodo_sazonal <- trimws(gsub("[[:space:]]+"," ",s$periodo_sazonal))
s$nome_aparelho_pesca <- trimws(gsub("[[:space:]]+"," ",s$nome_aparelho_pesca))
s$data_de_chegada <- as.Date(gsub("//","/",s$data_de_chegada,fixed=TRUE),format="%d/%m/%Y")
s$data_de_saida <- as.Date(s$data_de_saida); s$mes_ano <- as.Date(s$mes_ano)
s$ano <- as.integer(s$ano)
s$cpue_pescada <- round(s$cpue_pescada,2); s$cpue <- round(s$cpue,2)
stopifnot(isTRUE(all.equal(normalizar(brutos),normalizar(s),check.attributes=FALSE,tolerance=1e-12)))
x <- brutos
x <- x[!names(x) %in% c("cpue_pescada","cpue")]
names(x)[names(x)=="data_de_saida"] <- "data_saida"
names(x)[names(x)=="data_de_chegada"] <- "data_chegada"

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
captura_pescada_amarela <- x
stopifnot(identical(dim(captura_pescada_amarela),c(252L,14L)),
          identical(names(captura_pescada_amarela),c("embarcacao","tamanho_m","precipitacao","mes","ano","periodo_sazonal","mes_ano","data_saida","data_chegada","dias_ao_mar","pessoal_embarcado","peso_balanca","nome_aparelho_pesca","quantidade_aparelho_pesca")))
medicao <- tempfile(fileext=".rda")
save(captura_pescada_amarela,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(captura_pescada_amarela,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
