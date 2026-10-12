# D45 — Insetos: contagens sob seis inseticidas

- Registro: `D45_insetos_inseticidas`; objeto definitivo: `insetos_inseticidas`; nome_eapadados: ``.
- Dimensões: 72 × 2; unidade: unidade experimental agrícola tratada com inseticida.
- Natureza: real conforme documentação do pacote; origem: datasets::InsectSprays.
- Referência: Beall (1942), Biometrika 32:243–262, tabela 7, DOI 10.1093/biomet/32.3-4.243; McNeil (1977); datasets::InsectSprays.
- Licença: GPL-2 | GPL-3, conforme datasets (R 4.6.1). A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
count → contagem_insetos; spray → inseticida. Categorias de inseticida: A → inseticida_A, B → inseticida_B, C → inseticida_C, D → inseticida_D, E → inseticida_E, F → inseticida_F. Nenhuma linha excluída, reordenada ou simulada; zeros e ausências preservados. Sem conversão de unidades. Casca data.frame simples; estrutura de medidas repetidas explicada na ficha, sem atributos de groupedData que referenciem cabeçalhos antigos.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. Objeto primário recapturado da distribuição R/MASS e comparado à cópia do levantamento, antes das adaptações. Exceção D44: o levantamento guardava outro objeto; correção da fonte registrada em data-raw/D44_plantas_absorcao/fonte/CORRECAO_FONTE.md. Não houve reextração independente das publicações históricas.

## Uso didático

Modelos de contagem; Poisson; Binomial negativa; Kruskal-Wallis. Principal: Modelos de contagem. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Preservadas as 72 unidades, 12 por inseticida. A composição dos seis produtos e o protocolo detalhado não são informados na ajuda. Não inventar compostos ou tratar contagem como contínua sem avaliar o método. Dispersão e ajuste dos modelos devem ser avaliados na análise, sem reutilizar estimativas herdadas como garantia.
