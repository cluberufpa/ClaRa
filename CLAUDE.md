# ClaRa: o R escrito com clareza

Este projeto desenvolve a **ClaRa**, um jeito de escrever R pensado para
estudantes iniciantes de Engenharia de Pesca (disciplina de Estatística
Aplicada, ecossistema EAPA / CatalyseR Studio). A ClaRa é um dialeto amigável,
não uma linguagem nova: cada função responde a uma pergunta da pesquisa, em
português, e por trás dela roda R comum, no estilo do tidyverse.

Todo o projeto é escrito em **português do Brasil**: código, comentários,
mensagens de erro e documentação.

## Estrutura

```
ClaRa/
  CLAUDE.md                     este arquivo
  ClaRa.Rproj
  R/                            só as funções
    clara.R                     todas as funções da ClaRa, em seções
  exemplos/                     um roteiro por análise, com as figuras que ele gera
    anova_um_fator.R            ANOVA de um fator (PlantGrowth renomeado)
    anova_um_fator.png          figura gerada pelo próprio roteiro (ggsave)
    teste_t_dois_grupos.R       teste t de Welch (ToothGrowth, dose 0,5)
    teste_t_dois_grupos.png
  docs/                         histórico e ideias, nunca código
    concepcao_inicial_2026-09.md  primeira concepção da ClaRa (ver abaixo)
  .claude/skills/clara-nova-funcao/SKILL.md
                                passo a passo para criar uma função nova
```

Para testar tudo, a partir da raiz do projeto:

```
Rscript -e 'source("exemplos/anova_um_fator.R", echo = TRUE)'
Rscript -e 'source("exemplos/teste_t_dois_grupos.R", echo = TRUE)'
```

O R desta máquina está em `C:\R\R-4.6.1` (`C:/R/R-4.6.1/bin/Rscript.exe`).
No Git Bash, um `-e` com várias linhas derruba o Rscript: grave o teste num
arquivo `.R` e rode o arquivo.

Os roteiros de `exemplos/` rodam sempre a partir da raiz: carregam as funções
com `source("R/clara.R")` e gravam suas figuras em `exemplos/`.

Pacotes usados: dplyr, ggplot2, broom, car, multcompView, effectsize, rlang.

## Como o aluno usa (v0.1)

```r
resultado <- plantas |>
  comparar_medias(resposta = peso, grupos = tratamento)

resultado                       # imprime um pequeno relatório no console

resultado |>
  medir_efeito()

resultado |>
  grafico_medias(rotulo_resposta = "Peso seco (g)",
                 rotulo_grupos   = "Tratamento")
```

`comparar_medias()` escolhe o teste pelo número de grupos com dados (uma só
pergunta; a ClaRa escolhe o teste):

| Grupos | Teste | Partes próprias | `medir_efeito()` |
|---|---|---|---|
| 2 | t de Welch (padrão) ou de Student (`variancias_iguais = TRUE`, com Levene) | `$teste` | d de Cohen e g de Hedges (`pooled_sd` segue `variancias_iguais`) |
| 3 ou mais | ANOVA, Shapiro dos resíduos, Levene, Tukey | `$anova`, `$pares`, `$modelo` | η² e ω² |

As duas devolvem `$resumo` (com `letra`), `$pressupostos` e `$dados`, por isso
`grafico_medias()` serve para as duas sem mudança. As receitas ficam em
`receitas_medias` e `receitas_efeito` (listas com `anova` e `teste_t`), e a
análise escolhida fica anotada em `resultado$nomes$analise`. O que muda entre
Welch e Student (título do passo 3 e bloco de pressupostos) mora em
`variantes_teste_t`; esses trechos entram primeiro no `preencher_receita()`,
porque também têm marcadores.

`variancias_iguais = TRUE` é escolha do aluno, pensada para quando a
exploração dos dados (menu Explorar e Visualizar da CatalyseR) já mostrou
dispersões parecidas. A ClaRa nunca troca de teste olhando o Levene; se o
Levene rejeitar, o relatório recomenda voltar ao Welch.

### Ajuda

`ajuda()` lista as funções; `ajuda(comparar_medias)` imprime o cabeçalho
da função, lido do próprio `clara.R` (o caminho fica em `arquivo_clara`,
descoberto no `source()`). Por isso toda função do aluno precisa de um
cabeçalho no formato:

```
# nome_da_funcao() -------------------------------------------------------
#
# Pergunta: ...?
#
# O que faz.
#
# Argumentos:
#   argumento ........... o que é
#
# Devolve ...
#
# Exemplo:
#   ...
#
```

A linha de título (`# nome() ----`) é só para funções do aluno: é ela que a
`ajuda()` procura. Peças internas levam um comentário comum.

## A ideia central: a receita

Cada função da ClaRa guarda uma **receita**: um texto com código R em estilo
tidyverse, com marcadores `<<NOME>>` (por exemplo `<<RESPOSTA>>`,
`<<GRUPOS>>`, `<<DADOS>>`). A função:

1. captura os nomes que o aluno escreveu (colunas, tabela, resultado);
2. preenche a receita com `preencher_receita()`;
3. chama `executar_receita()`, que imprime a receita se
   `mostrar_codigo = TRUE` e depois a executa com `eval(parse(...))` num
   ambiente onde os objetos têm os nomes do aluno.

Consequência importante: **o código mostrado é exatamente o código que
rodou**. Nunca manter duas versões (uma para mostrar e outra para calcular).

O script do aluno fica só em ClaRa. Não colocar o código R equivalente logo
abaixo no analise.R; o R aparece apenas sob demanda, com `mostrar_codigo = TRUE`.

## Regras de estilo (decididas com o professor)

- **Uma função principal por análise** (granularidade grossa). Ex.:
  `comparar_medias()` faz resumo, ANOVA, pressupostos, Tukey e letras. Só
  quebrar em funções menores se ficar condensada demais.
- Funções complementares agem **sobre o resultado** da principal e entram no
  pipe: `resultado |> medir_efeito()`, `resultado |> grafico_medias()`.
- **Dados como primeiro argumento**, para funcionar com o pipe `|>`.
- Nomes com **verbo em português** que diz a intenção: `comparar_medias`,
  `medir_efeito`, `grafico_medias`, `conferir_...`, `resumir_...`.
- Argumentos com o **nome do papel na pesquisa** (`resposta`, `grupos`,
  `confianca`, `significancia`), **um por linha**, com `=` alinhado.
- Colunas aceitas **sem aspas ou com aspas** (`rlang::ensym()`), para a
  CatalyseR poder passar nomes como texto.
- Saídas que se leem: tibbles com colunas em português; listas com partes
  nomeadas abertas com `$`; classe própria com método `print` que mostra um
  pequeno relatório.
- **Tidyverse sempre que possível** nas receitas (pipe `|>`, `filter`,
  `mutate`, `summarise`, `case_when`, `left_join`). Onde o tidyverse não tem
  o teste (Tukey, Levene, Shapiro), usar a função clássica seguida de
  `tidy()` (broom) para voltar ao formato de tabela.
- **Não usar `%in%`** nem outros operadores `%...%` (o professor não gosta).
  Alternativas: `setdiff()`, `is.element()`, `case_when()`, ou uma função
  com nome em português (como `ou_entao()` no lugar de `%||%`).
- `case_when()` em vez de `if / else if` encadeados.
- **Uma frase explicativa acima de cada linha** nas funções do aluno,
  principalmente na função principal. Funções claras pedem comentários
  curtos; não repetir o óbvio.
- Arquivo organizado em seções numeradas (`# 1. ... ----`), visíveis no
  sumário do RStudio (Ctrl+Shift+O). Peças internas ficam na última seção,
  "Motor das receitas".
- Textos para o aluno com linguagem humanizada; **evitar travessões**.
- Números exibidos com vírgula decimal (`numero()`, `escrever_p()`); um p
  muito pequeno aparece como "p < 0,001", nunca zero.
- Estatística honesta: frases de pressupostos dizem o que o teste mostrou.
  p acima da significância é "sem evidência contra o pressuposto", nunca
  prova de que ele vale.
- Identidade visual **Ocean Gradient**: NAVY #0F3B5F, TEAL #2E7D8F,
  SEAFOAM #62B6B7, AMBER #E89B3C, CORAL #E76F51; `cores_ocean` tem 8 cores
  e se estende com `colorRampPalette()` quando há mais grupos.

## Limitações conhecidas

- Nomes de coluna com espaço ou símbolo (`Peso (g)`) quebram `TukeyHSD()` e
  `multcompLetters4()`. A ClaRa recusa esses nomes com mensagem amigável e
  pede `rename()` no preparo. Acentos (`ração`) funcionam.
- Hífen no nome de um grupo atrapalha as letras do Tukey; também é recusado.
- `executar_receita()` carrega os pacotes com `library()` (efeito colateral
  aceito: o analise.R carrega os mesmos pacotes).

## Decisões em aberto

1. Intervalo de η² e ω²: o effectsize usa intervalo unilateral por padrão, e o
   limite superior sai sempre 1. Manter, mostrar só o limite inferior ou usar
   `alternative = "two.sided"`?
2. ~~Rótulo "média ± DP" no gráfico~~: resolvido em outubro de 2026, a pedido
   do professor. O gráfico agora tem barra transparente até a média, o rótulo
   "média ± DP" ao lado do losango, letras todas na mesma altura, explicação
   no título e jitter com semente (a figura não muda a cada execução).
   `grafico_medias()` devolve um ggplot: ajustes extras entram com `+`.
3. ~~t de Student como opção~~: resolvido com `variancias_iguais = TRUE`.
   Em aberto: com três ou mais grupos o argumento ainda não tem efeito (a
   ANOVA clássica já supõe variâncias iguais). Quando a ANOVA de Welch
   entrar, `variancias_iguais = FALSE` deve passar a valer também ali, o
   que muda o padrão da ANOVA. Decidir com o professor.
4. Mínimo de 3 observações por grupo (exigido pelo Shapiro em cada grupo):
   vale hoje também para a ANOVA, que tecnicamente aceitaria 2.
5. Letras com dois grupos: imitam o Tukey ("a"/"a" sem diferença; "a" para a
   maior média e "b" com diferença). Manter ou não mostrar letras no teste t?

## Regras de crescimento

1. **A ClaRa só sabe fazer análises.** Livro, relatórios Quarto, app e dados
   ficam no ecossistema EAPA e na CatalyseR, que usam a ClaRa mas não moram
   aqui. Não criar pastas como `relatorios/` ou `dados/`.
2. **Uma análise por vez.** Uma análise só está fechada quando o exemplo roda
   do início ao fim, o `mostrar_codigo = TRUE` reproduz o resultado e o
   CLAUDE.md está atualizado. Ideias que surgirem no caminho vão para a seção
   "Em espera", não para o código.
3. **Um só arquivo (`R/clara.R`) enquanto couber.** Dividir em um arquivo por
   análise mais o motor (`clara_motor.R`, `clara_medias.R`...) somente quando
   ficar difícil de navegar.
4. **Não transformar em pacote por antecipação.** `source()` basta até existir
   um motivo concreto, como a CatalyseR precisar de `library(clara)` no
   projeto exportado.
5. **Versionar com git.**

## Em espera

- teste t pareado (antes e depois no mesmo animal): pede outro argumento,
  como `pareado_por = individuo`;
- ANOVA de Welch como comparação quando o Levene rejeitar a igualdade das
  variâncias;
- gráficos de diagnóstico (resíduos x ajustados, Q-Q);
- textos dinâmicos para relatório e poder do teste;
- próximas análises: `relacionar_variaveis()` (regressão) e
  `comparar_proporcoes()`.

## Próximos passos possíveis

- Integração com a CatalyseR: o exportador poderia gerar o analise.R em
  ClaRa.

## A concepção inicial (docs/concepcao_inicial_2026-09.md)

Em setembro de 2026 a ClaRa foi pensada como uma linguagem com sintaxe
própria (arquivos `.clara`, `rotina ... fim`, `se ... entao`, transpilador
para R). Em outubro de 2026 o caminho escolhido foi outro: **a ClaRa é
R de verdade**, funções em português que rodam em qualquer script R, com o
código tidyverse visível sob demanda. Esse documento vale como histórico e
fonte de ideias, não como especificação a implementar.

Aproveitado dele:
- o nome e a justificativa (clareza, nome acolhedor como Julia, R maiúsculo);
- nomes que ensinam o método em vez do autor do teste (`testar_normalidade`
  no lugar de `shapiro.test`);
- a ideia de `exigir:`, que aqui virou as conferências amigáveis antes do
  cálculo (`conferir_colunas()`).

Fora do escopo agora (não implementar sem o professor pedir):
- sintaxe própria, parser, transpilador, extensão `.clara` (Fases 2 e 3);
- traduzir os verbos básicos do dplyr (`filtrar`, `agrupar`, `resumir`):
  o aluno deve reconhecer `filter`, `group_by` e `summarise` quando vê a
  receita; a ClaRa atua no nível da análise, não no das operações básicas;
- recursos que o R não aceita (`confianca = 95%`, multiplicação justaposta
  `2x` como em Julia).

## Referência

O modelo "a pé" de onde a ClaRa partiu é o `analise.R` da ANOVA de um fator
do EAPACaderno (repositório astuciasnor/EAPACaderno), seções 4 a 9.
