# Executar na raiz da ClaRa. Valores transcritos das Tabelas 5.1 e 5.6 de Costa.
# A fonte impressa não disponibiliza uma planilha nem informa a fonte primária.
pasta <- "data-raw/D60_suinos_castracao"

tratamentos <- c(
  "A", "B", "C", "D", "B", "D", "A", "C", "C", "A", "D", "B", "D", "C", "B", "A",
  "A", "B", "C", "D", "B", "D", "A", "C", "C", "A", "D", "B", "D", "C", "B", "A"
)
ganhos <- c(
  93.0, 108.6, 108.9, 102.0, 115.4, 96.5, 77.9, 100.2,
  102.1, 94.9, 116.9, 96.0, 117.6, 114.1, 118.7, 97.6,
  125.2, 109.4, 116.4, 114.5, 120.7, 106.8, 95.4, 102.9,
  117.6, 112.4, 112.3, 110.4, 135.8, 126.3, 133.3, 101.8
)
stopifnot(length(tratamentos) == 32L, length(ganhos) == 32L)

suinos_castracao <- data.frame(
  quadrado = factor(rep(c("experimento_1", "experimento_2"), each = 16)),
  leitegada = factor(rep(1:8, each = 4)),
  posicao_peso_inicial = factor(rep(1:4, 8),
    labels = c("1_mais_pesado", "2_ordem_decrescente", "3_ordem_decrescente", "4_mais_leve")
  ),
  tratamento = factor(tratamentos, levels = c("A", "B", "C", "D")),
  ganho_peso_kg = ganhos
)

uma_vez <- function(a, b) all(table(droplevels(a), droplevels(b)) == 1L)
for (q in levels(suinos_castracao$quadrado)) {
  d <- suinos_castracao[suinos_castracao$quadrado == q, ]
  stopifnot(
    uma_vez(d$tratamento, d$leitegada),
    uma_vez(d$tratamento, d$posicao_peso_inicial)
  )
}

# A ANOVA conjunta da Tabela 5.8: os blocos são aninhados em cada quadrado.
modelo <- aov(ganho_peso_kg ~ tratamento + quadrado +
  quadrado:leitegada + quadrado:posicao_peso_inicial, data = suinos_castracao)
anova_modelo <- summary(modelo)[[1]]
stopifnot(
  nrow(suinos_castracao) == 32L,
  anova_modelo$Df[1] == 3L,
  anova_modelo$Df[5] == 15L,
  abs(anova_modelo[["Pr(>F)"]][1] - 0.0079) < 0.0001
)

save(suinos_castracao, file = "data/suinos_castracao.rda", compress = "xz", version = 2)

e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == "D60")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(length(i) == 1L, setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
