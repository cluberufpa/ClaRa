# D54 — Haemulon plumierii: idade, comprimento e sexo

- Registro: `D54_haemulon_crescimento`; objeto definitivo: `haemulon_crescimento`; nome_eapadados: ``.
- Dimensões: 465 × 3; unidade: ponto reconstruído aproximadamente de figura de idade e comprimento.
- Natureza: real reconstruído aproximadamente de figura; origem: FSAdata::WhiteGrunt2.
- Referência: Araujo e Martins (2007), Age, growth and mortality of white grunt (Haemulon plumierii) from the central coast of Brazil, Scientia Marina 71:793–800, figura 6; FSAdata::WhiteGrunt2.
- Licença: GPL (>= 2), FSAdata 0.4.1. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
age → idade_anos; tl → comprimento_total_mm; sex → sexo. Categorias de sexo: female → femea, male → macho.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Crescimento; von Bertalanffy; Comparação por sexo. Principal: Crescimento. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

465 pontos reconstruídos aproximadamente da figura 6, conforme a ajuda. Não apresentar como planilha bruta individual dos autores nem como dados sintéticos simulados. A precisão de 0,1 ano e os comprimentos refletem a reconstrução; revisar digitalização antes de interpretar erros finos ou repetidos. Confirmar fonte primária e preferir dados originais do estudo se disponíveis. Contexto pesqueiro adequado, embora distribuído por pacote.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::WhiteGrunt2`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("haemulon_crescimento")`; `data()` e `clara::haemulon_crescimento` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.

## Mantido ao lado do D64 (13/10/2026)

O professor manteve este conjunto depois de comparar com o D64 `platycephalus_crescimento` (tiger flathead, dados medidos): a faixa de idade é maior (até 28 anos), o L∞ varia menos (erro-padrão de cerca de 1% contra 2%) e o peixe é do Brasil. O custo é a origem: pontos lidos de uma figura, com idades que não são inteiras (427 das 465 têm casas decimais). Os dois formam um par didático, um de dados reconstruídos e outro de dados medidos. Figura de comparação em `docs/D54_comparacao_antigo_novo.png`. Verbo existente: `comparar_medias()` em uma idade fixa.
