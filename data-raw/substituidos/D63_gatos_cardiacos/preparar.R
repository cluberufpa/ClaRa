# Executar na raiz da ClaRa. Valores transcritos da Tabela 5.9 de Costa.
pasta <- "data-raw/D63_gatos_cardiacos"

gatos_cardiacos <- data.frame(
  combinacao_tecnica_periodo = factor(rep(c("I_AM", "I_PM", "II_AM", "II_PM"), each = 4)),
  dia = factor(rep(paste0("dia_", 1:4), 4)),
  substancia = factor(c(
    "D", "B", "A", "C", "B", "D", "C", "A",
    "A", "C", "B", "D", "C", "A", "D", "B"
  ), levels = c("A", "B", "C", "D")),
  log10_dose_ug = c(
    3.26, 4.15, 3.02, 3.67, 2.73, 3.38, 3.29, 4.50,
    3.45, 4.09, 2.66, 3.51, 3.20, 3.14, 3.48, 3.40
  ),
  id_celula = seq_len(16L)
)

uma_vez <- function(a, b) all(table(a, b) == 1L)
stopifnot(
  nrow(gatos_cardiacos) == 16L,
  uma_vez(gatos_cardiacos$substancia, gatos_cardiacos$combinacao_tecnica_periodo),
  uma_vez(gatos_cardiacos$substancia, gatos_cardiacos$dia)
)
modelo <- aov(log10_dose_ug ~ substancia + combinacao_tecnica_periodo + dia, data = gatos_cardiacos)
anova_modelo <- summary(modelo)[[1]]
stopifnot(
  anova_modelo$Df[1] == 3L,
  anova_modelo$Df[4] == 6L,
  abs(anova_modelo[["F value"]][1] - 0.2899) < 0.001
)
save(gatos_cardiacos, file = "data/gatos_cardiacos.rda", compress = "xz", version = 2)

e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
i <- which(catalogo_dados$codigo == novo$codigo)
stopifnot(length(i) <= 1L, setequal(names(novo), names(catalogo_dados)))
if (length(i) == 1L) {
  stopifnot(catalogo_dados$nome[i] == novo$nome)
  catalogo_dados[i, ] <- novo[names(catalogo_dados)]
} else {
  stopifnot(!any(catalogo_dados$nome == novo$nome))
  catalogo_dados <- rbind(catalogo_dados, novo[names(catalogo_dados)])
}
catalogo_dados <- catalogo_dados[order(catalogo_dados$codigo), ]
row.names(catalogo_dados) <- NULL
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
