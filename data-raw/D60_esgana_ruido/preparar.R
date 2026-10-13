# Executar na raiz da ClaRa (precisa do readxl e do digest, só aqui no preparo).
# D60 substitui os quadrados latinos de animais terrestres (vacas_fistuladas, depois
# suinos_castracao e o exercício gatos_cardiacos) por decisão do professor em 13/10/2026:
# um quadrado latino 4 x 4 com peixes, repetido em 144 indivíduos.
pasta <- "data-raw/D60_esgana_ruido"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  stopifnot(identical(
    digest::digest(file.path(fonte, partes[2]), algo = "sha256", file = TRUE),
    tolower(partes[1])
  ))
}

# Arquivo original do Dryad: uma linha por peixe focal e nível de ruído (576 linhas).
b <- utils::read.delim(file.path(fonte, "final_statistics.txt"), stringsAsFactors = FALSE)
stopifnot(identical(dim(b), c(576L, 22L)), !anyNA(b[c("fishID", "noise", "dist", "pxpermm")]))
b$sequencia <- toupper(gsub("'", "", b$playback.order, fixed = TRUE))

# O arquivo não traz o período; ele vem da ordem de cada sequência na Tabela A1 do artigo
# (códigos de ruído: 0 = estático, 1 = lento, 4 = médio, 6 = rápido).
ordem <- list(A = c(1, 4, 6, 0), B = c(6, 0, 1, 4), C = c(0, 6, 4, 1), D = c(4, 1, 0, 6))
b$periodo <- mapply(function(s, r) match(r, ordem[[s]]), b$sequencia, b$noise)
# As linhas originais de cada peixe já estão na ordem de exibição: a reconstrução confere.
stopifnot(!anyNA(b$periodo),
          all(tapply(b$periodo, b$fishID, function(p) identical(as.numeric(p), c(1, 2, 3, 4)))))

rotulos <- c("0" = "estático", "1" = "lento", "4" = "médio", "6" = "rápido")
esgana_gata_ruido <- data.frame(
  id_peixe                  = sprintf("P%03d", b$fishID),
  sequencia                 = factor(b$sequencia, levels = c("A", "B", "C", "D")),
  periodo                   = factor(b$periodo, levels = 1:4),
  ruido_visual              = factor(rotulos[as.character(b$noise)], levels = unname(rotulos)),
  distancia_cardume_mm      = b$dist / b$pxpermm,
  tamanho_peixe_mm          = b$size,
  velocidade_mm_s           = b$mm.speed,
  preferencia_cardume_maior = b$pref.score,
  ensaio                    = as.integer(sub("Trial_", "", b$trial, fixed = TRUE)),
  cardume_maior_n           = as.integer(b$lrgshoal),
  cardume_menor_n           = as.integer(b$smlshoal),
  stringsAsFactors = FALSE
)
esgana_gata_ruido <- esgana_gata_ruido[order(esgana_gata_ruido$id_peixe, esgana_gata_ruido$periodo), ]
row.names(esgana_gata_ruido) <- NULL

# Conferências: cada peixe recebe os quatro ruídos; sequência x período forma um quadrado
# latino 4 x 4 (cada ruído uma vez em cada linha e em cada coluna), com 36 peixes por
# sequência; os valores batem com a planilha arrumada entregue pelo professor.
x <- esgana_gata_ruido
celula <- unique(x[c("sequencia", "periodo", "ruido_visual")])
um <- function(a, b) all(table(a, b) == 1L)
stopifnot(
  identical(dim(x), c(576L, 11L)), !anyNA(x),
  length(unique(x$id_peixe)) == 144L, all(table(x$id_peixe) == 4L),
  all(table(x$id_peixe, x$ruido_visual) == 1L),
  all(table(unique(x[c("id_peixe", "sequencia")])$sequencia) == 36L),
  nrow(celula) == 16L,
  um(celula$ruido_visual, celula$sequencia), um(celula$ruido_visual, celula$periodo)
)
p <- as.data.frame(readxl::read_excel(file.path(fonte, "ruido_visual_quadrado_latino_4x4.xlsx"),
                                      sheet = "Dados"))
p <- p[order(p$peixe_id, p$periodo), ]
stopifnot(
  identical(as.integer(p$peixe_id), as.integer(sub("P", "", x$id_peixe))),
  identical(as.character(p$sequencia), as.character(x$sequencia)),
  identical(as.integer(p$periodo), as.integer(as.character(x$periodo))),
  isTRUE(all.equal(p$distancia_cardume_mm, x$distancia_cardume_mm)),
  isTRUE(all.equal(p$tamanho_peixe_mm, x$tamanho_peixe_mm))
)

save(esgana_gata_ruido, file = "data/esgana_gata_ruido.rda", compress = "xz", version = 2)

e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
catalogo_dados <- e$catalogo_dados
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
# O D63 (gatos, exercício complementar) sai junto: o D60 tem dados de sobra para exercícios.
catalogo_dados <- catalogo_dados[catalogo_dados$codigo != "D63", ]
i <- which(catalogo_dados$codigo == "D60")
stopifnot(length(i) == 1L, setequal(names(novo), names(catalogo_dados)))
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
row.names(catalogo_dados) <- NULL
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
