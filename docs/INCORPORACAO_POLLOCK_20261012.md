# Incorporação do pollock — 12/10/2026

Por autorização do professor, **`pollock_alasca` substitui `terremotos_fiji`
no D47**, na branch `dados`, worktree `ClaRa-dados/`. O catálogo permanece
com 61 entradas. Os outros registros foram preservados pela receita de
substituição; outras curadorias estão sendo feitas simultaneamente nessa worktree.
Não houve merge na main, push, mudança de versão ou alteração na TRILHA.

## O que entrou

NOAA/DisMAP, Golfo do Alasca, *Gadus chalcogrammus*, 2023. Fonte CC0 1.0,
confirmada na seção Access Information / Data License de
[InPort 69743](https://www.fisheries.noaa.gov/inport/item/69743).

- 523 linhas, 523 identificadores e 523 pares de coordenadas distintos.
- Oito colunas: `id_lance`, `ano`, `especie`, `latitude_graus`,
  `longitude_graus`, `profundidade_m`, `cpue_kg_ha`, `estrato`.
- Nenhum NA; 91 zeros de CPUE preservados. Profundidade: 19–584 m.
- Geometria explicitamente pedida e retornada em WGS84, EPSG:4326.
- Estratos como fator, com 54 códigos originais; ano e espécie constantes.
- Objeto comprimido com xz: **11.924 bytes**, abaixo do limite de 100 KB.

Fonte JSON integral, metadados do serviço/camada, página da licença, código
oficial, CSV de conferência e SHA-256 ficaram em
`data-raw/D47_pollock_alasca/fonte/`. `preparar.R` funciona sem internet.
Ajuda, ficha e de-para registram seleção por espécie/ano, unidade kg/ha,
dependência espacial, campos excluídos e serviço CURRENT mutável.
As fontes, o objeto preparado e a ajuda antigos foram arquivados em
`data-raw/substituidos/D47_terremotos_fiji/`.

## Conferência cartográfica

Natural Earth Land 1:10 milhões, v5.1.1; `sf`, validade geométrica e
interseção em EPSG:3338. **Dois pontos interceptam terra**:

| id_lance | Distância à borda do polígono terrestre | Decisão |
|---|---|---|
| -22483 | 48,93 m | Preservar e sinalizar |
| -22558 | 458,92 m | Preservar e sinalizar |

Os outros 521 não interceptam terra. A costa é generalizada; não é possível
atribuir o conflito exclusivamente à fonte ou ao contorno. Não houve
deslocamento, exclusão nem ajuste inventado. A revisão desses dois pontos
com costa mais detalhada/ou metadados de lance permanece pendente.

SHA-256 do ZIP Natural Earth usado:
`e547d749445eaa0964aba76738090ec88f5e63c4585122170f98c67a7ea922dc`.
Script, contorno, mapa geral, detalhes dos dois pontos, resultados,
tarball e biblioteca temporária estão em
`D:/Claude/EAPA-Ecossistema/tmp/incorporar-pollock-20261012/`.

## Validação realizada

1. Preparo e roxygen2 concluídos. A receita conferiu hash, EPSG, dimensões,
   IDs, ausência de NA, zeros, categorias e preservação das demais entradas
   do catálogo no momento da atualização.
2. **27 expectativas específicas do pollock aprovadas**, incluindo todos os
   valores em comparação à extração tabular da resposta NOAA.
3. Build de uma cópia temporária estável do pacote concluído. A primeira
   tentativa, com diretório de origem chamado ClaRa-dados, falhou no rename
   temporário do Windows; a cópia em `snapshot/clara/` e temporários dentro
   da pasta de verificação resolveram o build.
4. **Testes gerais da cópia temporária aprovados**, com oito skips do FSAdata,
   que não está instalado. O runner carregou explicitamente
   `tests/testthat/helper-dados.R` antes de `devtools::test()`. Uma tentativa
   anterior sem esse carregamento não encontrou os helpers; outra tentativa
   na worktree viva coincidiu com a substituição de D44/D48. Não foram alteradas
   as funções auxiliares nem os dados de outras curadorias para contornar isso.
5. **Instalação em biblioteca temporária e sessão limpa aprovadas**:
   `carregar_dados("pollock_alasca")`, `clara::pollock_alasca` e
   `data("pollock_alasca", package = "clara")` retornaram objetos idênticos.
   Confirmados 523 lances, 91 zeros, D47 novo e catálogo com 61 registros.

**R CMD check completo permanece pendente de resolver o ambiente de bibliotecas.**
A tentativa executada terminou na verificação de dependências: o check não
detectou os Imports, embora `requireNamespace()` os carregue e a instalação
e os testes funcionem. A investigação confirmou que
`installed.packages(noCache = TRUE)` retorna **zero pacotes** nessa instalação,
inclusive para MASS/testthat disponíveis. Não houve alteração na instalação
global do R nem nas bibliotecas. Não se declara check aprovado.

## Como carregar na revisão

### Utilidade e distribuição na instalação — conferência adicional

Registrados na ficha e na ajuda `?pollock_alasca`: mapas de pontos, bolhas
proporcionais, descritiva (incluindo histograma e boxplot), exploração de
CPUE × profundidade e discussão de unidade amostral, estratos e coordenadas.
Também estão explícitos os limites: ano e espécie constantes, dependência
espacial e necessidade de considerar o delineamento para estimar biomassa.

Após gerar novamente a ajuda, uma cópia atual foi instalada com
`R CMD INSTALL` em biblioteca temporária. Instalação concluída com
`DONE (clara)`; uma sessão limpa confirmou as 523 linhas, oito colunas,
91 zeros, as três formas de acesso idênticas e a seção de utilidade na
ajuda instalada. Evidências e script em
`tmp/incorporar-pollock-20261012/verificar-utilidade/` na raiz do ecossistema.

**Os dados acompanham a instalação desta versão da ClaRa**, pois o objeto
está em `data/` e o catálogo registra `fonte_dados = "clara"`. Carregá-lo
não instala outro pacote nem consulta a NOAA. A fonte e o histórico em
`data-raw/` ficam fora da distribuição, conforme `.Rbuildignore`.
O GitHub/main só oferecerá esses dados depois de integrar e publicar o
ramo `dados`; a conferência local não constitui publicação.
O check completo continua com a pendência ambiental descrita acima.

Na worktree de dados:

```r
devtools::load_all("D:/Claude/EAPA-Ecossistema/ClaRa-dados")
pollock <- carregar_dados("pollock_alasca")
summary(pollock[c("cpue_kg_ha", "profundidade_m")])
```

O objeto está disponível no código local da branch `dados`; uma instalação
antiga da main não contém essa substituição. A revisão didática deve conferir
os nomes/unidades, a legenda dos estratos e como representar os zeros no mapa.
