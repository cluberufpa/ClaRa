#' D47 - Pollock: CPUE e profundidade no Alasca
#'
#' Captura por unidade de esforço de pollock, Gadus chalcogrammus, em
#' 523 lances de pesquisa no Golfo do Alasca em 2023, distribuídos pela NOAA.
#'
#' @format Um `data.frame` com 523 linhas e 8 colunas:
#' \describe{
#'   \item{id_lance}{Identificador original SampleID, como texto; os sinais negativos fazem parte do código.}
#'   \item{latitude_graus}{Latitude em graus decimais WGS84 (EPSG:4326).}
#'   \item{longitude_graus}{Longitude em graus decimais WGS84; negativa a oeste.}
#'   \item{profundidade_m}{Profundidade do lance em metros, campo Depth da fonte.}
#'   \item{cpue_kg_ha}{Captura em peso por área varrida, kg/ha, campo WTCPUE da fonte; inclui 91 zeros.}
#'   \item{estrato}{Estrato amostral como fator; 54 códigos originais, sem interpretação numérica.}
#' }
#'
#' @details
#' Uma linha representa um lance para esta espécie e ano. São 523 pares de
#' coordenadas distintos; não há valores faltantes nas oito colunas.
#' A CPUE varia de 0 a 1345,89633822 kg/ha; profundidade de 19 a 584 metros.
#' A amostragem é estratificada e pode ter dependência espacial. A média
#' simples dos lances não estima automaticamente a biomassa de todo o Golfo.
#'
#' A área da bolha deve seguir cpue_kg_ha, por exemplo com
#' `ggplot2::scale_size_area()`. Os zeros precisam aparecer como pontos
#' adicionais, pois bolhas de área zero desaparecem. Os 54 estratos exigem
#' cuidado com a legenda; ano e espécie são constantes neste recorte.
#' A costa de referência é a do Alasca, não a do Brasil.
#' A inclusão dos dados não acrescenta funções de mapas à ClaRa.
#'
#' @section Utilidade didática:
#' Mapas de pontos mostram a distribuição dos lances de pesquisa. Bolhas
#' proporcionais permitem localizar concentrações de CPUE, mantendo os zeros
#' visíveis em uma camada de pontos. A estatística descritiva, o histograma
#' e o boxplot ajudam a estudar assimetria, zeros e capturas extremas.
#' A dispersão de CPUE por profundidade permite explorar uma associação
#' ambiental, sem pressupor uma relação linear ou causal.
#'
#' O conjunto também permite discutir unidade amostral, coordenadas WGS84,
#' esforço padronizado e amostragem estratificada. Ano e espécie têm um
#' único nível: não permitem comparar anos nem espécies. Não usar os lances
#' como réplicas independentes de um experimento; inferência espacial e
#' estimativa de biomassa exigem considerar o delineamento da pesquisa.
#' Os mapas são usos dos dados em ferramentas externas; esta inclusão não
#' implementa esses gráficos na ClaRa.
#'
#' @section Adaptações:
#' Consulta por Year = 2023 e CommonName contendo pollock. Todas as 523 linhas
#' retornadas, sua ordem, identificadores, CPUE, profundidades e zeros foram
#' preservados. Cabeçalhos traduzidos; ano, espécie e estrato como fatores.
#' Coordenadas extraídas da geometria solicitada em EPSG:4326; diferem dos
#' campos decimais originais por menos de 0,00000005 grau.
#' Não foram agrupados pontos nem criadas classes de profundidade.
#'
#' MapValue (raiz cúbica da CPUE), campos redundantes, Season (vazio),
#' StratumArea (ausente) e StdTime (constante, sem data real de cada lance)
#' ficaram apenas na fonte preservada. O serviço CURRENT é mutável;
#' a cópia local identifica a camada 20260601 consultada em 12/10/2026.
#' Substitui terremotos_fiji (datasets::quakes), mantendo o código D47.
#'
#' @source
#' NOAA/NMFS Office of Science and Technology (2026).
#' Survey Catch-per-unit-effort CURRENT, DisMAP; dados de pesquisa do
#' Alaska Fisheries Science Center, Golfo do Alasca, 2023.
#' \url{https://www.fisheries.noaa.gov/inport/item/69743}.
#' Licença CC0 1.0, declarada em Access Information / Data License.
#' Relatório associado: Data Report: 2023 Gulf of Alaska bottom trawl survey
#' (2024), \doi{10.25923/gbb1-x748}.
#' Consulta, fonte original, licença, hashes e preparo:
#' data-raw/D47_pollock_alasca/.
#'
#' @examples
#' pollock <- carregar_dados("pollock_alasca")
#' summary(pollock[c("cpue_kg_ha", "profundidade_m")])
#' sum(pollock$cpue_kg_ha == 0)
#' head(table(pollock$estrato))
#'
#' @docType data
#' @keywords datasets
"pollock_alasca"
