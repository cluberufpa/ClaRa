# Executar na raiz da ClaRa. A fonte completa inclui também o substrato.
pasta <- "data-raw/D10_enobieta_baci"
arquivo <- file.path(pasta, "fonte", "enobieta_baci_organizado.xlsx")
hash <- strsplit(readLines(file.path(pasta, "fonte", "SHA256.txt")), "  ", fixed = TRUE)[[1]][1]
bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), hash))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "macroinvertebrados"))
enobieta_baci <- brutos
# Nomes, ordem, categorias e valores da planilha organizada preservados.
stopifnot(identical(enobieta_baci, brutos), identical(dim(enobieta_baci), c(135L, 94L)))
stopifnot(!anyDuplicated(enobieta_baci$amostra_id), sum(enobieta_baci$baci_elegivel) == 120L)
taxons <- grep("^n_", names(enobieta_baci), value = TRUE)
stopifnot(length(taxons) == 78L, !anyNA(enobieta_baci[taxons]))
stopifnot(all(as.matrix(enobieta_baci[taxons]) >= 0),
          all(rowSums(enobieta_baci[taxons] > 0) == enobieta_baci$riqueza_taxons),
          isTRUE(all.equal(rowSums(enobieta_baci[taxons]) / enobieta_baci$area_surber_m2,
                           enobieta_baci$densidade_ind_m2)))
medicao <- tempfile(fileext = ".rda")
save(enobieta_baci, file = medicao, compress = "xz")
stopifnot(file.info(medicao)$size <= 100000L)
usethis::use_data(enobieta_baci, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
