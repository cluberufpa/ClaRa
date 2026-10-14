# Receitas dos dados de pacotes ----
# O registro contém apenas código de tradução, nunca observações copiadas.
receitas_dados_pacotes <- list(
  crabs_morfometria = list(pacote = "MASS", objeto = "crabs", traduzir = function(brutos) {
    # Preservamos os quartis do EAPADados, calculados sobre os 200 animais.
    data.frame(
      id_caranguejo = as.character(seq_len(nrow(brutos))),
      forma_cor = dplyr::case_when(as.character(brutos$sp) == "B" ~ "azul",
                                   as.character(brutos$sp) == "O" ~ "laranja"),
      sexo = dplyr::case_when(as.character(brutos$sex) == "M" ~ "macho",
                              as.character(brutos$sex) == "F" ~ "fêmea"),
      indice_no_grupo = brutos$index,
      largura_lobo_frontal_mm = brutos$FL,
      largura_posterior_mm = brutos$RW,
      comprimento_carapaca_mm = brutos$CL,
      largura_carapaca_mm = brutos$CW,
      profundidade_corpo_mm = brutos$BD,
      classe_largura_carapaca = as.character(cut(brutos$CW,
        breaks = stats::quantile(brutos$CW, seq(0, 1, 0.25)),
        include.lowest = TRUE, labels = paste0("largura_carapaca_Q", 1:4)))
    )
  }),
  idades_savel_repetibilidade = list(pacote = "FSAdata", objeto = "ShadCR", traduzir = function(brutos) {
    data.frame(fish_id = as.character(brutos$fishID),
               true_age = as.integer(brutos$trueAge),
               reader_a_1 = as.integer(brutos$agerA1), reader_a_2 = as.integer(brutos$agerA2),
               reader_b_1 = as.integer(brutos$agerB1), reader_b_2 = as.integer(brutos$agerB2),
               reader_c_1 = as.integer(brutos$agerC1), reader_c_2 = as.integer(brutos$agerC2))
  }),
  snapper_hg = list(pacote = "FSAdata", objeto = "SnapperHG1", traduzir = function(brutos) {
    # Os quartis eram calculados ANTES do filtro de idade; preservamos essa ordem.
    classes <- as.character(cut(brutos$len,
      breaks = stats::quantile(brutos$len, seq(0, 1, 0.25)),
      include.lowest = TRUE, labels = paste0("comprimento_Q", 1:4)))
    manter <- !is.na(brutos$age)
    data.frame(id_peixe = as.character(which(manter)),
               levantamento = as.character(brutos$survey[manter]),
               comprimento_cm = as.numeric(brutos$len[manter]),
               idade_anos = as.numeric(brutos$age[manter]),
               tem_idade_atribuida = rep(TRUE, sum(manter)),
               classe_comprimento = classes[manter])
  }),
  cabezon_maturidade = list(pacote = "FSAdata", objeto = "Cabezon", traduzir = function(brutos) {
    stopifnot(identical(names(brutos),c("date","length","age","maturity","stage")))
    x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
    names(x) <- c("data","comprimento_total_cm","idade","maturidade","estagio_maturidade")
    x$data <- as.Date(as.character(x$data),format="%m/%d/%Y")
    stopifnot(!anyNA(x$data))
    stopifnot(setequal(levels(x$maturidade),c("Immature","Mature","Unknown")))
    x$maturidade <- factor(x$maturidade,levels=c("Immature","Mature","Unknown"),labels=c("imatura","madura","desconhecida"),ordered=is.ordered(x$maturidade))
    stopifnot(sum(is.na(x$idade))==226L)
    x
  }),
  ruffe_biometria = list(pacote = "FSAdata", objeto = "RuffeSLRH92", traduzir = function(brutos) {
    stopifnot(identical(names(brutos),c("fish.id","month","day","year","indiv","location","length","weight","sex","maturity","age")))
    x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
    names(x) <- c("id_peixe","mes","dia","ano","id_individuo","localizacao","comprimento_total_mm","peso_g","sexo","maturidade","idade_anos")
    x$id_peixe <- as.character(x$id_peixe)
    x$id_individuo <- as.character(x$id_individuo)
    x$localizacao <- as.character(x$localizacao)
    stopifnot(setequal(levels(x$sexo),c("female","male","unknown")))
    x$sexo <- factor(x$sexo,levels=c("female","male","unknown"),labels=c("femea","macho","desconhecido"),ordered=is.ordered(x$sexo))
    stopifnot(setequal(levels(x$maturidade),c("developing","immature","mature","nearly.ripe","nearly.spent","recovering","ripe","running","spent","unknown","yoy")))
    x$maturidade <- factor(x$maturidade,levels=c("developing","immature","mature","nearly.ripe","nearly.spent","recovering","ripe","running","spent","unknown","yoy"),labels=c("em_desenvolvimento","imaturo","maduro","quase_maduro","quase_esgotado","em_recuperacao","pronto_desova","em_desova","esgotado","desconhecido","jovem_ano"),ordered=is.ordered(x$maturidade))
    stopifnot(isTRUE(all.equal(as.numeric(x$id_peixe),brutos$fish.id)),sum(is.na(x$idade_anos))==726L,sum(is.na(x$peso_g))==2L)
    x
  }),
  bighill_amostras = list(pacote = "FSAdata", objeto = "BGHRsample", traduzir = function(brutos) {
    stopifnot(identical(names(brutos),c("UID","date","loc","effort")))
    x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
    names(x) <- c("id_amostra","data","localizacao","esforco_min")
    x$id_amostra <- as.character(x$id_amostra)
    x$localizacao <- as.character(x$localizacao)
    x$data <- as.Date(as.character(x$data),format="%m/%d/%Y")
    stopifnot(!anyNA(x$data))
    stopifnot(!anyDuplicated(x$id_amostra),all(x$esforco_min==10L))
    x
  }),
  bighill_peixes = list(pacote = "FSAdata", objeto = "BGHRfish", traduzir = function(brutos) {
    stopifnot(identical(names(brutos),c("UID","fishID","specCode","length","weight","count")))
    x <- as.data.frame(lapply(brutos,identity),check.names=FALSE)
    names(x) <- c("id_amostra","id_peixe","codigo_especie","comprimento_total_mm","peso_g","contagem")
    x$id_amostra <- as.character(x$id_amostra)
    x$id_peixe <- as.character(x$id_peixe)
    x$codigo_especie <- as.character(x$codigo_especie)
    stopifnot(sum(is.na(x$id_peixe))==81L,sum(is.na(x$peso_g))==91L,all(x$contagem>=1L & x$contagem<=3L))
    x
  })
)
