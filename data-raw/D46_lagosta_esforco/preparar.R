# Executar na raiz da ClaRa (precisa do digest, só aqui no preparo).
# D46 volta a ter um conjunto em 13/10/2026, por decisão do professor: o exercício 11.1
# de Ivo e Fonteles Filho (1997), CPUE e esforço de pesca do estoque da lagosta-verde
# (Panulirus laevicauda). O D46 ensinava, com carros_frenagem, a comparar a reta com
# uma curva; a lagosta faz o mesmo com dados de pesca.
pasta <- "data-raw/D46_lagosta_esforco"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  stopifnot(identical(
    digest::digest(file.path(fonte, partes[2]), algo = "sha256", file = TRUE),
    tolower(partes[1])
  ))
}

# Transcrição literal da tabela do exercício, na ordem do livro. O livro não diz a
# que período corresponde cada linha; a ordem fica como está, sem coluna de ano.
l <- utils::read.csv(file.path(fonte, "exercicio_11_1_ivo_fonteles_1997.csv"))
stopifnot(identical(dim(l), c(14L, 2L)))

lagosta_cpue_esforco <- data.frame(
  esforco_mil_covo_dia = l$esforco_mil_covo_dia,
  cpue_kg_covo_dia     = l$cpue_kg_covo_dia
)

# Conferências: sem ausências, tudo positivo e a CPUE caindo com o esforço, como o
# enunciado pede para verificar (modelo y = A e^(-bx)).
ajuste <- stats::lm(log(cpue_kg_covo_dia) ~ esforco_mil_covo_dia, data = lagosta_cpue_esforco)
stopifnot(
  !anyNA(lagosta_cpue_esforco),
  all(lagosta_cpue_esforco > 0),
  stats::coef(ajuste)[[2]] < 0,
  stats::cor(log(lagosta_cpue_esforco$cpue_kg_covo_dia),
             lagosta_cpue_esforco$esforco_mil_covo_dia) < -0.9
)

usethis::use_data(lagosta_cpue_esforco, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
