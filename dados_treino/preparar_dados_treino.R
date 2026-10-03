# DADOS DE TREINO DA ClaRa
# x========================================================================x
# Gera os arquivos desta pasta: dados reais (do pacote EAPADados) e dados
# sintéticos, cada um feito para provocar uma situação que a ClaRa precisa
# tratar bem. Servem para testar e estudar as funções, não para pesquisa.
# Rode a partir da raiz do projeto:
#   Rscript dados_treino/preparar_dados_treino.R

library(dplyr)

# Grava uma tabela em CSV (ponto decimal, UTF-8) dentro desta pasta.
gravar <- function(tabela, nome) {
  write.csv(tabela,
            file.path("dados_treino", paste0(nome, ".csv")),
            row.names    = FALSE,
            fileEncoding = "UTF-8")
}


# 1. Dados reais (pacote EAPADados) ----------------------------------------
# Instale uma vez: remotes::install_github("astuciasnor/EAPADados")

# Peso final de bagres com quatro rações iso-proteicas (grupos desiguais: 5, 5, 4, 5).
EAPADados::isoproteica_bagre |>
  gravar("real_bagre_racoes")

# Crescimento de artêmia com duas rações (dois grupos: teste t).
EAPADados::artemia |>
  gravar("real_artemia_racoes")

# Tilápias com microalgas na ração: crescimento específico por tipo de microalga.
EAPADados::tilapia_microalgas |>
  select(id_tanque, tipo_microalga, nivel_substituicao_pct,
         sgr_pct_dia, peso_final_medio_g, sobrevivencia_pct) |>
  gravar("real_tilapia_microalgas")

# Caranguejos de Bragança (PA): largura da carapaça por sexo, local e estação.
EAPADados::biometria_caranguejos |>
  rename(local = Local, sexo = Sexo, estacao = Estacao,
         largura_carapaca = LC, comprimento_carapaca = CC) |>
  gravar("real_caranguejos_braganca")


# 2. Dados sintéticos -------------------------------------------------------
# A semente fixa faz o sorteio sair sempre igual.
set.seed(2026)

# Quatro rações com diferenças claras entre as médias.
tibble(
  racao  = rep(c("A", "B", "C", "D"), each = 8),
  peso_g = round(rnorm(32, mean = rep(c(250, 265, 282, 262), each = 8), sd = 12), 1)
) |>
  gravar("sint_quatro_racoes")

# Variâncias muito diferentes entre as densidades: o Levene deve rejeitar.
tibble(
  densidade      = rep(c("baixa", "media", "alta"), each = 12),
  comprimento_cm = round(rnorm(36, mean = rep(c(30, 28.5, 27), each = 12),
                               sd   = rep(c(0.6, 2.5, 5.5), each = 12)), 1)
) |>
  gravar("sint_variancias_desiguais")

# Poucos peixes e diferença pequena: sem evidência e com pouco poder.
tibble(
  viveiro = rep(c("V1", "V2", "V3"), each = 4),
  peso_g  = round(rnorm(12, mean = rep(c(100, 106, 103), each = 4), sd = 8), 1)
) |>
  gravar("sint_pouco_poder")

# Captura por unidade de esforço muito assimétrica: o Shapiro deve rejeitar.
tibble(
  petrecho = rep(c("rede", "espinhel", "linha"), each = 15),
  cpue_kg  = round(rlnorm(45, meanlog = rep(c(2.0, 2.4, 1.8), each = 15), sdlog = 0.9), 2)
) |>
  gravar("sint_residuos_assimetricos")

# Planilha com falhas: respostas e grupos em branco devem sair da análise.
tibble(
  racao  = rep(c("A", "B", "C"), each = 7),
  peso_g = round(rnorm(21, mean = rep(c(250, 268, 259), each = 7), sd = 10), 1)
) |>
  mutate(
    peso_g = replace(peso_g, c(3, 11, 19), NA),
    racao  = replace(racao, c(6, 15), NA)
  ) |>
  gravar("sint_com_faltantes")

# Dois locais com tamanhos e dispersões bem diferentes: Welch e Student divergem.
tibble(
  local          = rep(c("estuario", "costa"), times = c(10, 25)),
  comprimento_cm = round(c(rnorm(10, mean = 24, sd = 1.5),
                           rnorm(25, mean = 22, sd = 6)), 1)
) |>
  gravar("sint_dois_locais")

# Dez tanques: mais grupos que as oito cores da paleta.
tibble(
  tanque = rep(sprintf("T%02d", 1:10), each = 5),
  peso_g = round(rnorm(50, mean = rep(seq(200, 245, by = 5), each = 5), sd = 9), 1)
) |>
  gravar("sint_dez_tanques")
