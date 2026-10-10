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
