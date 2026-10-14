test_that("D12 garoupa reproduz as tabelas 2 x 2 publicadas de PCR e histologia", {
  x <- garoupa_pcr_histologia
  expect_identical(dim(x), c(123L, 4L))
  expect_identical(names(x), c("id_peixe", "replica", "histologia", "pcr"))
  expect_type(x$id_peixe, "character")
  expect_false(anyNA(x))
  expect_false(anyDuplicated(x$id_peixe) > 0L)
  expect_identical(levels(x$replica), c("1", "2"))
  expect_identical(levels(x$pcr), c("negativo", "positivo"))
  expect_identical(as.integer(table(x$replica)), c(74L, 49L))
  tab <- function(r) {
    y <- x[x$replica == r, ]
    table(y$histologia, y$pcr)
  }
  # Tabela 32 (réplica 1): histologia nas linhas, PCR nas colunas, negativo primeiro.
  expect_equal(as.integer(tab("1")), c(4L, 2L, 50L, 18L))
  # Tabela 34 (réplica 2).
  expect_equal(as.integer(tab("2")), c(3L, 3L, 28L, 15L))
  m1 <- mcnemar.test(tab("1"))
  expect_equal(unname(m1$statistic), 42.48077, tolerance = 1e-6)
  expect_equal(m1$p.value, 7.138e-11, tolerance = 1e-3)
  expect_lt(mcnemar.test(tab("2"))$p.value, 1e-4)
})

test_that("D11 treino_biometria conserva os defeitos do exercício de preparo", {
  x <- treino_biometria
  expect_identical(dim(x), c(71L, 10L))
  expect_type(x$id, "character")
  expect_identical(sum(is.na(x$comprimento_cm)), 5L)
  expect_identical(sum(is.na(x$peso_g)), 6L)
  expect_identical(sum(duplicated(x)), 3L)
  expect_true(" Braganca " %in% x$local)
  expect_true("Pescada  Amarela" %in% x$especie)
  expect_setequal(unique(x$sexo), c("Femea", "f", "F", "m", "M", "Macho"))
  expect_true(all(grepl("^[A-Za-z]+_(Seca|Chuvosa)$", x$amostra)))
})

test_that("D52 bagre reproduz a curva de 80 °C e o ajuste de Page", {
  x <- secagem_bagre
  expect_identical(dim(x), c(10L, 6L))
  expect_identical(names(x), c("tempo_min", "massa_peixe_kg", "temperatura_secador_c",
    "gas_consumido_kg", "energia_mj", "umidade_publicada"))
  expect_identical(x$tempo_min, seq(0L, 540L, by = 60L))
  expect_true(all(diff(x$massa_peixe_kg) < 0))
  expect_identical(x$massa_peixe_kg[c(1, 10)], c(8.53, 2.03))
  expect_identical(which(is.na(x)), 31L)
  x$massa_relativa <- x$massa_peixe_kg / 8.53
  page <- nls(massa_relativa ~ exp(-(k * tempo_min)^n), data = x,
              start = list(k = 0.002, n = 1))
  expect_equal(unname(coef(page)), c(0.002416, 1.421), tolerance = 1e-3)
  lewis <- nls(massa_relativa ~ exp(-k * tempo_min), data = x, start = list(k = 0.002))
  expect_lt(AIC(page), AIC(lm(massa_relativa ~ tempo_min, data = x)))
  expect_lt(AIC(page), AIC(lewis))
})

test_that("D60 esgana-gata é um quadrado latino 4 x 4 repetido em 144 peixes", {
  x <- esgana_gata_ruido
  expect_identical(dim(x), c(576L, 11L))
  expect_identical(names(x), c("id_peixe", "sequencia", "periodo", "ruido_visual",
    "distancia_cardume_mm", "tamanho_peixe_mm", "velocidade_mm_s",
    "preferencia_cardume_maior", "ensaio", "cardume_maior_n", "cardume_menor_n"))
  expect_false(anyNA(x))
  expect_identical(levels(x$ruido_visual), c("estático", "lento", "médio", "rápido"))
  expect_true(all(table(x$id_peixe, x$ruido_visual) == 1L))
  cel <- aggregate(distancia_cardume_mm ~ sequencia + periodo + ruido_visual, data = x, FUN = mean)
  uma_vez <- function(a, b) all(table(a, b) == 1L)
  expect_identical(nrow(cel), 16L)
  expect_true(uma_vez(cel$ruido_visual, cel$sequencia))
  expect_true(uma_vez(cel$ruido_visual, cel$periodo))
  a <- summary(aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo, data = cel))[[1]]
  expect_equal(a$Df, c(3, 3, 3, 6))
  expect_equal(a[["F value"]][1], 16.233, tolerance = 1e-3)
  r <- summary(aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo + Error(id_peixe),
    data = x))[["Error: Within"]][[1]]
  expect_equal(r$Df, c(3, 3, 426))
  expect_lt(r[["Pr(>F)"]][1], 1e-5)
})

test_that("D20 cangulo confere com a Tabela 11.2 de Ivo e Fonteles Filho (1997)", {
  x <- cangulo_crescimento
  expect_identical(dim(x), c(16L, 7L))
  expect_identical(names(x), c("comprimento_cm", "peso1_g", "peso2_g", "peso3_g",
    "peso_medio_g", "ln_comprimento", "ln_peso_medio"))
  expect_equal(x$comprimento_cm, seq(12, 42, by = 2))
  expect_equal(x$peso_medio_g, (x$peso1_g + x$peso2_g + x$peso3_g) / 3)
  # Somatórios impressos no livro, com três casas.
  expect_equal(round(sum(round(x$ln_comprimento, 3)), 3), 51.684)
  expect_equal(round(sum(round(x$ln_peso_medio, 3)), 3), 94.414, tolerance = 1e-4)
  reta <- lm(ln_peso_medio ~ ln_comprimento, data = x)
  expect_equal(unname(coef(reta)[2]), 2.859, tolerance = 1e-3)
  expect_s3_class(relacionar_variaveis(x, ln_peso_medio, ln_comprimento), "clara_regressao")
})

test_that("D42 artêmia reproduz o exercício 82 e contém o antigo EAPADados::artemia", {
  x <- artemia_racao
  expect_identical(dim(x), c(20L, 2L))
  expect_identical(levels(x$racao), c("A", "B"))
  expect_equal(as.vector(tapply(x$taxa_crescimento_mg_dia, x$racao, mean)), c(4.10, 3.42))
  t <- t.test(taxa_crescimento_mg_dia ~ racao, data = x, alternative = "greater",
              var.equal = TRUE)
  expect_equal(unname(t$statistic), 4.2028, tolerance = 1e-4)
  expect_lt(t$p.value, 0.001)
})

test_that("D46 lagosta: a CPUE cai exponencialmente com o esforço", {
  x <- lagosta_cpue_esforco
  expect_identical(dim(x), c(14L, 2L))
  expect_identical(names(x), c("esforco_mil_covo_dia", "cpue_kg_covo_dia"))
  fox <- lm(log(cpue_kg_covo_dia) ~ esforco_mil_covo_dia, data = x)
  expect_equal(unname(coef(fox)[2]), -0.05159, tolerance = 1e-3)
  expect_gt(summary(fox)$r.squared, 0.94)
  expect_lt(cor(x$esforco_mil_covo_dia, x$cpue_kg_covo_dia), -0.9)
})

test_that("catálogo traz os verbos da ClaRa que rodam em cada conjunto", {
  verbos <- c("comparar_medias", "comparar_medianas", "relacionar_variaveis")
  usados <- unlist(strsplit(catalogo_dados$verbo_clara[nzchar(catalogo_dados$verbo_clara)], "; "))
  expect_true(all(usados %in% verbos))
  expect_identical(catalogo_dados$verbo_clara[catalogo_dados$codigo == "D42"],
                   "comparar_medias; comparar_medianas")
})

test_that("situacao do catálogo tem vocabulário fixo e os limites ficam à parte", {
  expect_true(all(enc2utf8(catalogo_dados$situacao) %in%
                    c("provisório", "revisado", "sintético de treino")))
  expect_identical(sort(catalogo_dados$codigo[enc2utf8(catalogo_dados$situacao) == "sintético de treino"]),
                   c("D11", "D36", "D37"))
  expect_type(catalogo_dados$limites, "character")
  expect_false(anyNA(catalogo_dados$limites))
})

test_that("D13 tem rótulo sem hífen e D35 tem a coluna dieta, prontos para comparar_medias()", {
  a <- artemia_fitoesterois
  expect_false(any(grepl("-", levels(a$esterol_rotulo))))
  expect_identical(nrow(unique(a[c("esterol", "esterol_rotulo")])), nlevels(a$esterol_rotulo))
  exp1 <- droplevels(subset(a, experimento == "exp_1"))
  expect_s3_class(comparar_medias(exp1, biomassa_mg, esterol_rotulo), "clara_medias")
  t <- tilapia_microalgas
  expect_identical(levels(t$dieta), c("controle", "nannochloropsis_25", "nannochloropsis_50",
                                      "tetraselmis_25", "tetraselmis_50"))
  expect_identical(as.vector(table(t$dieta)), rep(3L, 5))
  expect_s3_class(comparar_medias(t, sgr_pct_dia, dieta), "clara_medias")
})

test_that("D24 e D31 saíram; os usos secundários estão no catálogo", {
  expect_false(any(c("D24", "D31") %in% catalogo_dados$codigo))
  expect_false(any(c("darter_ontario", "qfasa_predadores") %in% catalogo_dados$nome))
  analises <- setNames(enc2utf8(catalogo_dados$analises), catalogo_dados$codigo)
  expect_match(analises[["D03"]], "Kruskal-Wallis")
  expect_match(analises[["D62"]], "Kruskal-Wallis")
  expect_match(analises[["D41"]], "pareado")
  expect_match(analises[["D28"]], "aderência")
  expect_match(analises[["D55"]], "logística")
  expect_match(analises[["D50"]], "logística")
  expect_match(analises[["D15"]], "ANCOVA")
  expect_match(analises[["D16"]], "ANCOVA")
  expect_false(grepl("ANCOVA", analises[["D38"]]))
  expect_s3_class(comparar_medianas(cpue_tubarao, cpue, embarcacao), "clara_medianas")
  expect_s3_class(comparar_medianas(larvas_peixes_captura, numero_larvas, local), "clara_medianas")
  expect_s3_class(comparar_medianas(mesocosmos_secagem, crescimento_absoluto_cm, tratamento), "clara_medianas")
})

test_that("D54 tiger flathead tem um peixe por linha e o defeito do sexo está em NA", {
  x <- platycephalus_crescimento
  expect_identical(dim(x), c(4318L, 9L))
  expect_false(anyDuplicated(x$id_peixe) > 0L)
  expect_identical(levels(x$sexo), c("femea", "macho"))
  expect_identical(sum(is.na(x$sexo)), 444L)
  expect_identical(sum(is.na(x$comprimento_cm)), 17L)
  expect_identical(range(x$idade_anos), c(2L, 25L))
  expect_false("haemulon_crescimento" %in% catalogo_dados$nome)
  vb <- function(d) nls(comprimento_cm ~ Linf * (1 - exp(-K * (idade_anos - t0))),
                        data = d, start = list(Linf = 50, K = 0.3, t0 = 0))
  femeas <- coef(vb(x[which(x$sexo == "femea"), ]))
  machos <- coef(vb(x[which(x$sexo == "macho"), ]))
  expect_equal(unname(femeas[["Linf"]]), 78.66, tolerance = 5e-3)
  expect_equal(unname(machos[["Linf"]]), 61.29, tolerance = 5e-3)
  cinco <- subset(x, idade_anos == 5)
  expect_s3_class(comparar_medias(cinco, comprimento_cm, sexo), "clara_medias")
})
