# ANOVA DE UM FATOR COM A ClaRa: EXEMPLO
# x========================================================================x
# Pergunta: o peso seco das plantas difere entre os tratamentos?
# Dados: PlantGrowth, que já vem com o R (30 plantas, 3 tratamentos).
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/anova_um_fator.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
source("R/clara.R", encoding = "UTF-8")

# Damos nomes em português às colunas, como viriam de uma planilha nossa.
plantas <- PlantGrowth |>
  rename(peso = weight, tratamento = group)

# 2. Comparar as médias ----------------------------------------------------
resultado <- plantas |>
  comparar_medias(resposta = peso, grupos = tratamento)

resultado

# 3. Medir o tamanho do efeito ---------------------------------------------
resultado |>
  medir_efeito()

# 4. Mostrar a comparação num gráfico --------------------------------------
resultado |>
  grafico_medias(rotulo_resposta = "Peso seco (g)",
                 rotulo_grupos   = "Tratamento")

# 5. Ver o código R por trás da ClaRa --------------------------------------
# Com mostrar_codigo = TRUE, a função imprime o código e depois o resultado.
resultado |>
  medir_efeito(mostrar_codigo = TRUE)

# 6. Guardar a figura ------------------------------------------------------
# O ggsave() grava o último gráfico desenhado, o da seção 4.
ggsave("exemplos/anova_um_fator.png",
       width  = 7,
       height = 4.6,
       dpi    = 300,
       bg     = "white")

