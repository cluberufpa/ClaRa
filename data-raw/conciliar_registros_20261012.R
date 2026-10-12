# Correção pontual da colisão entre duas inclusões em checkouts diferentes.
# Executar na raiz da ClaRa-dados. Pode ser repetida sem duplicar registros.
ambiente_catalogo <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", ambiente_catalogo)
catalogo_dados <- ambiente_catalogo$catalogo_dados
catalogo_antes <- catalogo_dados
indice_larvas <- which(catalogo_dados$nome == "larvas_peixes_captura")
stopifnot(length(indice_larvas) == 1L,
          catalogo_dados$codigo[indice_larvas] %in% c("D61", "D62"),
          !any(catalogo_dados$codigo == "D62" &
                 catalogo_dados$nome != "larvas_peixes_captura"))

# Só muda o identificador do registro; valores e demais metadados permanecem.
catalogo_dados$codigo[indice_larvas] <- "D62"
catalogo_dados$registro[indice_larvas] <- "D62_larvas_captura"
catalogo_dados$titulo[indice_larvas] <- sub("^D61", "D62",
                                         catalogo_dados$titulo[indice_larvas])
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)

# O helper impede que uma inclusão use código já atribuído a outro conjunto.
source("data-raw/registrar_catalogo.R")
registrar_catalogo("data-raw/D61_anchova_norte/metadados.json")
load("data/catalogo_dados.rda", ambiente_catalogo)
catalogo_depois <- ambiente_catalogo$catalogo_dados
outros_antes <- catalogo_antes[!catalogo_antes$nome %in%
                              c("larvas_peixes_captura", "anchova_norte_california"), ]
outros_depois <- catalogo_depois[!catalogo_depois$nome %in%
                                c("larvas_peixes_captura", "anchova_norte_california"), ]
rownames(outros_antes) <- rownames(outros_depois) <- NULL
stopifnot(identical(outros_antes, outros_depois),
          nrow(catalogo_depois) == 62L,
          !anyDuplicated(catalogo_depois$codigo),
          !anyDuplicated(catalogo_depois$nome),
          catalogo_depois$nome[catalogo_depois$codigo == "D61"] == "anchova_norte_california",
          catalogo_depois$nome[catalogo_depois$codigo == "D62"] == "larvas_peixes_captura")
cat("Catálogo conciliado: D61 anchova; D62 larvas; 62 conjuntos.\n")
