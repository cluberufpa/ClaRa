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
library(clara)

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
# Os rótulos ficam guardados no resultado: gráficos e textos já os usam.
resultado <- bagres |>
  comparar_medias(resposta        = peso_g,
                  grupos          = racao,
                  rotulo_resposta = "Peso (g)",
                  rotulo_grupos   = "Tipo de Ração",
                  confianca       = 0.95)

resultado

# Tamanho de efeito: η² e ω², com a leitura de Cohen.
resultado |>
  medir_efeito(mostrar_codigo = F)

# 8. Tabelas ---------------------------------------------------------------
# As tabelas já saem prontas do resultado, para conferir no console.
resultado$resumo
resultado$anova
resultado$pares

# Para o Word, exibir_teste() e exibir_resumo() as montam no tema Ocean, com
# nomes em português e vírgula decimal (tema = "cinza" para o Viewer).
resultado |>
  exibir_teste()

resultado |>
  exibir_resumo(casas = 1)        # a nota de rodapé entra na seção 10

# 9. Gráficos --------------------------------------------------------------

# Cada gráfico fica guardado com um nome, para ser salvo na seção 11.

# 9.1 Exploração: caixas com as observações por cima.
grafico_caixas <- resultado |>
  grafico_boxplot()

grafico_caixas

# 9.2 Figura principal: barras, pontos, média ± DP, IC e letras.
# A figura que vai para o artigo: todas as escolhas escritas, com as opções
# ao lado. Um título, se a revista pedir, entra com titulo = "...".
grafico_barras <- resultado |>
  grafico_medias(explicacao       = TRUE,           # FALSE tira a explicação do topo
                 haste            = "ic",           # "ic", "ep" ou "dp"
                 mostrar_barras   = TRUE,
                 largura_barras   = 0.3,            # de 0 a 1
                 mostrar_pontos   = TRUE,
                 mostrar_media_dp = TRUE,
                 casas            = 2,              # casas decimais do rótulo
                 angulo_rotulo    = -90,            # 0 deitado; -90 ou 90 em pé
                 altura_rotulo    = 0.5,            # fração da barra
                 mostrar_letras   = TRUE,
                 cores            = "ocean",        # "ocean", "cinza" ou um vetor
                 tamanho_texto    = 12,
                 fonte            = "serif")         # "sans" (Arial) ou "serif" (Times)

grafico_barras

# 9.3 Resíduos contra ajustados: faixas de alturas parecidas, variâncias parecidas.
grafico_ajustados <- resultado |>
  grafico_residuos()

grafico_ajustados

# 9.4 Q-Q: pontos perto da reta, resíduos compatíveis com a normal.
grafico_normal <- resultado |>
  grafico_qq()

grafico_normal

# 9.5 Diferenças entre pares: haste que cruza a linha tracejada (zero),
#     sem diferença entre os dois grupos.
grafico_diferencas <- resultado |>
  grafico_pares()

grafico_diferencas

# 10. Textos para o relatório ----------------------------------------------
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados()

textos

# A tabela de médias com a nota de rodapé que escrever_resultados() escreveu.
resultado |>
  exibir_resumo(casas = 1,
                nota  = textos$nota_tabela)

# 11. Salvar cópias --------------------------------------------------------
# No projeto da CatalyseR, os CSVs e PNGs vão para saida/. Aqui, só as
# figuras, em exemplos/figuras/, com o nome do roteiro na frente.
# O nome antes do = vira o nome do arquivo: anova_bagres_boxplot.png...
salvar_figuras(anova_bagres_boxplot  = grafico_caixas,
               anova_bagres_medias   = grafico_barras,
               anova_bagres_residuos = grafico_ajustados,
               anova_bagres_qq       = grafico_normal,
               anova_bagres_pares    = grafico_diferencas,
               pasta                 = "exemplos/figuras",
               largura               = 18,
               altura                = 12)

# 12. Registrar o ambiente -------------------------------------------------
# As versões da ClaRa, do R e dos pacotes usadas nesta execução.
registrar_ambiente(arquivo = "exemplos/figuras/anova_bagres_sessionInfo.txt")
