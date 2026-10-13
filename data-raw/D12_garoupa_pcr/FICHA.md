# D12 — Garoupa: PCR e histologia nos mesmos peixes

- Registro: `D12_garoupa_pcr`; objeto: `garoupa_pcr_histologia`.
- Substitui `ovinos_caprinos_fmdv` (antes, `cabras_toxoplasma`, `erva_marinha_lesoes` e `bufalos_estrongilos`), por decisão do professor em 13/10/2026: o exemplo de McNemar passa a ser de pesca e aquicultura. Os ovinos eram dados individuais reais, mas de pecuária.
- Fonte: Bowater (2015), relatório FRDC 2010/034, Tabelas 32 e 34 (p. 123 do relatório). Licença CC BY 3.0 Austrália, declarada na p. 2 do PDF; tabela e licença conferidas no texto do relatório em 13/10/2026. A planilha de partida (réplica 1) foi montada e entregue pelo professor.
- 123 linhas, 4 colunas: `id_peixe`, `replica`, `histologia`, `pcr`. Juvenis de garoupa-de-Queensland (*Epinephelus lanceolatus*) em desafio por coabitação com *Streptococcus agalactiae*; cada peixe tem os dois exames. Órgãos agrupados: positivo se cérebro, coração ou baço dessem positivo.
- **As linhas são reconstruídas.** O relatório publica as tabelas 2 × 2; a receita expande as contagens em linhas, com identificadores artificiais e ordem sorteada (`set.seed()`). Só as contagens são reais. A réplica 1 usa as 74 linhas da planilha do professor, na ordem dela; a réplica 2 é expandida pela mesma receita, com semente 1202.
- Tabelas (histologia nas linhas, PCR nas colunas, negativo primeiro):
  - réplica 1, n = 74: 4, 2, 50 e 18; discordantes 2 (só histologia) e 50 (só PCR); PCR 91,9% × histologia 27,0%; χ² de McNemar = 42,48, p = 7,1e-11;
  - réplica 2, n = 49: 3, 3, 28 e 15; discordantes 3 e 28; PCR 87,8% × histologia 36,7%; p ≈ 1,6e-5.
- O que o conjunto ensina: um McNemar com discordância quase toda de um lado (o oposto de um caso equilibrado); a leitura certa é "o PCR detecta mais positivos que a histologia", e não sensibilidade absoluta, porque não há padrão-ouro; e como comparar métodos de diagnóstico no mesmo indivíduo.
- Limites: os peixes compartilhavam tanques, e o McNemar simples não modela a correlação intratanque; as duas réplicas não devem ser somadas sem pensar (sistemas diferentes); não se recuperam tanque, razão de coabitação, tratamento, órgão nem a identidade do peixe.
- Melhoria possível: os Apêndices 8 e 9 do relatório trazem o resultado por peixe e por órgão, com grupo de tratamento, sinais clínicos e destino. Digitalizá-los tornaria o conjunto real e daria tanque e tratamento (tabelas com células mescladas no PDF).
- Uso na Trilha: importar o CSV e escolher `histologia` e `pcr` (filtrando uma réplica por vez), ou digitar as quatro células na aba da tabela 2 × 2.
- Reproduzir na raiz: `source("data-raw/D12_garoupa_pcr/preparar.R")`.
