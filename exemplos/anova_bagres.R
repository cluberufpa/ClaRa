# PESO DOS BAGRES ENTRE AS RAÇÕES: ROTEIRO DE ANÁLISE EM ClaRa
# x========================================================================x
# Pergunta: o peso médio (g) difere entre os tipos de ração?
# Dados: bagres alimentados com quatro rações iso-proteicas (EAPADados).
#
# É o analise.R do caderno anova-bagres-gabarito (EAPACadernos) reescrito
# em ClaRa, na mesma ordem de seções.
#
# Rode as seções em ordem (Ctrl+Enter; sumário: Ctrl+Shift+O).
# Para entender uma função: ajuda(comparar_medias).
# Para ver o R por trás dela: mostrar_codigo = TRUE.
#   Rscript exemplos/anova_bagres.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
source("R/clara.R", encoding = "UTF-8")  # Carrega funções

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

# Cada gráfico fica guardado com um nome, para ser salvo na seção 11.

# 9.1 Exploração: caixas com as observações por cima.
grafico_caixas <- resultado |>
  grafico_boxplot(rotulo_resposta = "Peso (g)",
                  rotulo_grupos   = "Tipo de Ração")

grafico_caixas

# 9.2 Figura principal: barras, pontos, média ± DP, IC e letras.
grafico_barras <- resultado |>
  grafico_medias(rotulo_resposta = "Peso (g)",
                 rotulo_grupos   = "Tipo de Ração")

grafico_barras

# 9.3 Resíduos contra ajustados: faixas de alturas parecidas, variâncias parecidas.
grafico_ajustados <- resultado |>
  grafico_residuos(rotulo_grupos = "Tipo de Ração")

grafico_ajustados

# 9.4 Q-Q: pontos perto da reta, resíduos compatíveis com a normal.
grafico_normal <- resultado |>
  grafico_qq()

grafico_normal

# 9.5 Diferenças entre pares: haste que cruza a linha tracejada (zero),
#     sem diferença entre os dois grupos.
grafico_diferencas <- resultado |>
  grafico_pares(rotulo_resposta = "Peso (g)",
                rotulo_grupos   = "Tipo de Ração")

grafico_diferencas

# 10. Textos para o relatório ----------------------------------------------
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados(rotulo_resposta = "Peso (g)",
                      rotulo_grupos   = "Tipo de Ração")

textos

# 11. Salvar cópias --------------------------------------------------------
# No projeto da CatalyseR, os CSVs e PNGs vão para saida/. Aqui, só as
# figuras, em exemplos/figuras/, com o nome do roteiro na frente.
figuras <- list(boxplot  = grafico_caixas,
                medias   = grafico_barras,
                residuos = grafico_ajustados,
                qq       = grafico_normal,
                pares    = grafico_diferencas)

# Uma volta para cada figura: anova_bagres_boxplot.png, anova_bagres_medias.png...
for (nome in names(figuras)) {
  ggsave(paste0("exemplos/figuras/anova_bagres_", nome, ".png"),
         plot       = figuras[[nome]],
         width      = 7,
         height     = 4.6,
         dpi        = 300,
         bg         = "white",
         create.dir = TRUE)
}

# 12. Registrar o ambiente -------------------------------------------------
# No projeto da CatalyseR: sessionInfo() gravado em saida/sessionInfo.txt.
