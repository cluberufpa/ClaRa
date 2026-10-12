# D48 — Laranjeiras: crescimento da circunferência do tronco

- Registro: `D48_laranjeiras_crescimento`; objeto definitivo: `laranjeiras_crescimento`; nome_eapadados: ``.
- Dimensões: 35 × 3; unidade: medição em árvore ao longo do tempo; cinco árvores, sete tempos cada.
- Natureza: real conforme documentação do pacote; origem: datasets::Orange.
- Referência: Draper e Smith (1998), Applied Regression Analysis, exercício 24.N; Pinheiro e Bates (2000); datasets::Orange.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Tree → id_arvore; age → idade_dias; circumference → circunferencia_mm. id_arvore convertido em texto, mantendo códigos originais. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Curva logística; Exploração longitudinal. Principal: Curva logística. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

As 35 linhas são medidas repetidas de cinco árvores; não são 35 árvores. idade_dias corresponde ao tempo contado desde 31/12/1968 segundo a ajuda, sem converter para data ou presumir idade biológica exata. Altura de medição do tronco não confirmada; a ajuda diz provavelmente à altura do peito. Identificador ordenado original por diâmetro máximo convertido em texto; não usar essa ordem como preditor. Ajuste por árvore pode ser demonstrado sem excluir as demais da base.
