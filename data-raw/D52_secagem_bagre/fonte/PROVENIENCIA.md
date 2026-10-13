# Fonte primária

Ohijeagbon, I. O.; Lasode, O. A.; Adebayo, S.; Ajayi, O. O.; Omotosho, O. A. (2018).
*Data on drying kinetics of a semi-automated gas-fired fish dryer*. **Data in Brief**
18:641–647, DOI [10.1016/j.dib.2018.03.072](https://doi.org/10.1016/j.dib.2018.03.072).
Texto completo: [PMC5996308](https://pmc.ncbi.nlm.nih.gov/articles/PMC5996308/).
Licença do artigo: CC BY 4.0, conferida no XML da Europe PMC em 13/10/2026. Os dados
estão no próprio artigo ("Data are available within this article").

`secagem_bagre_80c_fonte.csv` é a transcrição literal das colunas de 80 °C das Tabelas 1
e 2 do artigo, feita na busca 14 da Trilha
(`TRILHA/docs/prompts_busca/resultados/14_secagem_pescado/`) e conferida valor a valor
contra o XML da Europe PMC em 13/10/2026. Os nomes das colunas do CSV são da
transcrição; os valores não foram alterados.

| Coluna do CSV | Tabela | Rótulo no artigo |
|---|---|---|
| `tempo_min` | 1 e 2 | Drying time (min) |
| `massa_peixe_kg` | 1 | Mass of fish (kg) |
| `massa_gas_kg` | 1 | Mass of gas used (kg); vazio no tempo 0 |
| `temperatura_secador_c` | 1 | Temperature of the dryer (°C) |
| `umidade_publicada_kg_agua_por_kg_peixe_seco` | 2 | Moisture content (kg water/kg dry fish) |
| `energia_utilizada_mj` | 2 | Energy utilization (MJ) |

O experimento: bagres-africanos (*Clarias gariepinus*) recém-capturados, eviscerados,
lavados em água salina e depois em água limpa, curvados com a cabeça presa à cauda e
escorridos por cerca de dez minutos, secos num secador de gabinete a gás (GLP) com
controle PID, na Universidade de Ilorin, Nigéria. O lote foi pesado de hora em hora.
O artigo traz também curvas a 100 °C (9 pontos) e 120 °C (8 pontos), deixadas de fora
por decisão do professor (13/10/2026).

A coluna de umidade não fecha com as massas: o rótulo diz base seca, mas 0,770 no
início é compatível com base úmida, e o valor final é 0,000. Ela fica no conjunto
como publicada, para discussão, e não entra no ajuste.
