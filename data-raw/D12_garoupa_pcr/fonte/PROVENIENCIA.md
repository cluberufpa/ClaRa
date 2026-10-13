# Fonte primária

Bowater, R. O. (2015). *Aquatic Animal Health Subprogram: Investigation of an emerging
bacterial disease in wild Queensland grouper, marine fish and stingrays with production of
diagnostic tools to reduce the spread of disease to other states of Australia*. Final report,
February 2015. FRDC Project No. 2010/034. Department of Agriculture, Fisheries and Forestry,
Brisbane. ISBN 978-0-7345-0446-3.

- PDF: <https://www.frdc.com.au/sites/default/files/products/2010-034-DLD.pdf> (também no
  repositório do governo de Queensland, ERA eprint 4891).
- Licença: **Creative Commons Attribution 3.0 Australia (CC BY 3.0)**, declarada na página 2
  do PDF ("All material in this publication is licensed under a Creative Commons Attribution
  3.0 Australia Licence, save for content supplied by third parties, logos and the
  Commonwealth Coat of Arms"). Texto do relatório lido em 13/10/2026.

## O estudo

Desafio experimental por coabitação com *Streptococcus agalactiae* em juvenis de
*Epinephelus lanceolatus* (garoupa-de-Queensland), em duas réplicas (sistemas). Para cada
peixe, os órgãos foram agrupados: o peixe era positivo se cérebro, coração ou baço fossem
positivos por PCR, por bacteriologia ou pela coloração de Gram-Glynn na histologia. O
relatório aplica o teste de McNemar para comparar os métodos (PCR, histologia e
bacteriologia) nos mesmos peixes e conclui que o PCR detecta mais positivos (p < 0,05).

## As contagens transcritas (histologia nas linhas, PCR nas colunas)

Tabela 32, réplica 1 (p. 123 do relatório), n = 74:

|                   | PCR + | PCR − | Total |
|-------------------|------:|------:|------:|
| Histologia +      |    18 |     2 |    20 |
| Histologia −      |    50 |     4 |    54 |
| Total             |    68 |     6 |    74 |

PCR 91,9% e histologia 27,0% de positivos (Tabela 33). χ² de McNemar com correção = 42,48,
p = 7,138e-11, recalculado no R.

Tabela 34, réplica 2 (p. 123), n = 49:

|                   | PCR + | PCR − | Total |
|-------------------|------:|------:|------:|
| Histologia +      |    15 |     3 |    18 |
| Histologia −      |    28 |     3 |    31 |
| Total             |    43 |     6 |    49 |

PCR 87,8% e histologia 36,7% de positivos (Tabela 35).

## Sobre as linhas

O relatório **não publica uma linha por peixe no corpo do texto**: traz as tabelas 2 × 2. Os
resultados por peixe e por órgão (com grupo de tratamento, sinais clínicos e destino do peixe)
estão nos **Apêndices 8 e 9** (páginas 183 e 184 do relatório, 184 e 185 do PDF), em tabelas
com células mescladas que ainda não foram digitalizadas; com elas o conjunto poderia virar
real e ganhar colunas de tanque e tratamento. Por ora, o conjunto da ClaRa expande as
contagens em 123 linhas com identificadores artificiais, embaralhadas com `set.seed()`. A
planilha de partida (`mcnemar_garoupa_pcr_histologia.xlsx`, montada pelo professor) reconstrói
só a réplica 1; a ClaRa usa as 74 linhas dela, na ordem dela (as contagens conferem com a
Tabela 32), e expande a réplica 2 com semente fixa (1202). O código de reprodução da própria
planilha (semente 1201) não reproduz a ordem das linhas dela, que é arbitrária.
Não recuperados: tanque, razão de coabitação, tratamento, órgão e identidade de cada peixe.
