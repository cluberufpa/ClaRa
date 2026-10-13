# Fonte primária

Matchette, S. R.; Herbert-Read, J. E. (2021). *Dynamic visual noise promotes social
attraction, but does not affect group size preference, in a shoaling fish*. **Animal
Behaviour** 177:39–48, DOI [10.1016/j.anbehav.2021.04.017](https://doi.org/10.1016/j.anbehav.2021.04.017).

Dados: Dryad, DOI [10.5061/dryad.sj3tx962p](https://doi.org/10.5061/dryad.sj3tx962p),
versão de 20/05/2021, licença CC0 1.0. O ZIP `doi_10_5061_dryad_sj3tx962p__v20210520.zip`,
baixado pelo professor em 13/10/2026, contém os dois arquivos preservados aqui sem
alteração: `final_statistics.txt` (576 linhas, separado por tabulação) e `readme.txt`
(dicionário das colunas).

`ruido_visual_quadrado_latino_4x4.xlsx` é a planilha arrumada que o professor entregou
(aba `Dados`, 576 x 15, e aba `Documentacao`). Ela não é a fonte do conjunto: a receita
gera tudo a partir do TXT e usa a planilha só para conferir peixe, sequência, período,
distância e tamanho.

O experimento: 144 esgana-gatas (*Gasterosteus aculeatus*) focais, dois por ensaio em
arenas simultâneas (72 ensaios), cada um exposto a quatro vídeos de ruído visual dinâmico
(estático, lento, médio e rápido; códigos 0, 1, 4 e 6 no arquivo) entre dois cardumes de
estímulo de tamanhos diferentes. A ordem dos vídeos seguiu uma de quatro sequências
(`playback.order`, a–d) que formam um quadrado latino 4 x 4 (Tabela A1 do artigo):

| Sequência | Período 1 | Período 2 | Período 3 | Período 4 |
|---|---|---|---|---|
| A | lento | médio | rápido | estático |
| B | rápido | estático | lento | médio |
| C | estático | rápido | médio | lento |
| D | médio | lento | estático | rápido |

O arquivo não tem a coluna de período; ela foi reconstruída por essa tabela, e a receita
confere que as quatro linhas de cada peixe no arquivo original já estão nessa ordem.
A distância em mm é `dist / pxpermm` (calibração de cada vídeo).
