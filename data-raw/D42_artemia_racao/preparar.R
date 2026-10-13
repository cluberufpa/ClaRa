# Executar na raiz da ClaRa (precisa do digest, só aqui no preparo).
# D42 volta a ter um conjunto em 13/10/2026, por decisão do professor: o exercício 82
# de Ivo e Fonteles Filho (1997), crescimento de Artemia salina com duas rações. É a
# fonte do antigo EAPADados::artemia, que trazia só as sete primeiras linhas de cada
# ração e se dizia fictício; a proposta antiga está em propostas_nao_integradas/artemia/.
pasta <- "data-raw/D42_artemia_racao"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  stopifnot(identical(
    digest::digest(file.path(fonte, partes[2]), algo = "sha256", file = TRUE),
    tolower(partes[1])
  ))
}

# Transcrição literal da tabela do exercício: dez taxas por ração, em mg/dia.
a <- utils::read.csv(file.path(fonte, "exercicio_82_ivo_fonteles_1997.csv"))
stopifnot(identical(dim(a), c(20L, 2L)))

# As rações ficam com as letras do livro, A antes de B: o enunciado afirma que A
# (farelo de arroz) é melhor que B (farelo de babaçu), e o teste unilateral
# depende dessa ordem.
artemia_racao <- data.frame(
  racao                   = factor(a$racao, levels = c("A", "B")),
  taxa_crescimento_mg_dia = a$taxa_crescimento_mg_dia
)

# Conferências: dez por ração, sem ausências, e as sete primeiras de cada ração
# iguais ao antigo EAPADados::artemia.
e <- new.env(parent = emptyenv())
load("data-raw/propostas_nao_integradas/artemia/fonte/artemia.rda", envir = e)
antigo <- as.data.frame(e$artemia)
primeiras <- artemia_racao[c(1:7, 11:17), ]
stopifnot(
  identical(as.vector(table(artemia_racao$racao)), c(10L, 10L)),
  !anyNA(artemia_racao),
  identical(as.character(primeiras$racao), as.character(antigo$racao)),
  identical(primeiras$taxa_crescimento_mg_dia, antigo$taxa_crescimento_mg_dia)
)

usethis::use_data(artemia_racao, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
