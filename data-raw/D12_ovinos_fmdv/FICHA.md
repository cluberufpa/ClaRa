# D12 — Ovinos e caprinos: febre aftosa em soro e swab oral

- Registro: `D12_ovinos_fmdv`; objeto: `ovinos_caprinos_fmdv`.
- Substitui `cabras_toxoplasma` (antes, `erva_marinha_lesoes` e `bufalos_estrongilos`), mantendo D12 e o exercício de McNemar. As cabras eram uma reconstrução a partir de tabelas; este conjunto traz dados individuais brutos e reais.
- Fonte: Gubbins et al. (2025), *Veterinary Research* 56:76, DOI 10.1186/s13567-025-01502-2. Artigo CC BY 4.0; dados (Additional file 13) sob CC0 1.0, conferido no texto completo (Europe PMC) em 12/10/2026. A planilha de partida foi montada e entregue pelo professor (`fonte/mcnemar_ovinos_caprinos_fmdv.xlsx`, SHA-256 conferido pela receita).
- 418 linhas, 11 colunas: `id_animal`, `id_local`, `data_coleta`, `visita`, `especie`, `idade_meses`, `sexo`, `origem_animal`, `pcr_soro`, `pcr_swab_oral`, `elisa_nsp`. Uma linha por par soro + swab oral de um animal em uma visita; 323 animais, 152 linhas de animais repetidos.
- Tabela principal (negativo primeiro, linhas = soro, colunas = swab): 400, 9, 8 e 1. Discordantes 8 (soro −/swab +) e 9 (soro +/swab −); McNemar p = 1, kappa ≈ 0,09. O artigo relata p > 0,9 e kappa = 0,08.
- O que o conjunto ensina além da tabela:
  - **independência:** com todas as linhas o par do mesmo animal se repete; a primeira coleta por animal (323 pares) dá 308, 8, 6 e 1 (p = 0,79);
  - **contraste:** ELISA NSP × PCR dá discordância de um lado só (178 contra 6), com p ≈ 10⁻³⁶;
  - **positivos raros:** só 10 soros e 9 swabs positivos e 1 par positivo nos dois exames; o kappa fica perto de zero com 96% de concordância.
- Uso na Trilha: importar o CSV/objeto e escolher duas colunas binárias (`pcr_soro` e `pcr_swab_oral`), ou digitar as quatro células na entrada direta da tabela 2 × 2. Filtrar `visita` ou escolher uma coleta por animal antes do McNemar.
- Removido na versão didática: `lesoes_fmd` (todas "No"), as colunas 0/1 que repetiam os exames, os rótulos originais em inglês duplicados e a indicação de amostragem repetida (se calcula pelo `id_animal`).
- Limites: rebanhos/locais (23) agrupam os animais; nenhum exame é padrão-ouro; sem coleta em agosto; ELISA tem 2 NA.
- Ponte para a aquicultura: comparar dois tipos de amostra ou métodos no mesmo indivíduo (hemolinfa × brânquia no camarão, soro × swab em peixes) e discutir independência quando o mesmo indivíduo é amostrado várias vezes.
- Reproduzir na raiz: `source("data-raw/D12_ovinos_fmdv/preparar.R")`.
