# D19 — Lebistes: sexo e infecção por *Gyrodactylus*

Substitui `camaroes_sexo` (170 camarões, tabela de livro sem referência), por
decisão do professor em 12/10/2026. O código D19 foi reaproveitado; o objeto e a
fonte antigos ficaram em `../substituidos/D19_camaroes_sexo/`. Objeto
`lebistes_parasitos`. Resposta à busca 10
(`TRILHA/docs/prompts_busca/resultados/10_sexo_por_especie_individuos/RESULTADO_BUSCA.md`).

## Fonte e licença

Walsman, J.; Janecka, M.; Clark, D.; Kramp, R.; Rovenolt, F. et al. (2022).
Data from: Shoaling guppies evade predation but have deadlier parasites.
[Dryad](https://datadryad.org/dataset/doi:10.5061/dryad.k3j9kd59h), DOI
10.5061/dryad.k3j9kd59h. Artigo: [Nature Ecology & Evolution](https://doi.org/10.1038/s41559-022-01772-5).
**CC0 1.0**, campo `license` da API do Dryad (conferido em 12/10/2026).

`fonte/peixes_parasitismo_individuos_tidy.xlsx` (244.494 bytes, SHA-256 em
`fonte/SHA256.txt`) é a planilha que o professor recebeu: aba `dados_brutos_tidy`
(4.715 × 17) e aba `documentacao`. Parece ser o `SI_ParasiteCountsOther.csv` do
Dryad, arrumado e traduzido. **A conferência linha a linha com o CSV original
não foi feita** (pendência: baixar o CSV, registrar o hash e comparar).

## O que é

Lebistes (*Poecilia reticulata*) selvagens de rios de Trinidad, 2003–2009, um
peixe por linha, com classe demográfica (fêmea, macho, juvenil), peso e
infecção por *Gyrodactylus*. 17 bacias, 25 rios, 69 combinações de bacia, rio,
sítio e ano.

## Preparo e de-para

`source("data-raw/D19_lebistes_parasitos/preparar.R")`, na raiz, confere o hash
e recria dados e registro.

| Fonte | ClaRa | Decisão |
|---|---|---|
| bacia, rio | bacia, rio | texto original |
| trecho_rio | trecho_rio | fator: Alto, Médio, Baixo curso e Lago |
| sitio_id | sitio | inteiro |
| ano | ano | inteiro |
| classe_sexo | sexo | fator fêmea, macho, juvenil (minúsculas) |
| peso_g | peso_g | g; 113 NA mantidos |
| contagem_parasitos | contagem_parasitos | inteiro |
| presenca_parasito | presenca_parasito | inteiro 0/1 |

Ficam na fonte, fora do objeto: `riqueza_com_gyro`, `riqueza_sem_gyro`,
`presenca_riqueza`, `presenca_ws`, `presenca_apio`, `presenca_fungo`,
`presenca_digenea`, `presenca_cn`. Nenhuma linha descartada, sem imputação.

## Uso didático

A tabela de contingência **não vem pronta**: o aluno a monta depois do preparo
da base compartilhada (contagem de `sexo` por `presenca_parasito`) e testa.

- **Qui-quadrado de independência:** sexo × infecção (3 × 2): χ² = 200,3, gl 2,
  p < 0,001; menor esperado 369. Fêmea × macho (2 × 2): χ² = 5,95, p = 0,015.
  Sexo × trecho do rio (3 × 4) é um segundo exercício.
- **Teste de proporções:** razão sexual 1:1 dos adultos, 56,2% de fêmeas
  (IC 54,5–57,9%).
- **Peso e contagem de parasitos por grupo** (t, Mann-Whitney, Kruskal-Wallis).
- Pergunta: a prevalência de *Gyrodactylus* depende do sexo, e a fase juvenil
  se infecta menos?

## Limites que o aluno precisa saber

- **Dependência.** Os peixes vêm agrupados em 69 sítios; o p-valor é otimista.
- **Juvenil não é sexo.** Os juvenis têm prevalência bem menor (14%, contra 37%
  nas fêmeas e 33% nos machos), o que pesa no χ² de 3 × 2.
- **Presença × contagem.** Em 3 peixes a presença é 1 e a contagem é 0: na fonte
  a presença vem do *Gyrodactylus* na lista de espécies, não da contagem. Mantido.
- **Linhas idênticas.** 723, sobretudo juvenis de mesmo peso, sem ID do peixe. Não usar `distinct()`.
- **Tema.** Peixe de aquário em estudo de ecologia parasitária, não de pesca ou
  aquicultura; ferramenta de ensino. Parecido em tema com `molinesias_parasitos` (D50).
- **Tamanho.** 4.715 linhas, acima das 2.000 do pedido da busca; mantido por
  decisão do professor (o N grande ajuda o qui-quadrado). Objeto de 9.500 bytes.
- A ClaRa ainda não tem verbo para o qui-quadrado; a incorporação não o acrescenta.
