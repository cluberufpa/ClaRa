#' Catálogo dos conjuntos de dados da ClaRa
#'
#' Uma linha por conjunto, com registro permanente, origem e usos didáticos.
#' Consulte `situacao` e `licenca` antes de distribuir uma cópia.
#'
#' @format Um `data.frame` com as colunas:
#' \describe{
#'   \item{codigo}{Registro permanente no formato D01, D02, etc.}
#'   \item{registro}{Registro curto e nome da pasta de preparo, como D01_bagre_racao.}
#'   \item{nome_eapadados}{Nome anterior no EAPADados; vazio para outras origens.}
#'   \item{nome}{Nome aceito por `carregar_dados()`; dados externos não são objetos copiados na ClaRa.}
#'   \item{fonte_dados}{Fornecedor do conjunto: clara, FSAdata ou MASS.}
#'   \item{rotulo}{Título curto para seleção.}
#'   \item{titulo}{Título completo da ajuda, com o registro.}
#'   \item{natureza}{Natureza do dado: real, agregado, reconstruido ou sintetico.}
#'   \item{origem}{Conjunto ou pacote de origem.}
#'   \item{unidade_amostral}{O que representa cada linha.}
#'   \item{linhas}{Número de observações do objeto.}
#'   \item{colunas}{Número de variáveis do objeto.}
#'   \item{analises}{Análises úteis, separadas por ponto e vírgula.}
#'   \item{analise_principal}{Principal uso didático.}
#'   \item{palavras_chave}{Termos de busca, separados por ponto e vírgula.}
#'   \item{verbo_clara}{Verbos existentes que recebem o conjunto.}
#'   \item{licenca}{Licença localizada ou pendência de autorização.}
#'   \item{referencia}{Referência da fonte, com ressalvas quando necessário.}
#'   \item{situacao}{Estado da curadoria, com vocabulário fixo: \code{provisório}, \code{revisado} ou \code{sintético de treino}.}
#'   \item{limites}{Limites de delineamento e pendências da fonte; vazio quando não há.}
#' }
#'
#' @details
#' Os registros não são renumerados nem reutilizados. O catálogo inclui
#' pendências explicitamente: presença no pacote não confirma licença da
#' fonte. Textos em português usam codificação Latin-1 declarada, preservando
#' os acentos sem strings marcadas como UTF-8 nos arquivos de dados.
#' Os sete conjuntos externos são lidos e traduzidos por `carregar_dados()`.
#'
#' @examples
#' catalogo_dados[, c("codigo", "nome", "analise_principal", "situacao")]
#'
#' @docType data
#' @keywords datasets
"catalogo_dados"
