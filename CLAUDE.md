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
ClaRa/                          o pacote R clara (desde 9/10/2026, v0.9.0)
  CLAUDE.md                     este arquivo
  DESCRIPTION                   nome, versão (a única), Imports e Collate
  NAMESPACE                     gerado pelo roxygen2 (não editar)
  NEWS.md                       o que mudou em cada versão
  LICENSE / LICENSE.md          MIT, clubeR e Evaldo Martins da Silva
  ClaRa.Rproj                   projeto de pacote (painel Build do RStudio)
  R/                            só as funções, um arquivo por pergunta
    clara.R                     página do pacote (?clara) e o mapa dos arquivos
    clara_medias.R              comparar_medias() e os gráficos das médias
    clara_medianas.R            comparar_medianas() e grafico_medianas()
    clara_regressao.R           relacionar_variaveis() e grafico_reta()
    clara_qualquer_analise.R    medir_efeito(), escrever_resultados(),
                                grafico_residuos(), grafico_qq(),
                                registrar_ambiente()
    clara_formatar.R            formatar_numero(), formatar_p(),
                                exibir_tabela() e os temas das tabelas
    clara_motor.R               ajuda() e peças internas
  man/                          páginas de ajuda, geradas pelo roxygen2
  tests/testthat/               testes; dados/ guarda cópias das bases de
                                treino usadas nos testes
  exemplos/                     um roteiro por análise (fora do pacote,
                                pelo .Rbuildignore; carregam library(clara))
    anova_um_fator.R            ANOVA de um fator (PlantGrowth renomeado)
    teste_t_dois_grupos.R       teste t de Welch (ToothGrowth, dose 0,5)
    anova_welch.R               ANOVA de Welch com Games-Howell (densidade
                                de estocagem, variâncias desiguais)
    kruskal_wallis.R            medianas com 3 grupos (CPUE por petrecho)
    mann_whitney.R              medianas com 2 grupos (artêmia)
    regressao_barbo.R           regressão linear simples (morfometria do barbo)
    anova_bagres.R              o analise.R do anova-bagres-gabarito
                                (EAPACadernos) reescrito em ClaRa, mesmas
                                seções, sem nenhum bloco em R comum
    figuras/                    figuras gravadas pelos roteiros (ggsave),
                                com o nome do roteiro como prefixo
  dados_treino/                 dados para testar e estudar as funções
  data-raw/                    fontes preservadas e curadoria dos dados;
                                cópia para revisão autorizada em 11/10/2026
  data/                        dados e catálogo; incorporação dos bagres
                                aprovada em 11/10/2026, autorização da fonte pendente
    preparar_dados_treino.R     gera todos os CSVs desta pasta
    real_*.rds / real_*.csv     dados reais, exportados do pacote EAPADados
    sint_*.rds / sint_*.csv     dados sintéticos, cada um com uma situação
  README.md                     a ClaRa para quem abre o repositório (mapa das
                                perguntas e a gramática da ClaRa)
  docs/                         histórico e ideias, nunca código
    concepcao_inicial_2026-09.md  primeira concepção da ClaRa (ver abaixo)
  .claude/skills/clara-nova-funcao/SKILL.md
                                passo a passo para criar uma função nova
```

Para testar tudo, a partir da raiz do projeto (no RStudio, o painel Build
faz o mesmo: Document, Test, Check, Install):

```
Rscript -e "roxygen2::roxygenise()"     # depois de mudar um bloco #'
Rscript -e "devtools::test()"           # os testes de tests/testthat
R CMD build --no-manual . && R CMD check --no-manual clara_<versão>.tar.gz
R CMD INSTALL --no-multiarch .          # antes de rodar os exemplos
```

A meta do check (decisão J do professor, 9/10/2026): 0 erros, 0 notas e
**um só aviso conhecido**, o dos acentos nos textos do código ("non-ASCII
characters"). Os acentos ficam no repositório; para o CRAN,
`Rscript ferramentas/preparar_cran.R --check` copia o pacote, troca os
acentos dos textos por escapes `\u` na cópia, gera o `.tar.gz` na pasta
acima da ClaRa e roda o check `--as-cran`, que sai sem o aviso. Qualquer outro aviso ou nota é problema novo.

Os roteiros de `exemplos/` usam a ClaRa instalada:

```
Rscript -e 'source("exemplos/anova_um_fator.R", echo = TRUE)'
Rscript -e 'source("exemplos/teste_t_dois_grupos.R", echo = TRUE)'
Rscript -e 'source("exemplos/anova_welch.R", echo = TRUE)'
Rscript -e 'source("exemplos/anova_bagres.R", echo = TRUE)'
Rscript -e 'source("exemplos/kruskal_wallis.R", echo = TRUE)'
Rscript -e 'source("exemplos/mann_whitney.R", echo = TRUE)'
Rscript -e 'source("exemplos/regressao_barbo.R", echo = TRUE)'
```

`anova_bagres.R` é o modelo da migração para a CatalyseR: o analise.R da
ANOVA de um fator inteiro em ClaRa. Ao migrar outra análise do EAPACadernos,
faça o mesmo: reescreva o roteiro em `exemplos/`, marque como "Ainda sem
ClaRa" o que faltar e crie as funções até não sobrar nenhum bloco marcado.

O R desta máquina está em `C:\R\R-4.6.1` (`C:/R/R-4.6.1/bin/Rscript.exe`).
Grave testes com várias linhas em um arquivo `.R` e rode esse arquivo, para
evitar problemas de aspas entre shells.

**Ambiente de execução no Windows (diagnóstico de 11/10/2026):** antes de
rodar R por ferramentas que filtram variáveis de ambiente, confira
`PROCESSOR_ARCHITECTURE`. O `cli` 3.6.6 consulta essa variável ao encerrar;
se ela estiver ausente, o processo sofre uma violação de memória
(`0xc0000005`), inclusive durante a instalação de pacotes. Nesta máquina,
a arquitetura nativa foi conferida como X64; no PowerShell, prepare o
processo com `$env:PROCESSOR_ARCHITECTURE = 'AMD64'`. Preserve a variável
quando ela já existir; em outra máquina, confira a arquitetura nativa antes
de preencher. Configure também uma localidade válida, por exemplo
`$env:LC_ALL = 'English_United States.utf8'`. Essas configurações valem para
o processo e seus filhos; não exigem alteração global do Windows ou do R.
Detalhes e resultados em `docs/DIAGNOSTICO_CHECK_WINDOWS_20261011.md`.

Os roteiros de `exemplos/` rodam sempre a partir da raiz: carregam a ClaRa
com `library(clara)` e gravam suas figuras em `exemplos/figuras/`
(`ggsave(..., create.dir = TRUE)`, que cria a pasta se ela faltar). Cada
figura leva o nome do roteiro como prefixo (`anova_bagres_qq.png`), para
se saber de onde veio sem criar uma subpasta por roteiro.

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
| `real_barbo_morfometria` | regressão real, reta limpa (r = 0,94), cinco populações para colorir; linhas em ordem de população (o Durbin-Watson rejeita) |
| `real_cangulo_peso_comprimento` | regressão real de uma relação curva (peso e comprimento): resíduos em U |

## Como a ClaRa se organiza

**Cada pergunta da pesquisa tem a sua análise e os seus gráficos, um nome
para cada figura; quatro verbos servem para qualquer análise
(`medir_efeito()`, `escrever_resultados()`, `grafico_residuos()` e
`grafico_qq()`).** O
aluno faz a pergunta; a ClaRa escolhe o teste. O README traz a tabela
completa, para quem abre o repositório.

| Pergunta | Análise | Gráficos | Testes por trás |
|---|---|---|---|
| A média difere entre os grupos? | `comparar_medias()` | `grafico_medias()`, `grafico_boxplot()`, `grafico_pares()` | t de Welch ou Student; ANOVA e Tukey; ANOVA de Welch e Games-Howell (`variancias_iguais = FALSE`); depois t pareado, como argumento |
| A mediana difere entre os grupos? | `comparar_medianas()` | `grafico_medianas()`, `grafico_boxplot()` | Mann-Whitney; Kruskal-Wallis e Dunn |
| Uma variável acompanha a outra? | `relacionar_variaveis()` | `grafico_reta()` | regressão linear simples (v0.12.0) |
| A proporção difere entre os grupos? | `comparar_proporcoes()` | a definir | qui-quadrado ou teste de proporções |

Regras que saem desse desenho:
- Uma variação da mesma pergunta entra como **argumento** do verbo
  (`variancias_iguais`, `pareado_por`), nunca como função nova.
- **Uma função, uma figura** (decisão do professor, outubro de 2026): uma
  mesma função não entrega figuras diferentes conforme um argumento `tipo`.
  Cada figura tem o seu nome: `grafico_medias()` (principal),
  `grafico_boxplot()` (exploração) e `grafico_pares()` (diferença de cada
  par). Já um argumento que muda a análise, sem mudar a natureza do que sai
  (`variancias_iguais`), continua sendo argumento.
- Um teste que responde a **outra pergunta** ganha verbo próprio. Mann-Whitney
  e Kruskal-Wallis não comparam médias; por isso vão para
  `comparar_medianas()` (nome aprovado pelo professor: conceito fácil de
  ensinar), e não para dentro de `comparar_medias()`.
- Análise nova não cria funções em "Para qualquer análise": só acrescenta
  receitas a `receitas_efeito`, `receitas_textos`, `receitas_residuos`,
  `receitas_qq`, `receitas_tabela_teste` e `receitas_tabela_resumo`.
- Cada pergunta mora no seu arquivo (`R/clara_medias.R`,
  `R/clara_medianas.R`), que abre com o título de seção (`# Comparar médias
  ----`). A `ajuda()` agrupa a lista de funções pelo `@concept` de cada
  uma, então uma pergunta nova aparece sozinha, desde que o arquivo entre
  no campo `Collate` do `DESCRIPTION` (depois de `clara_qualquer_analise.R`).
- Caso de fronteira, a decidir com o professor: ANOVA de dois fatores (ração
  e temperatura). Ainda é pergunta sobre médias, com interação: pode ser
  `comparar_medias(grupos = c(racao, temperatura))` ou um verbo próprio.

## Carregar dados (v0.15.0, pedido de 12/10/2026)

`carregar_dados("nome")` é a porta de entrada dos 55 conjuntos do catálogo.
O nome foi confirmado pelo professor. Os dados internos continuam em `data/`;
oito conjuntos do FSAdata e `MASS::crabs` são lidos na hora e traduzidos pelas
receitas em `R/dados_pacotes.R`. A função fica em `R/clara_dados.R`.
`fonte_dados` indica o fornecedor; FSAdata e MASS são opcionais em Suggests.
Para os nove externos, `data()` e `clara::nome` foram substituídos pela função.
As páginas de ajuda, nomes e registros D ficam. Não recriar cópias binárias
nas pastas de fontes; os `preparar.R` desses nove somente carregam e conferem.
O check usa uma biblioteca temporária, sem resíduos em `data-raw/`.
A versão 0.15.0 aguarda o sim do professor para merge na main; não alterar TRILHA.

## Como o aluno usa (v0.7)

```r
resultado <- plantas |>
  comparar_medias(resposta        = peso,
                  grupos          = tratamento,
                  rotulo_resposta = "Peso seco (g)",
                  rotulo_grupos   = "Tratamento")

resultado                       # imprime um pequeno relatório no console

resultado |>
  medir_efeito()

resultado |>
  grafico_medias()              # os rótulos vêm do resultado

textos <- resultado |>
  escrever_resultados()
textos$teste                    # no Quarto: `r textos$teste`

resultado |>
  grafico_boxplot()             # exploração: caixas e observações
resultado |>
  grafico_pares()               # diferença de cada par, com IC

resultado |>
  grafico_residuos()            # resíduos contra ajustados
resultado |>
  grafico_qq()                  # Q-Q dos resíduos

registrar_ambiente(arquivo = here("saida", "sessionInfo.txt"))  # no fim
```

**O resultado carrega o contexto** (v0.7, outubro de 2026): `rotulo_resposta`
e `rotulo_grupos` são informados uma vez, no verbo de pergunta
(`comparar_medias()`, `comparar_medianas()`), e ficam em
`resultado$nomes$rotulo_resposta` e `$rotulo_grupos` (sem eles, o nome da
coluna). Gráficos e `escrever_resultados()` usam esses rótulos quando o
aluno não informa outros; um rótulo dado no gráfico vale só para ele. O
título do `print` também usa os rótulos. As linhas do roteiro passam a
depender umas das outras, como num programa.

**A gramática da ClaRa** está no README: substantivos (a base, o
resultado), verbos de pergunta, verbos sobre o resultado e modificadores
(argumentos), ligados por três regras (frase começa por substantivo e segue
pelo pipe; o resultado lembra a análise; o mesmo verbo serve a qualquer
análise). Uma função nova da ClaRa deve caber nessa gramática.

**Um modificador por linha**, com `=` alinhado, mesmo que o roteiro fique
mais longo (preferência do professor, outubro de 2026). Escolhas que
importam para a conclusão aparecem escritas mesmo quando são o padrão
(`variancias_iguais = FALSE`), para o roteiro registrar a decisão. Fora das
análises (ler, preparar, repetir), o roteiro volta ao R comum, com código
fácil de ler: a ClaRa é de altíssimo nível e não substitui o R.

**O que vai para o artigo leva mais detalhe** (decisão do professor,
outubro de 2026). Nos roteiros, duas chamadas são as mais longas: a do
verbo de pergunta, porque o resultado alimenta tudo o que vem depois
(tabelas, poder, gráficos), e a da figura principal, porque ela vai para o
artigo. Nelas, todos os argumentos aparecem escritos, inclusive os padrões
(`confianca = 0.95`, `haste = "ic"`, `cores = "ocean"`...), com as opções
num comentário ao lado (`# "ic", "ep" ou "dp"`). Vale para toda tabela ou
figura principal de publicação. Os gráficos de conferência (boxplot,
resíduos, Q-Q, pares) e os textos ficam curtos: `resultado |> grafico_qq()`.

`grafico_residuos()` e `grafico_qq()` têm poucos parâmetros (só
`rotulo_grupos`, no de resíduos) e deixam o ggplot2 à vista em
`mostrar_codigo = TRUE`, para quem já conhece a sintaxe ajustar o que
quiser. As receitas são montadas de trechos (`trechos_diagnostico`: preparo
dos resíduos por análise e desenho por gráfico) em
`receitas_residuos[[analise]]` e `receitas_qq[[analise]]`. Na ANOVA, o Q-Q usa os resíduos
padronizados do modelo; no teste t, um painel por grupo (resíduo =
observação menos a média do grupo), como o Shapiro em cada grupo.

**Quantos parâmetros** (decisão do professor, outubro de 2026): os gráficos
de conferência (`grafico_boxplot()`, `grafico_pares()`, `grafico_residuos()`,
`grafico_qq()`) ficam com poucos parâmetros. O `grafico_medias()` é a figura
que vai para o artigo ou a tese e tem mais: `titulo`, `explicacao`, `haste`
(`"ic"`, `"ep"`, `"dp"`), `mostrar_barras`, `largura_barras` (0 a 1, padrão
0.3; o rótulo em pé acompanha a borda), `mostrar_pontos`,
`mostrar_media_dp`, `casas`, `angulo_rotulo`, `altura_rotulo` (fração da
coluna onde fica o rótulo em pé, padrão 0.5), `mostrar_letras`, `fonte`
(`"sans"`, Arial no Windows, ou `"serif"`, Times New Roman, para todos os
textos, inclusive rótulo e letras; o `family` só entra na receita com
`"serif"`), `cores`
(`"ocean"`, `"cinza"` ou um vetor) e `tamanho_texto`. A receita dele é
montada de trechos (`trechos_grafico_medias`) e traz só as camadas pedidas:
o código mostrado continua sendo exatamente o que rodou. Com os valores
padrão, a figura é a mesma de antes. A explicação do topo vai em
`subtitle` e cita só as partes que aparecem; o `titulo` vai em `title`.

Rótulo "média ± DP" com muitos grupos: com barras e mais de 6 grupos, ele
fica em pé **dentro da barra**, centrado no meio da altura dela
(`y = media * altura_rotulo`, padrão 0.5, `nudge_x = 0`), lido de cima para
baixo (`angle = -90`),
como pediu o professor. O meio da barra está livre (pontos e losango ficam
perto da média) e o rótulo não invade a coluna vizinha nem encosta nas
letras. Qualquer ângulo diferente de 0, com barras, segue a mesma posição
(`angulo_rotulo = 90` lê de baixo para cima). Sem barras, o rótulo em pé
fica ao lado do losango, na altura da média. Com mais de 8 grupos, `grafico_medias()` dá um aviso
(`warning`) sugerindo mostrar as médias numa tabela (`resultado$resumo`) e
usar `mostrar_media_dp = FALSE`. Sem barras fica deitado, porque em pé sairia cortado
embaixo (o eixo não começa no zero); nesse caso, com muitos grupos, a ajuda
recomenda `mostrar_media_dp = FALSE`. 45° funciona, mas raspa os pontos.

Cada gráfico das médias tem a sua receita: `trechos_grafico_medias`,
`receita_grafico_boxplot` e `receita_grafico_pares`. As paletas ficam em
`paletas_clara` (`ocean`, `cinza`); `trecho_de_cores()` escreve o trecho de
cores da receita para qualquer vetor, e o objeto na receita se chama `cores`. `grafico_pares()` usa
`resultado$pares` (Tukey) na ANOVA e `resultado$teste` no teste t; o título
explica o ponto, a haste e a linha tracejada da diferença zero. Os eixos
usam o rótulo do aluno sem preposição grudada ("Tipo de Ração";
"Diferença entre as médias, Peso (g)"): os marcadores B-A já dizem que
cada linha é um par. Com muitos
grupos (10 grupos = 45 pares), salve a figura mais alta. O boxplot já
serve às medianas (só usa `$dados`); os pares ainda não (ver "Em espera").

Toda receita de gráfico com cores começa com um trecho de cores
(`trecho_de_cores()`), que define `cores` (estendidas com
`colorRampPalette()` quando há mais grupos que cores) no próprio código
mostrado.
Assim a receita copiada roda sem a ClaRa; antes, `grafico_medias()` passava
a paleta por fora e a cópia falhava numa sessão limpa.

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
| 3 ou mais | ANOVA clássica (padrão): Shapiro dos resíduos, Levene, Tukey | `$anova`, `$pares`, `$modelo` | η² e ω² |
| 3 ou mais, `variancias_iguais = FALSE` | ANOVA de Welch: Shapiro em cada grupo, Games-Howell | `$anova` (sem SQ e QM), `$pares` | ω² aproximado, convertido do F de Welch |

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

### Relacionar variáveis (v0.12.0)

Decisões do professor (10/10/2026), pedidas pela Trilha para levar a
regressão linear simples para a ClaRa:

```r
resultado <- barbos |>
  relacionar_variaveis(resposta               = altura_maxima_corpo,
                       preditor               = distancia_dorsal_pelvica,
                       rotulo_resposta        = "Altura máxima do corpo",
                       rotulo_preditor        = "Distância dorsal-pélvica",
                       confianca              = 0.95,
                       avaliar_autocorrelacao = FALSE)

resultado |> grafico_reta(colorir_por = populacao)   # a figura principal
resultado |> grafico_residuos()                      # curva e funil
resultado |> grafico_qq()
```

- **Nomes**: `resposta` (o mesmo de `comparar_medias()`) e `preditor` (o
  termo da tela e dos moldes da Trilha); `rotulo_preditor` acompanha
  `rotulo_resposta`. A figura principal é `grafico_reta()`: diz o que se
  vê, como `grafico_medias()`.
- **Só uma reta** nesta versão. Grupos entram só como cor dos pontos, em
  `grafico_reta(colorir_por = ...)`, que não muda o modelo. Retas por
  grupo ficam em espera (outro modelo, com interação).
- **Diagnóstico**: Shapiro-Wilk e Breusch-Pagan (`car::ncvTest()`, o mesmo
  p de `performance::check_heteroscedasticity()`, que a tela usa) em
  `$pressupostos`; resíduos e Q-Q nas receitas de `grafico_residuos()` e
  `grafico_qq()`; Cook, alavancagem e resíduo extremo em
  `$influencia` (limites 4/n, 2p/n e 3, como o roteiro antigo da Trilha) e
  em `textos$influencia`. Gráficos próprios de influência ficam em espera.
- **Durbin-Watson** só com `avaliar_autocorrelacao = TRUE` (variante na
  receita, `variantes_regressao`), porque só faz sentido quando a ordem das
  linhas é a ordem da coleta. O p vem de reamostragem
  (`car::durbinWatsonTest()`, o mesmo algoritmo do `performance`); a
  receita usa `set.seed(1)`, e a tela da Trilha, que não fixa a semente,
  pode dar outro p a cada clique.
- `linha_da_base` (a posição na tabela original, antes de tirar as linhas
  sem resposta ou preditor) entra em `$dados` e `$influencia`, para o
  aluno achar a observação na planilha.
- **Efeito**: r de Pearson (com o sinal da inclinação, IC de `cor.test()`)
  e R² (IC de `eta_squared()` sobre o `lm`, bilateral como na ANOVA). A
  leitura usa os limites de Cohen para r (0,1; 0,3; 0,5), que ao quadrado
  valem para o R² (0,01; 0,09; 0,25), e não os do η².
- **Textos**: `$teste` traz a inclinação por unidade do preditor com o IC;
  `$equacao` escreve a reta com os rótulos; `$poder` usa `pwr.f2.test()`
  (f² = R² / (1 - R²)) e, como na ANOVA, só aparece sem evidência e com
  poder abaixo de 80%.
- **Tabelas**: `exibir_teste()` mostra os coeficientes (ganhou `casas` e
  `rotulo_preditor`, que só a regressão usa, e `nota`, que vale para todas
  as análises, como em `exibir_resumo()`) e `exibir_resumo()`, o
  ajuste do modelo numa linha.
- `grafico_residuos()` da regressão: uma nuvem só, com `geom_smooth(method
  = "loess")` em coral para mostrar curva (o cangulo dá um U).

### Teste t unilateral (v0.11.0)

Decisão do professor (10/10/2026), pedida pela Trilha, cuja tela do teste t
de duas amostras oferece a hipótese unilateral: `comparar_medias(...,
alternativa = "bilateral")`, com `"maior"` ou `"menor"` (a média do
primeiro grupo, na ordem dos níveis, maior ou menor que a do segundo). É
argumento, não função nova (regra do verbo). Com três ou mais grupos, só
`"bilateral"`: a ANOVA é sempre bilateral, e a função recusa o resto.
- A receita escreve `alternative =` no `t.test()`; a escolha fica em
  `resultado$nomes$alternativa` (`alternativa_do()` devolve `"bilateral"`
  para resultados sem ela, como as medianas).
- O IC da diferença fica aberto de um lado. Frases, `exibir_teste()`
  (coluna "IC 95% unilateral"), console e `formatar_numero()` escrevem
  `+∞`/`-∞`. `grafico_pares()` tem receita própria no unilateral, com uma
  seta no lado aberto (`receita_grafico_pares_unilateral`), para não
  pesar no código que os alunos da ANOVA veem.
- O IC do tamanho de efeito continua bilateral: estima o tamanho, não
  testa a hipótese.
- Poder no sentido da hipótese (d com sinal e `alternative` no
  `pwr.t2n.test()`). Diferença no sentido contrário: `$poder` diz isso, no
  lugar de um poder perto de zero.
- `escrever_resultados()` do teste t ganhou `$nota_tabela` e
  `$legenda_figura`, como a ANOVA, para o relatório do teste t na Trilha.

### ANOVA de Welch (v0.8.0)

Com três ou mais grupos e `variancias_iguais = FALSE`, a análise anotada é
`anova_welch`, com receitas próprias em `receitas_medias`,
`receitas_efeito` e `receitas_textos`:
- `oneway.test(var.equal = FALSE)`, lido direto do objeto (o `tidy()` dele
  solta uma mensagem em inglês). `$anova` tem as mesmas linhas da clássica
  (fator e resíduos), sem `sq` e `qm`; o gl dos resíduos tem decimais.
- Pressuposto: Shapiro em cada grupo, como no t de Welch; sem Levene.
- Games-Howell escrito em dplyr na receita (`cross_join`, `qtukey`,
  `ptukey`), como o Dunn; confere com `rstatix::games_howell_test()`.
  Letras com `vec2mat()` e `multcompLetters()`, maior média leva "a".
- `medir_efeito()`: ω² aproximado com `F_to_omega2()` (IC bilateral),
  igual à CatalyseR; o η² clássico não entra.
- Textos: F com os gl separados por ";" (o segundo tem vírgula decimal);
  aviso de cautela no Games-Howell com menos de 6 observações num grupo;
  o poder é aproximado pela F não central com os pesos do Welch (n /
  variância de cada grupo) e os gl do Welch, porque o pwr supõe variâncias
  iguais; confere com simulação a ±1 ponto percentual. Como na clássica,
  só entra no texto sem evidência e com poder abaixo de 80%.
- `grafico_residuos()` e `grafico_qq()` usam as receitas do teste t
  (resíduo = observação menos a média do grupo; Q-Q por grupo), porque não
  há modelo com variância comum.

### Comparar medianas (v0.6)

```r
resultado <- capturas |>
  comparar_medianas(resposta = cpue_kg, grupos = petrecho)

resultado |> medir_efeito()          # ε² dos postos (3+) ou r bisserial (2)
resultado |> grafico_medianas()      # a figura principal
resultado |> grafico_boxplot()       # exploração, a mesma das médias
textos <- resultado |> escrever_resultados()
```

| Grupos | Teste | Partes próprias | `medir_efeito()` |
|---|---|---|---|
| 2 | Mann-Whitney, com o deslocamento de Hodges-Lehmann e IC | `$teste` | r bisserial dos postos |
| 3 ou mais | Kruskal-Wallis; Dunn com p ajustado por Holm (padrão), Bonferroni ou BH (`ajuste_p`, v0.14.0) | `$teste`, `$pares` | ε² dos postos |

- **Mann-Whitney unilateral** (v0.13.0, pedido pela Trilha):
  `alternativa = "bilateral"`, `"maior"` ou `"menor"`, como no teste t; só
  com dois grupos (`escolher_alternativa()`, no motor, recusa com três ou
  mais). O IC do deslocamento fica aberto de um lado; a frase fala da
  mediana com dispersões parecidas e das observações com dispersões
  diferentes. As frases das medianas trazem `$nota_tabela` e
  `$legenda_figura`, como as médias.
- `$resumo` traz n, mediana, q1, q3, `aiq` e `letra`; `$pressupostos` traz
  o Fligner-Killeen (dispersão parecida nos grupos). Com dispersões
  parecidas, o teste compara as medianas; se o Fligner rejeitar, as frases
  de `escrever_resultados()` dizem "as distribuições" no lugar de "as
  medianas" e o alerta explica por quê.
- O Dunn é escrito em dplyr na própria receita (postos, correção de empates,
  z, `p.adjust(method = "holm")`), sem pacote novo; os z e os p conferem com
  `FSA::dunnTest()` e `dunn.test::dunn.test()`. Os pares saem na ordem do
  Tukey (`B-A`).
- Letras: `vec2mat()` e `multcompLetters()` com a matriz ordenada pela
  mediana, para a maior mediana levar "a". Com dois grupos, a regra do
  teste t.
- Mann-Whitney: `exact` é decidido na receita (exato sem empates e com menos
  de 50 observações; senão, aproximação normal), para o R não soltar avisos
  em inglês.
- ε² vem de `rank_epsilon_squared()`, com intervalo por bootstrap; a receita
  usa `set.seed(1)` para o resultado se repetir. Em `escrever_resultados()`,
  o ε² é calculado direto do H (`H / (n - 1)`), igual ao do effectsize.
- `grafico_medianas()`: pontos, losango na mediana, haste de q1 a q3 e
  letras; argumentos `titulo`, `explicacao`, `mostrar_pontos`,
  `mostrar_letras`, `cores`, `tamanho_texto` e `fonte`, montados de
  `trechos_grafico_medianas` como no `grafico_medias()`.
- `grafico_residuos()` e `grafico_qq()` não têm receita para as medianas:
  `escolher_receita()` (motor) explica isso ao aluno e indica o
  `grafico_boxplot()`. `grafico_medias()`, `grafico_pares()` e
  `grafico_medianas()` conferem a classe do resultado com
  `conferir_resultado()` e indicam a função certa.
- `$poder` sai vazio nas medianas (a ClaRa ainda não calcula poder para
  testes de postos).

### Formatar e exibir (v0.10.0)

Decisões B, C e D do professor (9/10/2026): uma só versão das funções de
formatação que se repetiam nos moldes da Trilha (`fmt()`, `formatar_p()`,
`flextable_ocean()`) e no EAPADados (`flextable_ocean()`,
`flextable_cinza()`), com o prefixo `exibir_*` para as tabelas.

- `formatar_numero(x, casas = 2)` e `formatar_p(p, casas = 3, no_texto =
  FALSE)`, em `R/clara_formatar.R`: vírgula decimal, `"< 0,001"`, traço no
  `NA` (como o `fmt()` dos moldes). Os `print()` dos resultados usam as
  duas; `numero()` e `escrever_p()` saíram do motor.
- **Por que `exibir_` e não `mostrar_`** (confirmado pelo professor em
  9/10/2026): na ClaRa, "mostrar" já é o verbo do código, no argumento
  `mostrar_codigo = TRUE` de todas as funções; `exibir_teste(mostrar_codigo
  = TRUE)` separa exibir o resultado de mostrar o código. E no ecossistema
  `mostrar_*` já tem outro dono: nos moldes antigos da Trilha e no
  EAPADados, `mostrar_anova()` e `mostrar_teste_t()` recebem os dados e
  fazem o teste, enquanto `exibir_*` (como `exibir_teste_t()` do EAPADados)
  apresenta um resultado já calculado. Regra: **`exibir_*` recebe um
  resultado pronto e devolve a apresentação (tabela)**; nenhuma função nova
  da ClaRa usa o prefixo `mostrar_`.
- `exibir_tabela(tabela, tema = c("ocean", "cinza"))`: qualquer tabela. Os
  temas são os do livro: `"ocean"` para a tabela numerada do Word (Times
  New Roman 10, como a dos moldes da Trilha; o EAPADados usava 9) e
  `"cinza"` para olhar no Viewer (Consolas 9, fundo sage). Os dois moram
  em `temas_tabela`, como trecho de receita.
- `exibir_teste()` e `exibir_resumo()`, em "Para qualquer análise": verbos
  sobre o resultado, como `escrever_resultados()`, com receitas por análise
  em `receitas_tabela_teste` e `receitas_tabela_resumo` (as cinco análises
  de hoje). A receita define `com_virgula()` e `texto_p()` (célula vazia no
  `NA`, como pede uma tabela de artigo) e o tema do flextable, para rodar
  copiada. `exibir_resumo()` põe a letra sobrescrita (`compose()` com
  `as_sup()`) e recebe a nota em `nota = textos$nota_tabela`; a receita
  mostra a nota como o aluno a escreveu (`rlang::enquo()` antes de o R
  avaliar o argumento) e roda no ambiente de quem chamou.
- Para a Trilha (rota ClaRa): o `relatorio.qmd` pode trocar o `transmute()`
  + `flextable_ocean()` das duas tabelas por `resultado |> exibir_teste()` e
  `resultado |> exibir_resumo(casas = casas, nota = textos$nota_tabela)`, e
  o `funcoes.R` do projeto deixa de precisar de `fmt()`, `formatar_p()` e
  `flextable_ocean()`. A mudança é na Trilha, não aqui (regra 1).

### Ajuda

Desde a v0.9.0 (pacote), a ajuda vem das páginas `.Rd` geradas pelo
roxygen2. `ajuda()` lista as funções do aluno, agrupadas por seção, com a
pergunta de cada uma; `funcoes_da_clara()` lê as páginas do pacote instalado
(`tools::Rd_db("clara")`; com `devtools::load_all()`, os arquivos de `man/`).
A pergunta é o título da página e a seção é o `@concept`. A lista abre no
painel **Viewer** (`pagina_de_ajuda()` monta o HTML, cores Ocean) ou, com
`onde = "console"`, no console. `ajuda(comparar_medias)` abre a página da
função no painel **Help**, o mesmo que `?comparar_medias`. A ordem da lista
é a de estudo, em `ordem_da_ajuda` (motor); uma função nova que ainda não
esteja lá entra no fim da sua seção, e uma seção nova antes de "Para
qualquer análise". Toda função do aluno tem este bloco roxygen, logo abaixo
da linha de título (que fica para o sumário do RStudio, Ctrl+Shift+O):

```
# nome_da_funcao() -------------------------------------------------------
#' A pergunta da pesquisa, com maiúscula e ponto de interrogação?
#'
#' O que faz, em parágrafos; listas em markdown (- **chave**: texto).
#'
#' @param argumento o que é
#'
#' @return Devolve ...; partes do resultado em lista (- `resultado$x`: ...).
#'
#' @examples
#' # exemplo que roda com dados do próprio R (PlantGrowth, ToothGrowth,
#' # InsectSprays); arquivos só em tempdir()
#'
#' @concept Nome da seção (Comparar médias, Para qualquer análise...)
#' @export
```

Depois de mudar um bloco `#'`, rode `roxygen2::roxygenise()` (ou
Ctrl+Shift+D no RStudio). Um `` `r ...` `` dentro do texto é avaliado pelo
roxygen: para mostrá-lo como código, use crase dupla (`` `` `r x` `` ``).
Peças internas levam comentário comum, sem `#'`.

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
- **Argumentos de escolha listam as opções no padrão**, com a primeira
  valendo quando o aluno não escolhe: `haste = c("ic", "ep", "dp")`,
  `cores = c("ocean", "cinza")`. Assim o Tab do RStudio mostra as opções
  (como em `cor(method = ...)`). Na função, `escolher_opcao()` devolve a
  escolhida ou dá mensagem amigável. O Tab também lista os nomes dos
  argumentos dentro de `funcao(`, porque o RStudio lê a definição da função
  depois do `library(clara)`.
- **Uma frase explicativa acima de cada linha** nas funções do aluno,
  principalmente na função principal. Funções claras pedem comentários
  curtos; não repetir o óbvio.
- Cada arquivo organizado em seções (`# Nome da seção ----`), visíveis no
  sumário do RStudio (Ctrl+Shift+O). Peças internas ficam em
  `R/clara_motor.R`, na seção "Motor das receitas".
- Textos para o aluno com linguagem humanizada; **evitar travessões**.
- Números exibidos com vírgula decimal (`numero()`, `escrever_p()`); um p
  muito pequeno aparece como "p < 0,001", nunca zero.
- Estatística honesta: frases de pressupostos dizem o que o teste mostrou.
  p acima da significância é "sem evidência contra o pressuposto", nunca
  prova de que ele vale.
- Identidade visual **Ocean Gradient**: NAVY #0F3B5F, TEAL #2E7D8F,
  SEAFOAM #62B6B7, AMBER #E89B3C, CORAL #E76F51; `paletas_clara$ocean` tem 8 cores
  e se estende com `colorRampPalette()` quando há mais grupos.

## Limitações conhecidas

- Nomes de coluna com espaço ou símbolo (`Peso (g)`) quebram `TukeyHSD()` e
  `multcompLetters4()`. A ClaRa recusa esses nomes com mensagem amigável e
  pede `rename()` no preparo. Acentos (`ração`) funcionam.
- Hífen no nome de um grupo atrapalha as letras (Tukey e Dunn); também é
  recusado.
- ~~`executar_receita()` carrega os pacotes com `library()`~~: resolvido
  na v0.9.0 (decisão K). A receita enxerga os pacotes por um ambiente
  próprio (`ambiente_com_pacotes()`, na ordem de `pacotes_*`, o último
  escondendo os anteriores, como no `library()`), e o caminho de busca do
  aluno não muda. O código mostrado traz os `library()` no topo, para rodar
  copiado numa sessão nova. A semente aleatória do aluno é preservada com
  `withr::with_preserve_seed()`, mesmo com o `set.seed(1)` da receita do ε².
- Com mais de 5000 observações, o `shapiro.test()` para com erro em inglês.
  O EAPACaderno trata isso (registra NA e deixa a leitura para o Q-Q); a
  ClaRa ainda não.
- `grafico_medias()` com muitos grupos e `mostrar_barras = FALSE`: o rótulo
  "média ± DP" fica deitado e pode tocar a coluna vizinha (em pé, sairia
  cortado). Saída: `mostrar_media_dp = FALSE`.

## Decisões em aberto

1. ~~Intervalo de η² e ω²~~: resolvido em outubro de 2026 (v0.7.1). Como o
   do d de Cohen no teste t, o intervalo é bilateral
   (`alternative = "two.sided"`): o limite superior deixa de sair sempre 1.
   Vale também para o ε² das medianas (decisão 9).
2. ~~Rótulo "média ± DP" no gráfico~~: resolvido em outubro de 2026, a pedido
   do professor. O gráfico agora tem barra transparente até a média, o rótulo
   "média ± DP" ao lado do losango, letras todas na mesma altura, explicação
   no título e jitter com semente (a figura não muda a cada execução).
   `grafico_medias()` devolve um ggplot: ajustes extras entram com `+`.
3. ~~t de Student como opção; ANOVA de Welch~~: resolvido. O teste t usa
   `variancias_iguais = TRUE` para o Student. A ANOVA de Welch entrou em
   v0.8.0 (outubro de 2026) com `variancias_iguais = FALSE`; por decisão do
   professor, o padrão do argumento (`NULL`) depende do número de grupos:
   FALSE (Welch) com dois, TRUE (ANOVA clássica) com três ou mais. Assim
   os roteiros de ANOVA que não escrevem o argumento não mudaram.
4. Mínimo de 3 observações por grupo (exigido pelo Shapiro em cada grupo):
   vale hoje também para a ANOVA, que tecnicamente aceitaria 2.
5. ~~Letras com dois grupos~~: mantidas (decisão do professor, outubro de
   2026). Imitam o Tukey ("a"/"a" sem diferença; "a" para a maior média e
   "b" com diferença).
6. ~~Poder observado~~: mantido como está (decisão do professor, outubro de
   2026). Registro do que se discutiu: segue o EAPACaderno (calcula o
   poder com o efeito observado e só o cita quando p ≥ α e poder < 80%). O
   poder observado é função direta do p, então essa frase aparece em quase
   todo resultado sem evidência e pouco acrescenta. Alternativas: dizer o n
   por grupo necessário para detectar um efeito de interesse definido pelo
   pesquisador, ou retirar a frase. O professor preferiu manter.
7. ~~`grafico_diagnostico(tipo = ...)`~~: separado em `grafico_residuos()` e
   `grafico_qq()`, pela regra "uma função, uma figura" (outubro de 2026, a
   pedido do professor, para avaliar como fica).
8. Medianas: Dunn com Holm, escrito na receita, ou um pacote (FSA,
   rstatix)? A receita mostra a conta inteira, mas fica longa. ~~Holm ou
   Bonferroni?~~ Resolvido em 11/10/2026 (v0.14.0): argumento
   `ajuste_p = c("holm", "bonferroni", "bh")`, Holm como padrão (controla
   o erro como Bonferroni, com mais poder); só com três ou mais grupos.
9. Medianas: limites de leitura. ε² usa os mesmos do η² (0,01; 0,06; 0,14)
   e o r bisserial os de Cohen para correlação (0,1; 0,3; 0,5). O intervalo
   do ε² é bilateral, como o do η² (decisão 1).
10. Medianas: o pressuposto conferido é a dispersão (Fligner-Killeen). Basta,
    ou também a forma das distribuições? E o mínimo de 3 observações por
    grupo (decisão 4) vale aqui também, embora os testes de postos não usem
    o Shapiro.

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
3. **Um arquivo por pergunta, na pasta `R/`** (divisão feita em outubro de
   2026, quando entrou `comparar_medianas()`):
   - `R/clara.R` é a página do pacote (`?clara`) e o mapa dos arquivos; o
     aluno escreve `library(clara)`;
   - `R/clara_medias.R`, `R/clara_medianas.R`...: o verbo, os gráficos, as
     receitas (inclusive as de efeito e de textos) e o `print` de cada
     pergunta, que acrescenta as suas receitas às listas
     (`receitas_efeito$kruskal <- ...`);
   - `R/clara_qualquer_analise.R`: `medir_efeito()`,
     `escrever_resultados()`, `grafico_residuos()` e `grafico_qq()`, só as
     funções e as listas vazias, mais o desenho dos resíduos que serve a
     todas;
   - `R/clara_motor.R`: `ajuda()`, peças internas e paletas.
   A ordem de carga é o motor, depois "qualquer análise", depois as
   perguntas (campo `Collate` do `DESCRIPTION`). O plano original punha a exibição no
   console no motor; ela ficou no arquivo de cada pergunta, para quem
   estuda uma pergunta achar tudo dela num arquivo só.
   **Arquivos, não subpastas** (decidido em outubro de 2026): cada pergunta
   cabe num arquivo de tamanho razoável; o sumário do RStudio
   (Ctrl+Shift+O) funciona dentro de um arquivo, não entre pastas; o prefixo
   `clara_` mantém tudo junto no painel Files, como uma lista de perguntas;
   e, se a ClaRa um dia virar pacote, a pasta `R/` de um pacote não aceita
   subpastas.
4. **Não transformar em pacote por antecipação.** `source()` basta até existir
   um motivo concreto, como a CatalyseR precisar de `library(clara)` no
   projeto exportado.
   **Primeiro motivo concreto anotado** (outubro de 2026, ao discutir a
   migração para a CatalyseR): o exportador copia os `R/clara*.R` para cada
   projeto, e cada cópia fica congelada na versão do dia da exportação.
   Projetos exportados em datas diferentes podem ter ClaRas diferentes (um
   argumento novo funciona num e falha no outro). Por enquanto, a versão
   fica em `R/clara.R` (no título e em `versao_clara`, avisada no
   `source()`), e toda mudança na ClaRa atualiza esse número nos dois
   lugares. Se manter as cópias em dia começar a dar trabalho, é a hora de
   virar pacote: instalado uma vez, atualizado num lugar só, com
   `packageVersion()`.
   **Revisto em 8/10/2026, com o nome novo da IDE (Trilha, pacote
   `trilha`):** a ClaRa já vem junto com a Trilha, como cópia em
   `inst/app/templates/clara/`, e a IDE não executa a ClaRa, só a põe nos
   projetos. Empacotar não muda isso e esbarra em duas coisas: este
   repositório é privado, e o projeto exportado deixaria de ser só CRAN.
   Por isso a ClaRa continua sem pacote. O cuidado que fica é a cópia
   atrasar; um teste na Trilha vai comparar as `versao_clara` (ver
   `TRILHA/docs/PLANO_TRILHA.md`).
   **Decidido em 9/10/2026: a ClaRa vira pacote** (substitui os dois
   parágrafos acima). Palavras do professor: "um belo pacote, bem
   estruturado, sem bugs, conversando bem com a Trilha". O motivo concreto
   agora existe: a Trilha vai **executar** a ClaRa, e não só copiá-la, e
   só um pacote instalado garante que a tela e o projeto rodem a mesma
   versão. O roteiro está em `TRILHA/docs/PLANO_TRILHA_E_CLARA.md`
   (fases 0 a 5); o plano de 8/10 e as decisões A a I estão em
   `docs/resumo_sessoes_2026-10.md`. Enquanto a `clara` não estiver no
   CRAN, o projeto exportado continua levando a cópia em `R/clara/`, mas
   tirada do pacote instalado. Mantém-se o desenho de hoje: um arquivo por
   pergunta em `R/`, receitas em listas, motor à parte.
   **Fase 1 feita em 9/10/2026 (v0.9.0, ramo `pacote`):** `DESCRIPTION`,
   roxygen2, testthat e `R CMD check` com só o aviso dos acentos. Os seis
   roteiros de `exemplos/` dão os mesmos números e figuras da 0.8.9. A
   versão mora só no `DESCRIPTION`; toda mudança na ClaRa sobe a versão lá
   e ganha uma linha no `NEWS.md`. Decisões do professor de 9/10 (letras do
   plano de 8/10, revistas): A nome `clara`; B `formatar_numero()` e
   `formatar_p()`, logo depois da Fase 1 (feito na v0.10.0, seção
   "Formatar e exibir"); C prefixo `exibir_*` (feito); D effectsize em
   Imports, car fica por ora (trocar o Levene muda números), flextable
   entrou com a formatação (v0.10.0); E redação só das análises que a
   ClaRa já cobre; F `atualizar_codigo()`, `conferir_codigo()` e
   `resumir_grupo()` ficam fora; G o `analise.R` e o relatório da rota
   ClaRa chamam a ClaRa; H mantenedor Evaldo Martins da Silva
   <cluber.ufpa@gmail.com> por enquanto (para o CRAN, o institucional é
   mais seguro); I dados só nos testes na Fase 1, e uns 15 conjuntos das
   ciências agrárias (criação animal, foco em pescado) numa fase própria;
   J acentos ficam até a Fase 5; K `library()` e `set.seed()` corrigidos
   já; L entram ANOVA, teste t e medianas; M prefixo `catalyser_` →
   `trilha_` na Trilha, feito no mesmo dia.
   **Decidido em 9/10/2026, para a Fase 2: o projeto exportado usa
   `library(clara)`** (opção b do professor). A cópia em `R/clara/` sai do
   projeto, e a de `TRILHA/inst/app/templates/clara/` deixa de existir. O
   motivo, nas palavras do professor: a `clara` só depende do CRAN e será
   um pacote leve e útil. Enquanto ela não estiver no CRAN, o projeto pede
   a instalação pelo GitHub (`remotes::install_github("cluberufpa/ClaRa")`,
   a mesma que a Trilha faz no `instalar_trilha.R`); quando entrar, basta
   `install.packages("clara")`. Assim a regra "só CRAN" do projeto exportado
   (seção "A ClaRa na Trilha") passa a ser "só CRAN e a `clara`". Foi
   descartada a opção (a), uma cópia legível dos fontes em `inst/` gerada no
   build, porque mantinha duas formas da mesma ClaRa.
5. **Versionar com git.** O repositório é `github.com/cluberufpa/ClaRa`
   (público desde 9/10/2026, ramo `main`; os alunos instalam com
   `remotes::install_github("cluberufpa/ClaRa")`). Nesta pasta os commits saem como
   `clubeR <cluber.ufpa@gmail.com>`; o push usa a credencial do cluberufpa
   guardada no Windows (Git Credential Manager).

## Em espera

- Mann-Whitney com empates: a receita usa a aproximação normal
  (`exact = FALSE` quando há empates). Desde o R 4.4, o `wilcox.test()`
  calcula o p exato também com empates, e o padrão dele dá outro p (na
  `real_artemia_racoes`: 0,027 no padrão do R, 0,035 na ClaRa). Decidir
  com o professor se a ClaRa acompanha o R novo;
- teste t pareado (antes e depois no mesmo animal): pede outro argumento,
  como `pareado_por = individuo`;
- `grafico_pares()` para as medianas: o Dunn não dá intervalo; seria
  preciso um IC por par (Hodges-Lehmann de cada par, com ajuste);
- poder para as medianas (`$poder` sai vazio);
- o alerta de `escrever_resultados()` nas médias poderia citar
  `comparar_medianas()` pelo nome, agora que ela existe;
- comparar com um controle (aprovado em outubro de 2026, a implementar):
  dois argumentos em `comparar_medias()` e `comparar_medianas()`,
  `comparacao = c("todos_os_pares", "contra_controle")` e `controle = "A"`.
  Médias: Tukey ou Dunnett (`multcomp`, CRAN: `glht(mcp(... = "Dunnett"))`);
  medianas: Dunn em todos os pares ou só contra o controle (Holm sobre
  k - 1 comparações). Letras, não asterisco: o controle leva "a"; quem não
  difere dele, "a"; quem difere, "b". `$pares` com k - 1 linhas;
  `grafico_pares()` só com as diferenças contra o controle;
  `escrever_resultados()` diz "a ração B diferiu do controle (A)". Com dois
  grupos, `comparacao` não muda o teste e `controle` define o sentido da
  diferença (tratamento menos controle);
- regressão com uma reta por grupo (`relacionar_variaveis(..., grupos = sexo)`):
  outro modelo, com interação, e decisões próprias (como testar se as
  retas diferem); até lá, a Trilha usa o molde antigo quando a tela pede
  retas por grupo;
- gráficos de influência da regressão (Cook, alavancagem,
  escala-localização), cada um com o seu nome; hoje a influência sai em
  `resultado$influencia` e nos textos;
- próxima análise: `comparar_proporcoes()`.

## A ClaRa na Trilha, antiga CatalyseR (outubro de 2026)

A integração começou pela ANOVA de um fator, como opção experimental no
exportador da CatalyseR ("Escrever o código em ClaRa", branch `clara` do
repositório da CatalyseR; clássica, Welch e automático da tela, este escrito
como `variancias_iguais` conforme a escolha que a CatalyseR fez pelo Levene).
Desde 9/10/2026 a IDE se chama **Trilha** e se desenvolve só em `TRILHA/`
(`cluberufpa/trilha`); a CatalyseR foi encerrada na 0.1.34 e não recebe mais
cópias. O trabalho mora na Trilha, não aqui (regra 1):
`TRILHA/inst/app/templates/clara/` guarda a cópia da ClaRa que viaja nos
projetos e `TRILHA/inst/app/templates/anova_clara/` o roteiro e o relatório.
Ao mudar a ClaRa, atualize essa cópia (e a versão, regra 4).

Decisões do professor para o projeto exportado em ClaRa:
- **Um só QMD**: `R/analise.R` é o caderno de estudo (cerca de 170 linhas) e
  `relatorios/relatorio.qmd` é o relatório Word, com a tabela da ANOVA, o
  resumo por grupo e a figura principal (sem a figura dos pares). Não há
  caderno HTML; os chunks do relatório repetem as chamadas da ClaRa do script
  e rodam sozinhos. Mais resultados, se preciso, entram como apêndice no Word.
- **Receita e carimbo, sem `.rds`**: a base nasce da planilha numa só cadeia
  com pipe até `base` (trilha, ramo e grupos como fator, sem nomes
  intermediários); o carimbo traz linhas, contagem e média por grupo que a
  tela mostrou, e `stopifnot()` trava só o número de linhas.
- **Só CRAN**: sem catalyser nem EAPADados no projeto. Desde 9/10/2026
  (Fase 2), **só CRAN e a `clara`**: o projeto carrega `library(clara)`
  em vez da cópia em `R/clara/` (regra 4).
- **`dados/` só com a planilha**, sem `brutos/` e `processados/`. A cópia
  da base para o Excel sai do script, em `saida/tabelas/base.csv`, refeita a
  cada execução; não vira aba da planilha bruta (seria cópia estática e
  mexeria na entrada preservada).
- A ClaRa viajava em `R/clara/`; a partir da Fase 2 o projeto usa
  `library(clara)` e a pasta sai. Em `R/` o aluno vê só `analise.R` e
  `funcoes.R`. As seções do roteiro são numeradas em sequência: 1 Preparar
  o ambiente, 2 Ler a planilha, 3 Preparar a base, 4 Comparar as médias,
  5 Tabelas, 6 Gráficos, 7 Textos dinâmicos, 8 Salvar cópias
  (`salvar_tabelas()` e `salvar_figuras()`, v0.7.3) e 9 Registrar o
  ambiente (`registrar_ambiente()`).
- Limites de linhas são acompanhados, não travados.

## Próximos passos possíveis

- Próxima pergunta (regressão ou proporções): um arquivo novo
  `R/clara_<pergunta>.R`, no molde de `R/clara_medianas.R`, acrescentado ao
  `Collate` do `DESCRIPTION` e à `ordem_da_ajuda` (motor), com testes
  em `tests/testthat/`.
- Integração com a CatalyseR: o exportador poderia gerar o analise.R em
  ClaRa, copiando os arquivos `R/clara*.R` para o projeto exportado como já faz com o
  `funcoes.R` (só pacotes do CRAN). Mapa do analise.R do EAPACaderno (ANOVA):
  seções 4 a 7 → `comparar_medias()` e `medir_efeito()`; 9.2 →
  `grafico_medias()`; 9.1 → `grafico_boxplot()`; 9.3 e 9.4 →
  `grafico_residuos()` e `grafico_qq()`; 9.5 → `grafico_pares()`; 10 →
  `escrever_resultados()`; 11 → `salvar_tabelas()` e `salvar_figuras()`
  (v0.7.3); 12 → `registrar_ambiente()` (v0.7.2). Ficam fora da ClaRa:
  leitura e preparo (2, 3); as tabelas flextable (8) entraram em v0.10.0
  (`exibir_teste()`, `exibir_resumo()`). Salvar cópias passou
  para a ClaRa em v0.7.3, por decisão do professor: a chamada esconde o
  `dir.create()`, a lista e o `for`, mas mostra cada item salvo com o nome
  do arquivo antes do `=` (`anova = resultado$anova` grava `anova.csv`). A análise do roteiro está
  toda coberta: `exemplos/anova_bagres.R` não tem mais blocos "Ainda sem
  ClaRa" (462 linhas de código no original, 42 em ClaRa). Os QMDs precisarão ler
  `resultado$...` e `textos$...` no lugar dos objetos soltos atuais.
- **No exportador, as escolhas aparecem escritas**: os argumentos da
  chamada são o registro do que o aluno escolheu nos menus da CatalyseR
  (`comparacao = "contra_controle"`, `controle = "A"`), e as escolhas
  principais vão escritas mesmo quando são o padrão
  (`comparacao = "todos_os_pares"`, `variancias_iguais = FALSE`).
- **Superado pelo carimbo.** Os dois itens abaixo descrevem a primeira ideia
  de conferência da base (`.rds` + `all.equal()`). Na rota ClaRa vigente, a
  base nasce da planilha e o carimbo trava o número de linhas com
  `stopifnot()` (seção "A ClaRa na Trilha"). Ficam como histórico; o que
  continua valendo é o projeto exportado sem catalyser nem EAPADados.
- Com `all.equal()` no lugar do `catalyser_conferir_base()` e a base lida do
  `.rds`, o analise.R exportado não precisa mais dos blocos que conferem a
  instalação do catalyser e do EAPADados (observação do professor, outubro
  de 2026). A mudança é no exportador da CatalyseR, não aqui.
- **Na migração, a conferência da base usa `all.equal()`** (aprovado pelo
  professor em outubro de 2026). O analise.R exportado lia a base pronta
  (`readRDS("dados/processados/base_compartilhada.rds")`), mostra em dplyr a
  receita que a CatalyseR registrou e confere com
  `all.equal(base_da_receita, base_pronta)`: `TRUE` confirma; senão, o R diz
  o que mudou. Isso substitui o `catalyser_conferir_base()` e tira do projeto
  exportado a dependência do pacote catalyser (GitHub), deixando-o só com
  pacotes do CRAN. Modelo pronto: seções 2 e 3 de `exemplos/anova_bagres.R`.

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
