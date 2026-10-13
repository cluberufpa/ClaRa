# Executar na raiz da ClaRa. D12 substitui bufalos_estrongilos por decisão do professor em 12/10/2026.
pasta <- "data-raw/D12_erva_lesoes"
fonte <- file.path(pasta, "fonte")
for (linha in readLines(file.path(fonte, "SHA256.txt"))) {
  partes <- strsplit(linha, "  ", fixed = TRUE)[[1]]
  arquivo <- file.path(fonte, partes[2])
  bruto <- readBin(arquivo, "raw", n = file.info(arquivo)$size)
  stopifnot(identical(
    digest::digest(bruto, algo = "sha256", serialize = FALSE),
    tolower(partes[1])
  ))
}

brutos <- utils::read.csv(file.path(fonte, "mesocosm.csv"), stringsAsFactors = FALSE)
traduzir_tratamento <- c(
  "Con" = "controle",
  "Clip" = "dano_artificial",
  "Bug" = "isopode_herbivoro"
)

# Cada mesocosmo tinha uma planta central já lesada e três plantas focais limpas.
# A fonte registra a cobertura final de cada focal; no início, a cobertura é zero
# por delineamento. Assim, o par antes/depois é a mesma planta focal.
linhas <- lapply(seq_len(nrow(brutos)), function(i) {
  tratamento <- unname(traduzir_tratamento[brutos$Treatment[i]])
  numero <- as.integer(brutos$Number[i])
  plantas <- seq_len(3L)
  id_planta <- sprintf("planta_%s_%02d_%d", tratamento, numero, plantas)
  depois <- as.numeric(unlist(brutos[i, paste0("AFTER_p", plantas)]))
  rbind(
    data.frame(
      id_planta = id_planta,
      tratamento = tratamento,
      momento = "antes",
      presenca_lesao = 0L,
      cobertura_lesao_pct = 0,
      stringsAsFactors = FALSE
    ),
    data.frame(
      id_planta = id_planta,
      tratamento = tratamento,
      momento = "depois",
      presenca_lesao = as.integer(depois > 0),
      cobertura_lesao_pct = depois,
      stringsAsFactors = FALSE
    )
  )
})

erva_marinha_lesoes <- do.call(rbind, linhas)
erva_marinha_lesoes <- erva_marinha_lesoes[order(
  erva_marinha_lesoes$id_planta,
  match(erva_marinha_lesoes$momento, c("antes", "depois"))
), ]
row.names(erva_marinha_lesoes) <- NULL
erva_marinha_lesoes$tratamento <- factor(
  erva_marinha_lesoes$tratamento,
  levels = c("controle", "dano_artificial", "isopode_herbivoro")
)
erva_marinha_lesoes$momento <- factor(
  erva_marinha_lesoes$momento,
  levels = c("antes", "depois")
)

stopifnot(
  identical(dim(erva_marinha_lesoes), c(180L, 5L)),
  identical(names(erva_marinha_lesoes), c(
    "id_planta", "tratamento", "momento", "presenca_lesao", "cobertura_lesao_pct"
  )),
  length(unique(erva_marinha_lesoes$id_planta)) == 90L,
  all(table(erva_marinha_lesoes$id_planta) == 2L),
  identical(levels(erva_marinha_lesoes$tratamento), c(
    "controle", "dano_artificial", "isopode_herbivoro"
  )),
  identical(levels(erva_marinha_lesoes$momento), c("antes", "depois")),
  all(erva_marinha_lesoes$presenca_lesao[erva_marinha_lesoes$momento == "antes"] == 0L),
  sum(erva_marinha_lesoes$presenca_lesao[erva_marinha_lesoes$momento == "depois"]) == 69L,
  all(erva_marinha_lesoes$cobertura_lesao_pct[erva_marinha_lesoes$momento == "antes"] == 0),
  all(erva_marinha_lesoes$presenca_lesao == as.integer(erva_marinha_lesoes$cobertura_lesao_pct > 0))
)

save(erva_marinha_lesoes, file = "data/erva_marinha_lesoes.rda", compress = "xz", version = 2)
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
i <- which(catalogo_dados$codigo == "D12")
novo <- as.data.frame(jsonlite::fromJSON(file.path(pasta, "metadados.json")), stringsAsFactors = FALSE)
novo$linhas <- as.integer(novo$linhas)
novo$colunas <- as.integer(novo$colunas)
for (n in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[n]] <- iconv(novo[[n]], from = "UTF-8", to = "latin1")
}
stopifnot(
  length(i) == 1L,
  catalogo_dados$nome[i] %in% c("bacterias_tratamento", "bufalos_estrongilos", "erva_marinha_lesoes"),
  setequal(names(novo), names(catalogo_dados))
)
catalogo_dados[i, ] <- novo[names(catalogo_dados)]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
