#' D04 - Lago Vitória: água sob gaiolas de tilápia
#'
#' Qualidade da água do Lago Vitória (Quênia), em março de 2023 e 2024, em
#' estações de gaiolas de tilápia-do-nilo e em estações de controle, em
#' quatro locais ao longo de um gradiente limnológico.
#'
#' @format Um `data.frame` com 217 linhas e 25 colunas:
#' \describe{
#'   \item{local}{Fator: Dunga, Ndere, Naya e Mfangano, na ordem do gradiente (golfo de Winam, boca do golfo e águas abertas).}
#'   \item{estacao}{Fator: Gaiolas ou Controle.}
#'   \item{id_amostra}{Identificador original da amostra, como texto; repete-se entre profundidades em 2023.}
#'   \item{ano}{Ano da coleta, como fator: 2023 ou 2024.}
#'   \item{profundidade_m}{Profundidade da leitura, em metros.}
#'   \item{profundidade_local_m}{Profundidade total do ponto, em metros; 81 NA, todos de 2024.}
#'   \item{secchi_m}{Transparência do disco de Secchi, em metros.}
#'   \item{temperatura_c}{Temperatura da água, em graus Celsius.}
#'   \item{nitrogenio_total_ugl}{Nitrogênio total, em µg/L, como declarado na fonte.}
#'   \item{fosforo_total_ugl}{Fósforo total, em µg/L.}
#'   \item{nitrato_ugl}{Nitrato, em µg/L.}
#'   \item{nitrito_ugl}{Nitrito, em µg/L.}
#'   \item{fosforo_reativo_ugl}{Fósforo reativo solúvel, em µg/L.}
#'   \item{silica_ugl}{Sílica (dióxido de silício), em µg/L.}
#'   \item{amonio_ugl}{Amônio, em µg/L.}
#'   \item{clorofila_a}{Clorofila a; a fonte declara mg/L, mas os valores (0 a 90) sugerem µg/L: unidade a confirmar.}
#'   \item{alcalinidade_mgl}{Alcalinidade, em mg/L.}
#'   \item{dureza_mgl}{Dureza, em mg/L.}
#'   \item{oxigenio_dissolvido_mgl}{Oxigênio dissolvido, em mg/L.}
#'   \item{condutividade_uscm}{Condutividade elétrica, em µS/cm.}
#'   \item{solidos_dissolvidos_mgl}{Sólidos dissolvidos totais, em mg/L.}
#'   \item{salinidade_ppt}{Salinidade, em partes por mil.}
#'   \item{ph}{pH.}
#'   \item{orp_mv}{Potencial de oxirredução, em mV.}
#'   \item{turbidez_ftu}{Turbidez, em FTU; 24 valores negativos preservados.}
#' }
#'
#' @details
#' Cada linha é uma leitura em uma profundidade, não uma amostra
#' independente: as leituras de uma mesma coluna de água se parecem. Em 2023
#' `id_amostra` identifica um perfil (26 perfis, 136 leituras); em 2024
#' identifica a leitura (81). O desenho é desbalanceado, de 4 a 30 leituras por
#' local, estação e ano. Testes de gaiolas contra controle com as 217 linhas
#' inflam o tamanho da amostra.
#'
#' Condutividade, sólidos dissolvidos e salinidade correlacionam acima de
#' 0,9. As variáveis têm escalas muito diferentes: padronizar antes de uma
#' PCA ou de um agrupamento. Há uma clorofila igual a zero e 24 turbidezes
#' negativas, mantidas como vieram. Conferir no artigo as unidades dos
#' nutrientes antes de compará-los com limites legais.
#'
#' @section Utilidade didática:
#' Ordenação de leituras de água por PCA e agrupamento hierárquico, com
#' estação, local e ano como variáveis qualitativas suplementares e a
#' clorofila a, a transparência ou o fósforo total como quantitativa
#' suplementar. Comparação de gaiolas e controle por local e ano. A inclusão
#' dos dados não acrescenta funções de PCA ou de agrupamento à ClaRa.
#'
#' @section Adaptações:
#' Todas as 217 linhas, na ordem original. Traduzidos os nomes das colunas e
#' os rótulos de estação (Cages, Control); local e estação viram fatores, e o
#' ano também, para não entrar como número. Valores, NA e unidades
#' preservados, sem arredondamento nem reescala.
#'
#' @source
#' Okechi, J.; Peoples, N.; Nyamweya, C.; Orina, P.; Cooperman, M.;
#' Kaufman, L. (2025). Dryad, \doi{10.5061/dryad.qfttdz0t5}. Licença CC0 1.0.
#' Artigo: \doi{10.1016/j.jglr.2025.102576}.
#' Fonte e preparo: data-raw/D04_lago_vitoria/.
#'
#' @examples
#' agua <- carregar_dados("lago_vitoria")
#' # Contar leituras por local e estação, e lembrar que não são independentes.
#' with(agua, table(local, estacao))
#' aggregate(oxigenio_dissolvido_mgl ~ estacao, data = agua, FUN = mean)
#'
#' @docType data
#' @keywords datasets
"lago_vitoria"
