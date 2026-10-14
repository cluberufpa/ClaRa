# D24 — Percina: idade e comprimento em Ontário

- Registro: `D24_percina_ontario`; objeto definitivo: `darter_ontario`; nome_eapadados: `darter_ontario`.
- Dimensões: 54 × 3; unidade: registro reconstruído aproximadamente de uma figura de indivíduos.
- Natureza: real reconstruída de figura; origem: EAPADados::darter_ontario.
- Referência: Reid (2004), Journal of Freshwater Ecology 19:441–444, Figura 2; FSAdata::DarterOnt.
- Licença: GPL-2 | GPL-3, FSAdata. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Mann-Whitney; Estatística descritiva. Principal: Mann-Whitney. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

São registros reconstruídos da Figura 2, não planilha primária individual. Manter quatro linhas com valores repetidos. Mann-Whitney exige lidar com empates; interpretar formas das distribuições e seletividade da captura.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::DarterOnt`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("darter_ontario")`; `data()` e `clara::darter_ontario` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.
