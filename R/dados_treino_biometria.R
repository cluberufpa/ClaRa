#' D11 - Biometria de pescado: DADOS SINTÉTICOS DE TREINO
#'
#' Peixes fictícios medidos em coletas em Ajuruteua, Bragança e Caratateua, com
#' **defeitos de propósito** para praticar o preparo de dados: texto escrito de
#' vários jeitos, valores ausentes, linhas duplicadas, uma coluna que junta duas
#' informações e a data guardada como texto. Não use para inferência.
#'
#' @format Um `data.frame` com 71 linhas (uma por peixe) e 10 colunas:
#' \describe{
#'   \item{id}{Texto: identificador do registro; repete nas linhas duplicadas.}
#'   \item{especie}{Texto: espécie, escrita de vários jeitos (`corvina`, `Corvina `, `Pescada  Amarela`).}
#'   \item{local}{Texto: praia ou município, com caixa e espaços inconsistentes.}
#'   \item{sexo}{Texto: `f`, `F` ou `Femea`; `m`, `M` ou `Macho`.}
#'   \item{amostra}{Texto: local e estação juntos, como `Caratateua_Seca`.}
#'   \item{data_coleta}{Texto: data no formato `dd/mm/aaaa`.}
#'   \item{comprimento_cm}{Comprimento total, em cm; 5 ausentes.}
#'   \item{peso_g}{Peso, em g; 6 ausentes.}
#'   \item{cpue}{Captura por unidade de esforço, em escala própria.}
#'   \item{profundidade_m}{Profundidade da coleta, em m.}
#' }
#'
#' @details Que coluna exercita cada recurso do preparo (aba `guia` da planilha):
#' \itemize{
#'   \item dados faltantes: `comprimento_cm`, `peso_g`;
#'   \item dicotomizar uma numérica: `comprimento_cm >= 25` (maturo);
#'   \item dicotomizar uma categórica: `sexo` (fêmea) ou `especie`;
#'   \item padronizar (escore z, normalizar 0-1): `comprimento_cm`, `peso_g`, `cpue`;
#'   \item classes de tamanho: `comprimento_cm`;
#'   \item remover duplicatas: a linha inteira (há três);
#'   \item padronizar texto: `especie`, `local`, `sexo`;
#'   \item variável calculada: fator de condição, `100 * peso_g / comprimento_cm^3`;
#'   \item reescalar: `peso_g` de g para kg;
#'   \item separar coluna: `amostra` em local e estação (separador `_`);
#'   \item tabela de contingência: `especie` x `local` ou `sexo` x `local`.
#' }
#' Os espaços nas pontas dos textos são parte do exercício; ao ler a planilha
#' original, use `readxl::read_excel(..., trim_ws = FALSE)` para não perdê-los.
#'
#' @section Adaptações:
#' Aba `biometria` da planilha `Treino-Transformacoes.xlsx`, sem correção de
#' nenhum defeito; só `id` passa a texto, pela convenção de identificadores. A aba
#' `desembarques_largo` não entrou: o exercício de empilhar é o de
#' [treino_desembarque]. Receita em `data-raw/D11_treino_biometria/preparar.R`.
#'
#' @source Dados fictícios do ecossistema EAPA, criados pelo professor para a
#' Trilha (antes CatalyseR). Fonte e preparo em `data-raw/D11_treino_biometria/`.
#'
#' @examples
#' table(treino_biometria$sexo)
#' sum(duplicated(treino_biometria))
#' @docType data
#' @keywords datasets
"treino_biometria"
