# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
pasta <- "data-raw/D41_mesocosmos_secagem"
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
s <- as.data.frame(readxl::read_excel(file.path(fonte,"Fish_Data_Dryad.xlsx"),sheet="Fish Growth",.name_repair="minimal"),check.names=FALSE)
stopifnot(identical(trimws(names(s)),c("Tank","A_Pres","Drying","Treatment","Initial_Date","Initial_SL","Initial_Biomass","Final_Date","Final_SL","Final_Biomass","Abs_SLGrowth","Rel_SLGrowth")))
x <- s
names(x) <- c("id_tanque","presenca_anfibios","secagem","tratamento","data_inicial","comprimento_padrao_inicial_cm","biomassa_inicial_estimada_g","data_final","comprimento_padrao_final_cm","biomassa_final_estimada_g","crescimento_absoluto_cm","crescimento_relativo")
x$id_tanque <- as.character(x$id_tanque)
stopifnot(all(x$presenca_anfibios %in% c("Y","N")),all(x$secagem %in% c("DR","ND")),!anyDuplicated(x$id_tanque))
x$presenca_anfibios <- factor(x$presenca_anfibios,levels=c("N","Y"),labels=c("não","sim"))
x$secagem <- factor(x$secagem,levels=c("ND","DR"),labels=c("não seco","seco e reabastecido"))
x$tratamento <- factor(x$tratamento)
x$data_inicial <- as.Date(x$data_inicial);x$data_final <- as.Date(x$data_final)
stopifnot(max(abs(x$crescimento_absoluto_cm-(x$comprimento_padrao_final_cm-x$comprimento_padrao_inicial_cm)))<1e-12,max(abs(x$crescimento_relativo-x$crescimento_absoluto_cm/x$comprimento_padrao_inicial_cm))<1e-12)

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
mesocosmos_secagem <- x
stopifnot(identical(dim(mesocosmos_secagem),c(30L,12L)),
          identical(names(mesocosmos_secagem),c("id_tanque","presenca_anfibios","secagem","tratamento","data_inicial","comprimento_padrao_inicial_cm","biomassa_inicial_estimada_g","data_final","comprimento_padrao_final_cm","biomassa_final_estimada_g","crescimento_absoluto_cm","crescimento_relativo")))
medicao <- tempfile(fileext=".rda")
save(mesocosmos_secagem,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(mesocosmos_secagem,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
