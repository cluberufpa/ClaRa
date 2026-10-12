# D48 — Molinésias: crescimento individual

Substitui `laranjeiras_crescimento` (Orange), por autorização do professor em 12/10/2026. O objeto é `molinesias_crescimento`; o código D48 permanece. Fontes antigas em `../substituidos/D48_laranjeiras_crescimento/`. Não há alias com nome de planta.

Fonte: Scherer, Ehlman, Bierbach, Krause e Wolf (2023), [Figshare V1](https://doi.org/10.6084/m9.figshare.23971599.v1), CC BY 4.0. Arquivo growth.csv, ID 42593824, [download original](https://ndownloader.figshare.com/files/42593824). MD5 oficial: `d861757ef46947b6a2f1e2f2e423cbdd`. Metadados integrais congelados em fonte/. Atribuição deve acompanhar redistribuições; [licença](https://creativecommons.org/licenses/by/4.0/). Adaptações da ClaRa descritas abaixo.

Artigo: DOI 10.1038/s41467-023-43069-6. Correção de abril de 2026: DOI 10.1038/s41467-026-71983-y, arquivo fonte/correcao.xml; acrescenta informação dos ensaios comportamentais de nove dias. Segundo os autores, não altera os resultados. Não é uma versão substituta do CSV de crescimento.

## Preparo e de-para

`source("data-raw/D48_molinesias_crescimento/preparar.R")`, na raiz, verifica o hash e recria dados e registro. Usa digest e jsonlite somente no preparo, sem dependências adicionais para carregar o conjunto.

| Fonte | ClaRa | Decisão |
|---|---|---|
| test_fish_ID | id_peixe | Texto, preserva identificador |
| mother_ID | id_mae | Texto, preserva m1, m2, m4 |
| fish_age_in_days | idade_dias | Inteiro, dias desde o nascimento |
| standard_length_in_cm | comprimento_padrao_cm | Valor observado, sem arredondamento |
| índice, predicted_standard_length_in_cm, lower_CI, upper_CI | omitidas | Índice técnico e resultados de ajuste não são observações |

Todas as 1178 linhas e sua ordem permanecem. São 34 fêmeas clonais de Poecilia formosa, provenientes de três mães (14, 4 e 16 filhas). A mãe registra parentesco; não representa tratamento aleatorizado.

## Utilidade didática

O conjunto permite acompanhar o crescimento real de cada peixe, comparar trajetórias individuais e estudar curvas de von Bertalanffy e Gompertz. É útil para interpretar comprimento assintótico e taxa de crescimento, conferir resíduos e distinguir comprimentos observados das previsões de um modelo. Substitui o exemplo de árvores do Orange por uma pergunta de bioecologia aquática.

As medições sucessivas permitem discutir dependência dentro do indivíduo, ocasiões ausentes e intervalos desiguais. O recorte de dez idades com cobertura completa oferece um exercício de comparação com a base integral: menos medições podem alterar os parâmetros estimados. O identificador da mãe permite reconhecer parentesco, sem tratá-lo como tratamento experimental. Os ajustes de crescimento são possibilidades de estudo em R; sua inclusão não cria um motor novo na ClaRa.

## Uso e limites

Há 30–38 medições por peixe e 40 idades distintas entre 0 e 280 dias. O dia 266 não consta na fonte. Não há NA nas quatro colunas, mas existem 182 ocasiões ausentes na combinação dos 34 peixes com as 40 idades observadas. Não se conhecem suas causas.

Usar o ID para identificar curvas e dependência. O conjunto completo é a versão oficial. A ajuda mostra um recorte opcional de 340 linhas nas dez idades com cobertura completa: 0, 14, 21, 42, 49, 56, 77, 154, 224 e 280. Não houve imputação; intervalos continuam desiguais. O recorte pode alterar os parâmetros estimados.

A exploração anterior encontrou ajustes individuais viáveis de von Bertalanffy e Gompertz; isso não valida pressupostos nem substitui modelo de dependência temporal. Sem verbo analítico atribuído no catálogo, pois a ClaRa ainda não oferece esses motores. Revisão didática pelo autor permanece pendente; autorização de incorporação e conferência técnica estão registradas.

