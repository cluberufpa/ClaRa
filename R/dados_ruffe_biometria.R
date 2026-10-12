#' D56 - Ruffe: biometria e maturidade no rio St. Louis
#'
#' Dados provisórios da passada 1. Unidade amostral: registro de peixe Gymnocephalus cernuus capturado em 1992.
#'
#' @format Um `data.frame` com 738 linhas e 11 colunas:
#' \describe{
#'   \item{id_peixe}{Texto do fish.id decimal original, preservado sem garantir unicidade.}
#'   \item{mes}{Mês numérico da captura.}
#'   \item{dia}{Dia do mês da captura.}
#'   \item{ano}{Ano da captura, 1992.}
#'   \item{id_individuo}{Texto do código indiv original, dentro do ano; repetições preservadas.}
#'   \item{localizacao}{Texto do código original da grade de captura, não coordenada geográfica.}
#'   \item{comprimento_total_mm}{Comprimento total em milímetros.}
#'   \item{peso_g}{Peso em gramas; duas ausências preservadas.}
#'   \item{sexo}{Fator: femea, macho ou desconhecido.}
#'   \item{maturidade}{Estágio categórico traduzido; desconhecido e jovem_ano preservados.}
#'   \item{idade_anos}{Idade por escamas em anos; 726 ausências preservadas.}
#' }
#'
#' @details
#' 738 linhas preservadas, inclusive identificadores repetidos da fonte. fish.id é número decimal: convertido em texto sem arredondar ou criar nova chave; indiv também pode repetir. Confirmar unidade amostral e duplicatas com a fonte antes de usar como identificador único. Idade por escamas disponível em apenas 12 registros (726 NA), peso com 2 NA; não sustenta ajuste de crescimento a todas as 738 linhas. Sexo desconhecido e estágio jovem do ano não significam ausência. Códigos de localização preservados em texto, sem inferir coordenadas. Rever significado biológico dos estágios traduzidos, sobretudo quase maduro/esgotado e jovem do ano.
#'
#' @section Adaptações:
#' fish.id → id_peixe; month → mes; day → dia; year → ano; indiv → id_individuo; location → localizacao; length → comprimento_total_mm; weight → peso_g; sex → sexo; maturity → maturidade; age → idade_anos. id_peixe em texto, mantendo códigos e ausências originais. id_individuo em texto, mantendo códigos e ausências originais. localizacao em texto, mantendo códigos e ausências originais. Categorias de sexo: female → femea, male → macho, unknown → desconhecido. Categorias de maturidade: developing → em_desenvolvimento, immature → imaturo, mature → maduro, nearly.ripe → quase_maduro, nearly.spent → quase_esgotado, recovering → em_recuperacao, ripe → pronto_desova, running → em_desova, spent → esgotado, unknown → desconhecido, yoy → jovem_ano.  Todas as linhas e sua ordem preservadas, sem imputação, exclusão ou simulação. Unidades originais mantidas.
#'
#' @section Leitura do pacote:
#' Adaptado de `FSAdata::RuffeSLRH92`, versão 0.4.1. Autoria do pacote: Derek Ogle.
#' As observações são lidas na hora por `carregar_dados("ruffe_biometria")`.
#' Não há cópia deste conjunto em data/ da ClaRa.
#'
#' @source
#' US Geological Survey, Lake Superior Biological Station, Ashland, Wisconsin, coleção pessoal; FSAdata::RuffeSLRH92.
#' Licença do pacote fornecedor: GPL (>= 2).
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D56_ruffe_biometria/.
#'
#' @examples
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   dados <- carregar_dados("ruffe_biometria")
#'   summary(dados)
#' }
#'
#' @name ruffe_biometria
#' @keywords datasets
NULL
