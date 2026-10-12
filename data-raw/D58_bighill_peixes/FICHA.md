# D58 — Big Hill: peixes e contagens por amostra

- Registro: `D58_bighill_peixes`; objeto definitivo: `bighill_peixes`; nome_eapadados: ``.
- Dimensões: 266 × 6; unidade: registro individual ou agrupado de espécie e comprimento dentro de amostra.
- Natureza: real conforme documentação do pacote; origem: FSAdata::BGHRfish.
- Referência: Dados obtidos diretamente de Ben Neely; Introductory Fisheries Analyses with R; FSAdata::BGHRfish.
- Licença: GPL (>= 2), FSAdata 0.4.1. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
UID → id_amostra; fishID → id_peixe; specCode → codigo_especie; length → comprimento_total_mm; weight → peso_g; count → contagem. id_amostra em texto, mantendo códigos e ausências originais. id_peixe em texto, mantendo códigos e ausências originais. codigo_especie em texto, mantendo códigos e ausências originais.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Preparar dados; Agregação de capturas; Relação peso-comprimento; CPUE. Principal: Preparar dados. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

266 linhas não equivalem necessariamente a 266 peixes: contagem varia de 1 a 3 e deve ser somada para captura. fishID tem 81 ausências e é local à amostra, não chave global; peso tem 91 NA. Manter todas as linhas e não expandir contagens em réplicas fictícias. UID referencia bighill_amostras; esforço fica naquela tabela e não deve ser somado após repetição por peixe. Códigos de espécie 116/118/122 preservados como texto; nomes comuns ingleses da ajuda não são inferidos como novos nomes científicos.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::BGHRfish`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("bighill_peixes")`; `data()` e `clara::bighill_peixes` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.
