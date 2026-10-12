# Conciliação dos registros de anchova e larvas — 12/10/2026

O professor determinou que conjuntos distintos tenham registros distintos.
A conferência confirmou que os dois objetos não são versões do mesmo dado:

| Registro definitivo | Objeto | Conteúdo | Dimensão | Fonte |
|---|---|---|---|---|
| D61 | anchova_norte_california | Desembarques mensais agregados de todos os portos da Califórnia, 1971–1991 | 252 × 6 | California Department of Fish and Game / NOAA ERDDAP; mesmo objeto curado no EAPADados |
| D62 | larvas_peixes_captura | Eventos de armadilhas luminosas em três enseadas de Santa Catalina, com contagens e duração, 2018–2019 | 58 × 7 | Dale et al., Dryad DOI 10.7291/D1S38T, CC0 |

Anchova serve ao estudo de séries temporais de desembarque; larvas, à relação
entre contagem e esforço de captura. A unidade amostral, período, variáveis,
fonte e observações são diferentes.

## Correção realizada

D61 foi preservado para anchova, como no checkout `ClaRa`. O registro de
larvas, que colidiu provisoriamente com ele em `ClaRa-dados`, passou a D62.
O objeto continua se chamando `larvas_peixes_captura`; não há mudança no nome
usado por `carregar_dados()` nem nos valores.

Em `ClaRa-dados`, foram reunidos os dois objetos e seus registros. A pasta de
larvas agora é `data-raw/D62_larvas_captura/`; anchova está em
`data-raw/D61_anchova_norte/`. Metadados, ficha, preparo, título da ajuda,
catálogo e testes usam os códigos definitivos. As notas anteriores estão
identificadas como histórico. A qualidade e as limitações já documentadas
dos demais conjuntos foram preservadas.

A receita pontual `data-raw/conciliar_registros_20261012.R` permite reproduzir
a conciliação. Ela verifica a identidade dos registros envolvidos, impede
ocupar D62 com outro conjunto, confere que os demais registros não mudaram
e pode ser repetida sem duplicação.

O checkout `ClaRa` continua com seu D61/anchova; a inclusão de D62 nele ocorrerá
na integração da branch `dados`. Esta correção não mescla os demais trabalhos
em andamento no outro checkout.

## Total consolidado

**62 conjuntos, 62 códigos únicos e 62 nomes únicos**, de D01 a D62:

- 53 conjuntos internos;
- oito carregados do FSAdata;
- um carregado do MASS.

O objeto `catalogo_dados` é o índice, não um 63º conjunto. A contagem de 60
correspondia ao núcleo inicial. Cada checkout havia incluído um conjunto
diferente sob D61 e por isso mostrava 61 isoladamente; a união correta é 62.

## Conferência dos dados

Os dois preparos foram executados com verificação das fontes congeladas.
Anchova foi conferida contra o CSV oficial e o objeto curado: 252 datas mensais
completas e desembarques em libras preservados. Larvas foi conferida contra
o CSV Dryad: 58 eventos, contagens inteiras, 15919 larvas no total, oito zeros
e esforço reconstruído de horas e minutos. Não houve imputação, exclusão
ou mistura de observações dos dois conjuntos.

Após repetir a conciliação, os outros 60 registros permaneceram idênticos.
Foram acrescentados testes para carregar ambos, conferir suas dimensões,
período/contagens e garantir D61/anchova e D62/larvas sem colisão.

Logs da validação ficam fora do repositório, em
`C:/Users/evaldoms/.codex/visualizations/2026/10/12/01a13047-d388-7021-9eca-e7a31dd0827c/verificacao-clara-registros/`.

Validação final: `R CMD build --no-manual` e `R CMD check --no-manual
--no-vignettes` concluídos. Instalação, carregamento, dados, documentação e
exemplos aprovados; 0 erros, 0 notas e somente o aviso conhecido de caracteres
não ASCII no código preexistente. No pacote instalado, 726 verificações
passaram, sem falhas ou avisos nos testes; oito testes externos foram pulados
por ausência do FSAdata. `git diff --check` sem erros.
