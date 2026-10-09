# COMPARAÇÃO DE DUAS MEDIANAS COM A ClaRa: EXEMPLO
# x========================================================================x
# Pergunta: a taxa de crescimento das artêmias (mg/dia) difere entre as
# duas rações?
# Dados: reais, do pacote EAPADados (14 artêmias, 7 por ração).
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/mann_whitney.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
library(clara)

# 2. Ler os dados ----------------------------------------------------------
artemias <- readRDS("dados_treino/real_artemia_racoes.rds")

glimpse(artemias)

# 3. Comparar as medianas --------------------------------------------------
# Com dois grupos, a ClaRa usa o Mann-Whitney no lugar do Kruskal-Wallis.
# Os rótulos ficam guardados no resultado: gráficos e textos já os usam.
resultado <- artemias |>
  comparar_medianas(resposta        = taxa_crescimento_mg_dia,
                    grupos          = racao,
                    rotulo_resposta = "Taxa de crescimento (mg/dia)",
                    rotulo_grupos   = "Ração",
                    confianca       = 0.95)

resultado

# 4. Medir o tamanho do efeito ---------------------------------------------
resultado |>
  medir_efeito()

# 5. Mostrar a comparação num gráfico --------------------------------------
# A figura que vai para o artigo: todas as escolhas escritas, com as opções
# ao lado. Um título, se a revista pedir, entra com titulo = "...".
grafico_principal <- resultado |>
  grafico_medianas(explicacao     = TRUE,           # FALSE tira a explicação do topo
                   mostrar_pontos = TRUE,
                   mostrar_letras = TRUE,
                   cores          = "ocean",        # "ocean", "cinza" ou um vetor
                   tamanho_texto  = 12,
                   fonte          = "sans")         # "sans" (Arial) ou "serif" (Times)

grafico_principal

# 6. Ver o código R por trás da ClaRa --------------------------------------
# Com mostrar_codigo = TRUE, a função imprime o código e depois o resultado.
resultado |>
  medir_efeito(mostrar_codigo = TRUE)

# 7. Escrever os resultados ------------------------------------------------
# As frases saem do resultado: se os dados mudam, o texto muda junto.
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados()

textos

# 8. Guardar a figura ------------------------------------------------------
ggsave("exemplos/figuras/mann_whitney_medianas.png",
       plot       = grafico_principal,
       width      = 7,
       height     = 4.6,
       dpi        = 300,
       bg         = "white",
       create.dir = TRUE)
