# D11 — Puromicina: concentração e velocidade de reação

- Registro: `D11_puromicina_reacao`; objeto definitivo: `puromicina_reacao`; nome_eapadados: ``.
- Dimensões: 23 × 4; unidade: medição de reação; um experimento por condição.
- Natureza: real; origem: datasets::Puromycin; planilha fornecida pelo professor.
- Referência: Treloar (1974); Bates e Watts (1988), apêndice A1.3; datasets::Puromycin, R 4.6.1.
- Licença: GPL-2 | GPL-3 da distribuição R; licença da origem preservada. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
`rownames` → `registro_original` (texto); `conc` → `concentracao_ppm`; `rate` → `velocidade_contagens_min2`; `state` → `condicao`; treated/untreated → com_puromicina/sem_puromicina. Índice preservado por ainda não haver aprovação de retirada.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Regressão logarítmica; Saturação Michaelis-Menten. Principal: Regressão logarítmica no intervalo observado. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Não presumir réplicas biológicas: um experimento por condição, seis concentrações distintas. Modelo logarítmico é aproximação empírica, sem assíntota. A retirada do índice da planilha fica para revisão.
