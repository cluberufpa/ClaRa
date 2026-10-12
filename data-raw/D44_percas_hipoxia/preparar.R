# Executar na raiz do pacote. Substituição autorizada em 12/10/2026.
pasta <- "data-raw/D44_percas_hipoxia"
codigo <- "D44"
nome <- "percas_hipoxia"
anterior <- "plantas_absorcao_co2"
arquivo <- file.path(pasta, "fonte", "perca_fonte.xlsx")
stopifnot(identical(digest::digest(readBin(arquivo, "raw", n = file.info(arquivo)$size),
                                  algo = "md5", serialize = FALSE),
                    "09ba220844c4c8ddd36d2a5c4d8fa1b6"))
brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "Hyp. Prot. - RMR"))
# readxl remove espaços nas pontas dos cabeçalhos; os valores ficam intactos.
stopifnot(identical(dim(brutos), c(449L, 4L)))
percas_hipoxia <- data.frame(
  id_peixe = as.character(brutos$ID),
  grupo = factor(brutos[["Treatment Group"]],
    levels = c("Baltic", "Biotest", "Balt@Bio"),
    labels = c("Referência a 18 °C", "Aquecimento crônico a 23 °C",
               "Aquecimento agudo a 23 °C")),
  saturacao_ar_pct = brutos[["Air saturation level"]],
  consumo_o2_mg_kg_h = brutos[["Resting metabolic rate"]]
)
levels(percas_hipoxia$grupo) <- iconv(levels(percas_hipoxia$grupo),
                                     from = "UTF-8", to = "latin1")
# Mantemos os 23 NA e as três linhas a 100%, todas sem resposta.
stopifnot(length(unique(percas_hipoxia$id_peixe)) == 40L,
          sum(is.na(percas_hipoxia$consumo_o2_mg_kg_h)) == 23L,
          !anyNA(percas_hipoxia[1:3]),
          !anyDuplicated(percas_hipoxia[c("id_peixe", "saturacao_ar_pct")]),
          sum(percas_hipoxia$saturacao_ar_pct == 100) == 3L,
          all(is.na(percas_hipoxia$consumo_o2_mg_kg_h[
            percas_hipoxia$saturacao_ar_pct == 100])))

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

