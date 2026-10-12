# Executado somente pelos scripts de preparo, na raiz do pacote.
# O JSON de cada conjunto contém uma linha, com o mesmo contrato do D01.
registrar_catalogo <- function(arquivo) {
  novo <- as.data.frame(jsonlite::fromJSON(arquivo), stringsAsFactors = FALSE)
  # Metadados anteriores à leitura externa continuam sendo da própria ClaRa.
  if (!is.element("fonte_dados", names(novo))) novo$fonte_dados <- "clara"
  novo$linhas <- as.integer(novo$linhas)
  novo$colunas <- as.integer(novo$colunas)
  for (coluna in names(novo)[vapply(novo, is.character, logical(1))]) {
    novo[[coluna]] <- iconv(novo[[coluna]], from = "UTF-8", to = "latin1")
    stopifnot(!anyNA(novo[[coluna]]))
  }
  anterior <- new.env(parent = emptyenv())
  load("data/catalogo_dados.rda", envir = anterior)
  catalogo_dados <- anterior$catalogo_dados
  stopifnot(setequal(names(catalogo_dados), names(novo)))
  novo <- novo[names(catalogo_dados)]
  stopifnot(!any(catalogo_dados$codigo == novo$codigo & catalogo_dados$nome != novo$nome))
  catalogo_dados <- rbind(catalogo_dados[catalogo_dados$nome != novo$nome, ], novo)
  catalogo_dados <- catalogo_dados[order(catalogo_dados$codigo), ]
  rownames(catalogo_dados) <- NULL
  stopifnot(!anyDuplicated(catalogo_dados$codigo), !anyDuplicated(catalogo_dados$nome))
  usethis::use_data(catalogo_dados, overwrite = TRUE, compress = "xz")
}
