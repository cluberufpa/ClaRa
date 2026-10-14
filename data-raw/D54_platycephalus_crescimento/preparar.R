# Executar na raiz da ClaRa (precisa do digest, só aqui no preparo).
# D54 volta a ter um conjunto em 13/10/2026, por decisão do professor: os 4.318
# peixes de Platycephalus richardsoni de Morrongiello e Thresher (2014, Dryad, CC0)
# ocupam o lugar de haemulon_crescimento, cujos pontos eram reconstruídos de uma
# figura (o antigo D54 está em data-raw/retirados/).
pasta <- "data-raw/D54_platycephalus_crescimento"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  stopifnot(identical(
    digest::digest(file.path(fonte, partes[2]), algo = "sha256", file = TRUE),
    tolower(partes[1])
  ))
}

# O arquivo da fonte tem uma linha por anel do otólito (22.941 linhas). As colunas do
# peixe (idade, comprimento, área, aparelho, data de captura) se repetem em todos os
# anéis; ficamos com uma linha por peixe, na ordem em que cada peixe aparece.
brutos <- utils::read.csv(file.path(fonte, "incrmement_measurements.csv"),
                          stringsAsFactors = FALSE)
stopifnot(identical(dim(brutos), c(22941L, 14L)),
          identical(names(brutos), c("area", "FishID", "sex", "gear", "capyear", "capmonth",
                                     "floorlength", "AdjAge", "DeciAge", "radius", "YOB",
                                     "Year", "Age", "Increment")))
constante <- function(coluna) {
  all(tapply(brutos[[coluna]], brutos$FishID, function(v) length(unique(v[!is.na(v)]))) <= 1L)
}
stopifnot(vapply(c("area", "gear", "capyear", "capmonth", "floorlength", "AdjAge",
                   "DeciAge", "YOB"), constante, logical(1)))

peixe <- brutos[!duplicated(brutos$FishID), ]
stopifnot(identical(nrow(peixe), 4318L), !anyNA(peixe$FishID))

# Em 444 peixes o sexo muda de um anel para outro (o mesmo peixe aparece como F e M),
# quase todos de capturas de 2009 e 2010: defeito da fonte. O sexo desses peixes não é
# confiável e fica como NA, sem escolher um por maioria; nenhuma outra coluna muda.
n_sexos <- tapply(brutos$sex, brutos$FishID, function(v) length(unique(v)))
sexo <- tapply(brutos$sex, brutos$FishID, function(v) v[1])[peixe$FishID]
sexo[n_sexos[peixe$FishID] > 1L] <- NA
stopifnot(identical(sum(is.na(sexo)), 444L), setequal(sexo[!is.na(sexo)], c("F", "M")))

platycephalus_crescimento <- data.frame(
  id_peixe       = peixe$FishID,
  area           = factor(peixe$area, levels = c("EBS", "ETAS")),
  aparelho       = factor(peixe$gear, levels = c("OT", "DS", "Unknown"),
                          labels = c("arrasto_fundo", "cerco_dinamarques", "desconhecido")),
  ano_captura    = peixe$capyear,
  mes_captura    = peixe$capmonth,
  sexo           = factor(unname(sexo), levels = c("F", "M"), labels = c("femea", "macho")),
  idade_anos     = peixe$AdjAge,
  idade_decimal  = peixe$DeciAge,
  comprimento_cm = peixe$floorlength,
  stringsAsFactors = FALSE
)
rownames(platycephalus_crescimento) <- NULL

# Conferências com o depósito: 4.318 peixes, idades de 2 a 25 anos, só 17 sem
# comprimento, 3.915 peixes em EBS e 403 em ETAS.
stopifnot(
  identical(dim(platycephalus_crescimento), c(4318L, 9L)),
  identical(range(platycephalus_crescimento$idade_anos), c(2L, 25L)),
  identical(sum(is.na(platycephalus_crescimento$comprimento_cm)), 17L),
  identical(as.vector(table(platycephalus_crescimento$area)), c(3915L, 403L)),
  identical(sum(!is.na(platycephalus_crescimento$sexo)), 3874L),
  !anyDuplicated(platycephalus_crescimento$id_peixe)
)

usethis::use_data(platycephalus_crescimento, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
# O D54 antigo (haemulon_crescimento) sai do catálogo: o código passa ao novo conjunto.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
catalogo_dados <- catalogo_dados[catalogo_dados$codigo != "D54", ]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 3)
registrar_catalogo(file.path(pasta, "metadados.json"))
