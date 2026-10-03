# PESO DOS BAGRES ENTRE AS RAÇÕES: ROTEIRO DE ANÁLISE EM ClaRa
# x========================================================================x
# Pergunta: o peso médio (g) difere entre os tipos de ração?
# Dados: bagres alimentados com quatro rações iso-proteicas (EAPADados).
#
# É o analise.R do caderno anova-bagres-gabarito (EAPACadernos) reescrito
# em ClaRa, na mesma ordem de seções. Onde a ClaRa ainda não tem função,
# o R comum aparece marcado com "Ainda sem ClaRa".
#
# Rode as seções em ordem (Ctrl+Enter; sumário: Ctrl+Shift+O).
# Para entender uma função: ajuda(comparar_medias).
# Para ver o R por trás dela: mostrar_codigo = TRUE.
#   Rscript exemplos/anova_bagres.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
source("R/clara.R", encoding = "UTF-8")

# 2. Ler os dados ----------------------------------------------------------
# A base já preparada, em .rds: guarda os tipos e a ordem dos grupos.
# No projeto da CatalyseR: readRDS("dados/processados/base_compartilhada.rds").
bagres <- readRDS("dados_treino/real_bagre_racoes.rds")

# Primeira olhada: racao deve ser fator (fct) e peso_g, número (dbl).
glimpse(bagres)

# 3. Como a base foi preparada ---------------------------------------------
# A receita que fez a base acima, a partir da planilha original. A planilha
# perde os tipos: racao volta como texto e precisa virar fator, com os
# grupos na ordem que queremos ver nas tabelas e nos gráficos.
bagres_planilha <- read.csv("dados_treino/real_bagre_racoes.csv", encoding = "UTF-8") |>
  mutate(racao = factor(racao, levels = c("A", "B", "C", "D")))

# A receita ainda dá a mesma base? TRUE confirma; senão, o R diz o que mudou.
all.equal(bagres_planilha, bagres)

# 4 a 7. Comparar as médias ------------------------------------------------
# Resumo, ANOVA, pressupostos, Tukey e letras, numa função só.
resultado <- bagres |>
  comparar_medias(resposta = peso_g, grupos = racao)

resultado

# Tamanho de efeito: η² e ω², com a leitura de Cohen.
resultado |>
  medir_efeito()

# 8. Tabelas ---------------------------------------------------------------
# As tabelas já saem prontas do resultado; a formatação para o Word
# (flextable) é apresentação e fica no funcoes.R do projeto da CatalyseR.
resultado$resumo
resultado$anova
resultado$pares

# 9. Gráficos --------------------------------------------------------------

# 9.1 Exploração: caixas com as observações por cima.
# Ainda sem ClaRa (em espera).
ggplot(resultado$dados, aes(x = racao, y = peso_g)) +
  geom_boxplot(width = 0.5, outlier.shape = NA, colour = "grey50") +
  geom_jitter(width = 0.1, height = 0, size = 1.5, alpha = 0.5) +
  labs(x = "Tipo de Ração", y = "Peso (g)") +
  theme_classic(base_size = 12)

# 9.2 Figura principal: barras, pontos, média ± DP, IC e letras.
grafico_barras <- resultado |>
  grafico_medias(rotulo_resposta = "Peso (g)",
                 rotulo_grupos   = "Tipo de Ração")

grafico_barras

# 9.3 e 9.4 Resíduos e Q-Q.
# Ainda sem ClaRa (em espera: grafico_diagnostico()).
diagnostico <- tibble(
  ajustado    = fitted(resultado$modelo),
  residuo     = residuals(resultado$modelo),
  padronizado = rstandard(resultado$modelo)
)

ggplot(diagnostico, aes(x = ajustado, y = residuo)) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey40") +
  geom_jitter(width = 0.02, height = 0, alpha = 0.7, colour = "#2E7D8F") +
  labs(x = "Valores ajustados (médias dos grupos)", y = "Resíduos") +
  theme_classic(base_size = 12)

ggplot(diagnostico, aes(sample = padronizado)) +
  stat_qq(colour = "#2E7D8F", alpha = 0.7) +
  stat_qq_line(colour = "#E76F51") +
  labs(x = "Quantis teóricos", y = "Resíduos padronizados") +
  theme_classic(base_size = 12)

# 9.5 Diferenças entre pares (floresta do Tukey).
# Ainda sem ClaRa (em espera).
ggplot(resultado$pares, aes(x = diferenca, y = comparacao)) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey60") +
  geom_errorbar(aes(xmin = ic_inf, xmax = ic_sup),
                width = 0.2, linewidth = 0.8, colour = "#2E7D8F",
                orientation = "y") +
  geom_point(size = 3, colour = "#0F3B5F") +
  labs(x = "Diferença de médias de Peso (g), IC 95% (Tukey)", y = NULL) +
  theme_classic(base_size = 12)

# 10. Textos para o relatório ----------------------------------------------
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados(rotulo_resposta = "Peso (g)",
                      rotulo_grupos   = "Tipo de Ração")

textos

# 11. Salvar cópias --------------------------------------------------------
# No projeto da CatalyseR, os CSVs e PNGs vão para saida/. Aqui, só a figura.
ggsave("exemplos/anova_bagres.png",
       plot   = grafico_barras,
       width  = 7,
       height = 4.6,
       dpi    = 300,
       bg     = "white")

# 12. Registrar o ambiente -------------------------------------------------
# No projeto da CatalyseR: sessionInfo() gravado em saida/sessionInfo.txt.
