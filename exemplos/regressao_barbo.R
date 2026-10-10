# REGRESSÃO LINEAR SIMPLES COM A ClaRa: MORFOMETRIA DO BARBO
# x========================================================================x
# Pergunta: a altura máxima do corpo do barbo acompanha a distância entre as
# nadadeiras dorsal e pélvica?
# Dados: 100 barbos (Barbus petenyi) de cinco populações, do pacote
# EAPADados. As medidas já foram corrigidas pelo comprimento padrão: a
# relação descreve a forma do corpo, não o crescimento dos peixes.
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/regressao_barbo.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
library(clara)

# 2. Ler os dados ----------------------------------------------------------
barbos <- readRDS("dados_treino/real_barbo_morfometria.rds")

glimpse(barbos)

# 3. Ajustar a reta --------------------------------------------------------
# A ClaRa ajusta a regressão linear simples e confere os resíduos. Os
# rótulos ficam guardados no resultado: gráficos e textos já os usam.
# As linhas da base estão em ordem de população, não na ordem da coleta;
# por isso a independência fica com o delineamento (avaliar_autocorrelacao
# = FALSE).
resultado <- barbos |>
  relacionar_variaveis(resposta               = altura_maxima_corpo,
                       preditor               = distancia_dorsal_pelvica,
                       rotulo_resposta        = "Altura máxima do corpo",
                       rotulo_preditor        = "Distância dorsal-pélvica",
                       confianca              = 0.95,
                       avaliar_autocorrelacao = FALSE)

resultado

# 4. Medir o tamanho do efeito ---------------------------------------------
resultado |>
  medir_efeito()

# 5. Tabelas ---------------------------------------------------------------
# Os coeficientes (intercepto e inclinação) e o ajuste do modelo.
textos <- resultado |>
  escrever_resultados()

resultado |>
  exibir_teste(tema = "cinza")

resultado |>
  exibir_resumo(nota = textos$nota_tabela,
                tema = "cinza")

# 6. Mostrar a reta num gráfico --------------------------------------------
# A figura que vai para o artigo: todas as escolhas escritas, com as opções
# ao lado. As cores por população ajudam a ler a figura; a reta continua
# uma só, a de todos os peixes juntos.
grafico_principal <- resultado |>
  grafico_reta(explicacao      = TRUE,           # FALSE tira a explicação do topo
               mostrar_faixa   = TRUE,
               mostrar_equacao = TRUE,
               colorir_por     = populacao,      # sem ele, uma cor só
               rotulo_cores    = "População",
               cores           = "ocean",        # "ocean", "cinza" ou um vetor
               casas           = 2,
               tamanho_texto   = 12,
               fonte           = "sans")         # "sans" (Arial) ou "serif" (Times)

grafico_principal

# 7. Conferir os resíduos --------------------------------------------------
# Resíduos contra ajustados: sem curva e sem funil, a reta serve.
grafico_residuos_reta <- resultado |>
  grafico_residuos()

grafico_residuos_reta

# Q-Q: pontos perto da reta, resíduos compatíveis com a normal.
grafico_qq_reta <- resultado |>
  grafico_qq()

grafico_qq_reta

# 8. Ver o código R por trás da ClaRa --------------------------------------
# Com mostrar_codigo = TRUE, a função imprime o código e depois o resultado.
barbos |>
  relacionar_variaveis(resposta       = altura_maxima_corpo,
                       preditor       = distancia_dorsal_pelvica,
                       mostrar_codigo = TRUE)

# 9. Escrever os resultados ------------------------------------------------
# As frases saem do resultado: se os dados mudam, o texto muda junto.
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos

# 10. Guardar as figuras ---------------------------------------------------
# O nome antes do = vira o nome do arquivo: regressao_barbo_reta.png...
salvar_figuras(regressao_barbo_reta     = grafico_principal,
               regressao_barbo_residuos = grafico_residuos_reta,
               regressao_barbo_qq       = grafico_qq_reta,
               pasta                    = "exemplos/figuras",
               largura                  = 18,
               altura                   = 12)
