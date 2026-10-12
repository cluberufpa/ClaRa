#' D17 - Solha-europeia: CPUE e ambiente no Báltico
#'
#' CPUE de solha-europeia, \emph{Platichthys flesus}, e condições ambientais
#' de arrastos ou estações no Mar Báltico. O conjunto é o recorte explícito de
#' todas as observações de 2008 no quarto trimestre do arquivo aberto da Dryad.
#' Foi curado para introduzir regressão linear múltipla na Trilha.
#'
#' @format Um `data.frame` com 179 linhas e 9 colunas:
#' \describe{
#'   \item{linha_fonte}{Posição da observação em `Flounder.csv`; usar somente
#'   para rastreabilidade.}
#'   \item{cpue_g}{Captura por unidade de esforço, em gramas, preservada da fonte.}
#'   \item{log_cpue_g}{`log1p(cpue_g)`; resposta recomendada para o modelo.}
#'   \item{temperatura_fundo_c}{Temperatura de fundo, em graus Celsius.}
#'   \item{salinidade}{Salinidade, na unidade da fonte.}
#'   \item{oxigenio_dissolvido_mg_l}{Oxigênio dissolvido, na unidade declarada pela fonte.}
#'   \item{profundidade_m}{Profundidade, em metros.}
#'   \item{latitude_graus}{Latitude em graus decimais.}
#'   \item{longitude_graus}{Longitude em graus decimais.}
#' }
#'
#' @details
#' A fonte contém 9.764 observações de solha. Foram selecionadas todas as 179
#' linhas com `year == 2008` e `quarter == 4`, sem exclusão adicional. A CPUE
#' tem 37 zeros e forte assimetria; por isso, a resposta didática é
#' `log_cpue_g = log1p(cpue_g)`. O modelo com os seis preditores ambientais e
#' espaciais tem R² de aproximadamente 0,646 e VIF máximo de aproximadamente
#' 4,21. Salinidade e longitude têm correlação de aproximadamente -0,67.
#'
#' A curadoria serve para ensino e não sustenta inferência para todo o Mar
#' Báltico. Ano e trimestre são constantes; não há fator categórico para usar
#' no modelo. Latitude e longitude descrevem associação espacial, não efeito
#' causal.
#'
#' @section Utilidade didática:
#' Regressão linear múltipla, transformação de resposta com zeros, correlação,
#' VIF, seleção de preditores, diagnóstico de resíduos e influência.
#'
#' @source
#' Data cod flounder. Dryad Digital Repository,
#' \doi{10.5061/dryad.kb2f352}, CC0 1.0. Artigo associado:
#' \doi{10.1111/jbi.13510}. Fonte e preparo:
#' `data-raw/D17_solha_baltico/`.
#'
#' @examples
#' solha <- carregar_dados("solha_baltico_2008_t4")
#' ajuste <- lm(log_cpue_g ~ temperatura_fundo_c + salinidade +
#'   oxigenio_dissolvido_mg_l + profundidade_m + latitude_graus +
#'   longitude_graus, data = solha)
#' summary(ajuste)$r.squared
#'
#' @docType data
#' @keywords datasets
"solha_baltico_2008_t4"
