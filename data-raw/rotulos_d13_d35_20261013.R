# Executar na raiz da ClaRa, depois de situacao_vocabulario_20261013.R.
# Decisões do professor em 13/10/2026: duas colunas novas, que deixam os grupos
# prontos para comparar_medias(), sem mexer em nenhuma coluna da fonte.
#
# D13 artemia_fitoesterois: os nomes químicos dos esteróis têm hífen, vírgula,
# parênteses e espaços (`24-methylenecholesterol`), e a ClaRa recusa grupos com
# hífen, porque ele atrapalha as letras das comparações. `esterol_rotulo` repete o
# nome com esses sinais trocados por "_"; `esterol` continua como na fonte.
#
# D35 tilapia_microalgas: são cinco dietas (controle e duas microalgas em 25 % e
# 50 % de substituição da farinha de peixe), com três aquários cada, conforme o
# artigo de dados (Amira et al. 2021, Data in Brief 38:107422: 270 alevinos, 18 por
# aquário). `tratamento_codigo` tem um nível por aquário (CR1, N25R2...); a coluna
# `dieta` junta tipo de microalga e nível.
e <- new.env(parent = emptyenv())
load("data/artemia_fitoesterois.rda", envir = e)
load("data/tilapia_microalgas.rda", envir = e)
load("data/catalogo_dados.rda", envir = e)

# --- D13 -------------------------------------------------------------------
a <- e$artemia_fitoesterois
stopifnot(!"esterol_rotulo" %in% names(a))
rotulo <- trimws(as.character(a$esterol))
rotulo <- gsub("[^A-Za-z0-9]+", "_", rotulo)
rotulo <- gsub("^_|_$", "", rotulo)
# Um rótulo por esterol, e nenhum esterol com dois rótulos.
stopifnot(identical(nrow(unique(data.frame(as.character(a$esterol), rotulo))),
                    length(unique(rotulo))),
          !any(grepl("-", rotulo)))
a <- data.frame(a[c("experimento", "esterol")],
                esterol_rotulo = factor(rotulo, levels = unique(rotulo[order(a$esterol)])),
                a[c("biomassa_mg", "massa_individual_ug")])
artemia_fitoesterois <- a

# --- D35 -------------------------------------------------------------------
t <- e$tilapia_microalgas
stopifnot(!"dieta" %in% names(t))
dieta <- ifelse(t$tipo_microalga == "controle", "controle",
                paste0(t$tipo_microalga, "_", t$nivel_substituicao_pct))
niveis <- c("controle", "nannochloropsis_25", "nannochloropsis_50",
            "tetraselmis_25", "tetraselmis_50")
stopifnot(all(dieta %in% niveis),
          identical(as.vector(table(factor(dieta, niveis))), rep(3L, 5)),
          identical(sub("R[0-9]$", "", as.character(t$tratamento_codigo)),
                    c("C", "C", "C", rep(c("N25", "N50", "T25", "T50"), each = 3))))
pos <- match("tratamento_codigo", names(t))
t <- data.frame(t[seq_len(pos)], dieta = factor(dieta, levels = niveis),
                t[(pos + 1):ncol(t)])
tilapia_microalgas <- t

save(artemia_fitoesterois, file = "data/artemia_fitoesterois.rda", compress = "xz", version = 2)
save(tilapia_microalgas, file = "data/tilapia_microalgas.rda", compress = "xz", version = 2)

# --- Catálogo e metadados ---------------------------------------------------
k <- e$catalogo_dados
la <- function(x) iconv(x, "UTF-8", "latin1")
k$colunas[k$codigo == "D13"] <- ncol(artemia_fitoesterois)
k$colunas[k$codigo == "D35"] <- ncol(tilapia_microalgas)
k$verbo_clara[k$codigo %in% c("D13", "D35")] <- "comparar_medias"
k$limites[k$codigo == "D13"] <- la(paste(
  "quatro experimentos independentes: comparar esteróis dentro de cada um;",
  "use esterol_rotulo nos grupos da ClaRa"))
k$limites[k$codigo == "D35"] <- la(paste(
  "15 aquários, três por dieta; a unidade é o aquário, não o peixe;",
  "o controle é comum às duas microalgas"))
catalogo_dados <- k
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 3)

esc <- function(v) gsub('"', '\\\\"', enc2utf8(v))
for (cd in c("D13", "D35")) {
  i <- which(k$codigo == cd)
  arq <- file.path("data-raw", k$registro[i], "metadados.json")
  txt <- readLines(arq, encoding = "UTF-8", warn = FALSE)
  troca <- function(campo, valor, numero = FALSE) {
    l <- grep(sprintf('^[[:space:]]*"%s":', campo), txt)
    fim <- if (grepl(",[[:space:]]*$", txt[l])) "," else ""
    txt[l] <<- if (numero) sprintf('  "%s": %s%s', campo, valor, fim)
                else sprintf('  "%s": "%s"%s', campo, esc(valor), fim)
  }
  troca("colunas", k$colunas[i], numero = TRUE)
  troca("verbo_clara", k$verbo_clara[i])
  troca("limites", k$limites[i])
  con <- file(arq, "wb"); writeLines(enc2utf8(txt), con, useBytes = TRUE); close(con)
  j <- jsonlite::fromJSON(arq)
  stopifnot(j$colunas == k$colunas[i], identical(j$limites, enc2utf8(k$limites[i])))
}
