# Arrumação leve dos conjuntos da ClaRa (12/10/2026), pedida pelo professor.
# Executar na raiz da ClaRa, depois dos `preparar.R` de cada conjunto.
#
# O que faz, sem mexer nos valores:
#   - tira colunas constantes ou que repetem outra coluna;
#   - renomeia colunas herdadas em inglês ou em maiúsculas;
#   - converte texto com poucas categorias em fator (e `linha` e `coluna` do
#     quadrado latino, que a ANOVA precisa como fatores);
#   - padroniza rótulos de categorias em português, com acento e minúsculas.
# Ficam de fora, de propósito: os conjuntos bagunçados para treino de preparo
# (captura_pescada_amarela_bruta, exportacao_pargo, treino_coletas,
# treino_desembarque) e os da QFASA (nomes de colunas exigidos pelo pacote).
#
# Depois de rodar, atualizar as dimensões no catálogo (final deste script) e a
# ajuda (`@format`) de cada conjunto alterado.

carregar <- function(nome) {
  e <- new.env(parent = emptyenv())
  load(file.path("data", paste0(nome, ".rda")), e)
  get(nome, e)
}
gravar <- function(nome, x) {
  assign(nome, x)
  save(list = nome, file = file.path("data", paste0(nome, ".rda")),
       compress = "xz", version = 2)
}
tirar <- function(x, ...) {
  col <- c(...)
  stopifnot(all(col %in% names(x)))
  x[setdiff(names(x), col)]
}
renomear <- function(x, de, para) {
  stopifnot(all(de %in% names(x)), !any(para %in% setdiff(names(x), de)))
  names(x)[match(de, names(x))] <- para
  x
}
fator <- function(x, niveis = NULL) {
  if (is.null(niveis)) factor(x) else factor(x, levels = niveis)
}
trocar_niveis <- function(f, de, para) {
  stopifnot(is.factor(f), all(de %in% levels(f)))
  lv <- levels(f)
  lv[match(de, lv)] <- para
  levels(f) <- lv
  f
}

alterar <- list()

# --- cpue_tubarao: nomes herdados em inglês e maiúsculas
x <- carregar("cpue_tubarao")
x <- renomear(x, c("Vessel", "Year", "Month", "CPUE", "Data"),
              c("embarcacao", "ano", "mes", "cpue", "data"))
alterar$cpue_tubarao <- x

# --- abalone_adultos: rótulos de sexo no padrão dos demais conjuntos
x <- carregar("abalone_adultos")
x$sexo <- trocar_niveis(x$sexo, c("Femea", "Macho"), c("fêmea", "macho"))
alterar$abalone_adultos <- x

# --- salvelino_formalina_remocao: nome em inglês
x <- carregar("salvelino_formalina_remocao")
alterar$salvelino_formalina_remocao <- renomear(x, "formalin", "formalina")

# --- camarao_vannamei_biometria: nome de arquivo é redundante com `base`
x <- carregar("camarao_vannamei_biometria")
x <- tirar(x, "arquivo_origem")
x$base <- fator(x$base)
x$origem <- fator(x$origem)
alterar$camarao_vannamei_biometria <- x

# --- enobieta_baci: constante vira fora; categorias viram fator
x <- carregar("enobieta_baci")
x <- tirar(x, "area_surber_m2")
x$local_id <- fator(x$local_id)
x$local_nome <- fator(x$local_nome)
x$condicao <- fator(x$condicao)
x$periodo <- fator(x$periodo, c("antes", "durante", "depois"))
x$campanha <- fator(x$campanha)
alterar$enobieta_baci <- x

# --- artemia_fitoesterois: nomes em inglês; sterol_id repete sterol_name
x <- carregar("artemia_fitoesterois")
stopifnot(identical(length(unique(paste(x$sterol_id, x$sterol_name))), length(unique(x$sterol_id))))
x <- tirar(x, "sterol_id")
x <- renomear(x, c("experiment", "sterol_name", "biomass_mg", "ind_weight_ug"),
              c("experimento", "esterol", "biomassa_mg", "massa_individual_ug"))
x$experimento <- fator(x$experimento)
x$esterol <- fator(x$esterol)
alterar$artemia_fitoesterois <- x

# --- truta_acidos_graxos: semana é constante (12)
x <- carregar("truta_acidos_graxos")
alterar$truta_acidos_graxos <- tirar(x, "semana")

# --- tilapia_microalgas: id_tanque repete tratamento_codigo; estocagem constante
x <- carregar("tilapia_microalgas")
stopifnot(identical(toupper(x$id_tanque), as.character(x$tratamento_codigo)))
alterar$tilapia_microalgas <- tirar(x, "id_tanque", "peixes_estocados")

# --- truta_riacho_crescimento: rótulos em inglês
x <- carregar("truta_riacho_crescimento")
x$racao_fator <- factor(c(low = "baixa", high = "alta")[as.character(x$racao_fator)],
                        levels = c("baixa", "alta"))
alterar$truta_riacho_crescimento <- x

# --- mesocosmos_secagem: data inicial é a mesma para todos
x <- carregar("mesocosmos_secagem")
alterar$mesocosmos_secagem <- tirar(x, "data_inicial")

# --- molinesias_parasitos: grupo repete local x espécie; rótulos de sexo
x <- carregar("molinesias_parasitos")
stopifnot(identical(as.character(x$grupo_local_especie),
                    paste(x$local, "/", x$especie)))
x <- tirar(x, "grupo_local_especie")
x$sexo <- trocar_niveis(x$sexo, c("F", "M"), c("fêmea", "macho"))
alterar$molinesias_parasitos <- x

# --- secagem_beterraba_gengibre: id_amostra repete produto + tratamento + temperatura
x <- carregar("secagem_beterraba_gengibre")
alterar$secagem_beterraba_gengibre <- tirar(x, "id_amostra")

# --- pollock_alasca: ano e espécie são constantes
x <- carregar("pollock_alasca")
alterar$pollock_alasca <- tirar(x, "ano", "especie")

# --- anchova_norte_california: categoria e porto são constantes; "marco"
x <- carregar("anchova_norte_california")
x <- tirar(x, "categoria_mercado", "porto")
x$mes <- trocar_niveis(x$mes, "marco", "março")
alterar$anchova_norte_california <- x

# --- morfometria_barbo: rio repete populacao (um rio por população)
x <- carregar("morfometria_barbo")
stopifnot(nrow(unique(x[c("populacao", "rio")])) == nlevels(x$populacao))
alterar$morfometria_barbo <- tirar(x, "rio")

# --- peixes_morfometria_multivariada: especie_codigo repete especie
x <- carregar("peixes_morfometria_multivariada")
alterar$peixes_morfometria_multivariada <- tirar(x, "especie_codigo")

# --- peixes_nutricao_portugal: cluster numérico repete o perfil nutricional
x <- carregar("peixes_nutricao_portugal")
stopifnot(nrow(unique(x[c("cluster_autores", "perfil_nutricional_autores")])) == nlevels(x$cluster_autores))
alterar$peixes_nutricao_portugal <- tirar(x, "cluster_autores")

# --- solha_baltico_2008_t4: linha_fonte é só rastro da planilha original
x <- carregar("solha_baltico_2008_t4")
alterar$solha_baltico_2008_t4 <- tirar(x, "linha_fonte")

# --- lagostas_kelp_sexo: rótulos sem acento
x <- carregar("lagostas_kelp_sexo")
x$sexo <- trocar_niveis(x$sexo, "femea", "fêmea")
x$mes_nome <- trocar_niveis(x$mes_nome, "marco", "março")
alterar$lagostas_kelp_sexo <- x

# --- recifes_ostras_heatmap: níveis em inglês
x <- carregar("recifes_ostras_heatmap")
x$zona_recife <- trocar_niveis(x$zona_recife, c("Centre", "Edge", "Off"), c("centro", "borda", "fora"))
x$estacao <- trocar_niveis(x$estacao, c("Summer", "Winter"), c("verão", "inverno"))
alterar$recifes_ostras_heatmap <- x

# --- trigo_quadrado_latino: linha, coluna e operador são fatores no delineamento
x <- carregar("trigo_quadrado_latino")
x$linha <- factor(x$linha)
x$coluna <- factor(x$coluna)
x$operador <- fator(x$operador)
alterar$trigo_quadrado_latino <- x

# --- cowichan_amostragem: categorias viram fator; ano inteiro
x <- carregar("cowichan_amostragem")
for (v in c("local", "sublocal", "ambiente", "sexo")) x[[v]] <- fator(x[[v]])
x$ano <- as.integer(x$ano)
alterar$cowichan_amostragem <- x

# --- lebistes_parasitos: bacia e rio são categorias
x <- carregar("lebistes_parasitos")
x$bacia <- fator(x$bacia)
x$rio <- fator(x$rio)
alterar$lebistes_parasitos <- x

# --- aquicultura_br: UF e estado são categorias
x <- carregar("aquicultura_br")
x$uf <- fator(x$uf)
x$estado <- fator(x$estado)
alterar$aquicultura_br <- x

# Grava e atualiza o catálogo
e <- new.env(parent = emptyenv())
load("data/catalogo_dados.rda", e)
catalogo_dados <- e$catalogo_dados
for (nome in names(alterar)) {
  x <- alterar[[nome]]
  stopifnot(is.data.frame(x), !anyNA(names(x)), !anyDuplicated(names(x)))
  for (v in names(x)) if (is.factor(x[[v]])) x[[v]] <- droplevels(x[[v]])
  gravar(nome, x)
  i <- which(catalogo_dados$nome == nome)
  stopifnot(length(i) == 1L)
  catalogo_dados$linhas[i] <- nrow(x)
  catalogo_dados$colunas[i] <- ncol(x)
  cat(sprintf("%-34s %4d x %2d\n", nome, nrow(x), ncol(x)))
}
save(catalogo_dados, file = "data/catalogo_dados.rda", compress = "xz", version = 2)
