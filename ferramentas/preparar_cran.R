# =============================================================================
#  Preparar a ClaRa para o CRAN: acentos dos textos viram escapes \u
# -----------------------------------------------------------------------------
#  Por que existe: o CRAN só aceita caracteres ASCII no código dos pacotes
#  (o aviso "checking code files for non-ASCII characters"). Os textos da
#  ClaRa estão em português, com acentos, e o professor prefere editá-los
#  assim (decisão J, 9/10/2026). Então os acentos ficam no repositório, e
#  este script faz a troca só na hora de mandar ao CRAN.
#
#  O que faz, sem tocar no repositório:
#    1. copia o pacote para uma pasta temporária;
#    2. nos arquivos de R/, troca cada letra acentuada DENTRO DE TEXTOS
#       ("Comparação" vira "Compara\u00e7\u00e3o"); comentários
#       ficam como estão, porque o CRAN aceita acento neles;
#    3. o R não lê um texto com escapes maior que 10 mil caracteres, e as
#       receitas passam disso: esses textos viram paste0() de pedaços;
#    4. confere que o R lê o código novo como lia o antigo;
#    5. roda R CMD build e deixa o .tar.gz na pasta acima da ClaRa (como o
#       devtools::build()), e, se pedido, o R CMD check --as-cran.
#
#  Como usar, na raiz da ClaRa:
#    Rscript ferramentas/preparar_cran.R            # só gera o .tar.gz
#    Rscript ferramentas/preparar_cran.R --check    # gera e roda o check
#
#  Para o aluno nada muda: a tela e o Word mostram os mesmos acentos, porque
#  "\u00e7" e "ç" são o mesmo texto para o R.
# =============================================================================

raiz <- normalizePath(".", winslash = "/")
if (!file.exists(file.path(raiz, "DESCRIPTION")) ||
    read.dcf(file.path(raiz, "DESCRIPTION"), "Package")[1, 1] != "clara") {
  stop("Rode este script na raiz da ClaRa (a pasta com o DESCRIPTION).")
}
rodar_check <- "--check" %in% commandArgs(trailingOnly = TRUE)

tem_acento <- function(x) grepl("[^\\x01-\\x7f]", x, perl = TRUE)

# Uma letra fora do ASCII vira o seu código: ç vira \u00e7. Acima de
# FFFF (emojis, por exemplo) o R pede a forma com chaves.
escapar <- function(texto) {
  letras <- strsplit(texto, "")[[1]]
  codigos <- utf8ToInt(texto)
  fora <- codigos > 127
  letras[fora] <- ifelse(
    codigos[fora] > 0xFFFF,
    sprintf("\\U{%X}", codigos[fora]),
    sprintf("\\u%04x", codigos[fora])
  )
  paste(letras, collapse = "")
}

# Um texto com escapes maior que o limite vira paste0() de pedaços, cortados
# no fim das linhas. Cada pedaço termina com o "\n" escrito com barra, para
# o texto final continuar o mesmo, quebra de linha por quebra de linha.
fatiar <- function(token, limite = 8000) {
  if (nchar(token) <= limite) return(token)
  aspa <- substr(token, 1, 1)
  linhas <- strsplit(substr(token, 2, nchar(token) - 1), "\n", fixed = TRUE)[[1]]
  pedacos <- character()
  atual <- character()
  for (l in linhas) {
    if (sum(nchar(atual)) + nchar(l) > limite && length(atual) > 0) {
      pedacos <- c(pedacos, paste(atual, collapse = "\n"))
      atual <- character()
    }
    atual <- c(atual, l)
  }
  pedacos <- c(pedacos, paste(atual, collapse = "\n"))
  ultimo <- length(pedacos)
  pedacos[-ultimo] <- paste0(pedacos[-ultimo], "\\n")
  paste0("paste0(", paste0(aspa, pedacos, aspa, collapse = ",\n"), ")")
}

# Troca os acentos só nos textos (tokens STR_CONST) de um arquivo. Anda de
# trás para a frente, para as posições dos textos de cima não mudarem.
escapar_arquivo <- function(linhas, nome) {
  pd <- utils::getParseData(parse(text = linhas, keep.source = TRUE))

  # Acento fora de texto e de comentário (num nome de objeto, por exemplo)
  # não tem escape possível: o script para e mostra onde está.
  estranhos <- pd[pd$terminal & !pd$token %in% c("STR_CONST", "COMMENT") &
                    tem_acento(pd$text), ]
  if (nrow(estranhos) > 0) {
    stop(sprintf("%s, linha %d: acento fora de texto e de comentário (%s).",
                 nome, estranhos$line1[1], estranhos$text[1]))
  }

  textos <- pd[pd$token == "STR_CONST", ]
  textos <- textos[order(-textos$line1, -textos$col1), ]
  for (i in seq_len(nrow(textos))) {
    t <- textos[i, ]
    bloco <- paste(linhas[t$line1:t$line2], collapse = "\n")
    # posição do fim do texto dentro do bloco (colunas contam letras)
    fim <- nchar(bloco) - nchar(linhas[t$line2]) + t$col2
    token <- substr(bloco, t$col1, fim)
    if (!tem_acento(token)) next
    novo <- paste0(substr(bloco, 1, t$col1 - 1), fatiar(escapar(token)),
                   substr(bloco, fim + 1, nchar(bloco)))
    linhas <- c(linhas[seq_len(t$line1 - 1)],
                strsplit(novo, "\n", fixed = TRUE)[[1]],
                linhas[-seq_len(t$line2)])
  }
  linhas
}

# Mesmo código para o R? Compara as expressões lidas, sem as posições. Antes,
# junta os paste0() só de textos num texto só, dos dois lados, para que o
# fatiamento não conte como diferença.
mesmo_codigo <- function(antes, depois) {
  juntar <- function(e) {
    if (is.call(e)) {
      e[] <- lapply(as.list(e), function(x) if (missing(x)) x else juntar(x))
      argumentos <- as.list(e)[-1]
      if (identical(e[[1]], as.name("paste0")) && length(argumentos) > 0 &&
          is.null(names(argumentos)) && all(vapply(argumentos, is.character, TRUE))) {
        return(do.call(paste0, argumentos))
      }
    }
    e
  }
  ler <- function(x) vapply(parse(text = x, keep.source = FALSE),
                            function(e) paste(deparse(juntar(e)), collapse = "\n"), "")
  identical(ler(antes), ler(depois))
}

# 1. Cópia do pacote, sem o histórico do git nem os arquivos do RStudio.
destino <- file.path(tempfile("clara_cran_"), "clara")
dir.create(destino, recursive = TRUE)
itens <- setdiff(list.files(raiz, all.files = TRUE, no.. = TRUE),
                 c(".git", ".Rproj.user", ".claude"))
invisible(file.copy(file.path(raiz, itens), destino, recursive = TRUE))

# 2 a 4. Escapes nos arquivos de R/, com a conferência.
cat("Trocando os acentos dos textos em R/:\n")
for (arquivo in list.files(file.path(destino, "R"), "\\.[Rr]$", full.names = TRUE)) {
  antes <- readLines(arquivo, encoding = "UTF-8", warn = FALSE)
  depois <- escapar_arquivo(antes, basename(arquivo))
  if (!mesmo_codigo(antes, depois)) {
    stop(basename(arquivo), ": o código com escapes não é igual ao original. Nada foi gerado.")
  }
  pd <- utils::getParseData(parse(text = depois, keep.source = TRUE))
  restam <- sum(pd$token == "STR_CONST" & tem_acento(pd$text))
  if (restam > 0) stop(basename(arquivo), ": ainda há textos com acento.")
  writeLines(depois, arquivo, useBytes = TRUE)
  cat(sprintf("  %-28s %4d linhas antes, %4d depois\n", basename(arquivo),
              length(antes), length(depois)))
}

# 5. Build da cópia; o .tar.gz fica na pasta acima da ClaRa.
r_cmd <- file.path(R.home("bin"), "R")
saida <- dirname(raiz)
pasta_antiga <- setwd(saida)
status <- system2(r_cmd, c("CMD", "build", "--no-manual", shQuote(destino)))
setwd(pasta_antiga)
versao <- read.dcf(file.path(raiz, "DESCRIPTION"), "Version")[1, 1]
tarball <- file.path(saida, sprintf("clara_%s.tar.gz", versao))
if (status != 0 || !file.exists(tarball)) stop("O R CMD build falhou.")
cat("\nPronto:", tarball, "(com escapes; o repositório não mudou)\n")

if (rodar_check) {
  cat("\nRodando R CMD check --as-cran...\n")
  # A pasta clara.Rcheck vai para a pasta temporária do Windows (fica lá
  # depois do fim, com o 00check.log), longe do ecossistema. O manual em PDF
  # fica de fora: ele pede LaTeX com a fonte inconsolata, que o CRAN tem e
  # esta máquina não precisa ter.
  pasta_check <- dirname(tempdir())
  system2(r_cmd, c("CMD", "check", "--as-cran", "--no-manual",
                   paste0("--output=", shQuote(pasta_check)), shQuote(tarball)))
  cat("\nRelatório do check:", file.path(pasta_check, "clara.Rcheck", "00check.log"), "\n")
}
