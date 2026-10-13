# D60 — Esgana-gata: ruído visual em quadrado latino 4 × 4

- Registro: `D60_esgana_ruido`; objeto: `esgana_gata_ruido`.
- Substitui `suinos_castracao` (D60) e retira o exercício `gatos_cardiacos` (D63), por decisão do professor em 13/10/2026: o quadrado latino passa a ter peixes. As curadorias anteriores estão em `data-raw/substituidos/` (D60_vacas_fistuladas, D60_suinos_castracao, D63_gatos_cardiacos); o rascunho dos guppies, nunca incorporado, em `data-raw/propostas_nao_integradas/`.
- Fonte: Matchette e Herbert-Read (2021), *Animal Behaviour* 177:39–48, DOI 10.1016/j.anbehav.2021.04.017. Dados: Dryad, DOI 10.5061/dryad.sj3tx962p, CC0 1.0. Detalhes em `fonte/PROVENIENCIA.md`.
- Dimensões: 576 × 11; unidade: um peixe focal sob um nível de ruído visual. São 144 peixes, cada um com quatro medidas.
- Delineamento: sequência (A–D) nas linhas, período (1–4) nas colunas e ruído visual (estático, lento, médio, rápido) como tratamento formam um quadrado latino 4 × 4, repetido em 36 peixes por sequência. O período foi reconstruído pela Tabela A1 do artigo.
- Resposta principal: `distancia_cardume_mm`, a distância mediana ao cardume mais próximo; menor = mais atração social. Auxiliares: `velocidade_mm_s` e `preferencia_cardume_maior`. Covariável: `tamanho_peixe_mm`.
- Análise didática 1 (quadrado latino clássico): médias das 16 células sequência × período, `aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo)`: ruído F = 16,2 e p = 0,0028; sequência p = 0,0017; período p = 0,23 (3 e 6 g.l.).
- Análise didática 2 (quadrados repetidos, peixe como bloco): `aov(distancia_cardume_mm ~ ruido_visual + sequencia + periodo + Error(id_peixe))`: ruído F = 10,1 e p = 2e-6 (3 e 426 g.l.), período p = 0,32. Concorda com o artigo (ruído p < 0,001 em modelo misto), mas não é a análise publicada.
- Limites: as quatro medidas do mesmo peixe não são independentes; `ensaio` reúne dois peixes filmados juntos e não identifica o indivíduo; o desenho não é balanceado para efeito residual (carryover). Os autores usaram modelos mistos, com transformação inversa da distância.
- Colunas omitidas do TXT: contagens de quadros, proporções intermediárias, resposta binária, imobilidade, cruzamentos, contraste de Michelson, distância em pixels e calibração. Continuam em `fonte/final_statistics.txt`.
- Reproduzir na raiz: `source("data-raw/D60_esgana_ruido/preparar.R")`.
