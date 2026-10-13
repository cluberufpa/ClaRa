# D60 — Guppies: coesão em quadrado latino 4 × 4

- Registro: `D60_guppies_quadrado_latino`; objeto: `guppies_quadrado_latino`.
- Fonte: Allibhai, Zanghi, How e Ioannou (2023), *Ecology and Evolution* 13:e9958, DOI [10.1002/ece3.9958](https://doi.org/10.1002/ece3.9958). Dados brutos: [Dryad 10.5061/dryad.j3tx95xjv](https://doi.org/10.5061/dryad.j3tx95xjv), licença CC0 1.0.
- Arquivos-fonte preservados nesta pasta: `Data_for_models.csv` (94 ensaios válidos; SHA-256 `C87B54D20B9BC06FACB7E3D257989B5D8EF4F27C9D8CC543FCA85EDEFA7119EC`) e `README_original.md`.
- Delineamento: quatro grupos de guppies (`Tub`) observados em quatro etapas (`day_of_testing`). Cada grupo recebeu uma vez cada combinação de temperatura e turbidez, e cada tratamento ocorreu uma vez em cada etapa. São 16 células completas do quadrado latino.
- Tratamentos: `controle` = água clara e temperatura usual; `temperatura` = temperatura elevada; `turbidez` = água turva; `temperatura_turbidez` = ambos. No estudo, as condições-alvo foram, respectivamente, 0 NTU/22 °C, 0 NTU/29 °C, 5 NTU/22 °C e 5 NTU/29 °C.
- Resposta: média, em pixels, da distância ao vizinho mais próximo (`mean_NND_min_dist`) dentro de cada combinação grupo × etapa. Quanto menor, maior a proximidade local entre peixes. `n_ensaios` registra 5 ou 6 ensaios reais em cada célula; dois dos 96 previstos foram excluídos pelos autores por falha da câmera.
- Preparação: `source("data-raw/D60_guppies_quadrado_latino/preparar.R")` na raiz da ClaRa. A receita lê o CSV, calcula as 16 médias e confere as três condições de balanceamento do quadrado. Nenhuma célula ou resposta foi inventada.
- ANOVA didática: `aov(dist_vizinho_px ~ tratamento + grupo + etapa, data = guppies_quadrado_latino)`. Nesta tabela de médias, tratamento tem F = 17,56 e p = 0,00225 (3 e 6 g.l.). **Não** são os resultados do artigo: os autores analisaram os 94 ensaios com modelos mistos, considerando a estrutura repetida e a natureza fatorial dos dois estressores. O exemplo agregado mostra o arranjo do quadrado latino, não substitui a análise inferencial original.
- Limitação adicional: as médias de células com cinco e seis ensaios recebem o mesmo peso na ANOVA didática; os pressupostos devem ser diagnosticados e a interpretação causal não deve apoiar-se apenas nessa agregação.
- Substitui o exemplo de suínos D60, preservado em `data-raw/substituidos/D60_suinos_castracao/`.
