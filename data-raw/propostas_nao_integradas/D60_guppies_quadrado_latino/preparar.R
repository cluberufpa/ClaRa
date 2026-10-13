# Executar na raiz da ClaRa. Fonte: Allibhai et al. (2023), Dryad
# https://doi.org/10.5061/dryad.j3tx95xjv (CC0).
# As 16 respostas são médias de ensaios publicados, não observações inventadas.
pasta <- "data-raw/D60_guppies_quadrado_latino"
brutos <- read.csv(file.path(pasta, "Data_for_models.csv"), check.names = TRUE)

stopifnot(
  nrow(brutos) == 94L,
  setequal(unique(brutos$Tub), 1:4),
  setequal(unique(brutos$day_of_testing), 1:4),
  !anyNA(brutos[c("Tub", "day_of_testing", "Treatment", "mean_NND_min_dist")]),
  all(is.finite(brutos$mean_NND_min_dist))
)

tratamentos <- c(
  Control = "controle",
  Temperature = "temperatura",
  Turbidity = "turbidez",
  `Temperature and Turbidity` = "temperatura_turbidez"
)
stopifnot(setequal(unique(brutos$Treatment), names(tratamentos)))
brutos$tratamento_pt <- unname(tratamentos[brutos$Treatment])

chaves <- c("Tub", "day_of_testing", "tratamento_pt")
medias <- aggregate(brutos$mean_NND_min_dist, by = brutos[chaves], FUN = mean)
contagens <- aggregate(brutos$mean_NND_min_dist, by = brutos[chaves], FUN = length)
names(medias)[4] <- "dist_vizinho_px"
names(contagens)[4] <- "n_ensaios"
celulas <- merge(medias, contagens, by = chaves, sort = FALSE)
celulas <- celulas[order(celulas$Tub, celulas$day_of_testing), ]

guppies_quadrado_latino <- data.frame(
  grupo = factor(celulas$Tub, levels = 1:4),
  etapa = factor(celulas$day_of_testing, levels = 1:4),
  tratamento = factor(celulas$tratamento_pt, levels = unname(tratamentos)),
  dist_vizinho_px = celulas$dist_vizinho_px,
  n_ensaios = as.integer(celulas$n_ensaios)
)
row.names(guppies_quadrado_latino) <- NULL

stopifnot(
  identical(dim(guppies_quadrado_latino), c(16L, 5L)),
  sum(guppies_quadrado_latino$n_ensaios) == 94L,
  all(guppies_quadrado_latino$n_ensaios %in% 5:6),
  all(table(guppies_quadrado_latino$grupo, guppies_quadrado_latino$etapa) == 1L),
  all(table(guppies_quadrado_latino$grupo, guppies_quadrado_latino$tratamento) == 1L),
  all(table(guppies_quadrado_latino$etapa, guppies_quadrado_latino$tratamento) == 1L)
)

# ANOVA do quadrado agregado: demonstração didática, NÃO a análise do artigo.
modelo <- aov(dist_vizinho_px ~ tratamento + grupo + etapa,
  data = guppies_quadrado_latino)
anova_modelo <- summary(modelo)[[1]]
stopifnot(
  identical(as.numeric(anova_modelo$Df), c(3, 3, 3, 6)),
  abs(anova_modelo[["Pr(>F)"]][1] - 0.002247328) < 1e-6
)

save(guppies_quadrado_latino,
  file = "data/guppies_quadrado_latino.rda", compress = "xz", version = 2)

e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == "D60")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")),
  stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(length(i) == 1L, setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
