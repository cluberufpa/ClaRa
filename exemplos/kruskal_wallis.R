# COMPARAÇÃO DE MEDIANAS COM A ClaRa: EXEMPLO COM TRÊS GRUPOS
# x========================================================================x
# Pergunta: a captura por unidade de esforço (CPUE, kg) difere entre os
# petrechos de pesca?
# Dados: sintéticos, 45 lances (15 por petrecho). A CPUE é assimétrica: a
# maioria dos lances pesca pouco, e alguns pescam muito. Com resposta assim,
# a mediana representa melhor o lance típico do que a média.
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/kruskal_wallis.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
source("R/clara.R", encoding = "UTF-8")

# 2. Ler os dados ----------------------------------------------------------
capturas <- readRDS("dados_treino/sint_residuos_assimetricos.rds")

glimpse(capturas)

# 3. Comparar as medianas --------------------------------------------------
# Com três grupos, a ClaRa usa o Kruskal-Wallis e, para os pares, o Dunn.
# Os rótulos ficam guardados no resultado: gráficos e textos já os usam.
resultado <- capturas |>
  comparar_medianas(resposta        = cpue_kg,
                    grupos          = petrecho,
                    rotulo_resposta = "CPUE (kg)",
                    rotulo_grupos   = "Petrecho",
                    confianca       = 0.95)

resultado

# 4. Olhar as observações de cada grupo ------------------------------------
# Pontos muito acima dos outros, em todos os petrechos: a CPUE é assimétrica.
# Caixas de alturas parecidas: dispersão parecida, como o Fligner-Killeen.
grafico_caixas <- resultado |>
  grafico_boxplot()

grafico_caixas

# 5. Medir o tamanho do efeito ---------------------------------------------
resultado |>
  medir_efeito()

# 6. Mostrar a comparação num gráfico --------------------------------------
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

# 7. Ver o código R por trás da ClaRa --------------------------------------
# Com mostrar_codigo = TRUE, a função imprime o código e depois o resultado.
capturas |>
  comparar_medianas(resposta       = cpue_kg,
                    grupos         = petrecho,
                    mostrar_codigo = TRUE)

# 8. Escrever os resultados ------------------------------------------------
# As frases saem do resultado: se os dados mudam, o texto muda junto.
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados()

textos

# 9. Guardar as figuras ----------------------------------------------------
# O nome antes do = vira o nome do arquivo: kruskal_wallis_boxplot.png...
salvar_figuras(kruskal_wallis_boxplot  = grafico_caixas,
               kruskal_wallis_medianas = grafico_principal,
               pasta                   = "exemplos/figuras",
               largura                 = 18,
               altura                  = 12)
