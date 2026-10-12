# D44 — Plantas: absorção de CO2 e resfriamento

- Registro: `D44_plantas_absorcao`; objeto definitivo: `plantas_absorcao_co2`; nome_eapadados: ``.
- Dimensões: 84 × 5; unidade: medição em uma planta sob concentração de CO2; sete medições por planta.
- Natureza: real conforme documentação do pacote; origem: datasets::CO2.
- Referência: Potvin, Lechowicz e Tardif (1990), Ecology 71:1389–1400, DOI 10.2307/1938276; Pinheiro e Bates (2000), apêndice A.5; datasets::CO2.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Plant → id_planta; Type → origem; Treatment → resfriamento; conc → concentracao_co2; uptake → absorcao_co2_umol_m2_s. id_planta convertido em texto, mantendo códigos originais. Categorias de resfriamento: nonchilled → sem_resfriamento, chilled → com_resfriamento. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Medidas repetidas por planta; Curvas de resposta; Planejamento fatorial. Principal: Medidas repetidas por planta. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Doze plantas, seis de cada origem; três por combinação origem × resfriamento, com sete concentrações por planta. As 84 medições não são réplicas independentes. A ajuda registra conc em mL/L; confirmar a unidade na fonte primária antes de converter ou acrescentar sufixo ao nome. Não confundir CO2 (experimento de plantas) com co2 (série atmosférica). Cópia do levantamento corrigida a partir do objeto nomeado da distribuição R.
