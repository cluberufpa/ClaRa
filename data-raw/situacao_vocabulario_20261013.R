# Executar na raiz da ClaRa. Decisão do professor (13/10/2026): o campo situacao do
# catálogo passa a ter vocabulário fixo, "provisório", "revisado" ou "sintético de
# treino". O que vinha escrito depois do termo (limites de delineamento, pendências)
# vai para a coluna nova limites, sem perder nada.
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
k <- e$catalogo_dados
antigo <- enc2utf8(k$situacao)

sinteticos <- c("D11", "D36", "D37")
revisados  <- grepl("^(revisado|curado|Curadoria aprovada|Pronto para explora)", antigo)
termo <- ifelse(k$codigo %in% sinteticos, "sintético de treino",
                ifelse(revisados, "revisado", "provisório"))

# O resto do texto: tira o termo antigo e o separador (";" ou ":").
termos_antigos <- c("sintético de treino", "revisado em 13/10/2026", "revisado",
                    "curado com limites", "curado", "Curadoria aprovada",
                    "Pronto para exploração didática", "Pronto para exploração com limites",
                    "Pronto para exploração", "Provisório para curadoria", "provisório")
resto <- antigo
for (t in termos_antigos) {
  comeca <- startsWith(resto, t) & resto == antigo
  resto[comeca] <- substring(resto[comeca], nchar(t) + 1)
}
resto <- trimws(sub("^[[:space:]]*[:;]", "", resto))
# No D12 o "com limites" do termo antigo já se explica pelo texto que segue.
# A obra de Ivo e Fonteles Filho dispensa termo de consentimento (professor, 13/10/2026).
resto <- sub(";? ?termos de redistribuição da obra a confirmar", "", resto)
resto[k$codigo == "D01"] <- paste0(resto[k$codigo == "D01"],
  "; termos do livro de Bhujel (2011) em consulta ao autor")
resto[k$codigo == "D11"] <- "defeitos de propósito; não usar para inferência"
resto[k$codigo %in% c("D36", "D37")] <- "não usar para inferência"
resto[k$codigo == "D28"] <- "fonte e licença conferidas em 13/10/2026; o depósito não diz qual sítio é o kelp cultivado"

k$situacao <- iconv(termo, "UTF-8", "latin1")
k$limites  <- iconv(resto, "UTF-8", "latin1")
stopifnot(!anyNA(k$situacao), !anyNA(k$limites),
          all(enc2utf8(k$situacao) %in% c("provisório", "revisado", "sintético de treino")))
# limites fica logo depois de situacao.
ordem <- append(setdiff(names(k), "limites"), "limites", after = match("situacao", names(k)))
catalogo_dados <- k[ordem]
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 3)

# Os metadados de cada registro acompanham o catálogo.
esc <- function(v) gsub('"', '\\\\"', enc2utf8(v))
for (i in seq_len(nrow(catalogo_dados))) {
  arq <- file.path("data-raw", catalogo_dados$registro[i], "metadados.json")
  if (!file.exists(arq)) next
  txt <- readLines(arq, encoding = "UTF-8", warn = FALSE)
  txt <- txt[!grepl('^[[:space:]]*"limites":', txt)]
  s <- grep('^[[:space:]]*"situacao":', txt)
  stopifnot(length(s) == 1)
  fim <- if (grepl(",[[:space:]]*$", txt[s])) "," else ""
  novo <- c(sprintf('  "situacao": "%s",', esc(catalogo_dados$situacao[i])),
            sprintf('  "limites": "%s"%s', esc(catalogo_dados$limites[i]), fim))
  txt <- append(txt[-s], novo, after = s - 1)
  con <- file(arq, "wb"); writeLines(enc2utf8(txt), con, useBytes = TRUE); close(con)
  j <- jsonlite::fromJSON(arq)
  stopifnot(identical(j$situacao, enc2utf8(catalogo_dados$situacao[i])),
            identical(j$limites, enc2utf8(catalogo_dados$limites[i])))
}
print(table(enc2utf8(catalogo_dados$situacao)))
for (i in seq_len(nrow(catalogo_dados))) cat(catalogo_dados$codigo[i], enc2utf8(catalogo_dados$situacao[i]), "|", enc2utf8(catalogo_dados$limites[i]), "\n")
