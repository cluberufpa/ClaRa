#' D12 - Cabras: Toxoplasma em soro, sangue e leite
#'
#' Resultado de três exames para *Toxoplasma gondii* nas mesmas 106 cabras
#' leiteiras da Argélia: ELISA indireto no soro e PCR em tempo real no sangue e
#' no leite. Cada linha é uma cabra, e as três colunas de exame são medições
#' pareadas, boas para o teste de McNemar e para a concordância entre exames.
#'
#' @format Um `data.frame` com 106 linhas e 4 colunas:
#' \describe{
#'   \item{id_cabra}{Texto: identificador fictício da cabra (`cabra_001` a `cabra_106`).}
#'   \item{elisa_soro}{Fator: resultado do ELISA no soro, `negativo` ou `positivo`.}
#'   \item{pcr_sangue}{Fator: resultado da PCR no sangue, `negativo` ou `positivo`.}
#'   \item{pcr_leite}{Fator: resultado da PCR no leite, `negativo` ou `positivo`.}
#' }
#'
#' @details **As linhas são reconstruídas.** O artigo de origem não publica uma
#' planilha com uma linha por cabra; publica as tabelas 2 x 2 (Tabelas 1 a 4).
#' Este conjunto foi montado para reproduzir **exatamente** essas tabelas, com a
#' ordem das linhas sorteada e identificadores fictícios. Só as contagens são
#' reais. Nada além delas (rebanho, idade, ordem de coleta) existe aqui.
#'
#' Tabelas reproduzidas (positivo na primeira linha e na primeira coluna):
#'
#' - PCR do sangue x PCR do leite, 106 cabras: 7, 9, 8 e 82 (McNemar, p = 1);
#' - ELISA do soro x PCR do leite: 13, 38, 2 e 53 (p < 0,000001);
#' - ELISA do soro x PCR do sangue: 15, 36, 1 e 54 (p < 0,000001).
#'
#' O exemplo do sangue contra o leite tem 17 pares discordantes, quase iguais
#' (9 e 8), e o McNemar não encontra diferença. Nos exemplos com o ELISA a
#' discordância vai quase toda para um lado, e o teste detecta. O ELISA mede
#' anticorpos (exposição), e a PCR, o DNA do parasito; por isso não são o mesmo
#' fenômeno, e nenhum dos três exames é padrão-ouro.
#'
#' As 106 cabras vêm de 31 rebanhos, e o McNemar trata as cabras como
#' independentes. A PCR do leite exige uma etapa extra de pré-tratamento.
#'
#' @section Adaptações:
#' Tradução dos nomes e dos rótulos para o português; criação dos identificadores
#' fictícios; reconstrução das linhas a partir das tabelas e embaralhamento com
#' semente fixa em `data-raw/D12_cabras_toxoplasma/preparar.R`, que confere as
#' quatro tabelas publicadas. Substitui `erva_marinha_lesoes`.
#'
#' @source Dahmane, A.; Vismarra, A.; Passebosc-Faure, K.; Reghaissia, N.;
#' Baroudi, D.; Samari, H.; Semeraro, M.; Yera, H.; Laatamna, A. (2025). First
#' Molecular Detection of *Toxoplasma gondii* DNA in Blood and Milk of Goats from
#' Algeria. *Pathogens* 14(2):174. \doi{10.3390/pathogens14020174}. Licença CC BY
#' 4.0, conferida em 12/10/2026. Tabelas e preparo em
#' `data-raw/D12_cabras_toxoplasma/`.
#'
#' @examples
#' table(cabras_toxoplasma$pcr_sangue, cabras_toxoplasma$pcr_leite)
#' mcnemar.test(table(cabras_toxoplasma$pcr_sangue, cabras_toxoplasma$pcr_leite))
#' @docType data
#' @keywords datasets
"cabras_toxoplasma"
