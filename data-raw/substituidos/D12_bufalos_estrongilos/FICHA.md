# D12 — Búfalos-africanos: ovos de estrongilídeos

- Registro: `D12_bufalos_estrongilos`; objeto: `bufalos_estrongilos`.
- Substitui `bacterias_tratamento` (`MASS::bacteria`) por decisão do professor em 12/10/2026, mantendo D12.
- Fonte: Ezenwa e Jolles (2015), dados Dryad/Zenodo DOI 10.5061/dryad.q2m38; artigo DOI 10.1126/science.1261714. Licença CC0 1.0, conferida em 12/10/2026.
- 418 linhas, seis colunas, 216 búfalos. Uma linha é uma observação antes ou depois; são 196 pares completos.
- O recorte guarda a primeira recaptura com resultado binário até 180 dias. As 14 ausências de pós válido e os seis resultados basais ausentes permanecem para o exercício de preparo.
- `tratamento`: controle/fenbendazol; `momento`: antes/depois. A resposta é 0/1; o grupo-controle não é removido.
- Limites: fauna terrestre e data pós-tratamento desigual (25–180 dias); a origem não identifica o motivo da ausência de recaptura. Não tratar as 418 linhas como independentes.
- Reproduzir na raiz: `source("data-raw/D12_bufalos_estrongilos/preparar.R")`.
