# D12 — Bactérias: presença após tratamentos em crianças

- Registro: `D12_bacterias_tratamento`; objeto definitivo: `bacterias_tratamento`; nome_eapadados: ``.
- Dimensões: 220 × 6; unidade: observação de uma criança em uma semana; medidas repetidas.
- Natureza: real; origem: MASS::bacteria, cópia preservada no levantamento.
- Referência: Amanda Leach via James McBroom; Venables e Ripley (2002); MASS::bacteria, MASS 7.3-65.
- Licença: GPL-2 | GPL-3, conforme MASS; não relicenciado como MIT. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
y/ap/hilo/week/ID/trt → presenca_bacteria/intervencao/adesao/semana/id_individuo/tratamento; n/y → ausente/presente; a/p → medicamento/placebo; hi/lo → alta/baixa; drug/drug+ → medicamento/medicamento_incentivo. ID como texto. Todas as 220 observações preservadas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

McNemar; Preparo de dados pareados; Regressão logística com estrutura longitudinal. Principal: McNemar. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Para McNemar selecionar semanas 0 e 11 e parear por id_individuo: 44 pares completos, sem imputar as seis perdas. Não tratar 220 registros como crianças independentes. Confirmar a interpretação dos campos de adesão e incentivo no protocolo.
