# Executar na raiz da ClaRa. D48 substitui laranjeiras_crescimento por decisão do professor em 12/10/2026.
pasta <- "data-raw/D48_molinesias_crescimento"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  bruto <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bruto, algo = "sha256", serialize = FALSE), partes[1]))
}
brutos <- utils::read.csv(file.path(fonte, "growth.csv"), stringsAsFactors = FALSE)
idades_completas <- c(0L, 14L, 21L, 42L, 49L, 56L, 77L, 154L, 224L, 280L)
selecionados <- brutos[brutos$fish_age_in_days %in% idades_completas, ]
molinesias_crescimento <- data.frame(
  peixe = as.character(selecionados$test_fish_ID),
  mae = factor(selecionados$mother_ID, levels = c("m1", "m2", "m4")),
  idade_dias = as.integer(selecionados$fish_age_in_days),
  comprimento_cm = as.numeric(selecionados$standard_length_in_cm)
)
stopifnot(identical(dim(molinesias_crescimento), c(340L, 4L)),
  identical(names(molinesias_crescimento), c("peixe", "mae", "idade_dias", "comprimento_cm")),
  length(unique(molinesias_crescimento$peixe)) == 34L,
  identical(sort(unique(molinesias_crescimento$idade_dias)), idades_completas),
  !anyDuplicated(molinesias_crescimento[c("peixe", "idade_dias")]),
  !anyNA(molinesias_crescimento), identical(as.integer(table(molinesias_crescimento$mae) / 10L), c(14L, 4L, 16L)))
save(molinesias_crescimento, file = "data/molinesias_crescimento.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv()); load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados; i <- which(catalogo_dados$codigo == "D48")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas); novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c("laranjeiras_crescimento", "molinesias_crescimento"),
          setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
