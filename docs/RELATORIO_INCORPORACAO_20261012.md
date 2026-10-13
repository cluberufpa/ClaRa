# Incorporação de substitutos de literatura — 12/10/2026

Branch: `codex/substitutos-literatura-20261012`. As quatro trocas abaixo
mantêm o código Dxx; os objetos, fontes congeladas, receitas, ajuda, catálogo e
testes foram preparados antes da retirada do objeto antigo. As fontes GPL
anteriores foram movidas para `data-raw/substituidos/`, como histórico.

| Conjunto | Código | Saiu | Entrou | Linhas × colunas | Licença | Commit |
|---|---|---|---|---:|---|---|
| Búfalos-africanos | D12 | `bacterias_tratamento` (`MASS::bacteria`) | `bufalos_estrongilos` | 418 × 6 | CC0 1.0 | `bd051bb` |
| Percas, respirometria | D44 | `plantas_absorcao_co2` (`datasets::CO2`) | `percas_respirometria` | 449 × 4 | CC0 1.0 | `c4b1b76` |
| Molinésias, crescimento | D48 | `laranjeiras_crescimento` (`datasets::Orange`) | `molinesias_crescimento` | 340 × 4 | CC BY 4.0 | `e27bf81` |
| Secagem de vegetais | D52 | `paciente_peso` (`MASS::wtloss`) | `secagem_beterraba_gengibre` | 594 × 8 | CC BY 4.0 | `624d2c5` |

## Atualização posterior do D12

Por decisão do professor em 12/10/2026, `bufalos_estrongilos` foi substituído por
`erva_marinha_lesoes`, e esta, no mesmo dia, por `cabras_toxoplasma` (106 × 4, CC BY 4.0): na
erva-marinha o "antes" era constante e a tabela de pares degenerava (`mcnemar.test()` não rodava).
O novo conjunto reconstrói as linhas a partir das Tabelas 1 a 4 de Dahmane et al. (2025); só as
contagens são reais. A fonte e a receita ficam em `data-raw/D12_cabras_toxoplasma/`; as anteriores,
em `data-raw/substituidos/`.

## O que foi feito diferente do combinado

- D48 usa o recorte equilibrado recomendado no aprofundamento: 34 peixes nas
  dez idades completas (340 medições), não as 1.178 linhas. O `growth.csv`
  integral continua congelado e a receita torna o critério de seleção visível.
- No D52, a combinação de condição chama-se `serie`, e não `id_serie`: o
  catálogo testa que toda coluna iniciada por `id_` seja texto; uma série é um
  fator, não um identificador textual. Isso não altera as oito informações
  propostas.
- As receitas calculam SHA-256 a partir dos bytes dos arquivos, pois a versão
  instalada de `digest` não aceita o argumento `file` usado no precedente D50.
  A conferência é equivalente e é executada antes de ler cada fonte.

## Decisões para o professor

1. Confirmar a escolha já materializada para D48: o objeto didático fica com
   `peixe`, `mae`, `idade_dias`, `comprimento_cm`; são 34 peixes, mães `m1`,
   `m2` e `m4` (14, 4 e 16 peixes). `mae` está documentada como agrupamento
   familiar, **não** como tratamento.
2. Confirmar a escolha já materializada para D44: `peixe`, `grupo`,
   `saturacao_ar_pct`, `consumo_o2_mg_kg_h`; grupos `Baltic` (13 peixes),
   `Biotest` (11) e `Balt@Bio` (16). A base mantém 449 linhas e 23 ausências.
3. Ainda não foram incorporados os recomendados sem aprovação didática:
   larvas de Catalina para D51/D53 e NOAA pollock 2023 para D47. **Professor,
   autoriza alguma dessas substituições?**

## Pendências por conjunto

- **D12:** as ausências de recaptura não são chamadas de morte ou perda; a
  observação pós varia de 25 a 180 dias e o contexto é saúde animal terrestre.
- **D44:** 15% só aparece em Biotest; as três linhas a 100% não têm consumo
  disponível. O ensaio reduziu oxigênio ao longo do tempo e os três grupos não
  formam um fatorial completo.
- **D48:** medidas repetidas por peixe; não usar as 340 linhas como réplicas
  independentes. O recorte curto não substitui a fonte integral para ajustes
  mais detalhados.
- **D52:** continuam pendentes a unidade de `time` e a associação dos códigos
  B/G aos produtos e C/E aos pré-tratamentos. Tempos como 4,99999999999998 foram
  arredondados a três casas; códigos e linhas foram preservados.

## Verificação

As quatro receitas conferem SHA-256, dimensões, nomes, tipos, níveis e ausências
antes de gravar os `.rda`. O catálogo tem todas as 18 colunas e foi conferido
contra os objetos e as páginas de ajuda.

```text
> devtools::test(filter = '^dados$')
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 494 ]

> devtools::test(filter = 'dados-substitutos-20261012')
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 20 ]

> Rscript ferramentas/preparar_cran.R --check
* checking examples ... [19s] OK
* checking tests ... [13s] OK
* DONE
Status: 4 NOTEs
```

O primeiro `--check` não alcançou o CRAN porque a rede do sandbox bloqueou as
URLs dos repositórios. Repetido fora do sandbox, ele concluiu sem erro ou aviso
novo das substituições, com quatro NOTEs: mantenedor/novo envio, ausência de
Pandoc para verificar README/NEWS, título histórico de `NEWS.md` e linhas
longas preexistentes nos exemplos de quatro arquivos `.Rd`.

Uma execução inicial e não filtrada de `devtools::test()` no diretório de
desenvolvimento parou em testes antigos porque `ler_treino()` não foi carregada
no ambiente daquele comando. Isso não ocorreu no teste do tarball: o
`R CMD check --as-cran` carregou `tests/testthat.R` e terminou `checking tests`
como `OK`. O problema de invocação do `devtools` não foi alterado nesta tarefa.

## Estado final do catálogo

`catalogo_dados`: 61 conjuntos e 18 colunas. Por licença registrada: 9 CC0,
14 CC BY, 20 GPL, 2 pendentes e 16 outros.

## Ajustes que a Trilha precisa fazer depois

- Atualizar seletores, receitas e exemplos que referenciavam
  `bacterias_tratamento`, `plantas_absorcao_co2`, `laranjeiras_crescimento` ou
  `paciente_peso` para os quatro nomes novos.
- Para D12, mostrar que o usuário precisa preparar os pares por `id_bufalo` e
  `momento` antes de McNemar; não oferecer 418 linhas como observações
  independentes.
- Para D44 e D48, manter o identificador individual na interface e explicitar
  medidas repetidas. Em D48, `mae` não deve aparecer como fator de tratamento.
- Para D52, não traduzir B/G ou C/E nem anexar unidade de tempo até a confirmação
  da fonte.

## O que ficou no EAPADados sem commit

Nada foi alterado no EAPADados nesta tarefa. A cópia já estava suja: `DESCRIPTION`,
`data-raw/preparar_dados.R`, dois arquivos de balanço, e a remoção de
`cabritos_fa_coltro`; também permanecem sem commit os objetos/documentações de
anchova, búfalos, chinook, secagem e truta, suas receitas/fontes em
`data-raw/` e os respectivos `.rda` em `data/`. Esses itens devem ser revisados
e comitados na sessão própria do EAPADados, não nesta branch da ClaRa.
