# ClaRa: o R escrito com clareza

## Carregar os dados de estudo

O catálogo consolidado reúne **56 conjuntos**: 47 internos, oito do FSAdata
e um do MASS. D61 é `anchova_norte_california` (desembarques mensais);
D62 é `larvas_peixes_captura` (contagens e esforço em armadilhas).
São conjuntos distintos, com registros próprios.

```r
library(clara)
bagres <- carregar_dados("bagre_racao_isoproteica")
catalogo_dados[, c("codigo", "nome", "fonte_dados")]
```

Na versão 0.15.0, oito conjuntos do FSAdata e os caranguejos de MASS são lidos
do pacote de origem e traduzidos na hora. Instale o fornecedor uma vez, se
necessário, e carregue o conjunto pelo nome da ClaRa:

```r
install.packages("FSAdata")
snapper <- carregar_dados("snapper_hg")
caranguejos <- carregar_dados("crabs_morfometria")
```

Para esses nove conjuntos, use `carregar_dados()` em vez de `data()` ou
`clara::nome`. Os nomes e os códigos D permanecem, assim como suas páginas de
ajuda. As observações continuam sob a licença do fornecedor. Os outros
conjuntos seguem disponíveis na ClaRa e também podem ser lidos pela nova função.


A ClaRa é um jeito de escrever R pensado para quem está começando na
Estatística Aplicada à Pesca e Aquicultura. Cada função responde a uma
pergunta da pesquisa, em português. Por trás dela roda R comum, no estilo do
tidyverse, e esse código aparece quando você pede.

```r
library(clara)

resultado <- peixes |>
  comparar_medias(resposta        = peso_g,
                  grupos          = racao,
                  rotulo_resposta = "Peso (g)",
                  rotulo_grupos   = "Ração")

resultado                                  # um pequeno relatório no console
resultado |> medir_efeito()                # a diferença é grande ou pequena?
resultado |> grafico_medias()              # a comparação numa figura
resultado |> grafico_qq()                  # os resíduos, num gráfico Q-Q
textos <- resultado |> escrever_resultados()   # frases para o relatório
resultado |> exibir_teste()                # a tabela do teste, para o Word
resultado |> exibir_resumo(nota = textos$nota_tabela)   # médias e letras

ajuda()                                    # a lista de funções
ajuda(comparar_medias)                     # o que uma função faz e como usá-la
```

## Instalar

A ClaRa é um pacote R. Enquanto não chega ao CRAN, instale do GitHub:

```r
install.packages("remotes")
remotes::install_github("cluberufpa/ClaRa")
```

## Como a ClaRa se organiza

**Cada pergunta da pesquisa tem a sua análise e os seus gráficos, com um
nome para cada figura. Quatro verbos servem para qualquer análise: medir o
efeito, escrever os resultados e olhar os resíduos em dois gráficos.** Você não precisa saber o nome do teste: a ClaRa
escolhe o teste certo para a pergunta e diz no relatório qual usou.

| Pergunta da pesquisa | Análise | Gráfico | Testes por trás | Situação |
|---|---|---|---|---|
| A média difere entre os grupos? | `comparar_medias()` | `grafico_medias()`, `grafico_boxplot()`, `grafico_pares()` | teste t de Welch ou de Student (2 grupos); ANOVA clássica com Tukey ou ANOVA de Welch com Games-Howell (3 ou mais) | pronta |
| A mediana difere entre os grupos? | `comparar_medianas()` | `grafico_medianas()`, `grafico_boxplot()` | Mann-Whitney (2 grupos); Kruskal-Wallis com Dunn (3 ou mais) | pronta |
| Uma variável acompanha a outra? | `relacionar_variaveis()` | `grafico_reta()` | regressão linear simples, com Shapiro-Wilk e Breusch-Pagan nos resíduos (Durbin-Watson, se a ordem das linhas for a da coleta) | pronta |
| A proporção difere entre os grupos? | `comparar_proporcoes()` | ainda sem nome | qui-quadrado ou teste de proporções | planejada |

| Para qualquer análise | O que faz |
|---|---|
| `medir_efeito()` | diz se o efeito é grande ou pequeno (η², ω², d de Cohen, ε² dos postos, r e R²...) |
| `escrever_resultados()` | escreve as frases do relatório, que mudam junto com os dados |
| `exibir_teste()` | a tabela do teste (ANOVA, t, Kruskal-Wallis, coeficientes da reta...), pronta para o Word |
| `exibir_resumo()` | a tabela por grupo, com a letra das comparações sobrescrita e a nota de rodapé (na regressão, o ajuste do modelo) |
| `grafico_residuos()` | resíduos contra ajustados: variâncias parecidas e, na regressão, sem curva (médias e regressão) |
| `grafico_qq()` | gráfico Q-Q: os resíduos são compatíveis com a normal? (médias e regressão) |
| `salvar_tabelas()` | grava cada tabela em CSV que o Excel em português abre |
| `salvar_figuras()` | grava cada gráfico em PNG, com medidas em centímetros |
| `registrar_ambiente()` | grava as versões da ClaRa, do R e dos pacotes, no fim do roteiro |
| `ajuda()` | lista as funções ou explica uma delas |

| Formatar e exibir | O que faz |
|---|---|
| `formatar_numero()` | escreve números com vírgula decimal: `86,25` |
| `formatar_p()` | escreve o p como no artigo: `0,032`, `< 0,001` ou `p = 0,032` |
| `exibir_tabela()` | qualquer tabela no tema Ocean (Word) ou cinza (Viewer) |

Uma análise nova não cria funções novas em "Para qualquer análise": ela só
ensina a `medir_efeito()`, a `escrever_resultados()`, a `exibir_teste()`,
a `exibir_resumo()`, a `grafico_residuos()` e a `grafico_qq()` a falar dela. Por isso a
lista de funções continua curta, mesmo com muitas análises.

## A gramática da ClaRa

A ClaRa tem poucas classes de palavras, e elas se combinam sempre do mesmo
jeito. Quem aprende a frase de uma análise já sabe escrever a das outras.

| Classe | O que é | Exemplos |
|---|---|---|
| **Substantivos** | o que existe no roteiro: a base de dados e o resultado de uma análise | `bagres`, `resultado`, `textos` |
| **Verbos de pergunta** | fazem a análise; recebem a base e devolvem um resultado | `comparar_medias()`, `comparar_medianas()` |
| **Verbos sobre o resultado** | recebem o resultado e devolvem uma tabela, uma figura ou frases | `medir_efeito()`, `grafico_...()`, `escrever_resultados()` |
| **Modificadores** | os argumentos: dizem o papel de cada coluna e as escolhas da análise | `resposta`, `grupos`, `rotulo_resposta`, `variancias_iguais` |

Três regras ligam as palavras:

1. **Toda frase começa por um substantivo e segue pelo pipe** (`|>`): a base
   entra num verbo de pergunta; o resultado entra num verbo sobre o
   resultado.
2. **O resultado lembra a análise.** O que você disse na pergunta (as
   colunas, os rótulos, a confiança, o teste escolhido) fica guardado nele.
   Por isso as frases seguintes são curtas: `resultado |> grafico_medias()`
   já sabe que o eixo se chama "Peso (g)".
3. **O mesmo verbo serve a qualquer análise.** `medir_efeito()` devolve η²
   depois de uma ANOVA, d de Cohen depois de um teste t e ε² depois de um
   Kruskal-Wallis. O verbo pergunta ao resultado qual análise foi feita.

Um modificador muda a análise sem mudar a pergunta (`variancias_iguais =
TRUE` troca o Welch pelo Student no teste t; `variancias_iguais = FALSE`
troca a ANOVA clássica pela de Welch). Uma pergunta nova pede um verbo novo
(medianas não são médias). Cada figura tem o seu nome: nenhum modificador
troca uma figura por outra.

Escreva um modificador por linha, com os `=` alinhados. O roteiro fica mais
longo, mas cada escolha aparece numa linha própria e se lê sem esforço.
Quando a escolha importa para a conclusão, escreva-a mesmo que seja o
padrão (`variancias_iguais = FALSE`): assim o roteiro registra a decisão.

Quando é preciso programar (ler arquivos, preparar a base), o roteiro volta
ao R comum, com dplyr. A ClaRa cuida das análises, não substitui o R. Para
guardar cópias, `salvar_tabelas()` e `salvar_figuras()` dispensam o `for`:
o nome antes do `=` vira o nome do arquivo (`anova = resultado$anova` grava
`anova.csv`).

## Ver o R por trás

Toda função aceita `mostrar_codigo = TRUE`. Ela imprime o código R que vai
rodar, com os nomes das suas colunas, e depois o executa. O código mostrado é
exatamente o código que rodou, e mostra só a análise que você fez. Dá para
copiar, colar e rodar sem a ClaRa.

## Pastas

```
R/clara.R         a página do pacote e o mapa dos arquivos
R/clara_*.R       um arquivo por pergunta (clara_medias.R, clara_medianas.R),
                  o que serve a qualquer análise e o motor
man/              as páginas de ajuda, geradas pelo roxygen2 (não editar)
tests/testthat/   os testes: cada situação dos dados de treino e a conferência
                  de que a receita mostrada dá o mesmo resultado
exemplos/         um roteiro por análise; as figuras que ele gera ficam em figuras/
dados_treino/     dados reais e sintéticos para testar e estudar as funções
docs/             histórico e ideias
```

Para rodar um exemplo, com a ClaRa instalada, a partir da raiz do projeto:

```
Rscript exemplos/anova_um_fator.R
```

Pacotes do CRAN: dplyr, ggplot2, broom, car, multcompView, effectsize, rlang,
stringr, pwr e withr.

## Licença

MIT. Copyright (c) 2026 clubeR e Evaldo Martins da Silva.
