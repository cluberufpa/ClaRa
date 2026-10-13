# Executar na raiz da ClaRa.
# D12 substitui erva_marinha_lesoes (antes, bufalos_estrongilos) por decisão do professor
# em 12/10/2026: o "antes" da erva-marinha era constante e o McNemar não rodava.
#
# As LINHAS SÃO RECONSTRUÍDAS: o artigo (Dahmane et al. 2025) publica só as tabelas
# 2 x 2. Cada tabela abaixo foi transcrita de lá (ver fonte/PROVENIENCIA.md).
pasta <- "data-raw/D12_cabras_toxoplasma"

# Tabela tripla (ELISA do soro, PCR do sangue, PCR do leite): 1 = positivo, 0 = negativo.
# Soropositivas (51): Tabela 2. Soronegativas (55): diferença entre as Tabelas 1 e 2.
celulas <- data.frame(
  elisa  = c(1, 1, 1, 1, 0, 0, 0, 0),
  sangue = c(1, 1, 0, 0, 1, 1, 0, 0),
  leite  = c(1, 0, 1, 0, 1, 0, 1, 0),
  n      = c(6, 9, 7, 29, 1, 0, 1, 53)
)
linhas <- celulas[rep(seq_len(nrow(celulas)), celulas$n), c("elisa", "sangue", "leite")]

set.seed(20261012)
linhas <- linhas[sample(nrow(linhas)), ]
row.names(linhas) <- NULL

rotulo <- function(x) factor(x, levels = c(0, 1), labels = c("negativo", "positivo"))
cabras_toxoplasma <- data.frame(
  id_cabra   = sprintf("cabra_%03d", seq_len(nrow(linhas))),
  elisa_soro = rotulo(linhas$elisa),
  pcr_sangue = rotulo(linhas$sangue),
  pcr_leite  = rotulo(linhas$leite),
  stringsAsFactors = FALSE
)

# As quatro tabelas publicadas, conferidas contra o conjunto reconstruído.
tabela <- function(a, b) unclass(table(a, b))
dimnames_nulos <- function(m) { dimnames(m) <- NULL; m }
t1 <- dimnames_nulos(tabela(cabras_toxoplasma$pcr_sangue, cabras_toxoplasma$pcr_leite)[2:1, 2:1])
t2 <- with(subset(cabras_toxoplasma, elisa_soro == "positivo"),
           dimnames_nulos(tabela(pcr_sangue, pcr_leite)[2:1, 2:1]))
t3 <- dimnames_nulos(tabela(cabras_toxoplasma$elisa_soro, cabras_toxoplasma$pcr_leite)[2:1, 2:1])
t4 <- dimnames_nulos(tabela(cabras_toxoplasma$elisa_soro, cabras_toxoplasma$pcr_sangue)[2:1, 2:1])
stopifnot(
  identical(dim(cabras_toxoplasma), c(106L, 4L)),
  identical(names(cabras_toxoplasma), c("id_cabra", "elisa_soro", "pcr_sangue", "pcr_leite")),
  !anyNA(cabras_toxoplasma),
  !anyDuplicated(cabras_toxoplasma$id_cabra),
  identical(t1, matrix(c(7L, 8L, 9L, 82L), 2)),
  identical(t2, matrix(c(6L, 7L, 9L, 29L), 2)),
  identical(t3, matrix(c(13L, 2L, 38L, 53L), 2)),
  identical(t4, matrix(c(15L, 1L, 36L, 54L), 2))
)

save(cabras_toxoplasma, file = "data/cabras_toxoplasma.rda", compress = "xz", version = 2)
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
  catalogo_dados$nome[i] %in% c("bufalos_estrongilos", "erva_marinha_lesoes", "cabras_toxoplasma"),
  setequal(names(novo), names(catalogo_dados))
)
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
