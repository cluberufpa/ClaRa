# Executar na raiz do pacote. Substituição autorizada em 12/10/2026.
pasta <- "data-raw/D17_solha_baltico_2008_t4"
codigo <- "D17"
nome <- "solha_baltico_2008_t4"
anteriores <- c("salmouras_carbonatos", "camarao_ecogreen", nome)
arquivo <- file.path(pasta, "fonte", "Data_cod_flounder.zip")

stopifnot(identical(
  digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
    algo = "md5", serialize = FALSE),
  "731c68d6bcc487a8cad1067049648a3e"
))

temporario <- tempfile("solha_baltico_")
dir.create(temporario)
on.exit(unlink(temporario, recursive = TRUE), add = TRUE)
utils::unzip(arquivo, exdir = temporario)
brutos <- utils::read.csv(file.path(temporario, "Flounder.csv"),
  check.names = FALSE
)

stopifnot(
  identical(names(brutos), c(
    "totalCPUE", "LATDD", "LONGDD", "year", "Depth", "quarter", "OXY", "TEM", "SAL"
  )),
  identical(dim(brutos), c(9764L, 9L)),
  !anyNA(brutos)
)

indice <- brutos$year == 2008L & brutos$quarter == 4L
recorte <- brutos[indice, , drop = FALSE]
solha_baltico_2008_t4 <- data.frame(
  linha_fonte = which(indice),
  cpue_g = recorte$totalCPUE,
  log_cpue_g = log1p(recorte$totalCPUE),
  temperatura_fundo_c = recorte$TEM,
  salinidade = recorte$SAL,
  oxigenio_dissolvido_mg_l = recorte$OXY,
  profundidade_m = recorte$Depth,
  latitude_graus = recorte$LATDD,
  longitude_graus = recorte$LONGDD
)

modelo <- stats::lm(
  log_cpue_g ~ temperatura_fundo_c + salinidade + oxigenio_dissolvido_mg_l +
    profundidade_m + latitude_graus + longitude_graus,
  data = solha_baltico_2008_t4
)
preditores <- solha_baltico_2008_t4[c(
  "temperatura_fundo_c", "salinidade", "oxigenio_dissolvido_mg_l",
  "profundidade_m", "latitude_graus", "longitude_graus"
)]
vif <- vapply(names(preditores), function(alvo) {
  outros <- preditores[names(preditores) != alvo]
  1 / (1 - summary(stats::lm(preditores[[alvo]] ~ ., data = outros))$r.squared)
}, numeric(1))

stopifnot(
  identical(dim(solha_baltico_2008_t4), c(179L, 9L)),
  !anyNA(solha_baltico_2008_t4),
  sum(solha_baltico_2008_t4$cpue_g == 0) == 37L,
  isTRUE(all.equal(unname(summary(modelo)$r.squared), 0.6456858, tolerance = 1e-6)),
  isTRUE(all.equal(unname(vif["salinidade"]), 3.807096, tolerance = 1e-5)),
  isTRUE(all.equal(unname(vif["oxigenio_dissolvido_mg_l"]), 4.208624, tolerance = 1e-5))
)

destino <- paste0("data/", nome, ".rda")
save(list = nome, file = destino, compress = "xz", version = 2)

# Mantém todos os demais registros do catálogo e substitui somente o D17.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == codigo)
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% anteriores)
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")),
  stringsAsFactors = FALSE
)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
  stopifnot(!anyNA(novo[[n]]))
}
stopifnot(setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
stopifnot(!anyDuplicated(catalogo_dados$codigo), !anyDuplicated(catalogo_dados$nome))
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
stopifnot(
  file.info(destino)$size <= 100000,
  sum(file.info(list.files("data", full.names = TRUE))$size) <= 3e6
)
