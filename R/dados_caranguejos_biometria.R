#' D16 - Caranguejos de Bragança: biometria por local, sexo e estação
#'
#' Dados provisórios da passada 1. Unidade amostral: registro de indivíduo; identificação da coleta a confirmar.
#'
#' @format Um `data.frame` com 993 linhas e 5 colunas:
#' \describe{
#'   \item{local}{Local de captura: Ajuruteua ou Caratateua.}
#'   \item{sexo}{Fator: fêmea ou macho.}
#'   \item{estacao}{Fator: chuvosa ou seca.}
#'   \item{largura_carapaca}{Largura da carapaça; unidade pendente de confirmação.}
#'   \item{comprimento_carapaca}{Comprimento da carapaça; unidade pendente de confirmação.}
#' }
#'
#' @details
#' Unidades das medidas, autoria, licença e protocolo a confirmar. A ajuda herdada declara mm, mas a decisão de curadoria mantém unidade pendente, portanto nomes sem sufixo de unidade. Preservar as 551 linhas repetidas; não excluir registros sem identificação da coleta. Nome definitivo sugerido: caranguejos_biometria.
#'
#' @section Adaptações:
#' Decisão anterior aprovada: Local/Sexo/Estacao/LC/CC → local/sexo/estacao/largura_carapaca/comprimento_carapaca; Fêmea/Macho → fêmea/macho; Chuvosa/Seca → chuvosa/seca. Unidade pendente, sem sufixo inventado.
#'
#' @source
#' Estudo de campo em Bragança, PA; referência bibliográfica a completar.
#' Licença: Não localizada; créditos e autorização a completar.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D16_caranguejos_biometria/.
#'
#' @examples
#' summary(caranguejos_biometria)
#'
#' @docType data
#' @keywords datasets
"caranguejos_biometria"
