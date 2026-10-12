# D17 — Camarão-branco: crescimento e qualidade da água (eco-green)

Substitui `salmouras_carbonatos` (Davis, 2002, livro comercial, licença não localizada), por decisão do professor em 12/10/2026. O D17 foi reaproveitado; o objeto antigo saiu do pacote e a fonte ficou em `../substituidos/D17_salmouras_carbonatos/`. Objeto `camarao_ecogreen`. **Não herda o papel de PCA do brine**: o professor decidiu que ele entra como conjunto de correlação e regressão.

Fonte: Lusiana, E. D. (2025). [Average shrimp growth and water quality parameters in eco-green aquaculture](https://doi.org/10.6084/m9.figshare.28785923.v1). Figshare, DOI 10.6084/m9.figshare.28785923.v1, **CC BY 4.0** (campo `license` da API do Figshare). O Figshare não traz artigo associado nem referências. O arquivo `Dataset for shrimp growth and water quality parameters in eco-green aquaculture.xlsx` (13.724 bytes, MD5 `bfff0556f8ef26ab20234a89cf69d252`, igual ao do Figshare) está em `fonte/`, com os metadados da API em `figshare_metadata.json`.

## O que é

Crescimento diário e qualidade da água de camarão-branco (*Litopenaeus vannamei*) num sistema eco-green na Indonésia, de 2021 a 2023 (13, 18 e 39 linhas). Cada linha traz o ganho diário (ADG) e 11 variáveis de água. O título da fonte diz "Average" (médias), e os dados mostram isso: as 70 linhas têm **só 7 combinações distintas das 11 variáveis de água**, repetidas entre os anos, enquanto o ganho diário varia dentro de cada combinação. A fonte não diz o que é cada linha (viveiro, ciclo, mês).

## Preparo e de-para

`source("data-raw/D17_camarao_ecogreen/preparar.R")`, na raiz, confere o hash e recria dados e registro.

| Fonte | ClaRa | Decisão |
|---|---|---|
| Sampling Year | ano | Fator (2021, 2022, 2023) |
| ADG (mg/day) | ganho_diario | Ganho diário médio; **sem unidade no nome** (ver limites) |
| Temp (0C) | temperatura_c | °C |
| Transparency (cm) | transparencia_cm | cm |
| TSS (mg/L) | solidos_suspensos_mgl | mg/L |
| Salinity (ppt) | salinidade_ppt | ppt |
| DO (mg/L) | oxigenio_mgl | mg/L |
| CO2 (mg/L) | co2_mgl | mg/L |
| Nitrate, Phosphate, Ammonia (mg/L) | nitrato_mgl, fosfato_mgl, amonia_mgl | mg/L |
| TOM (mg/L) | materia_organica_mgl | matéria orgânica total, mg/L |
| Total Vibrio (mg/L) | vibrio_total | **sem unidade no nome** (ver limites) |

Nenhuma reescala, arredondamento, imputação ou exclusão. As 70 linhas e a ordem da fonte foram mantidas; não há NA.

## Utilidade didática

- **Correlação e regressão do ganho diário contra a água.** As relações são **fracas**: a maior correlação com o ganho é −0,29 (oxigênio), seguida de −0,27 (matéria orgânica) e 0,23 (salinidade). Uma regressão com oxigênio, nitrato e Vibrio dá R² ≈ 0,13; é um exemplo honesto de modelo que quase não explica, não de achado.
- **Regressão múltipla e colinearidade.** Como há só 7 perfis de água, as 11 variáveis juntas são perfeitamente colineares (o `lm()` devolve coeficientes `NA`; o VIF é infinito). O aluno vê por que um modelo com muitos preditores não cabe em 7 pontos distintos, e escolhe poucas variáveis. Há pares muito correlacionados, como transparência e matéria orgânica (|r| = 0,91).
- **Pseudorreplicação.** O n é 70, mas a informação sobre a água vem de 7 perfis. Ensina a desconfiar do n e do p-valor.
- **Comparação entre anos** (Kruskal-Wallis do ganho por ano), com a mesma ressalva.

## Limites que o aluno precisa saber

- **Não serve para PCA ou HCA de estações:** seriam 7 pontos repetidos. Para ordenação de unidades com muitas variáveis, usar `lago_vitoria` (D04).
- **Valores médios.** Sem as réplicas originais, não há variação entre unidades; qualquer p-valor é frágil.
- **Unidades a conferir.** O ganho diário vem como mg/dia, com valores de 0,01 a 1,5, o que é incomum para camarão (pode ser g/dia); por isso a coluna não leva unidade. O Vibrio vem como mg/L (1.000 a 3.900), o que é estranho para uma contagem (talvez UFC/mL); idem.
- **Uma matéria orgânica de 108,7 mg/L** (média 28) destoa dos demais valores. Mantida.
- **Grupos de ano desbalanceados** (13, 18 e 39 linhas).
- **Sem artigo associado** no Figshare; não citar um artigo como origem dos dados. Sem verbo da ClaRa para regressão múltipla: a incorporação não acrescenta esse motor. Revisão didática pelo autor da ClaRa pendente.
