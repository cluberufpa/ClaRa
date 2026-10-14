# D54 — Tiger flathead: idade, comprimento e sexo

- Registro: `D54_platycephalus_crescimento`; objeto: `platycephalus_crescimento`.
- Ocupa o D54 (antes `haemulon_crescimento`, pontos reconstruídos de uma figura; fonte e receita em `data-raw/retirados/D54_haemulon_crescimento/`), por decisão do professor em 13/10/2026, depois de uma busca de dados de idade e comprimento com otólitos, sem restrição de licença.
- Fonte: Morrongiello e Thresher (2014), Dryad, DOI 10.5061/dryad.q9h64, **CC0 1.0**. Detalhes e o que se encontrou ao conferir em `fonte/PROVENIENCIA.md`.
- Dimensões: 4318 × 9; unidade: um peixe (*Platycephalus richardsoni*) capturado na pesca comercial do sudeste da Austrália, de 1981 a 2010.
- Natureza: real. Idade pelos anéis do otólito, em anos inteiros; comprimento em cm, arredondado para baixo.
- Situação: revisado.

## Do arquivo da fonte ao conjunto

O arquivo tem 22.941 linhas, uma por anel do otólito. Ficou uma linha por peixe (4.318), com as colunas que são do peixe. A largura dos anéis, o raio do otólito e o ano de nascimento ficaram de fora (outro exercício: crescimento individual).

| Coluna | Na fonte |
|---|---|
| `id_peixe` | `FishID` |
| `area` | `area` (EBS, ETAS) |
| `aparelho` | `gear` (OT = arrasto de fundo, DS = rede de cerco dinamarquesa, Unknown = desconhecido) |
| `ano_captura`, `mes_captura` | `capyear`, `capmonth` |
| `sexo` | `sex` (F = femea, M = macho) |
| `idade_anos` | `AdjAge` |
| `idade_decimal` | `DeciAge` |
| `comprimento_cm` | `floorlength` |

## Defeito do sexo

Em 444 peixes (10%) o sexo da fonte muda de um anel para outro. O sexo desses peixes é `NA` aqui (sem escolher por maioria), e as outras colunas ficaram como estão. Sobram 3.874 peixes com sexo (2.045 fêmeas e 1.829 machos). É um bom exemplo de dado faltante vindo de um defeito de registro.

## Resultados de conferência (von Bertalanffy, 3.867 peixes com idade e comprimento)

| | L∞ (cm) | K (por ano) | t0 (anos) |
|---|---|---|---|
| Todos | 70,0 | 0,070 | −5,79 |
| Fêmeas | 78,7 | 0,064 | −5,49 |
| Machos | 61,3 | 0,070 | −6,98 |

As curvas de fêmeas e machos diferem muito (F = 416 para três parâmetros, p < 0,001). Figura em `docs/D54_platycephalus_curva.png`.

## Uso didático

Curva de crescimento de von Bertalanffy com `nls()`, por sexo; comparação entre áreas e aparelhos; distribuição do comprimento por idade; dados faltantes. A ClaRa ainda não tem verbo para curvas não lineares: o aluno usa `nls()`. Verbo existente: `comparar_medias()` em uma idade fixa, fêmeas contra machos.

## Limites

Comprimento arredondado para baixo e idade inteira formam colunas de pontos no gráfico. Idades acima de 18 anos têm de 1 a 2 peixes por idade. Os peixes vêm de pescarias diferentes e de áreas diferentes; a comparação de áreas está confundida com o aparelho e o ano. As siglas EBS e ETAS não foram conferidas no artigo.

Reproduzir na raiz: `source("data-raw/D54_platycephalus_crescimento/preparar.R")`.
