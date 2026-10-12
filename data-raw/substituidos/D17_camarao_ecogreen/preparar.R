# Executar na raiz do pacote. Substituição autorizada em 12/10/2026.
pasta <- "data-raw/D17_camarao_ecogreen"
codigo <- "D17"
nome <- "camarao_ecogreen"
anterior <- "salmouras_carbonatos"
arquivo <- file.path(pasta, "fonte",
  "Dataset for shrimp growth and water quality parameters in eco-green aquaculture.xlsx")
stopifnot(identical(digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                                  algo = "md5", serialize = FALSE),
                    "bfff0556f8ef26ab20234a89cf69d252"))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "Sheet1"))
stopifnot(identical(dim(brutos), c(70L, 13L)))
camarao_ecogreen <- data.frame(
  ano = factor(brutos[["Sampling Year"]]),
  ganho_diario = brutos[["ADG (mg/day)"]],
  temperatura_c = brutos[["Temp (0C)"]],
  transparencia_cm = brutos[["Transparency (cm)"]],
  solidos_suspensos_mgl = brutos[["TSS (mg/L)"]],
  salinidade_ppt = brutos[["Salinity (ppt)"]],
  oxigenio_mgl = brutos[["DO (mg/L)"]],
  co2_mgl = brutos[["CO2 (mg/L)"]],
  nitrato_mgl = brutos[["Nitrate (mg/L)"]],
  fosfato_mgl = brutos[["Phosphate (mg/L)"]],
  amonia_mgl = brutos[["Ammonia (mg/L)"]],
  materia_organica_mgl = brutos[["TOM (mg/L)"]],
  vibrio_total = brutos[["Total Vibrio (mg/L)"]]
)
# As 70 linhas na ordem da fonte, sem NA. As variáveis de água assumem só 7
# combinações distintas de valores (a fonte traz médias); o ganho diário
# varia dentro de cada combinação.
agua <- camarao_ecogreen[-(1:2)]
stopifnot(identical(dim(camarao_ecogreen), c(70L, 13L)),
          !anyNA(camarao_ecogreen),
          identical(as.integer(table(camarao_ecogreen$ano)), c(13L, 18L, 39L)),
          nrow(unique(agua)) == 7L)

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
