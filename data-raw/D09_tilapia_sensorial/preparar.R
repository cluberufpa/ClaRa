# Executar na raiz da ClaRa; fonte organizada já existente, preservada.
pasta <- "data-raw/D09_tilapia_sensorial"
arquivo <- file.path(pasta, "fonte", "tilapia_sensorial_organizada.xlsx")
hash <- strsplit(readLines(file.path(pasta, "fonte", "SHA256.txt")), "  ", fixed = TRUE)[[1]][1]
bytes <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
stopifnot(identical(digest::digest(bytes, algo = "sha256", serialize = FALSE), hash))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "sensorial"))
stopifnot(identical(dim(brutos), c(122L, 7L)), !anyNA(brutos), !anyDuplicated(brutos$id_avaliador))
tilapia_sensorial <- brutos
# Identificador como texto, sem mudar valores nem ordem dos avaliadores.
tilapia_sensorial$id_avaliador <- as.character(brutos$id_avaliador)
for (coluna in names(brutos)[-1]) {
  stopifnot(all(brutos[[coluna]] %in% -3:3))
  tilapia_sensorial[[coluna]] <- as.integer(brutos[[coluna]])
  stopifnot(identical(as.double(tilapia_sensorial[[coluna]]), brutos[[coluna]]))
}
# Medir antes de incorporar; um arquivo acima de 100 KB exige decisão do professor.
medicao <- tempfile(fileext = ".rda")
save(tilapia_sensorial, file = medicao, compress = "xz")
stopifnot(file.info(medicao)$size <= 100000L)
stopifnot(identical(dim(tilapia_sensorial), c(122L, 7L)))
usethis::use_data(tilapia_sensorial, overwrite = TRUE, compress = "xz")
source("data-raw/registrar_catalogo.R")
registrar_catalogo(file.path(pasta, "metadados.json"))
print(tools::checkRdaFiles("data"))
