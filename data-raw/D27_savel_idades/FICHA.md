# D27 — Sável: repetibilidade das leituras de idade

- Registro: `D27_savel_idades`; objeto definitivo: `idades_savel_repetibilidade`; nome_eapadados: `idades_savel_repetibilidade`.
- Dimensões: 53 × 8; unidade: peixe com leituras de idade repetidas por leitor.
- Natureza: real; origem: EAPADados::idades_savel_repetibilidade.
- Referência: McBride, Hendricks e Olney (2005), Fisheries 30:10–18; FSAdata::ShadCR.
- Licença: GPL-2 | GPL-3, FSAdata. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto herdado com a planilha/CSV que o originou, antes das adaptações autorizadas. Uma fonte local organizada não equivale a reextração independente de toda a publicação.

## Uso didático

Wilcoxon pareado; Repetibilidade; Concordância. Principal: Wilcoxon pareado. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Não traduzir novamente cabeçalhos herdados nesta passada. Parear por fish_id; remover ausências somente do par usado. Leitor B tem 20 ausências em cada leitura. Falta de diferença em Wilcoxon não demonstra concordância perfeita.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::ShadCR`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("idades_savel_repetibilidade")`; `data()` e `clara::idades_savel_repetibilidade` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.
