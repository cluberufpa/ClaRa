# Carregar dados ----

# carregar_dados() ----
#' Qual conjunto de dados você quer estudar?
#'
#' Carrega um conjunto do catálogo da ClaRa. Os dados próprios vêm da ClaRa;
#' os nove conjuntos de pacotes são lidos do FSAdata ou MASS e traduzidos
#' pela receita em `R/dados_pacotes.R`, sem cópia das observações na ClaRa.
#'
#' @param nome Nome do conjunto no `catalogo_dados`, entre aspas.
#'
#' @return Um `data.frame`, com os nomes, tipos e categorias documentados
#' na ajuda do conjunto. A função não instala pacotes nem cria objetos no
#' ambiente de trabalho; atribua o retorno a um nome.
#'
#' @details
#' A coluna `fonte_dados` do catálogo indica se a origem é `clara`,
#' `FSAdata` ou `MASS`. Se o pacote externo faltar, a mensagem informa
#' como instalá-lo. Somente os conjuntos aprovados no catálogo são oferecidos.
#' Para os dados externos, use esta função em vez de `data()` ou `clara::nome`.
#' As licenças dos dados continuam sendo as dos respectivos fornecedores.
#'
#' @examples
#' bagres <- carregar_dados("bagre_racao_isoproteica")
#' head(bagres)
#' if (requireNamespace("FSAdata", quietly = TRUE)) {
#'   snapper <- carregar_dados("snapper_hg")
#'   head(snapper)
#' }
#'
#' @concept Carregar dados
#' @export
carregar_dados <- function(nome) {
  # Pedimos um único nome para procurar no catálogo.
  if (!is.character(nome) || length(nome) != 1L || is.na(nome) || !nzchar(nome)) {
    stop("Informe um nome entre aspas, por exemplo carregar_dados(\"snapper_hg\").", call. = FALSE)
  }
  # Lemos o catálogo da mesma instalação que fornece a função.
  catalogo <- getExportedValue("clara", "catalogo_dados")
  # Conferimos se o conjunto faz parte dos exemplos aprovados.
  if (!is.element(nome, catalogo$nome)) {
    stop("Conjunto não encontrado: ", nome, ". Consulte catalogo_dados$nome.", call. = FALSE)
  }
  # Os conjuntos próprios continuam disponíveis nos dados da ClaRa.
  if (catalogo$fonte_dados[match(nome, catalogo$nome)] == "clara") {
    return(getExportedValue("clara", nome))
  }
  # Procuramos a receita que identifica o pacote e a tradução.
  receita <- receitas_dados_pacotes[[nome]]
  # Explicamos como instalar a fonte quando ela ainda não está disponível.
  if (!requireNamespace(receita$pacote, quietly = TRUE)) {
    stop("Para carregar ", nome, ", instale o pacote ", receita$pacote,
         ": install.packages(\"", receita$pacote, "\"). Depois repita carregar_dados(\"",
         nome, "\").", call. = FALSE)
  }
  # Lemos o objeto original do pacote fornecedor.
  brutos <- getExportedValue(receita$pacote, receita$objeto)
  # Aplicamos somente a receita de tradução registrada para este conjunto.
  receita$traduzir(brutos)
}
