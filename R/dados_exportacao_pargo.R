#' D25 - Pargo: exportação brasileira em formato largo
#'
#' Dados provisórios da passada 1. Unidade amostral: combinação de país, produto e UF, com medidas anuais em colunas.
#'
#' @format Um `data.frame` com 4 linhas e 48 colunas:
#' \describe{
#'   \item{Países}{País de destino da exportação (character).}
#'   \item{Código NCM}{Código NCM do produto (character).}
#'   \item{Descrição NCM}{Descrição do produto na NCM; com rótulos inconsistentes, propositalmente preservados (character).}
#'   \item{Código ISIC Grupo}{Código do grupo ISIC (character).}
#'   \item{Descrição ISIC Grupo}{Descrição do grupo ISIC (character).}
#'   \item{UF do Produto}{Unidade da Federação de origem do produto (character).}
#'   \item{2025 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2025 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2024 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2024 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2023 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2023 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2022 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2022 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2021 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2021 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2020 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2020 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2019 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2019 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2018 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2018 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2017 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2017 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2016 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2016 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2015 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2015 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2014 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2014 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2013 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2013 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2012 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2012 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2011 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2011 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2010 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2010 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2009 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2009 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2008 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2008 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2007 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2007 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2006 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2006 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#'   \item{2005 - Valor US$ FOB}{Valor exportado no ano indicado, em dólares dos EUA, FOB.}
#'   \item{2005 - Quilograma Líquido}{Massa líquida exportada no ano indicado, em quilogramas.}
#' }
#'
#' @details
#' Preservar formato largo e descrições NCM herdadas para exercício. Códigos NCM permanecem texto com zero inicial. Não são 48 variáveis independentes nem 4 anos: há 21 anos em 42 colunas de medidas. Confirmar licença, consulta e abrangência do ano de 2025.
#'
#' @section Adaptações:
#' Cabeçalhos, categorias, valores, linhas e ordem herdados preservados.
#'
#' @source
#' Comex Stat / MDIC; exportação de pargo, 2005–2025; planilha exportada em 05/07/2026.
#' Licença: Fonte pública Comex Stat; licença específica a confirmar.
#' A licença MIT do código não substitui os termos da origem dos dados.
#' Fontes e preparo: data-raw/D25_pargo_exportacao/.
#'
#' @examples
#' summary(exportacao_pargo)
#'
#' @docType data
#' @keywords datasets
"exportacao_pargo"
