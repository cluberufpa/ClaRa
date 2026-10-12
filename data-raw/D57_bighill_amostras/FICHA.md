# D57 — Big Hill: amostras e esforço de pesca elétrica

- Registro: `D57_bighill_amostras`; objeto definitivo: `bighill_amostras`; nome_eapadados: ``.
- Dimensões: 20 × 4; unidade: amostra de pesca elétrica no reservatório Big Hill, maio de 2014.
- Natureza: real conforme documentação do pacote; origem: FSAdata::BGHRsample.
- Referência: Dados obtidos diretamente de Ben Neely; Introductory Fisheries Analyses with R; FSAdata::BGHRsample.
- Licença: GPL (>= 2), FSAdata 0.4.1. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
UID → id_amostra; date → data; loc → localizacao; effort → esforco_min. id_amostra em texto, mantendo códigos e ausências originais. localizacao em texto, mantendo códigos e ausências originais. data convertido de mês/dia/ano para Date, sem perda de datas.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Preparar dados; Relacionar amostras e peixes; Esforço e CPUE. Principal: Preparar dados. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Vinte amostras, todas com 10 minutos de esforço; loc é código, não coordenada. UID permite relação com bighill_peixes; não unir nem repetir o esforço por peixe nesta base. Ao estimar CPUE, somar contagem por amostra antes de dividir pelo esforço; incluir amostras sem captura da espécie. Datas da fonte em mês/dia/ano. Relação entre as tabelas e eventual agregação ficam para o exercício, sem criar um conjunto derivado na passada 1.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::BGHRsample`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("bighill_amostras")`; `data()` e `clara::bighill_amostras` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.
