# Executar na raiz do pacote. Substituição autorizada em 12/10/2026.
pasta <- "data-raw/D04_lago_vitoria"
codigo <- "D04"
nome <- "lago_vitoria"
anterior <- "doubs_ambiente"
arquivo <- file.path(pasta, "fonte", "2023_2024_water_quality_data.xlsx")
stopifnot(identical(digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                                  algo = "md5", serialize = FALSE),
                    "20e3b6c36d7438a915b47dc344ad7b18"))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "Sheet1"))
stopifnot(identical(dim(brutos), c(217L, 25L)))
lago_vitoria <- data.frame(
  local = factor(brutos$Site,
    levels = c("Dunga", "Ndere", "Naya", "Mfangano")),
  estacao = factor(brutos$Station,
    levels = c("Cages", "Control"), labels = c("Gaiolas", "Controle")),
  id_amostra = as.character(brutos$Stations_sample),
  ano = factor(brutos$Year),
  profundidade_m = brutos$depth_m,
  profundidade_local_m = brutos$total_depth,
  secchi_m = brutos$Secchi,
  temperatura_c = brutos$Temp_c,
  nitrogenio_total_ugl = brutos$TN,
  fosforo_total_ugl = brutos$TP,
  nitrato_ugl = brutos$NO3,
  nitrito_ugl = brutos$NO2,
  fosforo_reativo_ugl = brutos$SRP,
  silica_ugl = brutos$SIO2,
  amonio_ugl = brutos$NH4,
  clorofila_a = brutos$Chl_a,
  alcalinidade_mgl = brutos$ALK,
  dureza_mgl = brutos$HARD,
  oxigenio_dissolvido_mgl = brutos$DO,
  condutividade_uscm = brutos$Cond,
  solidos_dissolvidos_mgl = brutos$TDS,
  salinidade_ppt = brutos$Salinity,
  ph = brutos$pH,
  orp_mv = brutos$ORP,
  turbidez_ftu = brutos$Turbidity
)
# Todas as 217 linhas, na ordem da fonte; os 81 NA de profundidade_local_m
# (todos de 2024, ano em que o campo não foi medido) e os valores
# estranhos (24 turbidezes negativas, uma clorofila zero) ficam como vieram.
stopifnot(identical(dim(lago_vitoria), c(217L, 25L)),
          nlevels(lago_vitoria$local) == 4L,
          table(lago_vitoria$estacao)[["Gaiolas"]] == 117L,
          sum(is.na(lago_vitoria$profundidade_local_m)) == 81L,
          all(lago_vitoria$ano[is.na(lago_vitoria$profundidade_local_m)] == "2024"),
          sum(is.na(lago_vitoria[-6])) == 0L,
          !anyDuplicated(lago_vitoria[c("id_amostra", "ano", "profundidade_m")]),
          sum(lago_vitoria$turbidez_ftu < 0) == 24L,
          sum(lago_vitoria$clorofila_a == 0) == 1L)

destino <- paste0("data/", nome, ".rda")
save(list = nome, file = destino, compress = "xz", version = 2)
# A substituição mantém o código e todos os demais registros do catálogo.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == codigo)
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c(anterior, nome))
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")),
                      stringsAsFactors = FALSE)
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
stopifnot(file.info(destino)$size <= 100000,
          sum(file.info(list.files("data", full.names = TRUE))$size) <= 3e6)
