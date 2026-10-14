# D54 — Tiger flathead: idade, comprimento e sexo

- Registro: `D54_platycephalus_crescimento`; objeto: `platycephalus_crescimento`.
- Ocupa o D54 (antes `haemulon_crescimento`, pontos reconstruídos de uma figura; fonte e receita em `data-raw/retirados/D54_haemulon_crescimento/`), por decisão do professor em 13/10/2026, depois de uma busca de dados de idade e comprimento com otólitos, sem restrição de licença.
- Fonte: Morrongiello e Thresher (2014), Dryad, DOI 10.5061/dryad.q9h64, **CC0 1.0**. Detalhes e o que se encontrou ao conferir em `fonte/PROVENIENCIA.md`.
- Dimensões: **402 × 6**; unidade: um peixe (*Platycephalus richardsoni*) capturado em 2000 na pesca de arrasto de fundo, área EBS, sudeste da Austrália.
- Natureza: real, **recorte** do depósito (4.318 peixes). Idade pelos anéis do otólito, em anos inteiros; comprimento em cm, arredondado para baixo.
- Situação: revisado.

## O recorte (pedido do professor, 13/10/2026)

O professor observou que uma análise de crescimento não precisa de um número excessivo de dados. O depósito tem 4.318 peixes; ficaram 402: área EBS, arrasto de fundo, capturados em 2000 (252 fêmeas e 150 machos, idades de 2 a 16 anos).

- Foi escolhido um recorte natural, de uma pescaria e de um ano, e não uma amostra aleatória. Amostras aleatórias de 200 a 400 peixes do conjunto inteiro deram curvas instáveis (o L∞ dos machos variou de 56 a 89 cm), porque os peixes velhos são raros.
- Entre os recortes de uma pescaria e um ano, este tem o maior número de peixes com as duas curvas bem definidas (EBS cerco 2005 tem 546 peixes, mas só 2 acima de 10 anos, e a curva dos machos não converge; EBS arrasto 2009 tem 446, mas a curva dos machos fica mal determinada, com L∞ de 82 cm e erro-padrão de 43 cm).
- O conjunto inteiro misturava anos e aparelhos com crescimentos diferentes (L∞ de 70 cm contra 45 cm neste recorte): a curva única não representava nenhuma pescaria. O próprio recorte mostra por que o crescimento é estudado por coorte e ano.
- Os 4.318 peixes seguem no CSV de `fonte/`; para refazer com outro recorte, basta mudar o filtro no `preparar.R`.

O defeito do sexo (444 peixes do depósito têm sexo contraditório, quase todos de 2009 e 2010) não alcança este recorte, que não tem sexo faltante. Fica documentado em `fonte/PROVENIENCIA.md`.

## Colunas

| Coluna | Na fonte |
|---|---|
| `id_peixe` | `FishID` |
| `mes_captura` | `capmonth` |
| `sexo` | `sex` (F = femea, M = macho) |
| `idade_anos` | `AdjAge` |
| `idade_decimal` | `DeciAge` |
| `comprimento_cm` | `floorlength` |

Saíram as colunas constantes no recorte (área EBS, aparelho de arrasto de fundo, ano 2000) e as do anel do otólito (largura, raio, ano de nascimento).

## Resultados de conferência (von Bertalanffy, 402 peixes)

| | L∞ (cm) | K (por ano) | t0 (anos) |
|---|---|---|---|
| Fêmeas (252) | 47,0 (EP 1,0) | 0,32 (EP 0,04) | −0,82 |
| Machos (150) | 44,1 (EP 1,1) | 0,24 (EP 0,03) | −1,63 |
| Todos | 44,9 | 0,34 | −0,74 |

As curvas de fêmeas e machos diferem (F = 46 para três parâmetros, p < 0,001). Figura em `docs/D54_platycephalus_curva.png`.

## Uso didático

Curva de crescimento de von Bertalanffy com `nls()`, por sexo; comparação das curvas; distribuição do comprimento por idade. A ClaRa ainda não tem verbo para curvas não lineares: o aluno usa `nls()`. Verbo existente: `comparar_medias()` em uma idade fixa, fêmeas contra machos.

## Limites

Recorte de uma pescaria e de um ano: vale para ela. Comprimento arredondado para baixo e idade inteira formam colunas de pontos no gráfico. Só 21 peixes passam de 10 anos, e L∞ tem erro-padrão de cerca de 1 cm. Os peixes foram coletados em seis meses de 2000, em lances diferentes: o depósito não identifica o lance.

Reproduzir na raiz: `source("data-raw/D54_platycephalus_crescimento/preparar.R")`.
