# D04 — Lago Vitória: água sob gaiolas de tilápia

Substitui `doubs_ambiente` (`ade4::doubs`, GPL), por decisão do professor em 12/10/2026. Objeto `lago_vitoria`, código D04 preservado. Fontes antigas em `../substituidos/D04_doubs_ambiente/`; sem alias com o nome do rio Doubs.

Fonte: Okechi, Peoples, Nyamweya, Orina, Cooperman e Kaufman (2025), [Dryad](https://doi.org/10.5061/dryad.qfttdz0t5), CC0 1.0 (campo de licença da API do Dryad: CC0-1.0). Artigo: *Journal of Great Lakes Research*, DOI 10.1016/j.jglr.2025.102576. O arquivo `2023_2024_water_quality_data.xlsx` (41.006 bytes, MD5 `20e3b6c36d7438a915b47dc344ad7b18`) está em `fonte/`, com os metadados do Dryad em `dryad_metadata.json`. O MD5 foi calculado no arquivo recebido do professor; o Dryad não publica hash na página, e o tamanho coincide com o da página (41 KB).

## O que é

Água de águas quenianas do Lago Vitória em março de 2023 e março de 2024, coletada em estações **de gaiolas de tilápia-do-nilo (*Oreochromis niloticus*)** e em estações **de controle**, em quatro locais ao longo de um gradiente limnológico: Dunga e Ndere (golfo de Winam), Naya (boca do golfo) e Mfangano (águas abertas). A coleta foi em triplicata, a cada 1 m de profundidade. Cada linha é uma leitura de 19 variáveis físicas e químicas em uma profundidade.

## Preparo e de-para

`source("data-raw/D04_lago_vitoria/preparar.R")`, na raiz, confere o hash e recria dados e registro. readxl, digest e jsonlite só são usados no preparo.

| Fonte | ClaRa | Decisão |
|---|---|---|
| Site | local | Fator: Dunga, Ndere, Naya, Mfangano (ordem do gradiente, do README) |
| Station | estacao | Fator: Cages → Gaiolas, Control → Controle |
| Stations_sample | id_amostra | Texto, como veio; **não** é único por linha |
| Year | ano | Fator (2023, 2024), para não entrar como número na PCA |
| depth_m | profundidade_m | Profundidade da leitura, em m |
| total_depth | profundidade_local_m | Profundidade total do ponto, em m; 81 NA |
| Secchi | secchi_m | Transparência, em m |
| Temp_c | temperatura_c | °C |
| TN, TP, NO3, NO2, SRP, SIO2, NH4 | nitrogenio_total_ugl, fosforo_total_ugl, nitrato_ugl, nitrito_ugl, fosforo_reativo_ugl, silica_ugl, amonio_ugl | µg/L, como declarado no README |
| Chl_a | clorofila_a | **sem unidade no nome** (ver limites) |
| ALK, HARD | alcalinidade_mgl, dureza_mgl | mg/L |
| DO | oxigenio_dissolvido_mgl | mg/L |
| Cond, TDS, Salinity | condutividade_uscm, solidos_dissolvidos_mgl, salinidade_ppt | µS/cm, mg/L, ppt |
| pH, ORP, Turbidity | ph, orp_mv, turbidez_ftu | sem unidade; mV; FTU |

Nenhuma reescala, arredondamento, imputação ou exclusão. As 217 linhas e a ordem da fonte foram mantidas. Linhas por local, estação e ano:

| | 2023 gaiolas | 2023 controle | 2024 gaiolas | 2024 controle |
|---|---|---|---|---|
| Dunga | 5 | 8 | 10 | 4 |
| Ndere | 18 | 15 | 12 | 9 |
| Naya | 18 | 12 | 12 | 10 |
| Mfangano | 30 | 30 | 12 | 12 |

## Utilidade didática

Substitui o `doubs` no papel de **gradiente ambiental com muitas variáveis**: o aluno ordena leituras de água por PCA, agrupa por HCA e vê se o gradiente espacial (local) e o efeito das gaiolas (estação) aparecem. Com as 19 variáveis de água padronizadas, os dois primeiros eixos da PCA somam cerca de 52% da variância. Estação, local e ano servem como variáveis qualitativas suplementares; a clorofila a, a transparência ou o fósforo total, como quantitativa suplementar (no lugar da riqueza de peixes do `doubs`). O artigo relata menos oxigênio, pH mais baixo, menos sílica e mais turbidez junto às gaiolas.

Também permite comparar gaiolas e controle (teste t ou Mann-Whitney por local e ano) e mostrar que variáveis de água andam juntas: condutividade, sólidos dissolvidos e salinidade correlacionam acima de 0,9.

## Limites que o aluno precisa saber

- **Leituras não são réplicas independentes.** As 217 linhas são leituras em profundidades de poucos perfis de água, e as leituras de uma mesma coluna de água se parecem. Em 2023, `id_amostra` identifica um perfil (26 perfis, 136 leituras); em 2024, identifica a própria leitura (81 leituras). O desenho é desbalanceado: Dunga tem 5 e 8 leituras em 2023, Mfangano tem 30 e 30. Testes de gaiolas contra controle com as 217 linhas inflam o n; usar a média por perfil ou um modelo misto.
- **`id_amostra` não é identificador de linha.** Repete-se entre profundidades em 2023; a linha é identificada por `id_amostra`, `ano` e `profundidade_m` (sem repetição, conferido no preparo).
- **`profundidade_local_m` tem 81 NA, todos de 2024:** o campo não foi coletado naquele ano. Não imputar.
- **Unidades do README a conferir.** A clorofila a vem como mg/L, o que é incomum (valores de 0 a 90 sugerem µg/L); por isso a coluna não leva unidade no nome. O nitrogênio total (média de 38 µg/L) parece baixo para um lago eutrofizado: conferir no artigo se nitrogênio e fósforo estão nas unidades do README antes de comparar com limites legais.
- **Valores estranhos preservados:** 24 turbidezes negativas (mínimo −3,4 FTU, provável deriva de calibração do sensor), uma clorofila igual a zero e ORP de 20 a 990 mV.
- **Variáveis redundantes.** Condutividade, sólidos dissolvidos e salinidade medem quase o mesmo e puxam juntas o primeiro eixo. Ensinar isso, em vez de remover.
- **Padronizar antes da PCA.** As escalas são muito diferentes (ORP em centenas de mV, salinidade em centésimos); sem padronizar, o ORP domina.
- Sem verbo da ClaRa para PCA ou HCA: a incorporação não acrescenta motores multivariados. Revisão didática pelo autor da ClaRa pendente.
