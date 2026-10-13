#' D60 - Vacas fistuladas: quadrado latino 4 x 4
#'
#' Fermentação ruminal de quatro vacas leiteiras fistuladas em pastagem, em quatro
#' períodos de 14 dias, num **quadrado latino 4 x 4**: cada uma das quatro dietas aparece
#' uma vez em cada vaca (linhas) e uma vez em cada período (colunas). A dieta é a
#' combinação de dois fatores, a oferta de forragem e o tipo de suplemento (fatorial
#' 2 x 2 dentro do quadrado).
#'
#' @format Um `data.frame` com 16 linhas (uma por vaca e período) e 8 colunas:
#' \describe{
#'   \item{id_vaca}{Texto: identificador da vaca (1844, 2231, 2243, 5182); as linhas do quadrado.}
#'   \item{periodo}{Fator: período de 14 dias, `1` a `4`; as colunas do quadrado.}
#'   \item{oferta_forragem}{Fator: oferta diária de forragem, `20 kg` ou `30 kg` de matéria seca por vaca.}
#'   \item{suplemento}{Fator: `milho úmido` ou `trigo moído`, 3,5 kg de matéria seca por vaca por dia.}
#'   \item{tratamento}{Fator: as quatro combinações de oferta e suplemento; o tratamento do quadrado.}
#'   \item{ph_ruminal}{pH ruminal médio dos sete horários de coleta.}
#'   \item{nh3_n_mmol_l}{Nitrogênio amoniacal (N-NH3) médio, em mmol/L.}
#'   \item{agv_total_mmol_l}{Ácidos graxos voláteis totais médios, em mmol/L.}
#' }
#'
#' @details Cada vaca foi amostrada em sete horários no último dia de cada período. Os
#' horários não são réplicas do quadrado: a unidade do delineamento é a **célula vaca x
#' período**, e por isso o conjunto traz a média dos sete horários. Analisar os 112
#' valores brutos como independentes infla os graus de liberdade do resíduo (102 em vez de 6)
#' e faz o efeito de período parecer muito mais significativo.
#'
#' Modelo do quadrado latino, `aov(ph_ruminal ~ tratamento + id_vaca + periodo)`:
#' tratamento F = 0,18 (p = 0,90), vaca p = 0,69 e **período F = 13,1 (p = 0,005)**. O
#' erro médio cai de 0,080 (ANOVA de um fator, que ignora os blocos) para 0,021. Não há
#' efeito de dieta, mas o bloqueio por período é claro, e é isso que o conjunto mostra.
#' No modelo fatorial do artigo, `ph_ruminal ~ periodo + id_vaca + oferta_forragem *
#' suplemento`, os p da oferta, do suplemento e da interação são 0,810, 0,856 e 0,528, os
#' mesmos relatados na Tabela 4 do artigo; para o N-NH3 são 0,650, 0,416 e 0,728.
#'
#' Com só quatro vacas e 16 observações, o resíduo tem 6 graus de liberdade, e o poder é
#' pequeno. O desenho se transfere à aquicultura como ensaio de cruzamento de dietas, com
#' tanques ou gaiolas nas linhas e períodos nas colunas. Há possível efeito residual de uma
#' dieta sobre o período seguinte, que este quadrado simples não controla.
#'
#' @section Adaptações:
#' Dados do Experimento II do artigo (arquivo `data fistulated cows.xlsx` do Figshare).
#' Tradução dos nomes e dos rótulos; os códigos 1 e 2 da planilha foram resolvidos
#' comparando as médias com a Tabela 4 do artigo (oferta 1 = 20 kg, 2 = 30 kg; suplemento
#' 1 = milho úmido, 2 = trigo moído); médias por célula vaca x período; a VFA tem 25
#' ausências no arquivo bruto e a média usa os horários disponíveis. Receita e
#' conferências em `data-raw/D60_vacas_fistuladas/preparar.R`. Substitui
#' `trigo_quadrado_latino`.
#'
#' @source Merino, V.; Leichtle, S.; Balocchi, O.; Lanuza, F.; Parga, J.; Delagarde, R.;
#' Ruiz-Albarrán, M.; Rivero, M. J.; Pulido, R. (2021). Metabolic and Productive Response
#' and Grazing Behavior of Lactating Dairy Cows Supplemented with High Moisture Maize or
#' Cracked Wheat Grazing at Two Herbage Allowances in Spring. *Animals* 11(4):919.
#' \doi{10.3390/ani11040919}. Dados: Figshare, \doi{10.6084/m9.figshare.13818920.v3},
#' licença CC BY 4.0, conferida em 12/10/2026. Fonte e preparo em
#' `data-raw/D60_vacas_fistuladas/`.
#'
#' @examples
#' summary(aov(ph_ruminal ~ tratamento + id_vaca + periodo, data = vacas_fistuladas))
#' @docType data
#' @keywords datasets
"vacas_fistuladas"
