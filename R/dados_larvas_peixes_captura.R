#' D62 - Larvas de peixes: captura e esforço em armadilhas luminosas
#'
#' Contagens reais de larvas de peixes, somadas entre espécies, em três
#' enseadas de Santa Catalina, Califórnia, EUA, em 2018 e 2019.
#'
#' @format Um `data.frame` com 58 linhas e 7 colunas:
#' \describe{
#'   \item{id_evento}{Identificador original do evento de armadilha, como BFC-006.}
#'   \item{data}{Data de instalação da armadilha, classe Date.}
#'   \item{local}{Fator: Big Fisherman's Cove, Cat Harbor e Two Harbors.}
#'   \item{estacao}{Fator: Primavera e Verão; estações do hemisfério norte.}
#'   \item{ano}{Ano de amostragem como fator: 2018 e 2019.}
#'   \item{esforco_h}{Duração por armadilha em horas, reconstruída de horas e minutos da fonte.}
#'   \item{numero_larvas}{Número inteiro de larvas de peixes capturadas, incluindo zeros.}
#' }
#'
#' @details
#' Uma linha representa um evento de armadilha, não uma espécie nem uma
#' localidade independente. Há repetição temporal nos locais. Primavera foi
#' amostrada somente em 2019; a interação completa ano por estação não é
#' estimável. Há capturas muito abundantes: um evento reúne 5739 larvas.
#' Não excluir esses eventos sem evidência de erro.
#'
#' Para Poisson ou binomial negativa, usar a contagem como resposta e
#' `offset(log(esforco_h))` para a exposição. A proporcionalidade entre
#' captura esperada e duração é uma hipótese a avaliar. Há forte
#' superdispersão em ajustes exploratórios de Poisson; o delineamento e a
#' dependência temporal também precisam ser considerados. A CPUE pode ser
#' calculada como `numero_larvas / esforco_h`, em larvas por armadilha-hora.
#' A inclusão dos dados não acrescenta um motor de GLM à ClaRa.
#'
#' @section Adaptações:
#' Todas as 58 linhas, contagens, identificadores e sua ordem foram preservados.
#' Selecionadas sete variáveis; datas convertidas para Date; grupos como fatores;
#' estações traduzidas. Horas calculadas como soak_hours + soak_min/60, evitando
#' o arredondamento da coluna decimal original (diferença máxima de 0,2 minuto).
#' CPUE, variáveis redundantes e cefalópodes não entram. A soma de cefalópodes
#' no CSV (207) diverge do resumo do depósito (205); não altera a soma de
#' larvas de peixes (15919), coincidente com o depósito. Fonte integral preservada.
#'
#' @source
#' Dale, K.; Pilch, E.; Gomes, M.; Laszlo, N.; Mercer, A.; Mehta, R. (2025).
#' Using light traps to assess larval fish and octopus paralarvae diversity
#' and ontogenetic structure around Santa Catalina Island, CA. Dryad.
#' \doi{10.7291/D1S38T}. Arquivo Dale_Light_Trap_Data_Dryad.csv.
#' Licença CC0 1.0, declarada nos metadados do Dryad.
#' Artigo associado: \doi{10.5343/bms.2024.0135}.
#' Fontes e preparo: data-raw/D62_larvas_captura/.
#'
#' @section Usos secundários:
#' Kruskal-Wallis: `comparar_medianas(larvas_peixes_captura, numero_larvas,
#' local)` compara os três locais. O esforço varia entre eventos: para
#' comparar taxas, crie antes `numero_larvas / esforco_h` e compare essa
#' coluna.
#'
#' @examples
#' larvas <- carregar_dados("larvas_peixes_captura")
#' with(larvas, table(local, estacao))
#' summary(larvas$esforco_h)
#' with(larvas, numero_larvas / esforco_h)
#'
#' @docType data
#' @keywords datasets
"larvas_peixes_captura"
