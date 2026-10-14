# D55 — Cabezon: comprimento, idade e maturidade de fêmeas

- Registro: `D55_cabezon_maturidade`; objeto definitivo: `cabezon_maturidade`; nome_eapadados: ``.
- Dimensões: 525 × 5; unidade: fêmea de Scorpaenichthys marmoratus coletada no Oregon.
- Natureza: real conforme documentação do pacote; origem: FSAdata::Cabezon.
- Referência: Hannah, Blume e Thompson (2009), Length and age at maturity of female yelloweye rockfish and cabezon from Oregon waters based on histological evaluation of maturity, ODFW Information Reports 2009-04; dados obtidos de Bob Hanna, conforme FSAdata::Cabezon.
- Licença: GPL (>= 2), FSAdata 0.4.1. A licença MIT do código não altera a da fonte.
- Situação: provisório.

## Linhas e de-para

Todas as linhas e sua ordem preservadas. Ausências mantidas; nenhuma imputação.
date → data; length → comprimento_total_cm; age → idade; maturity → maturidade; stage → estagio_maturidade. data convertido de mês/dia/ano para Date, sem perda de datas. Categorias de maturidade: Immature → imatura, Mature → madura, Unknown → desconhecida.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.

As fontes usadas no preparo estão preservadas integralmente em `fonte/`, com SHA256. A conferência compara o objeto do levantamento com a fonte da distribuição do pacote, antes das adaptações documentadas. Não houve reextração independente das publicações históricas.

## Uso didático

Maturidade; Regressão logística; Crescimento; von Bertalanffy. Principal: Maturidade. Exemplo da ajuda resume os dados; não promete que a ClaRa tenha motor para todas as análises listadas.

## Pendências para a curadoria

Dados declarados obtidos diretamente dos pesquisadores, relativos apenas a fêmeas de Newport e Depoe Bay, Oregon. Preservados 226 valores ausentes de idade e categoria Unknown (desconhecida) de maturidade, que a descrição resumida não lista. Não codificar desconhecida como imatura ou madura nem excluir da base; selecionar respostas conhecidas no ramo logístico. Datas lidas como mês/dia/ano. Estágios 1 a 7 mantidos como códigos; não converter automaticamente em escala contínua. Confirmar unidade da idade em anos na fonte e seleção de indivíduos com leitura de otólito.

## Leitura na hora (12/10/2026)

Fornecedor: `FSAdata::Cabezon`, versão validada 0.4.1; licença GPL (>= 2). Autoria do pacote: Derek Ogle. Use `carregar_dados("cabezon_maturidade")`; `data()` e `clara::cabezon_maturidade` deixam de fornecer este conjunto. Receita e de-para em `R/dados_pacotes.R`. Comparação com a cópia anterior: `all.equal()` TRUE, com linhas, colunas, tipos e níveis preservados. As cópias binárias deixam de ser mantidas. Os registros anteriores desta ficha descrevem a migração histórica.

## Usos secundários (13/10/2026)

Regressão logística: crie `madura` (1 para madura, 0 para imatura; deixe de fora as três desconhecidas) e ajuste `glm(madura ~ comprimento_total_cm, family = binomial)`; o comprimento de primeira maturação (L50) é `-a / b`.
