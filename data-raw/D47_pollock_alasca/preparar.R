# Executar na raiz do pacote. A consulta NOAA congelada fica intacta em fonte/.
pasta <- "data-raw/D47_pollock_alasca"
arquivo <- file.path(pasta, "fonte", "noaa_pollock_2023_wgs84.json")
hash <- digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                       algo = "sha256", serialize = FALSE)
stopifnot(identical(hash,
  "4b82a2556a326af27515dcaa95f73deb34403c54bbf672d50c009ea89a257cbc"))
consulta <- jsonlite::fromJSON(arquivo)
stopifnot(is.null(consulta$error), !isTRUE(consulta$exceededTransferLimit),
          consulta$spatialReference$wkid == 4326)
brutos <- consulta$features$attributes
coordenadas <- consulta$features$geometry
stopifnot(nrow(brutos) == 523L, nrow(coordenadas) == 523L,
          !anyDuplicated(brutos$SampleID), all(brutos$Year == 2023L),
          all(brutos$Species == "Gadus chalcogrammus"),
          all(brutos$CommonName == "Walleye pollock"),
          all(brutos$TransformUnit == "cuberoot"),
          max(abs(brutos$Latitude - coordenadas$y)) < 5e-8,
          max(abs(brutos$Longitude - coordenadas$x)) < 5e-8)

# Uma linha por lance para esta espécie e ano, sem agregar pontos ou tirar zeros.
# A geometria foi pedida em WGS84; x é longitude e y é latitude.
# O estrato é um código qualitativo, não uma medida contínua.
pollock_alasca <- data.frame(
  id_lance = brutos$SampleID,
  ano = factor(brutos$Year),
  especie = factor(brutos$Species),
  latitude_graus = coordenadas$y,
  longitude_graus = coordenadas$x,
  profundidade_m = brutos$Depth,
  cpue_kg_ha = brutos$WTCPUE,
  estrato = factor(brutos$Stratum)
)
stopifnot(identical(dim(pollock_alasca), c(523L, 8L)),
          !anyNA(pollock_alasca),
          nrow(unique(pollock_alasca[c("latitude_graus", "longitude_graus")])) == 523L,
          all(pollock_alasca$latitude_graus >= -90 & pollock_alasca$latitude_graus <= 90),
          all(pollock_alasca$longitude_graus >= -180 & pollock_alasca$longitude_graus < 0),
          all(pollock_alasca$profundidade_m > 0),
          all(pollock_alasca$cpue_kg_ha >= 0),
          sum(pollock_alasca$cpue_kg_ha == 0) == 91L,
          nlevels(pollock_alasca$estrato) == 54L)
usethis::use_data(pollock_alasca, overwrite = TRUE, compress = "xz")

# Substituir somente o D47. Os demais registros, inclusive inclusões em curso,
# permanecem idênticos. A receita pode ser repetida depois da substituição.
anterior <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", anterior)
catalogo_dados <- anterior$catalogo_dados
i <- which(catalogo_dados$codigo == "D47")
stopifnot(length(i) == 1L,
          catalogo_dados$nome[i] %in% c("terremotos_fiji", "pollock_alasca"))
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
stopifnot(identical(catalogo_dados[-i, ], anterior$catalogo_dados[-i, ]),
          !anyDuplicated(catalogo_dados$codigo), !anyDuplicated(catalogo_dados$nome))
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
stopifnot(file.info("data/pollock_alasca.rda")$size <= 100000,
          sum(file.info(list.files("data", full.names = TRUE))$size) <= 3e6)
cat("D47 substituído por pollock_alasca:",
    file.info("data/pollock_alasca.rda")$size, "bytes\n")
