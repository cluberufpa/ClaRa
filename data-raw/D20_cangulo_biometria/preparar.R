# Executar na raiz da ClaRa; fontes congeladas, sem executar scripts herdados.
# Revisão de 13/10/2026: a fonte foi identificada. É a Tabela 11.2 de Ivo e
# Fonteles Filho (1997), Estatística pesqueira, com o cangulo (Balistes vetula)
# do Ceará. A transcrição da tabela entrou em fonte/ e confere com a cópia
# herdada do EAPADados; as colunas ganharam nomes que dizem o que guardam.
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

# Conferência com o livro: comprimentos e os três pesos são idênticos; a média
# e os logaritmos do livro têm uma ou três casas e conferem com os herdados
# depois de arredondados. Na classe de 36 cm o livro trunca a média (1015,2;
# a conta dá 1015,27), por isso a tolerância de 0,1 g. Na cópia herdada os
# nomes ln_peso e ln_comp estavam trocados: ln_peso guardava ln(comprimento).
livro <- utils::read.csv(file.path(fonte,"tabela_11_2_ivo_fonteles_1997.csv"))
stopifnot(identical(dim(livro), c(16L, 7L)),
          all(livro$comprimento_cm == brutos$comprimento_cm),
          all(livro$y1 == brutos$p1), all(livro$y2 == brutos$p2),
          all(livro$y3 == brutos$p3),
          max(abs(livro$media_y - brutos$peso_g)) < 0.1,
          max(abs(livro$ln_x - round(brutos$ln_peso, 3))) < 0.0015,
          max(abs(livro$ln_y - round(brutos$ln_comp, 3))) < 0.0015)

# Os três pesos de cada classe são três peixes diferentes daquele comprimento,
# não três pesagens do mesmo peixe. A média é a de três pesos, com todas as
# casas; os logaritmos são recalculados com todas as casas (eram a cópia
# herdada, com a mesma precisão), na ordem do livro: x' antes de y'.
cangulo_crescimento <- data.frame(
  comprimento_cm  = brutos$comprimento_cm,
  peso1_g         = brutos$p1,
  peso2_g         = brutos$p2,
  peso3_g         = brutos$p3,
  peso_medio_g    = (brutos$p1 + brutos$p2 + brutos$p3) / 3,
  ln_comprimento  = log(brutos$comprimento_cm),
  ln_peso_medio   = log((brutos$p1 + brutos$p2 + brutos$p3) / 3)
)
stopifnot(max(abs(cangulo_crescimento$peso_medio_g - brutos$peso_g)) < 1e-9,
          max(abs(cangulo_crescimento$ln_comprimento - brutos$ln_peso)) < 1e-6,
          max(abs(cangulo_crescimento$ln_peso_medio - brutos$ln_comp)) < 1e-6)

stopifnot(identical(dim(cangulo_crescimento),c(16L,7L)),
          identical(names(cangulo_crescimento),c("comprimento_cm","peso1_g","peso2_g","peso3_g",
                                                 "peso_medio_g","ln_comprimento","ln_peso_medio")))
medicao <- tempfile(fileext=".rda")
save(cangulo_crescimento,file=medicao,compress="xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(cangulo_crescimento,overwrite=TRUE,compress="xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta,"metadados.json"))
print(tools::checkRdaFiles("data"))
