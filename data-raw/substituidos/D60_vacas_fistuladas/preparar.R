# Executar na raiz da ClaRa (precisa do readxl e do digest, só aqui no preparo).
# D60 substitui trigo_quadrado_latino (agridat::cochran.latin) por decisão do professor em
# 12/10/2026: um quadrado latino com dados de produção animal, transferível à aquicultura
# (ensaio de cruzamento de dietas, com animais ou tanques nas linhas e períodos nas colunas).
pasta <- "data-raw/substituidos/D60_vacas_fistuladas"
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

b <- as.data.frame(readxl::read_excel(file.path(fonte, "data_fistulated_cows.xlsx")))
stopifnot(identical(names(b)[1:7], c("Period", "Time", "Cow No", "Herbage mass",
                                     "Supplement type", "N-NH3 MMOL/L", "PH")),
          identical(dim(b), c(112L, 15L)), names(b)[8] == "VFA")
names(b)[1:8] <- c("periodo", "hora", "vaca", "oferta", "suplemento", "nh3", "ph", "vfa")

# Cada vaca em cada período foi amostrada em sete horários no último dia do período. Os sete
# horários não são réplicas do quadrado: a unidade do delineamento é a célula vaca x período.
# Médias por célula (VFA com na.rm: 25 ausências no arquivo bruto).
media <- function(v, na.rm = FALSE) tapply(v, paste(b$vaca, b$periodo), mean, na.rm = na.rm)
cel <- unique(b[c("vaca", "periodo", "oferta", "suplemento")])
cel$chave <- paste(cel$vaca, cel$periodo)
cel$ph_ruminal <- media(b$ph)[cel$chave]
cel$nh3_n_mmol_l <- media(b$nh3)[cel$chave]
cel$agv_total_mmol_l <- media(b$vfa, na.rm = TRUE)[cel$chave]
cel <- cel[order(cel$vaca, cel$periodo), ]

# Códigos 1/2 da planilha, resolvidos pelas médias da Tabela 4 de Merino et al. (2021):
# oferta 1 = 20 kg de MS/vaca/dia, 2 = 30 kg; suplemento 1 = milho úmido, 2 = trigo moído.
niv_oferta <- c("20 kg", "30 kg")
niv_supl <- c("milho úmido", "trigo moído")
oferta <- factor(niv_oferta[cel$oferta], levels = niv_oferta)
suplemento <- factor(niv_supl[cel$suplemento], levels = niv_supl)
tratamento <- factor(paste(oferta, suplemento, sep = " + "),
                     levels = paste(rep(niv_oferta, each = 2), niv_supl, sep = " + "))

vacas_fistuladas <- data.frame(
  id_vaca          = as.character(cel$vaca),
  periodo          = factor(cel$periodo),
  oferta_forragem  = oferta,
  suplemento       = suplemento,
  tratamento       = tratamento,
  ph_ruminal       = as.numeric(cel$ph_ruminal),
  nh3_n_mmol_l     = as.numeric(cel$nh3_n_mmol_l),
  agv_total_mmol_l = as.numeric(cel$agv_total_mmol_l),
  stringsAsFactors = FALSE
)
row.names(vacas_fistuladas) <- NULL

# Conferências: quadrado latino 4 x 4 completo e médias contra a Tabela 4 do artigo.
tr <- vacas_fistuladas
um <- function(a, b) all(table(a, b) == 1L)
stopifnot(
  identical(dim(tr), c(16L, 8L)), !anyNA(tr),
  nlevels(factor(tr$id_vaca)) == 4L, nlevels(tr$periodo) == 4L, nlevels(tr$tratamento) == 4L,
  um(tr$id_vaca, tr$periodo), um(tr$tratamento, tr$id_vaca), um(tr$tratamento, tr$periodo),
  all(abs(tapply(tr$ph_ruminal, tr$oferta_forragem, mean) - c(5.73, 5.75)) < 0.01),
  all(abs(tapply(tr$nh3_n_mmol_l, tr$oferta_forragem, mean) - c(8.25, 7.71)) < 0.01),
  all(abs(tapply(tr$nh3_n_mmol_l, tr$suplemento, mean) - c(7.49, 8.47)) < 0.01),
  all(abs(tapply(tr$agv_total_mmol_l, tr$oferta_forragem, mean) - c(90.21, 96.66)) < 1)
)

save(vacas_fistuladas, file = "data/vacas_fistuladas.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == "D60")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(
  length(i) == 1L,
  catalogo_dados$nome[i] %in% c("trigo_quadrado_latino", "vacas_fistuladas"),
  setequal(names(novo), names(catalogo_dados))
)
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
