# D44 — Percas: consumo de oxigênio durante hipóxia

- Registro: `D44_percas_respirometria`; objeto: `percas_respirometria`.
- Substitui `plantas_absorcao_co2` (`datasets::CO2`) por decisão do professor em 12/10/2026, mantendo D44.
- Fonte: Ekström e colaboradores (2021), Dryad DOI 10.5061/dryad.tmpg4f4z3; cópia da mesma planilha no Zenodo 4591899. Licença CC0 1.0, conferida em 12/10/2026.
- 449 linhas, quatro colunas, 40 peixes. A fonte é a aba `Hyp. Prot. - RMR`, já longa; preserva as 23 ausências do consumo.
- Colunas: `peixe`, `grupo`, `saturacao_ar_pct`, `consumo_o2_mg_kg_h`. Grupos: Baltic (13 peixes), Biotest (11) e Balt@Bio (16).
- Há 13 níveis de saturação (15–100%); 15% só ocorre em Biotest e as três linhas de 100% não têm resposta disponível. Não imputar nem tornar o experimento artificialmente equilibrado.
- `grupo` descreve origem/história térmica; não é fatorial completo origem × temperatura. O ensaio reduziu oxigênio ao longo do tempo, portanto nível de oxigênio e progresso do ensaio variam juntos.
- Reproduzir na raiz: `source("data-raw/D44_percas_respirometria/preparar.R")`.
