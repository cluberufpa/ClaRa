# D17 — Solha-europeia: CPUE e ambiente no Báltico

## Fonte e licença

O arquivo `Data_cod_flounder.zip` foi obtido do repositório Dryad, DOI
[10.5061/dryad.kb2f352](https://doi.org/10.5061/dryad.kb2f352), sob CC0 1.0.
O artigo associado é identificado pela fonte como DOI
[10.1111/jbi.13510](https://doi.org/10.1111/jbi.13510). O ZIP original está em
`fonte/` e seu SHA-256 é
`ae4609e0a7755bc4eb000ea2d24a90d1180227f555f37e467d14d42e50f68654`.

## Recorte e preparo

O arquivo fonte `Flounder.csv` contém 9.764 registros. Para um exemplo de
regressão múltipla com dimensão legível, foram selecionadas **todas** as 179
linhas em que `year == 2008` e `quarter == 4`. Esta é uma curadoria didática,
definida antes dos exercícios; não é uma amostra para tirar conclusões sobre
todo o Mar Báltico.

`source("data-raw/D17_solha_baltico_2008_t4/preparar.R")`, na raiz do pacote,
confere o hash, extrai o ZIP, recria o recorte, o objeto e a linha D17 do
catálogo. Não há imputação, arredondamento nem exclusão dentro desse recorte.

| Fonte | ClaRa | Decisão |
|---|---|---|
| linha do CSV | `linha_fonte` | Rastreia a posição no arquivo bruto; não é preditor. |
| totalCPUE | `cpue_g` | CPUE em gramas, preservada. |
| totalCPUE | `log_cpue_g` | `log1p(cpue_g)`, resposta do modelo; preserva os 37 zeros. |
| TEM | `temperatura_fundo_c` | Temperatura de fundo, °C. |
| SAL | `salinidade` | Salinidade, na unidade da fonte. |
| OXY | `oxigenio_dissolvido_mg_l` | Oxigênio dissolvido, na unidade declarada pela fonte. |
| Depth | `profundidade_m` | Profundidade, m. |
| LATDD / LONGDD | `latitude_graus` / `longitude_graus` | Coordenadas em graus decimais. |

## Uso didático

O modelo-base é:

```r
solha <- carregar_dados("solha_baltico_2008_t4")
ajuste <- lm(
  log_cpue_g ~ temperatura_fundo_c + salinidade + oxigenio_dissolvido_mg_l +
    profundidade_m + latitude_graus + longitude_graus,
  data = solha
)
summary(ajuste)$r.squared
```

Ele tem R² = 0,646 (R² ajustado = 0,633). Há colinearidade moderada entre os
preditores — por exemplo, salinidade e longitude têm `r = -0,670`; os VIFs do
modelo-base vão de 1,64 a 4,21. Isso permite discutir seleção de variáveis,
VIF, resíduos e influência sem coeficientes indefinidos.

## Limites

- A CPUE bruta é muito assimétrica e tem 37 zeros. Use `log_cpue_g`, e não
  `cpue_g`, como resposta inicial.
- O recorte mantém seis pontos com distância de Cook acima de `4/n`; eles são
  matéria para diagnóstico, não motivo para exclusão automática.
- Latitude e longitude são preditores espaciais: descrevem associação no
  recorte, não uma relação causal.
- Ano e trimestre são constantes por construção; não entram no modelo nem há
  fator categórico neste conjunto.
