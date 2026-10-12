# D40 — Whitefish: condição e fisiologia sob salinidade

- Registro: `D40_whitefish_salinidade`; objeto definitivo: `whitefish_salinidade`; nome_eapadados: ``.
- Dimensões: 59 × 11; unidade: peixe amostrado nos dias 174 ou 252; subamostra de tanque, sem pareamento entre dias.
- Natureza: real; origem: Dryad::whitefish_salinidade.
- Referência: Yeung e colaboradores (2026), Stress, growth, and osmoregulatory data for the Atlantic Whitefish at different salinities, Dryad v3, DOI 10.5061/dryad.bg79cnpph, File_A.csv.
- Licença: CC0-1.0. A licença MIT do código não altera a da fonte.
- Situação: provisório; subamostras por tanque, sem pareamento individual.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
File_A.csv → tabela principal. Source Tank/Tank/Salinity/Fish ID/Day/Temp/Relative condition factor/Lactate/Glucose/Plasma Cortisol/Total Osmolarity → id_tanque_origem, id_tanque, salinidade_ppt, id_peixe, dia, grupo_temperatura, fator_condicao_relativo, lactato_mmol_l, glicose_mmol_l, cortisol_plasma_ng_l, osmolaridade_total_mosm. Cool/Warm → frio/quente. Todas as 59 linhas, medições e ausências preservadas; três IDs tratados como texto. As outras tabelas ficam integralmente na fonte, com unidades distintas, sem junção artificial.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Tabela selecionada diretamente da fonte primária. Demais tabelas preservadas integralmente, sem criar conjuntos adicionais nesta passada.

## Uso didático

Exploração por salinidade e ocasião; Planejamento com subamostras por tanque. Principal: Exploração por salinidade e ocasião. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Selecionada a tabela A pronta para análise, com as quatro tabelas originais preservadas na fonte. São 59 peixes, não os 60 mencionados no método; não preencher a linha ausente. Peixes não foram marcados ao longo do experimento, e os grupos dos dias 174 e 252 são de indivíduos diferentes. Temperatura e dia coincidem; não separar seus efeitos causalmente. Conferir replicação/alocação por tanque. Cortisol/osmolaridade ausentes no grupo frio; não imputar. README menciona glicose onde parece descrever osmolaridade; valores e ausências originais preservados.
