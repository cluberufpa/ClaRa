# Executar na raiz da ClaRa. D44 substitui plantas_absorcao_co2 por decisão do professor em 12/10/2026.
pasta <- "data-raw/D44_percas_respirometria"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  bruto <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bruto, algo = "sha256", serialize = FALSE), partes[1]))
}
brutos <- readxl::read_excel(file.path(fonte, "percas_hipoxia.xlsx"), sheet = "Hyp. Prot. - RMR")
percas_respirometria <- data.frame(
  peixe = as.character(brutos[["ID"]]),
  grupo = factor(brutos[["Treatment Group"]], levels = c("Baltic", "Biotest", "Balt@Bio")),
  saturacao_ar_pct = as.numeric(brutos[["Air saturation level"]]),
  consumo_o2_mg_kg_h = as.numeric(brutos[["Resting metabolic rate"]])
)
stopifnot(identical(dim(percas_respirometria), c(449L, 4L)),
  identical(names(percas_respirometria), c("peixe", "grupo", "saturacao_ar_pct", "consumo_o2_mg_kg_h")),
  length(unique(percas_respirometria$peixe)) == 40L,
  identical(sort(unique(percas_respirometria$saturacao_ar_pct)), c(15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100)),
  sum(is.na(percas_respirometria$consumo_o2_mg_kg_h)) == 23L,
  !anyDuplicated(percas_respirometria[c("peixe", "saturacao_ar_pct")]),
  identical(as.integer(table(unique(percas_respirometria[c("peixe", "grupo")])$grupo)), c(13L, 11L, 16L)))
save(percas_respirometria, file = "data/percas_respirometria.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv()); load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados; i <- which(catalogo_dados$codigo == "D44")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas); novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c("plantas_absorcao_co2", "percas_respirometria"),
          setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
