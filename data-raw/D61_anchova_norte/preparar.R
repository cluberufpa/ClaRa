# Executar na raiz da ClaRa. A pasta fonte congela tanto a extração oficial
# quanto o objeto publicado pelo EAPADados, para que esta curadoria possa ser
# refeita e conferida sem depender de acesso à internet.

pasta <- "data-raw/D61_anchova_norte"
fonte <- file.path(pasta, "fonte")

# Confere se os arquivos usados continuam exatamente os que foram registrados.
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  stopifnot(identical(tolower(unname(tools::sha256sum(arquivo))), partes[1]))
}

# A ClaRa conserva o objeto do EAPADados; não cria uma segunda interpretação
# do recorte. A planilha oficial abaixo é lida apenas para a conferência.
origem <- new.env(parent = emptyenv())
load(file.path(fonte, "anchova_norte_california.rda"), envir = origem)
anchova_norte_california <- as.data.frame(origem$anchova_norte_california)

bruto <- utils::read.csv(
  file.path(fonte, "anchova_norte_california_fonte.csv"),
  stringsAsFactors = FALSE,
  check.names = FALSE
)
unidades <- bruto[1, ]
bruto <- bruto[-1, ]

datas <- seq.Date(as.Date("1971-01-01"), as.Date("1991-12-01"), by = "month")
meses <- c(
  "janeiro", "fevereiro", "marco", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"
)

stopifnot(
  identical(unidades$time, "UTC"),
  identical(unidades$landings, "pounds"),
  nrow(anchova_norte_california) == 252L,
  identical(names(anchova_norte_california), c(
    "data", "ano", "mes", "categoria_mercado", "porto", "desembarque_lb"
  )),
  identical(anchova_norte_california$data, datas),
  identical(anchova_norte_california$ano, as.integer(format(datas, "%Y"))),
  is.ordered(anchova_norte_california$mes),
  identical(levels(anchova_norte_california$mes), meses),
  identical(levels(anchova_norte_california$categoria_mercado), "anchova-do-norte"),
  identical(levels(anchova_norte_california$porto), "todos_os_portos"),
  all(anchova_norte_california$desembarque_lb > 0),
  all(bruto$fish == "Anchovy, Northern"),
  all(bruto$port == "All"),
  identical(anchova_norte_california$desembarque_lb, as.numeric(bruto$landings))
)

# O catálogo circula também em instalações Windows antigas; preserva os
# metadados de texto em Latin-1, como os demais conjuntos da ClaRa.
codificar <- function(x) {
  iconv(x, from = "UTF-8", to = "latin1")
}

for (nome in names(anchova_norte_california)) {
  if (is.character(anchova_norte_california[[nome]])) {
    anchova_norte_california[[nome]] <- codificar(anchova_norte_california[[nome]])
  }
}

usethis::use_data(anchova_norte_california, overwrite = TRUE, compress = "xz")

source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
