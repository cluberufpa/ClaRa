# D44 — Percas: consumo de oxigênio sob hipóxia

Substitui `plantas_absorcao_co2` (CO2), por autorização do professor em 12/10/2026. Objeto `percas_hipoxia`, código D44 preservado. Fontes antigas em `../substituidos/D44_plantas_absorcao/`; sem alias com nome de planta.

Fonte: Ekström (2021), [Dryad](https://doi.org/10.5061/dryad.tmpg4f4z3), CC0 1.0. Artigo Ekström et al., DOI 10.1242/jeb.241554. O download do Dryad estava bloqueado; o XLSX foi obtido do [espelho Zenodo 4591899](https://zenodo.org/records/4591899), que referencia o mesmo DOI e declara cc-zero. MD5 do arquivo conferido com Zenodo: `09ba220844c4c8ddd36d2a5c4d8fa1b6`. Metadados dos dois depósitos congelados em fonte/. [Licença CC0](https://creativecommons.org/publicdomain/zero/1.0/).

## Preparo e de-para

`source("data-raw/D44_percas_hipoxia/preparar.R")`, na raiz, verifica hash e recria dados e registro. readxl, digest e jsonlite são usados somente no preparo. Nenhum deles é exigido para carregar os dados já incorporados.

Selecionada a aba `Hyp. Prot. - RMR`; outras três abas permanecem no XLSX bruto.

| Fonte | ClaRa | Decisão |
|---|---|---|
| ID | id_peixe | Identificador original como texto |
| Treatment Group | grupo | Fator com três rótulos em português |
| Air saturation level | saturacao_ar_pct | Porcentagem de saturação de ar, sem reescala |
| Resting metabolic rate | consumo_o2_mg_kg_h | Taxa de rotina em mg O2/kg/h, sem arredondamento |

readxl remove o espaço final do último cabeçalho. Baltic → Referência a 18 °C (13 peixes); Biotest → Aquecimento crônico a 23 °C (11); Balt@Bio → Aquecimento agudo a 23 °C (16). O grupo crônico é de origem em ambiente aquecido; o agudo é da referência testada a 23 °C. Não é um fatorial completo origem × temperatura.

## Utilidade didática

O conjunto permite estudar como o consumo de oxigênio responde à hipóxia, desenhar curvas por peixe e comparar visualmente os três grupos térmicos. É útil para discutir curvas com platô, cobertura desigual entre grupos e respostas ausentes. Seu principal ganho em relação ao CO2 é trazer essas perguntas para a fisiologia de peixes.

Também permite ensinar por que 449 linhas não representam 449 réplicas independentes: são medições de 40 peixes. A sequência decrescente de oxigênio ajuda a discutir o planejamento de medidas repetidas e a associação entre exposição e tempo. Ajustes conjuntos e inferência entre grupos exigem modelos apropriados, ainda não implementados na ClaRa.

## Integridade e limites

Todas as 449 linhas na ordem original e os 23 NA da resposta foram mantidos, incluindo três linhas a 100% sem resposta. Não preencher usando metabolismo de outra aba. Há 426 respostas válidas, de 8 a 12 por peixe. Existem 12 níveis com resposta, entre 15 e 90%; só Biotest tem medições a 15%.

O protocolo reduz o oxigênio progressivamente: saturação e ordem temporal se confundem. Não tratar as linhas como peixes independentes. Cobertura e interrupções do protocolo podem ser informativas; suas causas não foram atribuídas individualmente.

A resposta é metabolismo de rotina, não metabolismo padrão. A porcentagem é preditora; não é uma resposta proporcional para regressão beta. Curvas suaves ou com platô são possibilidades de estudo; não impor Michaelis-Menten. Um limiar exploratório não reproduz automaticamente o PCrit publicado. Sem verbo analítico atribuído: a incorporação não implementa medidas repetidas na ClaRa. Revisão didática pelo autor pendente.

