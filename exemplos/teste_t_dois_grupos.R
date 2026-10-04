# COMPARAÇÃO DE DUAS MÉDIAS COM A ClaRa: EXEMPLO
# x========================================================================x
# Pergunta: na menor dose de vitamina C, o crescimento dos dentes muda
#           conforme a fonte da vitamina?
# Dados: ToothGrowth, que já vem com o R. São 60 porquinhos-da-índia que
#        receberam vitamina C como suco de laranja (OJ) ou como ácido
#        ascórbico (VC), em três doses. Aqui usamos só a dose de 0,5 mg/dia:
#        10 animais em cada fonte.
# Com dois grupos, comparar_medias() faz o teste t de Welch no lugar da ANOVA.
# Rode a partir da raiz do projeto (abrindo o ClaRa.Rproj ou com Rscript):
#   Rscript exemplos/teste_t_dois_grupos.R

# 1. Preparar o ambiente ---------------------------------------------------
library(dplyr)
library(ggplot2)
source("R/clara.R", encoding = "UTF-8")

# Ficamos com a menor dose e damos nomes em português às colunas.
dentes <- ToothGrowth |>
  filter(dose == 0.5) |>
  rename(comprimento = len, fonte = supp)

# 2. Comparar as médias ----------------------------------------------------
# Os rótulos ficam guardados no resultado: gráficos e textos já os usam.
# variancias_iguais = FALSE é o padrão (Welch); escrito aqui, a escolha fica
# registrada no roteiro.
resultado <- dentes |>
  comparar_medias(resposta          = comprimento,
                  grupos            = fonte,
                  rotulo_resposta   = "Comprimento dos odontoblastos",
                  rotulo_grupos     = "Fonte de vitamina C",
                  confianca         = 0.95,
                  variancias_iguais = FALSE)

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
dentes |>
  comparar_medias(resposta       = comprimento,
                  grupos         = fonte,
                  mostrar_codigo = TRUE)

# 6. Guardar a figura ------------------------------------------------------
# O ggsave() grava o último gráfico desenhado, o da seção 4.
ggsave("exemplos/figuras/teste_t_dois_grupos.png",
       width      = 7,
       height     = 4.6,
       dpi        = 300,
       bg         = "white",
       create.dir = TRUE)

# 7. Ajustar o gráfico com o ggplot2 ---------------------------------------
# grafico_medias() devolve um gráfico do ggplot2: dá para continuar com +.
# Aqui trocamos os códigos OJ e VC por nomes e tiramos a explicação do topo.
resultado |>
  grafico_medias() +
  scale_x_discrete(labels = c(OJ = "Suco de laranja",
                              VC = "Ácido ascórbico")) +
  labs(title = NULL)

# 8. Supor variâncias iguais (teste de Student) ----------------------------
# Se a exploração dos dados mostrou dispersões parecidas nos dois grupos,
# dá para pedir o teste de Student. O relatório inclui o Levene e avisa se
# ele rejeitar a igualdade das variâncias.
dentes |>
  comparar_medias(resposta          = comprimento,
                  grupos            = fonte,
                  variancias_iguais = TRUE)

# 9. Olhar os resíduos -----------------------------------------------------
# No teste t, o Q-Q tem um painel por grupo, como o Shapiro em cada grupo.
resultado |>
  grafico_qq()

# 10. Escrever os resultados -----------------------------------------------
# As frases saem do resultado: se os dados mudam, o texto muda junto.
# No Quarto, cada frase entra no parágrafo com `r textos$teste`.
textos <- resultado |>
  escrever_resultados()

textos

# 11. Pedir ajuda ----------------------------------------------------------
# ajuda() lista as funções da ClaRa; ajuda(nome) explica uma delas.
ajuda()
ajuda(comparar_medias)
