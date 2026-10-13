# Executar na raiz da ClaRa (precisa do readxl e do digest, só aqui no preparo).
# D12 substitui cabras_toxoplasma (antes, erva_marinha_lesoes e bufalos_estrongilos)
# por decisão do professor em 12/10/2026: dados individuais brutos e reais, com
# discordância nos dois sentidos, em vez de linhas reconstruídas de uma tabela.
pasta <- "data-raw/D12_ovinos_fmdv"
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

b <- as.data.frame(readxl::read_excel(
  file.path(fonte, "mcnemar_ovinos_caprinos_fmdv.xlsx"),
  sheet = "Dados_pareados"
))

# A planilha traz o texto "NA" em duas linhas do ELISA; vira NA de verdade.
b[] <- lapply(b, function(x) if (is.character(x)) replace(x, x == "NA", NA) else x)

positivo <- function(x) {
  stopifnot(all(x %in% c("Negative", "Positive", NA)))
  factor(c(Negative = "negativo", Positive = "positivo")[x],
         levels = c("negativo", "positivo"))
}

ovinos_caprinos_fmdv <- data.frame(
  id_animal     = b$animal_id,
  id_local      = b$premissa_id,
  data_coleta   = as.Date(substr(b$data_coleta, 1, 10)),
  visita        = factor(b$visita, levels = paste0("V", 1:7)),
  especie       = factor(c(Sheep = "ovino", Goats = "caprino")[b$especie],
                         levels = c("ovino", "caprino")),
  idade_meses   = as.numeric(b$idade_meses),
  sexo          = factor(c(Female = "fêmea", Male = "macho")[b$sexo],
                         levels = c("fêmea", "macho")),
  origem_animal = factor(c(`Same farm` = "mesma propriedade",
                           `Livestock market` = "mercado de gado",
                           Neighbors = "vizinhos")[b$origem_animal],
                         levels = c("mesma propriedade", "mercado de gado", "vizinhos")),
  pcr_soro      = positivo(b$resultado_pcr_soro),
  pcr_swab_oral = positivo(b$resultado_pcr_swab_oral),
  elisa_nsp     = positivo(b$resultado_elisa_nsp),
  stringsAsFactors = FALSE
)

# Conferências contra a planilha de origem e contra a aba Documentacao.
tab <- table(soro = ovinos_caprinos_fmdv$pcr_soro, swab = ovinos_caprinos_fmdv$pcr_swab_oral)
stopifnot(
  identical(dim(ovinos_caprinos_fmdv), c(418L, 11L)),
  !anyNA(ovinos_caprinos_fmdv[setdiff(names(ovinos_caprinos_fmdv), "elisa_nsp")]),
  sum(is.na(ovinos_caprinos_fmdv$elisa_nsp)) == 2L,
  length(unique(ovinos_caprinos_fmdv$id_animal)) == 323L,
  sum(duplicated(ovinos_caprinos_fmdv$id_animal) | duplicated(ovinos_caprinos_fmdv$id_animal, fromLast = TRUE)) == 152L,
  !anyDuplicated(ovinos_caprinos_fmdv[c("id_animal", "visita")]),
  identical(as.integer(tab), c(400L, 9L, 8L, 1L)),
  identical(as.integer(b$pcr_soro_binario), as.integer(ovinos_caprinos_fmdv$pcr_soro == "positivo")),
  identical(as.integer(b$pcr_swab_oral_binario), as.integer(ovinos_caprinos_fmdv$pcr_swab_oral == "positivo")),
  all(b$lesoes_fmd == "No")  # constante: não entra no conjunto
)

save(ovinos_caprinos_fmdv, file = "data/ovinos_caprinos_fmdv.rda", compress = "xz", version = 2)
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
  catalogo_dados$nome[i] %in% c("bufalos_estrongilos", "erva_marinha_lesoes",
                                "cabras_toxoplasma", "ovinos_caprinos_fmdv"),
  setequal(names(novo), names(catalogo_dados))
)
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
