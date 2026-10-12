# =============================================================================
#  ClaRa: o motor
# =============================================================================
#
#  A ajuda() e as peças internas que todas as funções usam: conferir as
#  colunas, preencher a receita, mostrá-la e rodá-la, as paletas de cores
#  e a escrita dos números. O aluno não precisa abrir este arquivo.
# =============================================================================


# Ajuda ------------------------------------------------------------------------

# ajuda() ----------------------------------------------------------------------
#' Que funções a ClaRa tem, e como usar cada uma?
#'
#' Sem nome de função, lista todas as funções da ClaRa, agrupadas pela
#' pergunta da pesquisa que respondem. Com o nome de uma função, abre a
#' página de ajuda dela no painel Help do RStudio: a pergunta, o que faz, os
#' argumentos, o que devolve e exemplos. É o mesmo que `?comparar_medias`.
#'
#' @param funcao o nome da função, com ou sem aspas
#' @param onde "painel" (padrão: a lista no painel Viewer e a página da
#'   função no painel Help do RStudio) ou "console"
#'
#' @return Sem nome de função, os nomes de todas as funções da ClaRa; com
#'   ele, o nome pedido. Os dois sem imprimir.
#'
#' @examples
#' if (interactive()) {
#'   ajuda()
#'   ajuda(comparar_medias)
#' }
#'
#' @concept Ajuda
#' @export
ajuda <- function(funcao,
                  onde = c("painel", "console")) {

  # Onde mostrar: nos painéis do RStudio (padrão) ou no console.
  onde <- escolher_opcao(onde, c("painel", "console"), "onde")

  # As funções do aluno, lidas das páginas de ajuda do pacote.
  funcoes <- funcoes_da_clara()

  # Sem nome de função, mostramos a lista de todas, agrupadas pela seção
  # onde moram, com a pergunta de cada uma.
  if (missing(funcao)) {
    mostrar_lista("Funções da ClaRa", listar_funcoes(funcoes), onde)
    return(invisible(funcoes$funcao))
  }

  # O nome que o aluno pediu, escrito com ou sem aspas.
  nome <- rlang::as_name(rlang::ensym(funcao))

  # Se não for uma função da ClaRa, dizemos quais existem.
  if (!is.element(nome, funcoes$funcao)) {
    stop("Não há ajuda da ClaRa para ", nome, ". As funções da ClaRa são: ",
         toString(funcoes$funcao), ".", call. = FALSE)
  }

  # A página da função: no painel Help ou, no console, como texto.
  tipo <- if (onde == "console") "text" else getOption("help_type", "html")
  print(utils::help(nome, package = "clara", help_type = tipo))

  invisible(nome)
}

# As funções do aluno: nome, pergunta (o título da página de ajuda) e seção
# (o @concept). Lê as páginas do pacote instalado; com devtools::load_all(),
# lê os arquivos de man/.
funcoes_da_clara <- function() {
  paginas <- tryCatch(tools::Rd_db("clara"), error = function(e) list())
  if (!length(paginas)) {
    arquivos <- list.files(system.file("man", package = "clara"), "[.]Rd$",
                           full.names = TRUE)
    paginas  <- lapply(arquivos, tools::parse_Rd)
  }
  campo <- function(pagina, marca) {
    marcas <- vapply(pagina, function(parte) attr(parte, "Rd_tag"), character(1))
    partes <- pagina[marcas == marca]
    if (!length(partes)) return("")
    trimws(gsub("\\s+", " ", paste(unlist(partes[[1]]), collapse = "")))
  }
  funcoes <- data.frame(
    funcao   = vapply(paginas, campo, character(1), marca = "\\name"),
    pergunta = vapply(paginas, campo, character(1), marca = "\\title"),
    secao    = vapply(paginas, campo, character(1), marca = "\\concept")
  )
  # Só as páginas com seção são de funções do aluno (a do pacote não tem).
  funcoes <- funcoes[nzchar(funcoes$secao), ]
  # A ordem de estudo: as funções de ordem_da_ajuda primeiro, na ordem dela;
  # uma função nova, que ainda não esteja lá, entra no fim, e a seção dela
  # (uma pergunta nova) aparece antes de "Para qualquer análise".
  posicao <- match(funcoes$funcao, ordem_da_ajuda, nomatch = length(ordem_da_ajuda) + 1)
  finais  <- c("Para qualquer análise", "Formatar e exibir", "Ajuda")
  ordem   <- order(match(funcoes$secao, finais, nomatch = 0),
                   tapply(posicao, funcoes$secao, min)[funcoes$secao],
                   posicao, funcoes$funcao)
  funcoes <- funcoes[ordem, ]
  rownames(funcoes) <- NULL
  funcoes
}

# As funções na ordem em que se estudam, para a lista da ajuda().
ordem_da_ajuda <- c(
  "comparar_medias", "grafico_medias", "grafico_boxplot", "grafico_pares",
  "comparar_medianas", "grafico_medianas",
  "relacionar_variaveis", "grafico_reta",
  "carregar_dados",
  "medir_efeito", "escrever_resultados", "exibir_teste", "exibir_resumo",
  "grafico_residuos", "grafico_qq",
  "salvar_tabelas", "salvar_figuras", "registrar_ambiente",
  "formatar_numero", "formatar_p", "exibir_tabela",
  "ajuda"
)

# Lista as funções da ClaRa, cada uma com a pergunta que responde, agrupadas
# pela seção onde moram (como "Comparar médias"). Devolve as linhas do texto.
listar_funcoes <- function(funcoes) {
  nomes   <- paste0(funcoes$funcao, "()")
  largura <- max(nchar(nomes))

  # Um bloco por seção: o nome da seção e as suas funções, alinhadas.
  blocos <- lapply(unique(funcoes$secao), function(secao) {
    escolhidas <- funcoes$secao == secao
    c("", paste0(secao, ":"),
      paste0("  ", formatC(nomes[escolhidas], width = -largura), "  ",
             funcoes$pergunta[escolhidas]))
  })
  c(unlist(blocos), "", "Para saber mais sobre uma delas: ajuda(comparar_medias)")
}

# Mostra a lista de funções: no RStudio, como página no painel Viewer; fora
# dele (ou com onde = "console"), como texto no console.
mostrar_lista <- function(titulo, linhas, onde) {
  visualizador <- getOption("viewer")
  if (onde == "painel" && is.function(visualizador)) {
    pagina <- tempfile("ajuda_clara_", fileext = ".html")
    writeLines(enc2utf8(pagina_de_ajuda(titulo, linhas)), pagina, useBytes = TRUE)
    visualizador(pagina)
    cat("A lista das funções abriu no painel Viewer. ",
        "Para vê-la aqui: ajuda(onde = \"console\").\n", sep = "")
  } else {
    cat("\n", titulo, "\n", strrep("=", nchar(titulo)), "\n", sep = "")
    cat(linhas, sep = "\n")
    cat("\n")
  }
}

# Monta a página HTML da lista, com as cores da ClaRa. O texto vai num bloco
# de largura fixa, para manter alinhadas as funções e as perguntas.
pagina_de_ajuda <- function(titulo, linhas) {
  escapar <- function(x) gsub(">", "&gt;", gsub("<", "&lt;", gsub("&", "&amp;", x, fixed = TRUE), fixed = TRUE), fixed = TRUE)
  corpo <- escapar(linhas)
  # Nomes das seções (Comparar médias:, Ajuda: ...) em negrito.
  corpo <- sub("^([A-ZÁÉÍÓÚ][A-Za-zçãõáéíóú ]*:)", "<b>\\1</b>", corpo)
  c("<!DOCTYPE html>",
    "<html lang=\"pt-BR\"><head><meta charset=\"utf-8\">",
    paste0("<title>", escapar(titulo), "</title>"),
    "<style>",
    "body { font-family: Arial, sans-serif; margin: 16px; color: #1d2b36; }",
    "h1 { color: #0F3B5F; font-size: 20px; border-bottom: 2px solid #62B6B7; padding-bottom: 4px; }",
    "pre { font-family: Consolas, 'Courier New', monospace; font-size: 13px; line-height: 1.45; white-space: pre-wrap; }",
    "b { color: #2E7D8F; }",
    "</style></head><body>",
    paste0("<h1>", escapar(titulo), "</h1>"),
    "<pre>", corpo, "</pre>",
    "</body></html>")
}

# A versão da ClaRa instalada, que registrar_ambiente() grava.
versao_da_clara <- function() {
  as.character(utils::packageVersion("clara"))
}

# Motor das receitas -----------------------------------------------------------
#
# Peças internas usadas pelas funções acima: conferir colunas, descobrir
# nomes, preencher a receita, mostrá-la e rodá-la.

# Confere, antes da análise, se as colunas existem e servem para comparar.
conferir_colunas <- function(dados, coluna_resposta, coluna_grupos) {
  colunas_que_faltam <- setdiff(c(coluna_resposta, coluna_grupos), names(dados))
  nomes_com_simbolos <- make.names(c(coluna_resposta, coluna_grupos)) !=
    c(coluna_resposta, coluna_grupos)
  grupos_com_resposta <- as.character(
    dados[[coluna_grupos]][!is.na(dados[[coluna_resposta]])]
  )

  problema <- dplyr::case_when(
    length(colunas_que_faltam) > 0 ~
      paste("Coluna não encontrada nos dados:", toString(colunas_que_faltam)),
    any(nomes_com_simbolos) ~
      "Use nomes de coluna sem espaços nem símbolos, como peso_g. Renomeie com rename().",
    !is.numeric(dados[[coluna_resposta]]) ~
      "A resposta precisa ser numérica. Confira o tipo da coluna no preparo.",
    any(grepl("-", dados[[coluna_grupos]], fixed = TRUE)) ~
      "Há hífen no nome de um grupo; ele atrapalha as letras das comparações. Renomeie os grupos.",
    dplyr::n_distinct(dados[[coluna_grupos]], na.rm = TRUE) < 2 ~
      "A comparação precisa de pelo menos dois grupos com dados.",
    any(table(grupos_com_resposta) < 3) ~
      "Cada grupo precisa de pelo menos 3 observações com resposta.",
    .default = "nenhum"
  )

  if (problema != "nenhum") stop(problema, call. = FALSE)
}

# Confere, antes da regressão, se as duas colunas existem e servem para a reta.
conferir_colunas_reta <- function(dados, coluna_resposta, coluna_preditor) {
  colunas_que_faltam <- setdiff(c(coluna_resposta, coluna_preditor), names(dados))
  nomes_com_simbolos <- make.names(c(coluna_resposta, coluna_preditor)) !=
    c(coluna_resposta, coluna_preditor)
  completas <- !is.na(dados[[coluna_resposta]]) & !is.na(dados[[coluna_preditor]])

  problema <- dplyr::case_when(
    length(colunas_que_faltam) > 0 ~
      paste("Coluna não encontrada nos dados:", toString(colunas_que_faltam)),
    any(nomes_com_simbolos) ~
      "Use nomes de coluna sem espaços nem símbolos, como peso_g. Renomeie com rename().",
    coluna_resposta == coluna_preditor ~
      "A resposta e o preditor precisam ser colunas diferentes.",
    !is.numeric(dados[[coluna_resposta]]) ~
      "A resposta precisa ser numérica. Confira o tipo da coluna no preparo.",
    !is.numeric(dados[[coluna_preditor]]) ~
      "O preditor precisa ser numérico. Para comparar grupos, use comparar_medias().",
    sum(completas) < 3 ~
      "A reta precisa de pelo menos 3 observações com resposta e preditor.",
    dplyr::n_distinct(dados[[coluna_preditor]][completas]) < 2 ~
      "O preditor tem um valor só; sem variação nele, não há reta para ajustar.",
    .default = "nenhum"
  )

  if (problema != "nenhum") stop(problema, call. = FALSE)
}

# Confere se o resultado veio da análise que a função sabe desenhar.
conferir_resultado <- function(resultado, classe, mensagem) {
  if (!inherits(resultado, classe)) stop(mensagem, call. = FALSE)
}

# Escolhe, numa lista de receitas, a da análise que o resultado guarda. Sem
# receita para ela, explica ao aluno, em vez de deixar o R falhar adiante.
escolher_receita <- function(receitas, resultado, nome_funcao) {
  receita <- receitas[[ou_entao(resultado$nomes$analise, "")]]
  if (is.null(receita)) {
    stop(nome_funcao, "() não se aplica a este resultado. ",
         dplyr::case_when(
           is.element(nome_funcao, c("grafico_residuos", "grafico_qq")) ~
             paste("Os resíduos conferem os pressupostos das médias (ANOVA e teste t)",
                   "e da regressão; para olhar as observações de cada grupo, use grafico_boxplot()."),
           .default = "Ela serve aos resultados de comparar_medias(), comparar_medianas() e relacionar_variaveis()."
         ), call. = FALSE)
  }
  receita
}

# Confere se um argumento de sim ou não recebeu TRUE ou FALSE.
conferir_sim_ou_nao <- function(valor, nome_argumento) {
  if (!isTRUE(valor) && !isFALSE(valor)) {
    stop(nome_argumento, " aceita só TRUE ou FALSE.", call. = FALSE)
  }
}

# Confere se um rótulo recebeu um texto só (ou nada, para usar o nome da coluna).
conferir_rotulo <- function(valor, nome_argumento) {
  if (!is.null(valor) && (!is.character(valor) || length(valor) != 1)) {
    stop(nome_argumento, " aceita um texto entre aspas, como \"Peso (g)\".",
         call. = FALSE)
  }
}

# Devolve a opção escolhida num argumento de escolha. O padrão do argumento
# lista todas as opções (assim o Tab do RStudio as mostra); se o aluno não
# escolheu, vale a primeira. Uma opção que não existe vira mensagem amigável.
escolher_opcao <- function(valor, opcoes, nome_argumento) {
  if (identical(valor, opcoes)) return(opcoes[1])
  if (!is.character(valor) || length(valor) != 1 || !is.element(valor, opcoes)) {
    stop(nome_argumento, " aceita só: ",
         paste0("\"", opcoes, "\"", collapse = " ou "), ".", call. = FALSE)
  }
  valor
}

# A hipótese alternativa em português (como o aluno escreve) e no R (como o
# t.test() e o wilcox.test() a recebem).
alternativas_r <- list(bilateral = "two.sided", maior = "greater", menor = "less")

# Devolve a hipótese alternativa escolhida. A unilateral só existe com dois
# grupos; com três ou mais, o teste é sempre bilateral, e a mensagem diz
# qual teste roda em cada caso (dois = "teste t", varios = "a ANOVA").
escolher_alternativa <- function(alternativa, quantos_grupos, dois, varios) {
  alternativa <- escolher_opcao(alternativa, names(alternativas_r), "alternativa")
  if (quantos_grupos > 2 && alternativa != "bilateral") {
    stop("alternativa = \"", alternativa, "\" só existe com dois grupos (", dois, "). ",
         "Com ", quantos_grupos, " grupos, ", varios, " é sempre bilateral: ",
         "use alternativa = \"bilateral\".", call. = FALSE)
  }
  alternativa
}

# Confere se um argumento recebeu uma fração: um número maior que 0 e até 1.
conferir_fracao <- function(valor, nome_argumento) {
  if (!is.numeric(valor) || length(valor) != 1 || valor <= 0 || valor > 1) {
    stop(nome_argumento, " aceita um número maior que 0 e até 1, como 0.3 ou 0.6.",
         call. = FALSE)
  }
}

# Transforma a escolha de cores num vetor: o nome de uma paleta da ClaRa
# ("ocean", "cinza") ou um vetor de cores que o R reconheça.
escolher_cores <- function(cores) {
  e_paleta  <- is.character(cores) && length(cores) == 1 &&
    is.element(cores, names(paletas_clara))
  sao_cores <- is.character(cores) &&
    !inherits(try(grDevices::col2rgb(cores), silent = TRUE), "try-error")
  if (!e_paleta && !sao_cores) {
    stop("cores aceita \"ocean\", \"cinza\" ou um vetor de cores, ",
         "como c(\"darkgreen\", \"orange\").", call. = FALSE)
  }
  if (e_paleta) paletas_clara[[cores]] else cores
}

# Descobre o nome do objeto que o aluno passou (plantas, resultado...).
# Se ele passou uma expressão longa, usamos um nome padrão.
nome_do_objeto <- function(expressao, padrao) {
  if (is.symbol(expressao)) deparse(expressao) else padrao
}

# Junta o que o aluno pediu para salvar, em salvar_tabelas() e
# salvar_figuras(). Cada item leva o nome do seu arquivo: o nome escrito
# (anova = resultado$anova) ou, sem ele, o nome do próprio objeto (base).
# Devolve os nomes e o código de cada item como o aluno o escreveu; o
# conferir() diz se o valor é do tipo certo (tabela ou gráfico).
itens_para_salvar <- function(itens, o_que, exemplo, conferir) {
  if (!length(itens)) {
    stop("Diga o que salvar, com o nome do arquivo antes do =, por exemplo: ",
         exemplo, ".", call. = FALSE)
  }
  nomes   <- rlang::names2(itens)
  codigos <- vapply(itens, rlang::quo_text, character(1), USE.NAMES = FALSE)
  for (i in seq_along(itens)) {
    if (nzchar(nomes[i])) next
    expressao <- rlang::quo_get_expr(itens[[i]])
    if (!is.symbol(expressao)) {
      stop("Dê um nome a ", codigos[i], ": ele vira o nome do arquivo, ",
           "como em nome = ", codigos[i], ".", call. = FALSE)
    }
    nomes[i] <- as.character(expressao)
  }
  ruins <- nomes[!grepl("^[A-Za-z0-9_-]+$", nomes)]
  if (length(ruins)) {
    stop("Os nomes viram nomes de arquivo: use só letras sem acento, números ",
         "e _. Troque: ", toString(ruins), ".", call. = FALSE)
  }
  if (anyDuplicated(nomes)) {
    stop("Dois itens com o mesmo nome: ", toString(unique(nomes[duplicated(nomes)])),
         ". Cada arquivo precisa de um nome só dele.", call. = FALSE)
  }
  for (i in seq_along(itens)) {
    if (!conferir(rlang::eval_tidy(itens[[i]]))) {
      stop(codigos[i], " não é ", o_que, ".", call. = FALSE)
    }
  }
  list(nomes = nomes, codigos = codigos)
}

# Confere se a pasta recebeu um caminho só, entre aspas ou com here().
conferir_pasta <- function(pasta) {
  if (!is.character(pasta) || length(pasta) != 1 || !nzchar(pasta)) {
    stop("pasta aceita um caminho só, como here(\"saida\", \"tabelas\").",
         call. = FALSE)
  }
}

# Troca cada marcador <<NOME>> da receita pelo valor correspondente. Um
# valor vazio (NULL) fica de fora: a análise não usa aquele marcador.
preencher_receita <- function(receita, valores) {
  for (marcador in names(Filter(Negate(is.null), valores))) {
    receita <- gsub(paste0("<<", marcador, ">>"), trimws(valores[[marcador]]),
                    receita, fixed = TRUE)
  }
  trimws(receita)
}

# Imprime a receita com uma moldura, para o aluno copiar para o script. Os
# library() dos pacotes vêm no topo: numa sessão nova, a receita copiada
# precisa deles para rodar.
mostrar_receita <- function(receita, pacotes = character()) {
  cat("\n# ---- Código R por trás da ClaRa: copie, cole e rode ----------\n\n")
  if (length(pacotes)) cat(paste0("library(", pacotes, ")"), "", sep = "\n")
  cat(receita, "\n")
  cat("\n# --------------------------------------------------------------\n\n")
}

# Roda a receita num espaço próprio, onde os objetos têm os nomes do aluno.
# Assim, o código mostrado e o código executado são o mesmo texto. Quando a
# receita repete o código que o aluno escreveu (resultado$resumo), ela roda
# a partir do lugar de onde a função foi chamada, para achar os objetos dele.
# Os pacotes da receita não são carregados com library(): ela os enxerga por
# um ambiente próprio, e o caminho de busca do aluno não muda. A semente
# aleatória do aluno é guardada e devolvida, mesmo que a receita use
# set.seed().
executar_receita <- function(receita, objetos, pacotes, mostrar_codigo,
                             ambiente_do_aluno = globalenv()) {
  if (mostrar_codigo) mostrar_receita(receita, pacotes)
  ambiente <- list2env(objetos, parent = ambiente_com_pacotes(pacotes, ambiente_do_aluno))
  withr::with_preserve_seed(
    eval(parse(text = receita, keep.source = FALSE), envir = ambiente)
  )
}

# Um ambiente que enxerga as funções exportadas dos pacotes, como se tivessem
# sido carregados com library(), na mesma ordem (o último esconde os
# anteriores), e, depois deles, o ambiente do aluno.
ambiente_com_pacotes <- function(pacotes, ambiente_do_aluno) {
  ambiente <- ambiente_do_aluno
  for (pacote in pacotes) {
    espaco    <- asNamespace(pacote)
    nomes     <- getNamespaceExports(pacote)
    proprios  <- nomes[vapply(nomes, exists, logical(1), envir = espaco, inherits = FALSE)]
    # As reexportadas (como o tibble() do dplyr) moram nas importações do pacote.
    importados <- parent.env(espaco)
    alheios   <- setdiff(nomes, proprios)
    alheios   <- alheios[vapply(alheios, exists, logical(1), envir = importados, inherits = FALSE)]
    ambiente <- new.env(parent = ambiente)
    importIntoEnv(ambiente, proprios, espaco, proprios)
    list2env(mget(alheios, envir = importados), envir = ambiente)
  }
  ambiente
}

# Devolve o valor informado ou, se ele estiver vazio (NULL), a alternativa.
ou_entao <- function(valor, alternativa) {
  if (is.null(valor)) alternativa else valor
}

# Os números e os p-valores do console usam formatar_numero() e formatar_p()
# (clara_formatar.R), as mesmas funções que o aluno usa.


# Cores dos gráficos -----------------------------------------------------------

# As paletas que o aluno escolhe pelo nome: a Ocean Gradient (oito cores) e
# uma em cinza, para revistas impressas em preto e branco.
paletas_clara <- list(
  ocean = c("#0F3B5F", "#2E7D8F", "#62B6B7", "#E89B3C",
            "#E76F51", "#6A4C93", "#1B998B", "#B23A48"),
  cinza = c("grey25", "grey70")
)

# Escreve um vetor de cores como código R, quatro por linha.
escrever_vetor <- function(valores) {
  textos <- paste0("\"", valores, "\"")
  linhas <- split(textos, ceiling(seq_along(textos) / 4))
  paste0("c(", paste(vapply(linhas, paste, character(1), collapse = ", "),
                     collapse = ",\n           "), ")")
}

# O trecho de cores que abre as receitas de gráfico. Com mais grupos que
# cores, colorRampPalette() cria cores intermediárias. Fica dentro da receita
# para o código mostrado rodar sozinho, sem a ClaRa.
trecho_de_cores <- function(vetor) {
  paste0("
# Cores: uma para cada grupo (intermediárias, se houver mais grupos que cores).
cores <- ", escrever_vetor(vetor), "
cores <- colorRampPalette(cores)(max(length(cores), nlevels(<<RESULTADO>>$dados$<<GRUPOS>>)))")
}

# O trecho com a paleta Ocean, usado pelos gráficos de diagnóstico.
trecho_cores <- trecho_de_cores(paletas_clara$ocean)
