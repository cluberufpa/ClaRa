# ANOVA DE UM FATOR COM A ClaRa: EXEMPLO
# x========================================================================x
# Pergunta: o peso seco das plantas difere entre os tratamentos?
# Dados: PlantGrowth, que já vem com o R (30 plantas, 3 tratamentos).
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/anova_um_fator.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
library(clara)

# Damos nomes em português às colunas, como viriam de uma planilha nossa.
plantas <- PlantGrowth |>
  rename(peso = weight, tratamento = group)

# 2. Comparar as médias ----------------------------------------------------
# Os rótulos ficam guardados no resultado: gráficos e textos já os usam.
resultado <- plantas |>
  comparar_medias(resposta        = peso,
                  grupos          = tratamento,
                  rotulo_resposta = "Peso seco (g)",
                  rotulo_grupos   = "Tratamento",
                  confianca       = 0.95)

resultado

# 3. Medir o tamanho do efeito ---------------------------------------------
resultado |>
  medir_efeito()

# 4. Mostrar a comparação num gráfico --------------------------------------
# A figura que vai para o artigo: todas as escolhas escritas, com as opções
# ao lado. Um título, se a revista pedir, entra com titulo = "...".
resultado |>
  grafico_medias(explicacao       = TRUE,           # FALSE tira a explicação do topo
                 haste            = "ic",           # "ic", "ep" ou "dp"
                 mostrar_barras   = TRUE,
                 largura_barras   = 0.3,            # de 0 a 1
                 mostrar_pontos   = TRUE,
                 mostrar_media_dp = TRUE,
                 casas            = 2,              # casas decimais do rótulo
                 angulo_rotulo    = 0,              # 0 deitado; -90 ou 90 em pé
                 altura_rotulo    = 0.5,            # fração da barra
                 mostrar_letras   = TRUE,
                 cores            = "ocean",        # "ocean", "cinza" ou um vetor
                 tamanho_texto    = 12,
                 fonte            = "sans")         # "sans" (Arial) ou "serif" (Times)

# 5. Ver o código R por trás da ClaRa --------------------------------------
# Com mostrar_codigo = TRUE, a função imprime o código e depois o resultado.
resultado |>
  medir_efeito(mostrar_codigo = TRUE)

# 6. Guardar a figura ------------------------------------------------------
# O ggsave() grava o último gráfico desenhado, o da seção 4.
ggsave("exemplos/figuras/anova_um_fator.png",
       width      = 7,
       height     = 4.6,
       dpi        = 300,
       bg         = "white",
       create.dir = TRUE)

# 7. Escrever os resultados ------------------------------------------------
# As frases saem do resultado: se os dados mudam, o texto muda junto.
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados()

textos

