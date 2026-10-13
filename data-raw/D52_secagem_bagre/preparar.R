# Executar na raiz da ClaRa (precisa do digest, só aqui no preparo).
# D52 volta a ter um conjunto em 13/10/2026, por decisão do professor: a curva de secagem
# de bagre-africano a 80 °C de Ohijeagbon et al. (2018) ocupa o lugar de
# secagem_beterraba_gengibre (vegetais), retirado no mesmo dia.
pasta <- "data-raw/D52_secagem_bagre"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  stopifnot(identical(
    digest::digest(file.path(fonte, partes[2]), algo = "sha256", file = TRUE),
    tolower(partes[1])
  ))
}

# Transcrição literal das colunas de 80 °C das Tabelas 1 e 2 do artigo: dez pesagens
# do mesmo lote de peixes, de hora em hora.
b <- utils::read.csv(file.path(fonte, "secagem_bagre_80c_fonte.csv"))
stopifnot(identical(dim(b), c(10L, 6L)))

secagem_bagre <- data.frame(
  tempo_min             = as.integer(b$tempo_min),
  massa_peixe_kg        = b$massa_peixe_kg,
  temperatura_secador_c = b$temperatura_secador_c,
  gas_consumido_kg      = b$massa_gas_kg,
  energia_mj            = b$energia_utilizada_mj,
  umidade_publicada     = b$umidade_publicada_kg_agua_por_kg_peixe_seco
)

# Conferências com o artigo: tempos de 0 a 540 min, massa sempre caindo, de 8,53 a
# 2,03 kg; só o gás do tempo 0 é vazio (não há intervalo antes da primeira pesagem).
stopifnot(
  identical(secagem_bagre$tempo_min, seq(0L, 540L, by = 60L)),
  all(diff(secagem_bagre$massa_peixe_kg) < 0),
  identical(secagem_bagre$massa_peixe_kg[c(1, 10)], c(8.53, 2.03)),
  identical(which(is.na(secagem_bagre)), 31L),
  all(abs(secagem_bagre$temperatura_secador_c - 80) < 3)
)

save(secagem_bagre, file = "data/secagem_bagre.rda", compress = "xz", version = 2)

# O D52 estava vago: a linha entra no catálogo, que segue em ordem de código.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(setequal(names(novo), names(catalogo_dados)))
catalogo_dados <- catalogo_dados[catalogo_dados$codigo != "D52", ]
catalogo_dados <- rbind(catalogo_dados, novo[names(catalogo_dados)])
catalogo_dados <- catalogo_dados[order(catalogo_dados$codigo), ]
row.names(catalogo_dados) <- NULL
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
