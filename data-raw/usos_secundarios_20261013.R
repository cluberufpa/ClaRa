# Executar na raiz da ClaRa. Decisão do professor (13/10/2026): destacar, nos
# conjuntos que os cobrem, os usos secundários que dispensam buscar dados novos
# (Kruskal-Wallis, t pareado, qui-quadrado de aderência, regressão logística e
# ANCOVA), e tirar do D38 a ANCOVA, que lá trataria peixes do mesmo tanque como
# réplicas. Atualiza catálogo, metadados, fichas e ajudas.
usos <- list(
  D03 = list(analises = "Séries temporais; Kruskal-Wallis e Dunn (CPUE por embarcação); Estatística descritiva",
             verbo = "comparar_medianas",
             texto = paste("Kruskal-Wallis: `comparar_medianas(cpue_tubarao, cpue, embarcacao)` compara a CPUE",
                           "das três embarcações. Os registros de uma embarcação ao longo dos anos não são",
                           "independentes; leia o valor de p como aproximado.")),
  D62 = list(analises = paste("Regressão de Poisson com offset; Binomial negativa com offset; Exploração de CPUE;",
                              "Kruskal-Wallis (larvas por local)"),
             verbo = "comparar_medianas",
             texto = paste("Kruskal-Wallis: `comparar_medianas(larvas_peixes_captura, numero_larvas, local)`",
                           "compara os três locais. O esforço varia entre eventos: para comparar taxas, crie",
                           "antes `numero_larvas / esforco_h` e compare essa coluna.")),
  D41 = list(analises = paste("Planejamento fatorial; Crescimento relativo; ANOVA de dois fatores candidata;",
                              "Kruskal-Wallis (crescimento por tratamento); Teste t pareado (comprimento inicial e final)"),
             verbo = "comparar_medianas",
             texto = paste("Kruskal-Wallis: `comparar_medianas(mesocosmos_secagem, crescimento_absoluto_cm,",
                           "tratamento)` compara os quatro tratamentos. Teste t pareado: cada linha é um peixe",
                           "(um por tanque) com comprimento padrão inicial e final;",
                           "`t.test(comprimento_padrao_final_cm, comprimento_padrao_inicial_cm, paired = TRUE)`",
                           "dá p < 0,001.")),
  D28 = list(analises = paste("Qui-quadrado de independência; Qui-quadrado de aderência (razão sexual 1:1);",
                              "Proporções; Teste t (comprimento por sexo)"),
             verbo = NULL,
             texto = paste("Qui-quadrado de aderência: a razão sexual esperada é 1:1, e há 663 fêmeas e 794",
                           "machos; `chisq.test(table(lagostas_kelp_sexo$sexo))` dá p = 0,0006.")),
  D55 = list(analises = "Maturidade; Regressão logística (maturidade x comprimento); Crescimento; von Bertalanffy",
             verbo = NULL,
             texto = paste("Regressão logística: crie `madura` (1 para madura, 0 para imatura; deixe de fora as",
                           "três desconhecidas) e ajuste `glm(madura ~ comprimento_total_cm, family = binomial)`;",
                           "o comprimento de primeira maturação (L50) é `-a / b`.")),
  D50 = list(analises = paste("Modelos de contagem; Binomial negativa; Sobredispersão; Kruskal-Wallis;",
                              "Regressão logística (infecção x comprimento); Prevalência"),
             verbo = NULL,
             texto = paste("Regressão logística: `glm(infectado_01 ~ comprimento_padrao_cm, family = binomial)`",
                           "relaciona a chance de infecção ao tamanho do peixe; há comprimentos ausentes.")),
  D15 = list(analises = paste("Regressão de potência; Exploração por espécie;",
                              "ANCOVA (log do peso x log do comprimento, por espécie)"),
             verbo = NULL,
             texto = paste("ANCOVA: com `log(peso_g)` e `log(comprimento_padrao_mm)`, o modelo",
                           "`lm(log_peso ~ log_comp * especie)` testa se as espécies têm a mesma inclinação",
                           "(alometria) e, sem interação, o mesmo intercepto. Cada linha é um peixe.")),
  D16 = list(analises = paste("Teste t; ANOVA de dois fatores; Estatística descritiva; Regressão linear;",
                              "ANCOVA (comprimento x largura da carapaça, por sexo ou local)"),
             verbo = NULL,
             texto = paste("ANCOVA: `lm(comprimento_carapaca ~ largura_carapaca * sexo)` (ou `* local`) testa se",
                           "machos e fêmeas têm a mesma relação entre as medidas da carapaça. Cada linha é um",
                           "caranguejo.")),
  D38 = list(analises = paste("Pseudorreplicação: médias por tanque; Fatorial 2 x 2 (temperatura x ração) no tanque;",
                              "Estatística descritiva"),
             principal = "Pseudorreplicação: agregar os peixes por tanque",
             verbo = NULL,
             texto = paste("Os 69 peixes estão em sete tanques, e temperatura e ração foram aplicadas ao tanque:",
                           "a unidade experimental é o tanque. Compare as médias dos tanques, não os peixes. O",
                           "fatorial 2 x 2 é desbalanceado (22 °C com ração alta tem um só tanque). A ANCOVA",
                           "foi tirada daqui; para ela, use D15 ou D16."))
)

e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", envir = e)
k <- e$catalogo_dados
la <- function(x) iconv(x, "UTF-8", "latin1")
esc <- function(v) gsub('"', '\\\\"', enc2utf8(v))
for (cd in names(usos)) {
  u <- usos[[cd]]
  i <- which(k$codigo == cd)
  k$analises[i] <- la(u$analises)
  if (!is.null(u$principal)) k$analise_principal[i] <- la(u$principal)
  if (!is.null(u$verbo)) k$verbo_clara[i] <- u$verbo
  # Metadados do registro.
  pasta <- file.path("data-raw", k$registro[i])
  arq <- file.path(pasta, "metadados.json")
  txt <- readLines(arq, encoding = "UTF-8", warn = FALSE)
  for (campo in c("analises", "analise_principal", "verbo_clara")) {
    l <- grep(sprintf('^[[:space:]]*"%s":', campo), txt)
    fim <- if (grepl(",[[:space:]]*$", txt[l])) "," else ""
    txt[l] <- sprintf('  "%s": "%s"%s', campo, esc(k[[campo]][i]), fim)
  }
  con <- file(arq, "wb"); writeLines(enc2utf8(txt), con, useBytes = TRUE); close(con)
  stopifnot(identical(jsonlite::fromJSON(arq)$analises, u$analises))
  # Ficha.
  ficha <- file.path(pasta, "FICHA.md")
  f <- readLines(ficha, encoding = "UTF-8", warn = FALSE)
  if (!any(f == "## Usos secundários (13/10/2026)")) {
    f <- c(f, "", "## Usos secundários (13/10/2026)", "", u$texto)
    con <- file(ficha, "wb"); writeLines(enc2utf8(f), con, useBytes = TRUE); close(con)
  }
  # Ajuda: uma seção logo antes dos exemplos (ou do nome do objeto).
  ajuda <- file.path("R", paste0("dados_", k$nome[i], ".R"))
  r <- readLines(ajuda, encoding = "UTF-8", warn = FALSE)
  if (!any(grepl("@section Usos secundários", r, fixed = TRUE))) {
    alvo <- grep("^#' @examples", r)[1]
    if (is.na(alvo)) alvo <- grep('^"', r)[1]
    linhas <- strwrap(u$texto, width = 78, prefix = "#' ")
    r <- append(r, c("#' @section Usos secundários:", linhas, "#'"), after = alvo - 1)
    con <- file(ajuda, "wb"); writeLines(enc2utf8(r), con, useBytes = TRUE); close(con)
  }
}
catalogo_dados <- k
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 3)
