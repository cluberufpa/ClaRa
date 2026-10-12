# D50 — Molinésias: carga de parasitos

- Registro: `D50_molinesias_parasitos`; objeto: `molinesias_parasitos`.
- Substituição de `escolares_ausencias` (`MASS::quine`) autorizada pelo professor em 11/10/2026, reutilizando D50. Na data da substituição, o catálogo tinha 60 conjuntos; após a inclusão do D61, tem 61. D45/InsectSprays permanece.
- Fonte: Sheehy e colaboradores (2026), Dryad, DOI 10.5061/dryad.jsxksn0r9; artigo DOI 10.1002/ece3.74288.
- Licença: CC0; consentimento dos autores e contribuintes no README do próprio depósito. MIT continua sendo a licença do código da ClaRa.
- Fontes congeladas em `fonte/`, extraídas do ZIP original encontrado em Downloads. SHA256 conferido pelo script de preparo.
- 128 peixes dissecados, oito colunas. Uma linha por peixe. Preservadas todas as linhas, zeros, extremos e ausências. Não foi incorporado o arquivo comportamental com ensaios repetidos.
- Cinco colunas traduzidas; três derivadas: chave técnica de linha, grupo local/espécie e indicador de infecção. Mantidas as oito colunas da planilha avaliada; revisão fina posterior.
- 31 zeros, máximo 644. Sexo: dois NA; comprimento: dez NA. Os modelos com comprimento usam 118 casos.
- Finalidade principal: binomial negativa com vários preditores. Também permite discutir Poisson/sobredispersão, Kruskal-Wallis e logística de prevalência.
- Limites: observacional, quatro grupos desbalanceados, apenas dois locais, sexo/espécie incompletamente cruzados, sem exposição para offset. Não representa experimento balanceado. Não remover extremos sem evidência de erro.
- Parecer: `docs/AVALIACAO_MOLINESIAS_20261011.md`. A aceitação da fonte não equivale à aprovação final de todas as colunas e categorias; situação no catálogo: provisório.
- Fonte antiga preservada em `data-raw/substituidos/D50_escolares_ausencias/`; seus scripts são históricos e não devem ser executados para regenerar o catálogo atual.
- Reproduzir na raiz do pacote: `source("data-raw/D50_molinesias_parasitos/preparar.R")`.
