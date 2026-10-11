# Catálogo da migração: rode na raiz do pacote, após preparar os bagres.
# Este arquivo registra apenas metadados; nunca recalcula os dados.
novo <- data.frame(
  codigo = "D-001",
  nome = "bagre_racao_isoproteica",
  rotulo = "Bagres: rações isoproteicas",
  titulo = "D-001 · Peso médio final de bagres por ração isoproteica",
  natureza = "real",
  origem = "EAPADados::isoproteica_bagre",
  unidade_amostral = "gaiola; peso médio final dos peixes, conforme documentação de origem",
  linhas = 19L,
  colunas = 2L,
  analises = "ANOVA de um fator; Kruskal–Wallis e Dunn; Estatística descritiva; Boxplot",
  analise_principal = "ANOVA de um fator",
  palavras_chave = "bagre; racao; dieta; proteina; aquicultura; gaiola; peso; Welch; Tukey",
  verbo_clara = "comparar_medias; comparar_medianas",
  licenca = "Não localizada; autorização dos autores pendente",
  referencia = "Bhujel, R. C. (2011). Statistics for Aquaculture. Tabela 7.4, p. 103; conforme documentação do EAPADados",
  situacao = "Curadoria aprovada; autorização da fonte pendente",
  stringsAsFactors = FALSE
)

# O texto conserva acentos, com a codificação declarada em cada string.
# Latin-1 comporta o português; substituímos apenas o travessão tipográfico
# no rótulo de Kruskal-Wallis para não exigir UTF-8 nos dados serializados.
novo$analises <- sub("Kruskal–Wallis", "Kruskal-Wallis", novo$analises, fixed = TRUE)
novo$titulo <- sub(" · ", " - ", novo$titulo, fixed = TRUE)
for (coluna in names(novo)[vapply(novo, is.character, logical(1))]) {
  novo[[coluna]] <- iconv(novo[[coluna]], from = "UTF-8", to = "latin1")
  stopifnot(!anyNA(novo[[coluna]]))
}

# Ao acrescentar outro conjunto, preservamos os registros anteriores.
catalogo_dados <- novo
if (file.exists("data/catalogo_dados.rda")) {
  anterior <- new.env(parent = emptyenv())
  load("data/catalogo_dados.rda", envir = anterior)
  outros <- anterior$catalogo_dados
  stopifnot(identical(names(outros), names(novo)))
  stopifnot(!any(outros$codigo == novo$codigo & outros$nome != novo$nome))
  catalogo_dados <- rbind(outros[outros$nome != novo$nome, , drop = FALSE], novo)
}
rownames(catalogo_dados) <- NULL
stopifnot(!anyDuplicated(catalogo_dados$codigo), !anyDuplicated(catalogo_dados$nome))
usethis::use_data(catalogo_dados, overwrite = TRUE, compress = "xz")
