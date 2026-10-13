#' D01_bagre_racao - Peso médio final de bagres por ração isoproteica
#'
#' Adaptado de `EAPADados::isoproteica_bagre`: 19 observações sob quatro
#' rações comerciais isoproteicas, apresentadas na Tabela 7.4 de Bhujel
#' (2011), segundo a documentação do EAPADados.
#'
#' @format Um `data.frame` com 19 linhas e 2 colunas:
#' \describe{
#'   \item{racao}{Fator nominal, com níveis A, B, C e D nessa ordem.
#'     Identifica as quatro rações; os códigos originais foram preservados.}
#'   \item{peso_g}{Peso médio final dos peixes por gaiola, em
#'     gramas, conforme a documentação de origem. Não é ganho de peso nem
#'     peso individual de cada peixe.}
#' }
#'
#' @details
#' A unidade observacional é a gaiola, representada pelo peso médio final
#' dos peixes, conforme a documentação recebida. Há 5, 5, 4 e 5 observações
#' nos grupos A, B, C e D. São dados descritos na origem como reais;
#' cada valor é uma média por unidade experimental, não uma réplica de peixe.
#'
#' **Adaptações.** A aba `src_isoproteica` da fonte local foi preservada.
#' `Ração` passou a `racao` e `Peso` a `peso_g`; esses são
#' também os nomes do objeto anterior no EAPADados. As categorias A a D, os 19
#' valores e sua ordem foram mantidos. Nenhuma linha ou coluna foi removida,
#' nenhum valor foi imputado e não há valores ausentes. Não houve conversão
#' de unidade nem cálculo de novas medidas. O objeto final é um `data.frame`
#' simples, com grupo como fator nominal e resposta como número.
#'
#' **Limites da fonte.** A documentação anterior diverge entre quatro
#' gaiolas por ração e cinco réplicas planejadas. O original ainda precisa
#' ser conferido para homologar esse detalhe; não inferir números de peixes
#' nem replicação entre tanques a partir desta tabela. A inferência entre
#' rações pressupõe unidades experimentais independentes. O conjunto não
#' permite estudar crescimento ao longo do tempo nem ganho de peso.
#'
#' **Licença e autorização.** Não há licença pública. O professor aprovou a
#' curadoria em 11/10/2026 e autorizou, em 12/10/2026, o uso interno na Trilha e
#' na ClaRa (dados de pesquisa e coleta do grupo). Isso não é uma licença
#' pública nem indica que os dados estejam licenciados sob MIT.
#'
#' A preparação reproduzível e o histórico completo estão em
#' `data-raw/D01_bagre_racao/` no repositório da ClaRa.
#'
#' @source
#' Bhujel, R. C. (2011). *Statistics for Aquaculture*. Tabela 7.4, p. 103,
#' conforme referência da documentação do EAPADados. O original não foi
#' conferido nesta migração. Fonte local: `dados_brutos_eapadados.xlsx`,
#' aba `src_isoproteica`, e documentação `data_isoproteica_bagre.R`.
#'
#' @examples
#' # O peso médio final difere entre as quatro rações?
#' resultado <- comparar_medias(
#'   dados = bagre_racao_isoproteica,
#'   resposta = peso_g,
#'   grupos = racao,
#'   rotulo_resposta = "Peso médio final (g)",
#'   rotulo_grupos = "Ração",
#'   confianca = 0.95,
#'   variancias_iguais = TRUE,
#'   alternativa = "bilateral",
#'   mostrar_codigo = FALSE
#' )
#' resultado$resumo
#' resultado$anova
#'
#' @docType data
#' @keywords datasets
"bagre_racao_isoproteica"
