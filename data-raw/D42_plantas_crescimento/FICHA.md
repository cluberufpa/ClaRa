# D42 — Plantas: massa seca sob três tratamentos

- Registro: `D42_plantas_crescimento`; objeto definitivo: `plantas_crescimento`; nome_eapadados: ``.
- Dimensões: 30 × 2; unidade: unidade do experimento de crescimento de plantas; protocolo detalhado pendente.
- Natureza: real conforme documentação do pacote; origem: datasets::PlantGrowth.
- Referência: Dobson (1983), An Introduction to Statistical Modelling, exemplo da tabela 7.4; datasets::PlantGrowth.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
weight → massa_seca; group → tratamento. Categorias de tratamento: ctrl → controle, trt1 → tratamento_1, trt2 → tratamento_2. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em data-raw/D44_plantas_absorcao/fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

DIC; ANOVA de um fator. Principal: DIC. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

A ajuda não informa espécie, unidade da massa seca nem protocolo completo de randomização. Não inventar gramas, espécie ou composição dos tratamentos. Trinta observações, dez por condição. Confirmar o delineamento na fonte histórica; natureza experimental declarada pelo pacote.
