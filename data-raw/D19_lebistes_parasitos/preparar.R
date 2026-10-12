# Executar na raiz do pacote. Substituição autorizada em 12/10/2026.
# A fonte (xlsx do professor, arrumado a partir do Dryad) fica intacta em fonte/.
pasta <- "data-raw/D19_lebistes_parasitos"
codigo <- "D19"
nome <- "lebistes_parasitos"
anterior <- "camaroes_sexo"
arquivo <- file.path(pasta, "fonte", "peixes_parasitismo_individuos_tidy.xlsx")
hash <- digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                       algo = "sha256", serialize = FALSE)
stopifnot(identical(hash,
  "2ea92f6bf9b0de8f4f64ce0beac320ed4f1fee53df467c001f739bc4df848347"))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "dados_brutos_tidy"))
stopifnot(identical(dim(brutos), c(4715L, 17L)),
          setequal(brutos$classe_sexo, c("Fêmea", "Macho", "Juvenil")),
          setequal(brutos$trecho_rio,
                   c("Alto curso", "Médio curso", "Baixo curso", "Lago")),
          all(brutos$contagem_parasitos == floor(brutos$contagem_parasitos)),
          all(brutos$presenca_parasito %in% 0:1))

# Todas as linhas e a ordem da fonte. Uma linha é um lebiste; a fonte não traz
# identificador do peixe, então linhas iguais (juvenis de mesmo peso) não são
# duplicatas verificáveis e não passam por distinct(). Os NA do peso ficam.
lebistes_parasitos <- data.frame(
  bacia = brutos$bacia,
  rio = brutos$rio,
  trecho_rio = factor(brutos$trecho_rio,
    levels = c("Alto curso", "Médio curso", "Baixo curso", "Lago")),
  sitio = as.integer(brutos$sitio_id),
  ano = as.integer(brutos$ano),
  sexo = factor(brutos$classe_sexo, levels = c("Fêmea", "Macho", "Juvenil"),
    labels = c("fêmea", "macho", "juvenil")),
  peso_g = brutos$peso_g,
  contagem_parasitos = as.integer(brutos$contagem_parasitos),
  presenca_parasito = as.integer(brutos$presenca_parasito)
)
# Convenção do catálogo: acentos declarados em Latin-1 nos dados binários.
for (v in c("trecho_rio", "sexo")) {
  levels(lebistes_parasitos[[v]]) <- iconv(levels(lebistes_parasitos[[v]]),
                                           from = "UTF-8", to = "latin1")
}
stopifnot(identical(dim(lebistes_parasitos), c(4715L, 9L)),
          identical(as.integer(table(lebistes_parasitos$sexo)),
                    c(1951L, 1520L, 1244L)),
          sum(is.na(lebistes_parasitos$peso_g)) == 113L,
          sum(is.na(lebistes_parasitos[-7])) == 0L,
          sum(lebistes_parasitos$presenca_parasito) == 1400L,
          # Na fonte a presença vem do Gyrodactylus na lista de espécies de
          # parasitos, não da contagem: 3 peixes têm presença 1 e contagem 0.
          sum(lebistes_parasitos$presenca_parasito == 1L &
              lebistes_parasitos$contagem_parasitos == 0L) == 3L,
          sum(lebistes_parasitos$presenca_parasito == 0L &
              lebistes_parasitos$contagem_parasitos > 0L) == 0L)

destino <- paste0("data/", nome, ".rda")
save(list = nome, file = destino, compress = "xz", version = 2)
# A substituição mantém o código e todos os demais registros do catálogo.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == codigo)
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c(anterior, nome))
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
stopifnot(!anyDuplicated(catalogo_dados$codigo), !anyDuplicated(catalogo_dados$nome))
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
stopifnot(file.info(destino)$size <= 100000,
          sum(file.info(list.files("data", full.names = TRUE))$size) <= 3e6)
