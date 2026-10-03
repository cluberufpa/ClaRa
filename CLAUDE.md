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
  LICENSE                       MIT, clubeR e Evaldo Martins da Silva
  ClaRa.Rproj
  R/                            só as funções
    clara.R                     todas as funções da ClaRa, em seções
  exemplos/                     um roteiro por análise, com as figuras que ele gera
    anova_um_fator.R            ANOVA de um fator (PlantGrowth renomeado)
    anova_um_fator.png          figura gerada pelo próprio roteiro (ggsave)
    teste_t_dois_grupos.R       teste t de Welch (ToothGrowth, dose 0,5)
    teste_t_dois_grupos.png
    anova_bagres.R              o analise.R do anova-bagres-gabarito
                                (EAPACadernos) reescrito em ClaRa, mesmas
                                seções; o que falta à ClaRa aparece como
                                "Ainda sem ClaRa"
    anova_bagres.png
  dados_treino/                 dados para testar e estudar as funções
    preparar_dados_treino.R     gera todos os CSVs desta pasta
    real_*.rds / real_*.csv     dados reais, exportados do pacote EAPADados
    sint_*.rds / sint_*.csv     dados sintéticos, cada um com uma situação
  README.md                     a ClaRa para quem abre o repositório (mapa das perguntas)
  docs/                         histórico e ideias, nunca código
    concepcao_inicial_2026-09.md  primeira concepção da ClaRa (ver abaixo)
  .claude/skills/clara-nova-funcao/SKILL.md
                                passo a passo para criar uma função nova
```

Para testar tudo, a partir da raiz do projeto:

```
Rscript -e 'source("exemplos/anova_um_fator.R", echo = TRUE)'
Rscript -e 'source("exemplos/teste_t_dois_grupos.R", echo = TRUE)'
Rscript -e 'source("exemplos/anova_bagres.R", echo = TRUE)'
```

`anova_bagres.R` é o termômetro da migração para a CatalyseR: cada função
nova da ClaRa deve substituir um bloco "Ainda sem ClaRa" dele.

O R desta máquina está em `C:\R\R-4.6.1` (`C:/R/R-4.6.1/bin/Rscript.exe`).
No Git Bash, um `-e` com várias linhas derruba o Rscript: grave o teste num
arquivo `.R` e rode o arquivo.

Os roteiros de `exemplos/` rodam sempre a partir da raiz: carregam as funções
com `source("R/clara.R")` e gravam suas figuras em `exemplos/`.

Pacotes usados: dplyr, ggplot2, broom, car, multcompView, effectsize, rlang,
stringr e pwr (todos do CRAN). O EAPADados (GitHub) só é preciso para
regenerar os dados reais de `dados_treino/`.

### Dados de treino

`dados_treino/` foi autorizada pelo professor em outubro de 2026, como
exceção à regra 1 de crescimento. Guarda só dados para testar e estudar a
ClaRa, nunca dados de pesquisa. Para regenerar:
`Rscript dados_treino/preparar_dados_treino.R`.

Cada base existe em dois formatos, com o mesmo conteúdo:
- **`.rds`, a base pronta** (leia com `readRDS()`): grupos como fator, na
  ordem natural (baixa, media, alta), identificações (`id_...`) como texto.
  É o formato preferido, igual ao que o projeto da CatalyseR lê
  (`dados/processados/base_compartilhada.rds`).
- **`.csv`, como uma planilha** (leia com `read.csv()`): abre no Excel, mas
  perde os tipos; os grupos voltam como texto e a ClaRa os ordena em ordem
  alfabética (alta, baixa, media).

Decisão de outubro de 2026 para os roteiros: a seção 2 lê o `.rds`; a seção 3
mostra, em dplyr, a receita que fez a base a partir da planilha e confere
com `all.equal()` que ela ainda dá a mesma base. Assim o roteiro analisa a
base certa sem esconder o preparo (ver `exemplos/anova_bagres.R`). O
`all.equal()` substitui, só com R base, o `catalyser_conferir_base()` do
EAPACaderno.

| Arquivo | Situação que provoca |
|---|---|
| `real_bagre_racoes` | ANOVA real, 4 rações, grupos desiguais (5, 5, 4, 5) |
| `real_artemia_racoes` | teste t real, 2 rações |
| `real_tilapia_microalgas` | ANOVA real, 3 microalgas; o Levene rejeita |
| `real_caranguejos_braganca` | teste t real com 993 animais; o Shapiro rejeita, mas os grupos são grandes |
| `sint_quatro_racoes` | diferenças claras entre 4 rações |
| `sint_variancias_desiguais` | o Levene rejeita (alerta para a ANOVA de Welch) |
| `sint_pouco_poder` | sem evidência e com pouco poder (aparece `$poder`) |
| `sint_residuos_assimetricos` | o Shapiro rejeita com grupos pequenos |
| `sint_com_faltantes` | respostas e grupos em branco (5 de 21 excluídas) |
| `sint_dois_locais` | Welch e Student divergem; com Student, o Levene rejeita |
| `sint_dez_tanques` | mais grupos que as 8 cores da paleta |

## Como a ClaRa se organiza

**Cada pergunta da pesquisa tem dois verbos próprios (a análise e o gráfico);
dois verbos servem para qualquer análise (`medir_efeito()` e
`escrever_resultados()`).** O aluno faz a pergunta; a ClaRa escolhe o teste.
O README traz a tabela completa, para quem abre o repositório.

| Pergunta | Análise | Gráfico | Testes por trás |
|---|---|---|---|
| A média difere entre os grupos? | `comparar_medias()` | `grafico_medias()` | t de Welch ou Student; ANOVA e Tukey; depois t pareado e ANOVA de Welch, como argumentos |
| A mediana difere entre os grupos? | `comparar_medianas()` | `grafico_medianas()` | Mann-Whitney; Kruskal-Wallis |
| Uma variável acompanha a outra? | `relacionar_variaveis()` | a definir | regressão linear |
| A proporção difere entre os grupos? | `comparar_proporcoes()` | a definir | qui-quadrado ou teste de proporções |

Regras que saem desse desenho:
- Uma variação da mesma pergunta entra como **argumento** do verbo
  (`variancias_iguais`, `pareado_por`), nunca como função nova.
- Um teste que responde a **outra pergunta** ganha verbo próprio. Mann-Whitney
  e Kruskal-Wallis não comparam médias; por isso vão para
  `comparar_medianas()` (nome aprovado pelo professor: conceito fácil de
  ensinar), e não para dentro de `comparar_medias()`.
- Análise nova não cria funções em "Para qualquer análise": só acrescenta
  receitas a `receitas_efeito` e `receitas_textos`.
- No `clara.R`, cada pergunta é uma seção (`# 1. Comparar médias ----`), e
  "Para qualquer análise" é a seção 2. A `ajuda()` agrupa a lista de funções
  por esses títulos de seção, então uma seção nova aparece sozinha.
- Caso de fronteira, a decidir com o professor: ANOVA de dois fatores (ração
  e temperatura). Ainda é pergunta sobre médias, com interação: pode ser
  `comparar_medias(grupos = c(racao, temperatura))` ou um verbo próprio.

## Como o aluno usa (v0.3)

```r
resultado <- plantas |>
  comparar_medias(resposta = peso, grupos = tratamento)

resultado                       # imprime um pequeno relatório no console

resultado |>
  medir_efeito()

resultado |>
  grafico_medias(rotulo_resposta = "Peso seco (g)",
                 rotulo_grupos   = "Tratamento")

textos <- resultado |>
  escrever_resultados(rotulo_resposta = "Peso seco (g)",
                      rotulo_grupos   = "Tratamento")
textos$teste                    # no Quarto: `r textos$teste`
```

`escrever_resultados()` é uma função só para todas as análises: como
`medir_efeito()`, ela escolhe a receita pela análise feita
(`receitas_textos$anova` ou `receitas_textos$teste_t`). As frases são
dinâmicas: recalculadas do resultado a cada execução. As receitas definem
`com_virgula()` e `texto_p()` no próprio código mostrado, para rodarem
copiadas numa sessão sem a ClaRa. O alerta de normalidade leva em conta o
tamanho dos grupos (30 ou mais: ANOVA e teste t pouco sensíveis ao desvio).

`comparar_medias()` escolhe o teste pelo número de grupos com dados (uma só
pergunta; a ClaRa escolhe o teste):

| Grupos | Teste | Partes próprias | `medir_efeito()` |
|---|---|---|---|
| 2 | t de Welch (padrão) ou de Student (`variancias_iguais = TRUE`, com Levene) | `$teste` | d de Cohen e g de Hedges (`pooled_sd` segue `variancias_iguais`) |
| 3 ou mais | ANOVA, Shapiro dos resíduos, Levene, Tukey | `$anova`, `$pares`, `$modelo` | η² e ω² |

As duas devolvem `$resumo` (com `letra`), `$pressupostos`, `$amostra` (total,
usadas e excluídas) e `$dados`, por isso
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
- Com mais de 5000 observações, o `shapiro.test()` para com erro em inglês.
  O EAPACaderno trata isso (registra NA e deixa a leitura para o Q-Q); a
  ClaRa ainda não.
- `grafico_medias()` com muitos grupos (10, por exemplo): os rótulos
  "média ± DP" se sobrepõem.

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
6. Poder observado em `escrever_resultados()`: segue o EAPACaderno (calcula o
   poder com o efeito observado e só o cita quando p ≥ α e poder < 80%). O
   poder observado é função direta do p, então essa frase aparece em quase
   todo resultado sem evidência e pouco acrescenta. Alternativas: dizer o n
   por grupo necessário para detectar um efeito de interesse definido pelo
   pesquisador, ou retirar a frase. Decidir com o professor.

## Regras de crescimento

1. **A ClaRa só sabe fazer análises.** Livro, relatórios Quarto, app e dados
   ficam no ecossistema EAPA e na CatalyseR, que usam a ClaRa mas não moram
   aqui. Não criar pastas como `relatorios/` ou `dados/`. Exceção autorizada:
   `dados_treino/`, só com dados para testar e estudar as funções.
   **Nunca alterar o projeto modelo** (EAPACadernos) nem a CatalyseR a partir
   daqui: lê-los como referência é permitido; as funções novas nascem aqui.
2. **Uma análise por vez.** Uma análise só está fechada quando o exemplo roda
   do início ao fim, o `mostrar_codigo = TRUE` reproduz o resultado e o
   CLAUDE.md está atualizado. Ideias que surgirem no caminho vão para a seção
   "Em espera", não para o código.
3. **Um só arquivo (`R/clara.R`) enquanto couber.** Dividir em um arquivo por
   análise mais o motor (`clara_motor.R`, `clara_medias.R`...) somente quando
   ficar difícil de navegar. **Gatilho já decidido:** dividir quando entrar a
   segunda pergunta (`relacionar_variaveis()` ou `comparar_medianas()`).
   Plano, **um arquivo por pergunta**, todos na pasta `R/`:
   - `R/clara.R` vira só a porta de entrada: carrega os outros arquivos com
     `source()`, para o aluno continuar escrevendo `source("R/clara.R")`;
   - `R/clara_medias.R`: os dois verbos das médias (`comparar_medias()`,
     `grafico_medias()`) e todas as receitas das médias, inclusive as de
     efeito e de textos da ANOVA e do teste t;
   - `R/clara_medianas.R`, `R/clara_regressao.R`...: o mesmo para cada
     pergunta nova;
   - `R/clara_qualquer_analise.R`: `medir_efeito()` e
     `escrever_resultados()`, só as funções (as receitas moram no arquivo
     de cada pergunta, que as acrescenta às listas:
     `receitas_efeito$regressao <- ...`);
   - `R/clara_motor.R`: peças internas, exibição no console e `ajuda()`.
   Quem quiser estudar uma pergunta abre um arquivo só e encontra tudo dela.
   **Arquivos, não subpastas** (decidido em outubro de 2026): cada pergunta
   cabe num arquivo de tamanho razoável; o sumário do RStudio
   (Ctrl+Shift+O) funciona dentro de um arquivo, não entre pastas; o prefixo
   `clara_` mantém tudo junto no painel Files, como uma lista de perguntas;
   e, se a ClaRa um dia virar pacote, a pasta `R/` de um pacote não aceita
   subpastas.
   Atenção: a `ajuda()` hoje lê os cabeçalhos e os títulos de seção de
   `arquivo_clara`; ela precisa passar a ler todos os `R/clara*.R`, e cada
   arquivo de pergunta abre com o seu título de seção (`# Comparar médias
   ----`), que vira o grupo na lista.
4. **Não transformar em pacote por antecipação.** `source()` basta até existir
   um motivo concreto, como a CatalyseR precisar de `library(clara)` no
   projeto exportado.
5. **Versionar com git.** O repositório é `github.com/cluberufpa/ClaRa`
   (privado, ramo `main`). Nesta pasta os commits saem como
   `clubeR <cluber.ufpa@gmail.com>`; o push usa a credencial do cluberufpa
   guardada no Windows (Git Credential Manager).

## Em espera

- teste t pareado (antes e depois no mesmo animal): pede outro argumento,
  como `pareado_por = individuo`;
- ANOVA de Welch como comparação quando o Levene rejeitar a igualdade das
  variâncias;
- gráficos de diagnóstico (resíduos x ajustados, Q-Q): `grafico_diagnostico()`;
- `comparar_medianas()` e `grafico_medianas()`: Mann-Whitney (2 grupos) e
  Kruskal-Wallis (3 ou mais), com Dunn para os pares; o alerta de
  `escrever_resultados()` já sugere esses testes quando a normalidade falha
  com grupos pequenos;
- do EAPACaderno ainda sem ClaRa: boxplot de exploração e gráfico de
  floresta das diferenças do Tukey;
- `rotulo_resposta` e `rotulo_grupos` informados uma vez só, em
  `comparar_medias()`, em vez de repetidos no gráfico e nos textos;
- próximas análises: `relacionar_variaveis()` (regressão) e
  `comparar_proporcoes()`.

## Próximos passos possíveis

- Ao começar a segunda pergunta (regressão ou medianas): primeiro dividir o
  `clara.R` em um arquivo por pergunta (plano na regra 3 de crescimento),
  conferir que os dois exemplos e a `ajuda()` continuam iguais, e só então
  escrever o verbo novo.
- Integração com a CatalyseR: o exportador poderia gerar o analise.R em
  ClaRa, copiando `R/clara.R` para o projeto exportado como já faz com o
  `funcoes.R` (só pacotes do CRAN). Mapa do analise.R do EAPACaderno (ANOVA):
  seções 4 a 7 → `comparar_medias()` e `medir_efeito()`; 9.2 →
  `grafico_medias()`; 10 → `escrever_resultados()`. Ficam fora da ClaRa:
  leitura e preparo (2, 3), tabelas flextable (8), salvar cópias (11, 12).
  Faltam: 9.1, 9.3, 9.4 e 9.5 (gráficos). Os QMDs precisarão ler
  `resultado$...` e `textos$...` no lugar dos objetos soltos atuais.

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
