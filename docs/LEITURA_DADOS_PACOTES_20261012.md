# Dados de pacotes lidos na hora — ClaRa 0.15.0

Pedido executado na branch `dados`, conforme `TRILHA/docs/PEDIDO_RETIRAR_FSADATA_DA_CLARA.md`. Nome `carregar_dados()` confirmado pelo professor. **Merge na main aguardando o sim previsto no passo 9; sem push nesta rodada.**

## Resultado

O catálogo permanece com 60 registros: **51 conjuntos fornecidos pela ClaRa, oito pelo FSAdata e um pelo MASS**. Códigos D, registros, nomes, linhas, colunas, tipos, categorias e ordem das observações foram preservados. Os outros 51 registros mantêm todos os campos anteriores; apenas recebem `fonte_dados = "clara"`.

`carregar_dados("nome")` lê os dados próprios da ClaRa ou confere o pacote opcional, lê seu objeto e aplica a tradução registrada em `R/dados_pacotes.R`. Não instala pacotes automaticamente e só oferece nomes presentes no catálogo. A função aparece na ajuda da ClaRa, preservando a ordem anterior das análises.

As nove cópias de `data/` e as cópias `.rda`, `.rds` e `.rdata` das nove pastas de fontes foram retiradas. As fichas, referências, ajuda, de-para e documentação textual de origem permanecem. Os `preparar.R` desses conjuntos carregam e conferem a receita atual; não recriam cópias no pacote. Os hashes das fontes remanescentes foram conferidos. O histórico Git anterior permanece.

## Igualdade conferida antes da retirada

Fonte instalada para a verificação: **FSAdata 0.4.1**, Derek Ogle, GPL (>= 2); **MASS 7.3-65**, Brian Ripley e Bill Venables, GPL-2 | GPL-3. As licenças dos fornecedores estão na documentação e no catálogo; o código próprio da ClaRa continua MIT.

| Código | Nome na ClaRa | Fonte lida | Estrutura | Comparação com a cópia anterior |
|---|---|---|---|---|
| D23 | crabs_morfometria | MASS::crabs | 200 × 10 | identical TRUE |
| D24 | darter_ontario | FSAdata::DarterOnt | 54 × 3 | identical TRUE |
| D27 | idades_savel_repetibilidade | FSAdata::ShadCR | 53 × 8 | identical TRUE |
| D34 | snapper_hg | FSAdata::SnapperHG1 | 1331 × 6 | identical TRUE |
| D54 | haemulon_crescimento | FSAdata::WhiteGrunt2 | 465 × 3 | identical TRUE |
| D55 | cabezon_maturidade | FSAdata::Cabezon | 525 × 5 | identical TRUE |
| D56 | ruffe_biometria | FSAdata::RuffeSLRH92 | 738 × 11 | identical TRUE |
| D57 | bighill_amostras | FSAdata::BGHRsample | 20 × 4 | identical TRUE |
| D58 | bighill_peixes | FSAdata::BGHRfish | 266 × 6 | identical TRUE |

Os quatro vindos do EAPADados foram reconstruídos e conferidos. Em `snapper_hg`, as classes de comprimento dependem dos quartis dos 18.420 registros originais, calculados **antes** do filtro de idade que retém 1.331. Recalcular quartis após o filtro mudaria os dados. Foram também preservados os tipos numéricos dos comprimentos e das idades. No crabs, preservados os quartis e a categoria `fêmea`, com acento.

## Uso e mudança de interface

```r
library(clara)
bagres <- carregar_dados("bagre_racao_isoproteica")
snapper <- carregar_dados("snapper_hg")
caranguejos <- carregar_dados("crabs_morfometria")
catalogo_dados[, c("codigo", "nome", "fonte_dados")]
```

Para os nove externos, `data(nome, package = "clara")` e `clara::nome` deixam de ser a interface. Usar `carregar_dados("nome")`; as páginas `?snapper_hg` e equivalentes continuam. Se FSAdata faltar, a mensagem em português orienta `install.packages("FSAdata")`. Os outros 51 conjuntos continuam acessíveis também pelas interfaces anteriores.

## Validação

- R 4.6.1, Windows 11; build e check completos da versão 0.15.0: **0 erros, 0 notas, somente o aviso conhecido de acentos no código**.
- **686 testes passaram**, sem falhas, avisos de teste ou skips, com FSAdata e MASS disponíveis. Os nove testes externos usam `skip_if_not_installed()` individualmente quando o fornecedor não está instalado.
- No pacote instalado, conferidos `identical()` para os nove retornos, as nove páginas de ajuda e a presença da nova função na ajuda geral. Conferida a preservação dos 51 registros internos.
- Segunda instalação temporária sem FSAdata: dados próprios e MASS acessíveis; mensagem de instalação do FSAdata conferida.
- A pasta `data/` contém 52 arquivos RDA, incluindo o catálogo, totalizando **218.420 bytes**.
- Configuração global do R preservada. O `Renviron.site` local fixa bibliotecas; o check utilizou configuração e biblioteca temporárias para localizar FSAdata. Preservados também `PROCESSOR_ARCHITECTURE=AMD64` e a localidade válida usados no diagnóstico anterior.
- Logs, tar.gz, bibliotecas e cópias temporárias de comparação ficaram fora de `data-raw/` e do repositório. `TRILHA/` e funções de análise não foram alteradas.

## Próxima decisão

Autorizar o merge da branch `dados` na `main`, conforme o passo 9 do pedido. A mudança do seletor e do projeto exportado da Trilha pertence à sessão da Trilha. Nenhuma outra retirada prevista na emenda foi executada nesta rodada.
