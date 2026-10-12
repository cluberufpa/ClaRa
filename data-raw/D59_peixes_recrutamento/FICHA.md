# D59 — Peixes: índice mensal de recrutamento

- Registro: `D59_peixes_recrutamento`; objeto definitivo: `peixes_recrutamento`; nome_eapadados: ``.
- Dimensões: 453 × 2; unidade: mês da série de índice de recrutamento, janeiro de 1950 a setembro de 1987.
- Natureza: real conforme documentação do pacote; origem: astsa::rec.
- Referência: Roy Mendelssohn, Pacific Fisheries Environmental Laboratory, NOAA, comunicação pessoal, conforme astsa::rec; Shumway e Stoffer, Time Series Analysis and Its Applications.
- Licença: GPL (>= 2), astsa 2.5. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Série ts transformada em data.frame mensal com data e indice_recrutamento; frequência e início usados para reconstruir o calendário. Primeiro dia representa o mês, não dia real de coleta. Valores e ordem da série preservados; sem interpolação ou novas variáveis ambientais.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Séries temporais; Autocorrelação; Tendência. Principal: Séries temporais. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

O valor é índice de recrutamento, não número bruto de peixes. Espécie, área, construção e escala do índice não são especificadas na ajuda resumida: confirmar na documentação primária. Série ts com frequência 12, início 1950 e 453 valores termina em setembro de 1987; limite arredondado 1988 da impressão não é data de coleta. Primeiro dia do mês é convenção de representação, não dia observado. Preservados valores repetidos. Dependência temporal exige métodos adequados; não inventar variáveis ambientais nem parear automaticamente com SOI.
