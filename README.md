# ClaRa: o R escrito com clareza

A ClaRa é um jeito de escrever R pensado para quem está começando na
Estatística Aplicada à Pesca e Aquicultura. Cada função responde a uma
pergunta da pesquisa, em português. Por trás dela roda R comum, no estilo do
tidyverse, e esse código aparece quando você pede.

```r
source("R/clara.R", encoding = "UTF-8")

resultado <- peixes |>
  comparar_medias(resposta = peso_g, grupos = racao)

resultado                                  # um pequeno relatório no console
resultado |> medir_efeito()                # a diferença é grande ou pequena?
resultado |> grafico_medias()              # a comparação numa figura
resultado |> grafico_qq()                  # os resíduos, num gráfico Q-Q
textos <- resultado |> escrever_resultados()   # frases para o relatório

ajuda()                                    # a lista de funções
ajuda(comparar_medias)                     # o que uma função faz e como usá-la
```

## Como a ClaRa se organiza

**Cada pergunta da pesquisa tem a sua análise e os seus gráficos, com um
nome para cada figura. Quatro verbos servem para qualquer análise: medir o
efeito, escrever os resultados e olhar os resíduos em dois gráficos.** Você não precisa saber o nome do teste: a ClaRa
escolhe o teste certo para a pergunta e diz no relatório qual usou.

| Pergunta da pesquisa | Análise | Gráfico | Testes por trás | Situação |
|---|---|---|---|---|
| A média difere entre os grupos? | `comparar_medias()` | `grafico_medias()`, `grafico_boxplot()`, `grafico_pares()` | teste t de Welch ou de Student (2 grupos); ANOVA com Tukey (3 ou mais) | pronta |
| A mediana difere entre os grupos? | `comparar_medianas()` | `grafico_medianas()` | Mann-Whitney (2 grupos); Kruskal-Wallis (3 ou mais) | planejada |
| Uma variável acompanha a outra? | `relacionar_variaveis()` | ainda sem nome | regressão linear | planejada |
| A proporção difere entre os grupos? | `comparar_proporcoes()` | ainda sem nome | qui-quadrado ou teste de proporções | planejada |

| Para qualquer análise | O que faz |
|---|---|
| `medir_efeito()` | diz se o efeito é grande ou pequeno (η², ω², d de Cohen...) |
| `escrever_resultados()` | escreve as frases do relatório, que mudam junto com os dados |
| `grafico_residuos()` | resíduos contra ajustados: as variâncias dos grupos são parecidas? |
| `grafico_qq()` | gráfico Q-Q: os resíduos são compatíveis com a normal? |
| `ajuda()` | lista as funções ou explica uma delas |

Uma análise nova não cria funções novas em "Para qualquer análise": ela só
ensina a `medir_efeito()`, a `escrever_resultados()`, a `grafico_residuos()`
e a `grafico_qq()` a falar dela. Por isso a
lista de funções continua curta, mesmo com muitas análises.

## Ver o R por trás

Toda função aceita `mostrar_codigo = TRUE`. Ela imprime o código R que vai
rodar, com os nomes das suas colunas, e depois o executa. O código mostrado é
exatamente o código que rodou, e mostra só a análise que você fez. Dá para
copiar, colar e rodar sem a ClaRa.

## Pastas

```
R/clara.R         as funções (um arquivo por pergunta quando a ClaRa crescer)
exemplos/         um roteiro por análise, com as figuras que ele gera
dados_treino/     dados reais e sintéticos para testar e estudar as funções
docs/             histórico e ideias
```

Para rodar um exemplo, a partir da raiz do projeto:

```
Rscript exemplos/anova_um_fator.R
```

Pacotes do CRAN: dplyr, ggplot2, broom, car, multcompView, effectsize, rlang,
stringr e pwr.

## Licença

MIT. Copyright (c) 2026 clubeR e Evaldo Martins da Silva.
