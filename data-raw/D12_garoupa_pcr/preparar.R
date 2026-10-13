# Executar na raiz da ClaRa (precisa do readxl e do digest, só aqui no preparo).
# D12 substitui ovinos_caprinos_fmdv (antes, cabras_toxoplasma, erva_marinha_lesoes e
# bufalos_estrongilos) por decisão do professor em 13/10/2026: o exemplo de McNemar passa a ser
# de pesca e aquicultura. As LINHAS SÃO RECONSTRUÍDAS das tabelas 2 x 2 publicadas; só as
# contagens são reais.
pasta <- "data-raw/D12_garoupa_pcr"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  bruto <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(
    digest::digest(bruto, algo = "sha256", serialize = FALSE),
    tolower(partes[1])
  ))
}

# Contagens de Bowater (2015), relatório FRDC 2010/034, desafio por coabitação com
# Streptococcus agalactiae em juvenis de Epinephelus lanceolatus. Cada fila é um par (histologia,
# PCR) do mesmo peixe, com 1 = positivo e 0 = negativo, na ordem ++, +-, -+, --.
#   Tabela 32 (réplica 1, n = 74): 18, 2, 50, 4.   Tabela 34 (réplica 2, n = 49): 15, 3, 28, 3.
# A réplica 1 usa as linhas da planilha do professor, na ordem dela (as contagens conferem com a
# Tabela 32); a réplica 2 é expandida das contagens e embaralhada com semente fixa.
reconstruir <- function(n, semente) {
  pares <- data.frame(
    histologia = rep(c(1L, 1L, 0L, 0L), n),
    pcr        = rep(c(1L, 0L, 1L, 0L), n)
  )
  set.seed(semente)
  pares[sample(nrow(pares)), , drop = FALSE]
}
planilha <- as.data.frame(readxl::read_excel(
  file.path(fonte, "mcnemar_garoupa_pcr_histologia.xlsx"), sheet = "Dados_reconstruidos"))
r1 <- data.frame(histologia = as.integer(planilha$histologia), pcr = as.integer(planilha$pcr))
# As 74 linhas da planilha têm exatamente as contagens da Tabela 32.
stopifnot(
  nrow(r1) == 74L, !anyNA(r1),
  identical(as.integer(table(factor(r1$histologia, 1:0), factor(r1$pcr, 1:0))),
            c(18L, 50L, 2L, 4L))
)
r2 <- reconstruir(c(15, 3, 28, 3), 1202L)

rotulo <- function(x) factor(x, levels = c(0L, 1L), labels = c("negativo", "positivo"))
todos <- rbind(cbind(replica = 1L, r1), cbind(replica = 2L, r2))
garoupa_pcr_histologia <- data.frame(
  id_peixe   = sprintf("peixe_%03d", seq_len(nrow(todos))),
  replica    = factor(todos$replica, levels = 1:2),
  histologia = rotulo(todos$histologia),
  pcr        = rotulo(todos$pcr),
  stringsAsFactors = FALSE
)
row.names(garoupa_pcr_histologia) <- NULL

# As duas tabelas publicadas (histologia nas linhas, PCR nas colunas; negativo primeiro).
g <- garoupa_pcr_histologia
tab <- function(r) unname(table(g$histologia[g$replica == r], g$pcr[g$replica == r]))
stopifnot(
  identical(dim(g), c(123L, 4L)), !anyNA(g), !anyDuplicated(g$id_peixe),
  identical(as.integer(table(g$replica)), c(74L, 49L)),
  identical(as.integer(tab("1")), c(4L, 2L, 50L, 18L)),
  identical(as.integer(tab("2")), c(3L, 3L, 28L, 15L)),
  # McNemar com correção, como no relatório (p < 0,05) e na planilha do professor
  abs(mcnemar.test(tab("1"))$statistic - 42.48077) < 1e-4,
  abs(mcnemar.test(tab("1"))$p.value - 7.138e-11) < 1e-13,
  mcnemar.test(tab("2"))$p.value < 1e-4
)

save(garoupa_pcr_histologia, file = "data/garoupa_pcr_histologia.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == "D12")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(
  length(i) == 1L,
  catalogo_dados$nome[i] %in% c("bufalos_estrongilos", "erva_marinha_lesoes", "cabras_toxoplasma",
                                "ovinos_caprinos_fmdv", "garoupa_pcr_histologia"),
  setequal(names(novo), names(catalogo_dados))
)
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
