# Executar na raiz do pacote. A fonte permanece intacta em fonte/.
pasta <- "data-raw/D62_larvas_captura"
arquivo <- file.path(pasta, "fonte", "Dale_Light_Trap_Data_Dryad.csv")
hash <- digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                       algo = "sha256", serialize = FALSE)
stopifnot(identical(hash,
  "6a9c1b77c8ea34cdfe9e039c7368cec4663686c770307b4ddf903e8c330014e5"))
brutos <- read.csv(arquivo, stringsAsFactors = FALSE, check.names = FALSE)
stopifnot(identical(dim(brutos), c(58L, 22L)), !anyNA(brutos),
          !anyDuplicated(brutos$sample), all(brutos$n_fish >= 0),
          all(brutos$n_fish == floor(brutos$n_fish)),
          setequal(brutos$site, c("BFC", "CH", "TH")),
          setequal(brutos$season, c("Spring", "Summer")))

# Mantemos todos os eventos e a ordem original. O nome geográfico é próprio.
# As horas são reconstruídas dos componentes, sem arredondar minutos/60.
# A CPUE fica para o aluno calcular: a resposta do GLM é a contagem inteira.
larvas_peixes_captura <- data.frame(
  id_evento = brutos$sample,
  data = as.Date(brutos$date_deployed, format = "%m/%d/%Y"),
  local = factor(brutos$site, levels = c("BFC", "CH", "TH"),
    labels = c("Big Fisherman's Cove", "Cat Harbor", "Two Harbors")),
  estacao = factor(brutos$season, levels = c("Spring", "Summer"),
    labels = c("Primavera", "Verão")),
  ano = factor(brutos$year, levels = c(2018, 2019)),
  esforco_h = brutos$soak_hours + brutos$soak_min / 60,
  numero_larvas = as.integer(brutos$n_fish)
)
# Convenção do catálogo: acentos declarados em Latin-1 nos dados binários.
levels(larvas_peixes_captura$estacao) <- iconv(
  levels(larvas_peixes_captura$estacao), from = "UTF-8", to = "latin1")
stopifnot(identical(dim(larvas_peixes_captura), c(58L, 7L)),
          !anyNA(larvas_peixes_captura),
          all(larvas_peixes_captura$esforco_h > 0),
          sum(larvas_peixes_captura$numero_larvas) == 15919L,
          sum(larvas_peixes_captura$numero_larvas == 0L) == 8L,
          all(as.integer(format(larvas_peixes_captura$data, "%Y")) == brutos$year),
          max(abs(larvas_peixes_captura$esforco_h -
                    brutos$soak_time_standardized)) <= 1/300 + 1e-12)
usethis::use_data(larvas_peixes_captura, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
stopifnot(file.info("data/larvas_peixes_captura.rda")$size <= 100000,
          sum(file.info(list.files("data", full.names = TRUE))$size) <= 3e6)
