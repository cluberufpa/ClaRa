# D47 — Pollock: CPUE e profundidade no Alasca

Substituição de `terremotos_fiji` autorizada pelo professor em 12/10/2026.
Registro `D47_pollock_alasca`; objeto `pollock_alasca`, **523 linhas × 8 colunas**.
O D47 foi reutilizado; o catálogo permanece com 61 registros, preservando os outros 60.
Fontes, receita, documentação e objeto antigos estão em
`../substituidos/D47_terremotos_fiji/`, como histórico fora do pacote distribuído.

## Fonte e licença

NOAA/NMFS Office of Science and Technology (2026),
[Survey Catch-per-unit-effort CURRENT, InPort 69743](https://www.fisheries.noaa.gov/inport/item/69743),
DisMAP; dados do Alaska Fisheries Science Center, Golfo do Alasca, 2023.
Relatório associado: *Data Report: 2023 Gulf of Alaska bottom trawl survey* (2024),
[DOI 10.25923/gbb1-x748](https://doi.org/10.25923/gbb1-x748).

**CC0 1.0**, declarada em Access Information → Data License no próprio catálogo.
A página completa está congelada em `fonte/noaa_pagina.html`.
A licença MIT do código da ClaRa não substitui a licença da fonte.
O aluno carrega os dados sem internet; o preparo usa apenas arquivos locais.

Consulta em 12/10/2026 à
[camada GOA](https://services2.arcgis.com/C8EMgrsFcRFL6LrL/arcgis/rest/services/GOA_Sample_Locations_CURRENT/FeatureServer/0),
com `Year=2023 AND CommonName LIKE '%pollock%'`, `outFields=*`,
`returnGeometry=true`, `outSR=4326`, formato JSON. Todos os retornos são
*Gadus chalcogrammus*. Não há indicador de truncamento. O serviço CURRENT muda:
o catálogo textual menciona fevereiro de 2026, mas a camada consultada se
identifica como `Gulf of Alaska Sample Locations 20260601`.

Resposta integral em `fonte/noaa_pollock_2023_wgs84.json`; metadados da camada e
do serviço, página da licença e código oficial de compilação preservados.
O CSV de conferência é uma **extração tabular da resposta JSON**, feita na busca;
não é uma segunda fonte independente. Os hashes estão em `fonte/SHA256.txt`.
`preparar.R` confere o SHA-256 da resposta antes de gerar o objeto.

## Unidade e de-para

Uma linha representa um lance da pesquisa, para a espécie e o ano selecionados.
São 523 IDs e 523 pares de coordenadas distintos. A ordem da resposta é preservada;
nenhuma linha é removida, imputada, agrupada, deslocada ou simulada.

| Origem | Destino | Tratamento |
|---|---|---|
| SampleID | id_lance | texto; sinais negativos preservados, sem sentido de quantidade |
| Year | ano | fator, nível 2023 |
| Species | especie | fator, nível Gadus chalcogrammus; nome científico preservado |
| geometry.y, resposta EPSG:4326 | latitude_graus | graus decimais WGS84 |
| geometry.x, resposta EPSG:4326 | longitude_graus | graus decimais WGS84; oeste negativo |
| Depth | profundidade_m | valores em metros, sem conversão |
| WTCPUE | cpue_kg_ha | peso por área varrida, kg/ha, sem transformação |
| Stratum | estrato | fator com os 54 códigos originais |

O código oficial `Compile_Dismap_Current.R` renomeia `depth_m` e `cpue_kgha`
para as variáveis distribuídas. Os 91 zeros permanecem. CPUE: mínimo 0,
mediana 2,52302846, máximo 1345,89633822 kg/ha. Profundidade: 19–584 m,
mediana 129 m. Nenhum NA nas oito colunas. Latitude: 52,463480–60,271130;
longitude: −169,898030–−133,138620 (limites aqui arredondados).

A geometria WGS84 difere dos campos Latitude/Longitude em menos de 5e-8 grau.
Não usar o x/y nativo projetado do serviço como longitude/latitude.
O `MapValue` da fonte é raiz cúbica da CPUE e não entra no objeto; tampouco
`Season` (523 strings vazias), `StratumArea` (523 ausências), `StdTime`
(constante, sem data real individual) ou campos redundantes de apresentação.
Esses campos continuam acessíveis na fonte. O DisMAP já padronizou e preencheu
zeros; esta não é uma tabela bruta de captura em kg.

## Uso didático e conferência cartográfica

| Utilidade | Pergunta ou aprendizagem | Cuidados |
|---|---|---|
| Mapa de pontos | Onde foram realizados os lances? | Usar WGS84 e contorno do Alasca; revisar os dois pontos costeiros sinalizados. |
| Bolhas proporcionais | Onde se concentram as maiores CPUEs? | Área proporcional à CPUE; representar os 91 zeros separadamente. |
| Resumos, histograma e boxplot | Como a CPUE e a profundidade se distribuem? | Examinar assimetria e valores extremos; não excluir zeros nem capturas altas por conveniência. |
| Dispersão CPUE × profundidade | A captura por área varrida varia com a profundidade? | Exploração observacional; não assumir linearidade, causalidade ou independência espacial. |
| Planejamento e preparo | O que são lance, estrato, coordenadas e esforço padronizado? | Os códigos de estrato são categorias; a média simples não estima automaticamente a biomassa do Golfo. |

Ano e espécie são constantes: este recorte não serve para comparações entre
anos ou espécies. Os usos cartográficos descrevem possibilidades do conjunto,
não funções de mapas já implementadas na ClaRa. A utilidade também consta
da ajuda instalada, em `?pollock_alasca`.

Mapa de pontos, bolhas proporcionais, descritiva e dispersão CPUE × profundidade.
Pergunta: onde ocorreram os maiores valores de CPUE de pollock em 2023, e como
eles se relacionam com a profundidade? Usar o contorno do Alasca.
Área da bolha proporcional à CPUE; representar também os zeros como pontos.
Ano e espécie são constantes. Os 54 estratos deixam a legenda extensa;
eventuais classes de profundidade devem ser apresentadas como derivação do aluno,
sem reinterpretar os códigos originais. Não foi criado um motor de mapas na ClaRa.

Conferência em 12/10/2026 com `sf`, Natural Earth **Land 1:10 milhões, v5.1.1**,
geometrias válidas e transformação de pontos e terra para EPSG:3338:

| id_lance | Latitude original | Longitude original | Profundidade | CPUE | Distância à borda terrestre |
|---|---|---|---|---|---|
| -22483 | 57,53938 | −156,01738 | 32 m | 0 kg/ha | aproximadamente 49 m |
| -22558 | 57,85557 | −152,81519 | 25 m | 19,37255522 kg/ha | aproximadamente 459 m |

Esses dois pontos interceptam o polígono de terra; os outros 521 não.
O contorno é generalizado: a interseção não prova erro de coordenada da NOAA.
**Os dois pontos foram mantidos, sem correção inventada.** Conferência com costa
mais detalhada e/ou metadados do lance permanece como pendência cartográfica.
[Fonte do contorno](https://www.naturalearthdata.com/downloads/10m-physical-vectors/10m-land/).
Não foi localizada declaração de censura de coordenadas por sensibilidade;
isso não demonstra ausência de generalização na origem.

A pesquisa usa estratos e pode ter dependência espacial. Comparações entre
estratos são observacionais; a média simples de CPUE não é estimativa automática
de biomassa do Golfo. Preservar capturas extremas e zeros.

## Validação

Preparo com conferência de hash, EPSG:4326, dimensões, IDs, coordenadas, zeros e
categorias; substituição exclusiva do D47, preservando os demais registros.
Ajuda gerada por roxygen2; testes específicos com comparação de cada coluna à
extração tabular preservada. Resultado da instalação e verificação do pacote:
`docs/INCORPORACAO_POLLOCK_20261012.md`.

Busca inicial e comparação de quatro candidatos:
`TRILHA/docs/prompts_busca/resultados/06_pontos_com_coordenadas/PARECER.md`.
