# Fonte primária

Tabelas 1 a 4 de Dahmane et al. (2025), *First Molecular Detection of
Toxoplasma gondii DNA in Blood and Milk of Goats from Algeria*, **Pathogens**
14(2):174, DOI [10.3390/pathogens14020174](https://doi.org/10.3390/pathogens14020174)
(PMC11858173), licença **CC BY 4.0**, lida no texto completo em 12/10/2026.

O artigo **não publica uma planilha com uma linha por cabra**: a declaração de
disponibilidade diz que os dados estão "sob pedido" ao autor correspondente, e o
suplemento do MDPI (Tabela S1, informações de amostragem) não foi acessível.
Por isso o conjunto da ClaRa é uma **reconstrução** a partir das tabelas.

## As contagens transcritas (106 cabras leiteiras, 31 rebanhos, Mila, Argélia)

Tabela 1, PCR do sangue (linhas) × PCR do leite (colunas), todas as 106 cabras:

|            | leite + | leite − |
|------------|--------:|--------:|
| sangue +   |       7 |       9 |
| sangue −   |       8 |      82 |

McNemar relatado: p = 1; kappa 0,3578.

Tabela 2, as 51 cabras soropositivas no ELISA, sangue × leite:

|            | leite + | leite − |
|------------|--------:|--------:|
| sangue +   |       6 |       9 |
| sangue −   |       7 |      29 |

McNemar relatado: p = 0,8036.

Tabela 3, ELISA do soro (linhas) × PCR do leite (colunas):

|            | leite + | leite − |
|------------|--------:|--------:|
| ELISA +    |      13 |      38 |
| ELISA −    |       2 |      53 |

McNemar relatado: p < 0,000001.

Tabela 4, ELISA do soro × PCR do sangue:

|            | sangue + | sangue − |
|------------|---------:|---------:|
| ELISA +    |       15 |       36 |
| ELISA −    |        1 |       54 |

McNemar relatado: p < 0,000001.

## Por que as quatro tabelas fecham uma tabela tripla única

As Tabelas 1 e 2 dão o sangue × leite entre soropositivas e, por diferença,
entre soronegativas (1, 0, 1 e 53). As Tabelas 3 e 4 conferem as margens dessas
células. A tabela tripla (ELISA, sangue, leite) é única, e a receita
(`preparar.R`) confere as quatro tabelas publicadas contra ela.
