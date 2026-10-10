# clara 0.12.0 (10 de outubro de 2026)

Relacionar variáveis (decisões do professor de 10/10/2026), pedida pela
Trilha para levar a regressão linear simples para a ClaRa. Nova pergunta,
em `R/clara_regressao.R`.

* `relacionar_variaveis(dados, resposta, preditor, rotulo_resposta,
  rotulo_preditor, confianca = 0.95, avaliar_autocorrelacao = FALSE)`: a
  regressão linear simples. Devolve `$coeficientes` (intercepto e
  inclinação, com EP, IC, t e p), `$ajuste` (n, R², R² ajustado, erro
  padrão dos resíduos e F), `$pressupostos` (Shapiro-Wilk e
  Breusch-Pagan nos resíduos; Durbin-Watson só com
  `avaliar_autocorrelacao = TRUE`, com `set.seed(1)` porque o p vem de
  reamostragem), `$influencia` (as observações com resíduo padronizado
  acima de 3, alavancagem acima de 2p/n ou Cook acima de 4/n, com
  `linha_da_base`), `$amostra`, `$dados` e `$modelo`. Os testes são os
  mesmos da tela da Trilha (`car::ncvTest()` dá o mesmo p de
  `performance::check_heteroscedasticity()`).
* `grafico_reta()`: a figura principal, com os pontos, a reta, a faixa de
  confiança (calculada com `predict()`, no nível da análise) e a equação
  com o R². `colorir_por` dá uma cor por grupo aos pontos, só para a
  leitura: a reta continua uma só.
* Receitas da regressão nos verbos para qualquer análise:
  `medir_efeito()` (r de Pearson e R², com IC; leitura de Cohen para r,
  que ao quadrado vale para o R²), `escrever_resultados()` (com
  `$equacao` e `$influencia`; `$nota_tabela` e `$legenda_figura` da
  regressão), `exibir_teste()` (os coeficientes), `exibir_resumo()` (o
  ajuste do modelo), `grafico_residuos()` (nuvem única com uma curva loess,
  para mostrar curvatura e funil) e `grafico_qq()` (resíduos
  padronizados, como na ANOVA).
* `exibir_teste()` ganhou `rotulo_preditor` e `casas` (só a regressão os usa)
  e `nota`, a nota de rodapé, como `exibir_resumo()` (em todas as análises);
  `escrever_resultados()` ganhou `rotulo_preditor`, que só vale para a
  regressão.
* Dados de treino novos: `real_barbo_morfometria` (reta limpa, cinco
  populações) e `real_cangulo_peso_comprimento` (relação curva). Roteiro
  novo: `exemplos/regressao_barbo.R`.

# clara 0.11.0 (10 de outubro de 2026)

Teste t unilateral (decisão do professor, 10/10/2026), para a Trilha levar
o teste t de duas amostras para a ClaRa sem perder a hipótese unilateral
que a tela dela oferece.

* `comparar_medias(..., alternativa = "bilateral")`: com dois grupos,
  `"maior"` (a média do primeiro grupo, na ordem dos níveis, é maior que a
  do segundo) ou `"menor"`. Com três ou mais grupos, só `"bilateral"`: a
  ANOVA é sempre bilateral, e a função recusa com mensagem. A escolha fica
  em `resultado$nomes$alternativa`, e a receita escreve `alternative =` no
  `t.test()`.
* No unilateral, o intervalo da diferença é aberto de um lado. As frases
  de `escrever_resultados()`, a tabela de `exibir_teste()` (coluna
  "IC 95% unilateral") e o console escrevem `+∞` ou `-∞`;
  `grafico_pares()` tem receita própria, com uma seta no lado aberto. O
  intervalo do tamanho de efeito continua bilateral.
* No unilateral, o poder é calculado no sentido da hipótese; se a
  diferença saiu no sentido contrário, `$poder` diz isso.
* `escrever_resultados()` do teste t passa a trazer `$nota_tabela` e
  `$legenda_figura`, como a ANOVA (para o relatório do teste t na Trilha).
* `formatar_numero()` e as tabelas escrevem `+∞` e `-∞` no lugar de `Inf`.

# clara 0.10.0 (9 de outubro de 2026)

Formatar e exibir (decisões B, C e D do professor): uma só versão das
funções de formatação que hoje se repetem nos moldes da Trilha
(`fmt()`, `formatar_p()`, `flextable_ocean()`) e no EAPADados
(`flextable_ocean()`, `flextable_cinza()`).

* `formatar_numero()`: vírgula decimal, casas fixas e traço no `NA`; faz
  o que o `fmt()` dos moldes fazia.
* `formatar_p()`: `"0,032"`, `"< 0,001"` e, com `no_texto = TRUE`,
  `"p = 0,032"`; traço no `NA`.
* `exibir_tabela()`: qualquer tabela no tema `"ocean"` (relatório Word,
  Times New Roman 10, cabeçalho azul-marinho) ou `"cinza"` (Viewer, letra
  de console, fundo verde acinzentado).
* `exibir_teste()` e `exibir_resumo()`: as duas tabelas do relatório a
  partir do resultado, com uma receita por análise (ANOVA, ANOVA de Welch,
  teste t, Kruskal-Wallis e Mann-Whitney) e o código visível com
  `mostrar_codigo = TRUE`. `exibir_resumo()` põe a letra das comparações
  sobrescrita à média (ou à mediana) e aceita a nota de rodapé de
  `escrever_resultados()` em `nota = textos$nota_tabela`.
* flextable entra em Imports.
* Os `print()` dos resultados usam `formatar_numero()` e `formatar_p()`; as
  peças internas `numero()` e `escrever_p()` saíram. A saída no console não
  mudou.

# clara 0.9.0 (9 de outubro de 2026)

A ClaRa vira pacote R (`library(clara)`). As funções, os argumentos e os
resultados são os mesmos da ClaRa 0.8.9: os seis roteiros de `exemplos/`
dão os mesmos números e as mesmas figuras.

* Instalação: `remotes::install_github("cluberufpa/ClaRa")`. No roteiro,
  `library(clara)` no lugar de `source("R/clara.R")`.
* Documentação pelo roxygen2: cada função tem a sua página no painel Help
  (`?comparar_medias`), com a pergunta da pesquisa como título e exemplos
  que rodam com dados do próprio R (`PlantGrowth`, `ToothGrowth`,
  `InsectSprays`).
* `ajuda()` lista as funções a partir das páginas de ajuda do pacote e
  abre a página de uma função no painel Help. O argumento `onde` passa a
  aceitar `"painel"` (padrão) ou `"console"`.
* As receitas rodam sem `library()`: os pacotes ficam visíveis só para a
  receita, e o caminho de busca do aluno não muda. O código mostrado com
  `mostrar_codigo = TRUE` traz os `library()` no topo, para a receita
  copiada rodar numa sessão nova.
* A semente aleatória do aluno é preservada, mesmo quando a receita usa
  `set.seed()` (o intervalo do ε² por bootstrap).
* A versão vem do `DESCRIPTION` (`packageVersion("clara")`); acabou o
  `versao_clara` em `R/clara.R`.
* Testes com testthat: os números conferem com `aov()`, `TukeyHSD()`,
  `oneway.test()`, `t.test()`, `kruskal.test()` e `wilcox.test()`, e a
  receita mostrada, rodada sem a ClaRa, dá o mesmo resultado da função.
