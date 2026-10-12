# Executar na raiz da ClaRa. D52 substitui paciente_peso por decisão do professor em 12/10/2026.
pasta <- "data-raw/D52_secagem_vegetais"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  bruto <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(digest::digest(bruto, algo = "sha256", serialize = FALSE), partes[1]))
}
brutos <- readxl::read_excel(file.path(fonte, "beterraba_gengibre_fonte.xlsx"), sheet = "Planilha1")
secagem_beterraba_gengibre <- data.frame(
  serie = interaction(brutos$product, brutos$treatment, brutos$temp, brutos$rep, drop = TRUE),
  id_amostra = as.character(brutos$ID), produto_codigo = factor(brutos$product),
  tratamento_codigo = factor(brutos$treatment), temperatura_c = as.numeric(brutos$temp),
  repeticao = as.integer(brutos$rep), tempo_origem = round(as.numeric(brutos$time), 3),
  razao_umidade = as.numeric(brutos$mr)
)
stopifnot(identical(dim(secagem_beterraba_gengibre), c(594L, 8L)),
  identical(names(secagem_beterraba_gengibre), c("serie", "id_amostra", "produto_codigo", "tratamento_codigo", "temperatura_c", "repeticao", "tempo_origem", "razao_umidade")),
  nlevels(secagem_beterraba_gengibre$serie) == 36L,
  identical(levels(secagem_beterraba_gengibre$produto_codigo), c("B", "G")),
  identical(levels(secagem_beterraba_gengibre$tratamento_codigo), c("C", "E")),
  identical(sort(unique(secagem_beterraba_gengibre$temperatura_c)), c(60, 70, 80)),
  !anyNA(secagem_beterraba_gengibre$razao_umidade), all(secagem_beterraba_gengibre$razao_umidade > 0))
save(secagem_beterraba_gengibre, file = "data/secagem_beterraba_gengibre.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv()); load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados; i <- which(catalogo_dados$codigo == "D52")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas); novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
stopifnot(length(i) == 1L, catalogo_dados$nome[i] %in% c("paciente_peso", "secagem_beterraba_gengibre"),
          setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
