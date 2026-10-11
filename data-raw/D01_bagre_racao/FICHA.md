# D01 — Bagres: rações isoproteicas

Data: 11/10/2026. Conjunto atual: `EAPADados::isoproteica_bagre`.
Objeto final: `bagre_racao_isoproteica`. Código permanente: `D01`.
Registro e pasta de preparo: `D01_bagre_racao`.
Nome antigo no EAPADados: `isoproteica_bagre`.
Curadoria aprovada pelo professor em 11/10/2026; autorização da fonte pendente.

## O que foi autorizado e feito

O professor solicitou a cópia dos dados brutos para examiná-los antes da
curadoria. Foram preservados, com conferência SHA256 em `fonte/SHA256.txt`:

- `dados_brutos_eapadados.xlsx`: arquivo completo da fonte local, intocado;
  o conjunto está na aba `src_isoproteica`;
- `isoproteica_bagre.rda`: cópia do objeto atual, apenas como referência;
- `data_isoproteica_bagre.R`: documentação atual do EAPADados;
- `preparar_dados.R`: preparo atual do EAPADados, apenas para consulta;
  não executar este script aqui.

`bagres_para_revisao.xlsx` é uma extração para consulta da aba de origem:
19 linhas, duas colunas (`Ração`, `Peso`), na mesma ordem e com os mesmos
valores. Nenhuma linha foi excluída, imputada ou recodificada; nenhum cabeçalho
foi traduzido. Não há células vazias nas 19 observações. Há 5, 5, 4 e 5
observações para A, B, C e D, respectivamente. Esses números descrevem a
planilha; a interpretação experimental ainda depende da conferência da fonte.

## Origem informada e pendências

A documentação existente cita Bhujel, R. C. (2011), *Statistics for
Aquaculture*, Tabela 7.4, p. 103. Esta etapa não conferiu o livro original.
A documentação descreve peso médio final em gramas por gaiola e contém uma
divergência: quatro gaiolas por ração em um trecho e cinco réplicas planejadas
em outro. A unidade experimental e o desenho devem ser confirmados.

Natureza declarada no inventário: real. Ainda não homologada nesta curadoria.
Não interpretar os 19 valores como pesos de 19 peixes individuais nem fabricar
réplicas para balancear os grupos.

Licença específica dos dados e autorização de redistribuição: não localizadas
nos arquivos consultados. A preferência do professor pela licença MIT da
ClaRa não constitui autorização para redistribuir esta fonte.

## Uso didático candidato

A planilha de balanço lista ANOVA de um fator, Welch e Kruskal-Wallis.
Adequação científica, pergunta, chamadas da ClaRa e limites serão registrados
na proposta após a revisão. Não foi executada nem aprovada uma análise nesta
etapa.

## Decisão do professor e adaptações aplicadas

Em 11/10/2026, no chat, o professor declarou: “Eu acho que podemos aprovar.
OS autores ainda não me respondeu, mas já quero usar na clara.” Foi aplicado
o preparo local, com a pendência de autorização explicitada na ajuda e no
catálogo. Não foi atribuída licença MIT aos dados. O professor autorizou posteriormente a integração local na `main`.
A autorização de publicação da fonte continua pendente; não houve push.

| Nome na fonte | Nome no EAPADados | Nome final | Unidade | Tipo |
|---|---|---|---|---|
| Ração | racao | racao | Não se aplica | Fator nominal |
| Peso | peso_g | peso_g | g, conforme documentação recebida | double |

O nome da resposta explicita que se trata de peso médio final, não ganho de
peso nem medição individual. O objeto passou de tibble a `data.frame`
simples. Categorias A → A, B → B, C → C e D → D; ordem A, B, C, D. Não se
trata de fator ordinal. Não foram acrescentados identificadores artificiais.
Não houve exclusão de linhas/colunas, imputação, conversão de unidades,
junção, mudança de formato largo/longo ou cálculo de novas medidas.

## Preparo e conferência

Na raiz de `ClaRa-dados/`, execute:

```r
source("data-raw/D01_bagre_racao/preparar.R", encoding = "UTF-8")
source("data-raw/preparar_catalogo.R", encoding = "UTF-8")
```

O primeiro script confere o SHA256 da fonte, dimensões 19 × 2, ausência de
NA, contagens 5/5/4/5 e igualdade de cada valor e categoria com o objeto
preservado do EAPADados. Totais por grupo: 431, 444, 410 e 463 g;
médias: 86,2; 88,8; 102,5; 92,6 g. As observações e sua ordem foram
preservadas. `usethis::use_data(..., compress = "xz")` gera o objeto de
304 bytes e o catálogo de 712 bytes (tamanhos desta primeira gravação).

## Pergunta didática e exemplo

O peso médio final dos bagres difere entre as quatro rações? A ajuda mostra:

```r
comparar_medias(
  dados = bagre_racao_isoproteica,
  resposta = peso_g,
  grupos = racao,
  rotulo_resposta = "Peso médio final (g)",
  rotulo_grupos = "Ração",
  confianca = 0.95,
  variancias_iguais = TRUE,
  alternativa = "bilateral",
  mostrar_codigo = FALSE
)
```

Uso principal: ANOVA de um fator, clássica/Tukey ou Welch/Games-Howell,
conforme a escolha de variâncias. Também serve a Kruskal-Wallis e Dunn,
estatística descritiva e boxplot. Os testes não substituem a conferência de
independência das gaiolas no desenho original.

## Pendências fora do escopo dos dados

`dados_treino/preparar_dados_treino.R` e `exemplos/anova_bagres.R` ainda
usam a origem anterior. A futura troca precisa preservar a interface
`real_bagre_racoes` (`racao`, `peso_g`), renomeando a resposta ao criar essa
base. Esses arquivos não foram alterados. A integração com a Trilha também
continua para a fase seguinte.

O `DESCRIPTION` recebeu `LazyData: true` e as duas referências aos novos
arquivos de documentação em `Collate`, necessárias para a instalação. A
ordem das funções, a versão e as dependências foram preservadas. Além de
`data-raw/`, `.Rbuildignore` exclui `.git`, que no worktree é um arquivo e
estava entrando no pacote.

## Resultado da validação em 11/10/2026

- `roxygen2::roxygenise()` gerou as duas páginas de ajuda.
- `devtools::test()` executou 200 expectativas: 200 passaram, zero falhas,
  zero avisos e zero testes ignorados, incluindo 15 expectativas dos dados.
- O exemplo com `comparar_medias()` foi executado e seus resultados foram
  salvos localmente em `data-raw/validacao/exemplo_bagres.rds`.
- `tools::checkRdaFiles("data")`: 304 e 712 bytes, compressão xz, formato 3.
- A ANOVA recalculada fornece SQ de tratamento aproximadamente 662 e SQ
  residual aproximadamente 136, F aproximadamente 24,4 e p aproximadamente
  0,00000510. A documentação anterior informava 665 e 128: esses valores
  antigos não foram reproduzidos na ajuda nova nem tratados como referência
  validada. O livro original continua pendente de conferência.
- O build do pacote foi gerado. O `R CMD check --no-manual` não concluiu:
  instalação falhou em lazy loading. A mesma instalação falhou na `main`
  original, sem dados novos. Carregar a instalação existente, ou somente
  `dplyr`, imprime a confirmação da carga mas termina com código 1 neste
  ambiente. Não foi alterado código de funções nem pacotes instalados para
  tentar corrigir essa condição. Causa definitiva ainda não identificada.
- A primeira tentativa dentro do sandbox não lia os helpers de teste. Fora
  dele os 200 testes executaram; o código de saída anormal do processo ainda
  ocorreu. Não interpretar a contagem de testes aprovados como aprovação do
  check ou instalação concluída.
- `git fetch origin` concluído; `origin/main` em `c4a63e1`, já ancestral da
  `main` local `44cb0fe`, usada como base. `git merge origin/main` informou
  que a branch já está atualizada. A pasta `ClaRa/` permaneceu limpa.

Situação após a decisão posterior do professor: **curadoria e preparo
aprovados; integração local na main autorizada; validação formal de instalação
e autorização da fonte pendentes**. A integração local não significa
instalação concluída. Não houve instalação global nem push. O acompanhamento
distingue curadoria aprovada, integração local e check pendente; a marca de
validação completa só será aplicada quando o check concluir.

## Convenção anterior de identificação (substituída pelo pedido da Trilha)

Por decisão do professor em 11/10/2026, o registro passa a `D01` e o
nome completo do objeto a `D01_bagre_racao_isoproteica`. O nome anterior
sem prefixo foi usado apenas durante o preparo local, antes da publicação.
Não mudou nenhum valor, categoria, unidade ou tipo de coluna.

## Ajuste solicitado pela Trilha em 11/10/2026

O professor mandou seguir `PEDIDO_DADOS_TRILHA_PARA_CLARA.md`. Conforme
esse pedido, o código é `D01`, o registro e a pasta são
`D01_bagre_racao` e o objeto é `bagre_racao_isoproteica`, sem prefixo.
O catálogo acrescenta `registro` e `nome_eapadados = "isoproteica_bagre"`.
A resposta volta ao nome `peso_g`, exigido pelos consumidores atuais da
Trilha; a ajuda explicita que é peso médio final por gaiola. Valores,
tipos, categorias e ordem continuam iguais. Nenhum arquivo da Trilha ou
função da ClaRa foi modificado. A autorização da fonte permanece pendente.

Conferência deste ajuste: 209 expectativas passaram (24 dos dados), sem
falhas, avisos ou testes ignorados. Comparação direta com o objeto anterior
confirmou valores e tipos idênticos após renomear a coluna para `peso_g`.
Dados em xz: 292 bytes; catálogo com os dois campos novos: 736 bytes.
O processo R continua terminando com código 1, conforme impedimento já
registrado; não foi declarada instalação/check concluída.
