# ANOVA DE WELCH COM A ClaRa: EXEMPLO
# x========================================================================x
# Pergunta: o comprimento dos peixes muda conforme a densidade de estocagem?
# Dados: dados_treino/sint_variancias_desiguais, sintéticos. São 36 peixes,
#        12 em cada densidade (baixa, media e alta). Na densidade alta, os
#        comprimentos variam muito mais: o Levene rejeita a igualdade das
#        variâncias.
# Com três ou mais grupos, comparar_medias() faz a ANOVA clássica (padrão).
# Com variancias_iguais = FALSE, faz a ANOVA de Welch com Games-Howell, que
# não supõem variâncias iguais.
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/anova_welch.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
source("R/clara.R", encoding = "UTF-8")

# A base pronta: densidade como fator, na ordem baixa, media e alta.
peixes <- readRDS("dados_treino/sint_variancias_desiguais.rds")

# 2. Primeiro, a ANOVA clássica --------------------------------------------
# O Levene, nos pressupostos, mostra variâncias diferentes, e o alerta dos
# textos recomenda a ANOVA de Welch.
classica <- peixes |>
  comparar_medias(resposta          = comprimento_cm,
                  grupos            = densidade,
                  rotulo_resposta   = "Comprimento (cm)",
                  rotulo_grupos     = "Densidade de estocagem",
                  variancias_iguais = TRUE)       # TRUE: ANOVA clássica

classica$pressupostos

textos_classica <- classica |>
  escrever_resultados()
textos_classica$alerta

# 3. A ANOVA de Welch ------------------------------------------------------
# A mesma pergunta, sem supor variâncias iguais. Escrita no roteiro, a
# escolha fica registrada.
resultado <- peixes |>
  comparar_medias(resposta          = comprimento_cm,
                  grupos            = densidade,
                  rotulo_resposta   = "Comprimento (cm)",
                  rotulo_grupos     = "Densidade de estocagem",
                  confianca         = 0.95,
                  variancias_iguais = FALSE)      # FALSE: ANOVA de Welch

resultado

# 4. Medir o tamanho do efeito ---------------------------------------------
# Na ANOVA de Welch, um ω² aproximado, convertido do F de Welch.
resultado |>
  medir_efeito()

# 5. Mostrar a comparação num gráfico --------------------------------------
# As letras vêm do Games-Howell.
resultado |>
  grafico_medias(explicacao       = TRUE,           # FALSE tira a explicação do topo
                 haste            = "ic",           # "ic", "ep" ou "dp"
                 mostrar_barras   = TRUE,
                 largura_barras   = 0.3,            # de 0 a 1
                 mostrar_pontos   = TRUE,
                 mostrar_media_dp = TRUE,
                 casas            = 1,              # casas decimais do rótulo
                 mostrar_letras   = TRUE,
                 cores            = "ocean",        # "ocean", "cinza" ou um vetor
                 tamanho_texto    = 12,
                 fonte            = "sans")         # "sans" (Arial) ou "serif" (Times)

ggsave("exemplos/figuras/anova_welch_medias.png", width = 7, height = 5,
       create.dir = TRUE)

# A diferença de cada par, com o IC do Games-Howell.
resultado |>
  grafico_pares()

ggsave("exemplos/figuras/anova_welch_pares.png", width = 7, height = 4)

# 6. Conferir os pressupostos nos gráficos ---------------------------------
# Sem modelo comum para os grupos, o resíduo é a distância de cada peixe
# até a média do seu grupo; o Q-Q tem um painel por grupo.
resultado |>
  grafico_residuos()

resultado |>
  grafico_qq()

ggsave("exemplos/figuras/anova_welch_qq.png", width = 7, height = 4)

# 7. Escrever os resultados ------------------------------------------------
textos <- resultado |>
  escrever_resultados()

textos

# 8. Ver o código R por trás da ClaRa --------------------------------------
# Com mostrar_codigo = TRUE, a função imprime o código e depois o resultado:
# a ANOVA de Welch com oneway.test() e o Games-Howell escrito em dplyr.
peixes |>
  comparar_medias(resposta          = comprimento_cm,
                  grupos            = densidade,
                  variancias_iguais = FALSE,
                  mostrar_codigo    = TRUE)
