# Fonte primária

Morrongiello, J. R.; Thresher, R. E. (2014). *Data from: A statistical framework to
explore ontogenetic growth variation among individuals and populations: a marine fish
example*. Dryad. DOI [10.5061/dryad.q9h64](https://doi.org/10.5061/dryad.q9h64).
Artigo: *Ecological Monographs*, DOI 10.1890/13-2355.1. Autores: CSIRO (Austrália).

Licença: **CC0 1.0**, conferida na API do Dryad em 13/10/2026 (campo `license`:
`https://spdx.org/licenses/CC0-1.0.html`). Versão 1, publicada em 28/08/2014.

O depósito tem quatro arquivos: `incrmement measurements.csv` (1,5 MB), `increment
averages.csv`, `environmental data.csv` e `tiger flathead biochronologies.xlsx`. Só o
primeiro entrou aqui. O nome do arquivo tem um erro de digitação na origem
("incrmement") e foi guardado como `incrmement_measurements.csv` (o navegador trocou
o espaço por `+` no download). O conteúdo não foi alterado; o SHA256 está em
`SHA256.txt`.

Colunas do arquivo (22.941 linhas, uma por anel do otólito de cada peixe): `area`,
`FishID`, `sex`, `gear`, `capyear`, `capmonth`, `floorlength` (comprimento em cm,
arredondado para baixo), `AdjAge` (idade ajustada, em anos inteiros), `DeciAge`
(idade decimal), `radius` (raio do otólito, mm), `YOB` (ano de nascimento), `Year`,
`Age` (idade a que o anel corresponde) e `Increment` (largura do anel, mm).

Idades: contagem de incrementos do otólito, combinada com o tipo de borda, a data da
captura e um aniversário nominal em 1 de janeiro (descrição do depósito).

## O que se encontrou ao conferir (13/10/2026)

- 4.318 peixes; as colunas do peixe (comprimento, idade, área, aparelho, ano e mês de
  captura) são constantes dentro de cada peixe.
- Exceção: o **sexo** muda de um anel para outro em 444 peixes (quase todos de 2009 e
  2010; 369 e 66 em cada ano, mais 9 em 2002). Os dois sexos aparecem para o mesmo
  peixe. Não há como saber qual é o certo; no conjunto da ClaRa o sexo desses peixes
  é `NA`.
- 17 peixes sem comprimento; 5 sem raio do otólito.
- Códigos de área `EBS` (3.915 peixes) e `ETAS` (403): o depósito diz que as áreas
  são do sudeste da Austrália; o significado das siglas não foi conferido no artigo.
