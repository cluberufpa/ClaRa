# D15 — Peixes neotropicais: comprimento e peso

- Registro: `D15_peixes_neotropicais`; objeto definitivo: `peixes_neotropicais_biometria`; nome_eapadados: `bagley_lwr_central_america`.
- Dimensões: 306 × 9; unidade: peixe amostrado.
- Natureza: real; origem: EAPADados::bagley_lwr_central_america.
- Referência: Bagley, Breitman e Johnson (2022); DOI 10.3897/aiep.52.86467; Mendeley DOI 10.17632/kphrvvgwwz.1.
- Licença: CC BY 4.0. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Decisão anterior aprovada: retirar log_peso_g, log_sl_mm, nadadeira_dorsal, nadadeira_caudal e sexo; no → id_registro (texto). Todas as 306 linhas preservadas. Duas diferenças de espaço final em red fin no CSV explicadas pela transformação str_squish já documentada no preparo original.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Regressão de potência; Exploração por espécie; ANCOVA com logaritmos calculados na análise. Principal: Regressão de potência. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Preservar 306 indivíduos e ausências de comprimento total. Não confundir nove rótulos taxonômicos com as sete espécies do título do artigo. Revisar desequilíbrio entre espécies e a identificação dos dois grupos sp. Nome definitivo sugerido nesta passada: peixes_neotropicais_biometria.

## Usos secundários (13/10/2026)

ANCOVA: com `log(peso_g)` e `log(comprimento_padrao_mm)`, o modelo `lm(log_peso ~ log_comp * especie)` testa se as espécies têm a mesma inclinação (alometria) e, sem interação, o mesmo intercepto. Cada linha é um peixe.
