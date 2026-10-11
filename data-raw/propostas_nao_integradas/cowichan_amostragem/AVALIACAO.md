# Candidata a substituir walleye_erie — avaliação inicial

Busca solicitada pelo professor em 11/10/2026, após autorizar manter o
walleye_erie completo (132.676 bytes xz). Nenhuma substituição efetuada.

Fonte primária: https://doi.org/10.5061/dryad.6m905qg99
May, Emily; de Haas, Hazel; Sewell, Taylor et al. (2026), publicado em
10/06/2026. Título: Intraspecific variation in the bony traits and elemental
phenotype of a marine and freshwater fish.

Segundo o depósito, Cowichan_Data.xlsx reúne 246 indivíduos de
Gasterosteus aculeatus, cinco populações da drenagem Cowichan, 2022–2023.
Traz sexo, população/local/sub-local, tipo de corpo d'água, massa fresca e
seca, comprimentos total e padrão, caracteres morfológicos e fósforo.
Abas declaradas: Dataset e Metadata. Ausências marcadas como NA.

Inferência didática preliminar: registros individuais e locais podem servir
para AAS e estratificação proporcional, usando o arquivo como população
finita didática. Isso não torna a coleta original uma amostra probabilística
de toda a população natural. Conferir tamanhos dos estratos e ausências
antes de recomendar a troca. Tem menos indivíduos e outra espécie que
walleye_erie; não preserva estudos de idade/maturidade.

Termos primários do Dryad: https://datadryad.org/terms (20/05/2025), seção
1(a): dados publicados sob CC0. Registrar instrumento da versão via
metadados ao conseguir baixar. CC0 dos dados não significa mudar o artigo
ou a documentação do repositório para MIT.

Tamanho informado da planilha: 167,01 KB. Isso é o XLSX bruto, não o
tamanho do objeto R em xz; este ainda não foi medido. Os endpoints públicos
de download da planilha (file_stream/4806532) e README (4806549) retornaram
HTTP 403 tanto na ferramenta web quanto na tentativa direta autorizada.
Portanto os valores, dimensões efetivas, estratos e hash do XLSX ainda
não foram conferidos. Não incorporar até a verificação da fonte.

Alternativas já consultadas e não recomendadas como substituição nova:
WhiteGrunt2 já está no Núcleo 60 e foi reconstruído aproximadamente de
uma figura, segundo a documentação oficial; BGHRfish também já está na
fila, com 266 registros, três espécies e ausências de peso.

Referências oficiais consultadas:
- https://fishr-core-team.github.io/FSAdata/reference/WhiteGrunt2.html
- https://fishr-core-team.github.io/FSAdata/reference/BGHRfish.html
- https://fishr-core-team.r-universe.dev/FSAdata/FSAdata.pdf
  (WalleyeErie2: fonte Ohio DNR, uso não educacional requer permissão).

## Conferência concluída com arquivos do professor — 11/10/2026

Esta seção atualiza a limitação de download acima: o professor forneceu
Cowichan_Data.xlsx e README (1).md de Downloads. Ambos têm exatamente os
hashes SHA256 e tamanhos da versão 446982. Cópias originais preservadas aqui;
README (1).md foi copiado com nome README.md. Licença da versão confirmada
nos metadados da API: https://spdx.org/licenses/CC0-1.0.html.

A aba analítica tem 246 linhas × 34 colunas, sem linhas totalmente repetidas.
A aba do dicionário chama-se Meta-data (o README a chama Metadata).
Sexo: 127 fêmeas e 119 machos; anos: 136 registros de 2022 e 110 de 2023.

| Local | Peixes | Exemplo: amostra proporcional de 60 |
|---|---:|---:|
| Bear Lake | 42 | 10 |
| Cowichan Estuary | 56 | 14 |
| Cowichan Lake | 56 | 14 |
| Cowichan River | 54 | 13 |
| Mesachie Lake | 38 | 9 |

Alocação pelo método dos maiores restos. Para a média de massa fresca,
a variância teórica da amostragem estratificada desta base, com essa
alocação e correção de população finita, é 0,5925 da variância da AAS de
60 registros. Isso é uma comparação descritiva dos dois planos nesta
população didática, não resultado de uma coleta nova ou teste inferencial.

O professor pediu avaliar a candidata e depois manter só as colunas
importantes. Preparado cowichan_para_revisao.xlsx com 246 × 8: id_registro,
ano, local, sublocal, ambiente, sexo, massa_fresca_g e comprimento_total_mm.
Nomes geográficos/códigos preservados; ambiente e sexo traduzidos. Nenhum
peixe excluído, nenhum valor imputado. ID é a ordem original, não marca de campo.
O recorte está completo para essas oito colunas. A fonte integral permanece.
Conferência linha a linha em R e na planilha passou; objeto em xz medido
com **3.504 bytes**, abaixo de 100 KB. Fonte integral serializada na avaliação:
25.176 bytes. A avaliação não alterou data/, catálogo ou instalação da ClaRa.
O R gravou os resultados de sucesso e encerrou com código 1; persiste a
limitação de encerramento do ambiente conhecida nesta sessão. Isso não
equivale a check do pacote aprovado.

Massa fresca: 0,427 a 3,82 g; comprimento total: 36,5 a 70,92 mm.
Na fonte integral, faltam dados de fósforo/digestão/excreção, fora do recorte.
Há um conflito no registro 234 (linha Excel 235): total 51,09 mm e padrão
55 mm. Não decidir por suposição qual medida está errada. Valor total
mantido, com pendência explícita. Usar massa como resposta inicial dos
exercícios; confirmar esse par com os autores antes de exercícios de comprimento.

Recomendação: candidata adequada para substituir o exemplo de amostragem,
com base menor, estratos suficientes e CC0. Não substitui análises de idade
e maturidade do walleye. Usar a base como população finita didática, sem
atribuir amostragem probabilística ao estudo original. A troca definitiva
ainda não foi feita; esta avaliação não aumenta o número de objetos do pacote.
