# Executar na raiz da ClaRa. D12 substitui bacterias_tratamento por decisão do professor em 12/10/2026.
pasta <- "data-raw/D12_bufalos_estrongilos"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  bruto <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bruto, algo = "sha256", serialize = FALSE), partes[1]))
}

antes <- utils::read.csv(file.path(fonte, "pre-treatment_worms.csv"),
                         na.strings = c("", "NA"), stringsAsFactors = FALSE)
depois_todas <- utils::read.csv(file.path(fonte, "worms.csv"),
                                na.strings = c("", "NA"), stringsAsFactors = FALSE)
depois_validas <- depois_todas[!is.na(depois_todas$worms_yn) &
                                 depois_todas$captureinterval <= 180, ]
depois_validas <- depois_validas[order(depois_validas$animalID,
                                       depois_validas$captureinterval), ]
depois_primeira <- depois_validas[!duplicated(depois_validas$animalID), ]
indice_depois <- match(antes$animalID, depois_primeira$animalID)
traduzir_grupo <- function(x) ifelse(x == "bolus", "fenbendazol", "controle")

linhas_antes <- data.frame(
  id_bufalo = antes$animalID, id_captura = antes$captureID,
  tratamento = traduzir_grupo(antes$trt), momento = "antes",
  presenca_ovos_estrongilos = as.integer(antes$worms_yn),
  dias_apos_intervencao = 0L, stringsAsFactors = FALSE
)
tem_depois <- !is.na(indice_depois)
linhas_depois <- data.frame(
  id_bufalo = antes$animalID[tem_depois],
  id_captura = depois_primeira$captureID[indice_depois[tem_depois]],
  tratamento = traduzir_grupo(antes$trt[tem_depois]), momento = "depois",
  presenca_ovos_estrongilos = as.integer(depois_primeira$worms_yn[indice_depois[tem_depois]]),
  dias_apos_intervencao = as.integer(depois_primeira$captureinterval[indice_depois[tem_depois]]),
  stringsAsFactors = FALSE
)
bufalos_estrongilos <- rbind(linhas_antes, linhas_depois)
bufalos_estrongilos <- bufalos_estrongilos[order(bufalos_estrongilos$id_bufalo,
  match(bufalos_estrongilos$momento, c("antes", "depois"))), ]
row.names(bufalos_estrongilos) <- NULL
bufalos_estrongilos$tratamento <- factor(bufalos_estrongilos$tratamento,
                                          levels = c("controle", "fenbendazol"))
bufalos_estrongilos$momento <- factor(bufalos_estrongilos$momento,
                                       levels = c("antes", "depois"))
stopifnot(identical(dim(bufalos_estrongilos), c(418L, 6L)),
  identical(names(bufalos_estrongilos), c("id_bufalo", "id_captura", "tratamento", "momento", "presenca_ovos_estrongilos", "dias_apos_intervencao")),
  length(unique(bufalos_estrongilos$id_bufalo)) == 216L,
  sum(bufalos_estrongilos$momento == "antes") == 216L,
  sum(bufalos_estrongilos$momento == "depois") == 202L,
  sum(is.na(bufalos_estrongilos$presenca_ovos_estrongilos)) == 6L)

largo <- reshape(bufalos_estrongilos[, c("id_bufalo", "momento", "presenca_ovos_estrongilos")],
                 idvar = "id_bufalo", timevar = "momento", direction = "wide")
pares_completos <- stats::complete.cases(largo)
grupo_por_id <- bufalos_estrongilos$tratamento[match(largo$id_bufalo, bufalos_estrongilos$id_bufalo)]
tabela_fenbendazol <- table(largo$presenca_ovos_estrongilos.antes[pares_completos & grupo_por_id == "fenbendazol"],
                            largo$presenca_ovos_estrongilos.depois[pares_completos & grupo_por_id == "fenbendazol"])
tabela_controle <- table(largo$presenca_ovos_estrongilos.antes[pares_completos & grupo_por_id == "controle"],
                         largo$presenca_ovos_estrongilos.depois[pares_completos & grupo_por_id == "controle"])
stopifnot(sum(pares_completos) == 196L,
  identical(as.integer(tabela_fenbendazol), c(47L, 45L, 2L, 4L)),
  identical(as.integer(tabela_controle), c(27L, 16L, 16L, 39L)))

save(bufalos_estrongilos, file = "data/bufalos_estrongilos.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv()); load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados; i <- which(catalogo_dados$codigo == "D12")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas); novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c("bacterias_tratamento", "bufalos_estrongilos"),
          setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
