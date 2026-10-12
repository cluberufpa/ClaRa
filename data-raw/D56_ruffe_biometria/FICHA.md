# D56 — Ruffe: biometria e maturidade no rio St. Louis

- Registro: `D56_ruffe_biometria`; objeto definitivo: `ruffe_biometria`; nome_eapadados: ``.
- Dimensões: 738 × 11; unidade: registro de peixe Gymnocephalus cernuus capturado em 1992.
- Natureza: real conforme documentação do pacote; origem: FSAdata::RuffeSLRH92.
- Referência: US Geological Survey, Lake Superior Biological Station, Ashland, Wisconsin, coleção pessoal; FSAdata::RuffeSLRH92.
- Licença: GPL (>= 2), FSAdata 0.4.1. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
fish.id → id_peixe; month → mes; day → dia; year → ano; indiv → id_individuo; location → localizacao; length → comprimento_total_mm; weight → peso_g; sex → sexo; maturity → maturidade; age → idade_anos. id_peixe em texto, mantendo códigos e ausências originais. id_individuo em texto, mantendo códigos e ausências originais. localizacao em texto, mantendo códigos e ausências originais. Categorias de sexo: female → femea, male → macho, unknown → desconhecido. Categorias de maturidade: developing → em_desenvolvimento, immature → imaturo, mature → maduro, nearly.ripe → quase_maduro, nearly.spent → quase_esgotado, recovering → em_recuperacao, ripe → pronto_desova, running → em_desova, spent → esgotado, unknown → desconhecido, yoy → jovem_ano.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Frequência de comprimento; Relação peso-comprimento; Crescimento; Maturidade. Principal: Frequência de comprimento. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

738 linhas preservadas, inclusive identificadores repetidos da fonte. fish.id é número decimal: convertido em texto sem arredondar ou criar nova chave; indiv também pode repetir. Confirmar unidade amostral e duplicatas com a fonte antes de usar como identificador único. Idade por escamas disponível em apenas 12 registros (726 NA), peso com 2 NA; não sustenta ajuste de crescimento a todas as 738 linhas. Sexo desconhecido e estágio jovem do ano não significam ausência. Códigos de localização preservados em texto, sem inferir coordenadas. Rever significado biológico dos estágios traduzidos, sobretudo quase maduro/esgotado e jovem do ano.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::RuffeSLRH92`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("ruffe_biometria")`; `data()` e `clara::ruffe_biometria` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.
