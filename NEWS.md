# clara (em desenvolvimento)

- D52 passa a `secagem_bagre` (10 x 6, CC BY 4.0), por decisão do professor (13/10/2026): o código vago volta a
  ter uma curva de secagem, agora de pescado. Ohijeagbon et al. (2018, *Data in Brief* 18:641-647): um lote de
  bagres-africanos eviscerados num secador a gás a 80 °C, pesado de hora em hora de 0 a 540 min (8,53 -> 2,03 kg).
  Com a massa relativa, o modelo de Page vence o de Lewis e a reta (k = 0,00242 por minuto, n = 1,42). É uma só
  curva, sem réplicas: ensina o primeiro `nls()` e a comparação de modelos, não o efeito da temperatura. A
  umidade publicada não fecha com as massas e fica só para discussão. Catálogo com 53 conjuntos.

- Sai o D52 `secagem_beterraba_gengibre` (13/10/2026), por decisão do professor: é de vegetais, e há muitos
  estudos de secagem de pescado. O conjunto ensinava regressão não linear com curvas de secagem (razão de umidade
  ao longo do tempo). O código D52 fica vago até a busca de um substituto com pescado
  (`TRILHA/docs/prompts_busca/14_secagem_pescado.md`); fonte, receita, `.rda` e ajuda vão para
  `data-raw/substituidos/D52_secagem_vegetais/`, e a arrumação leve deixa de tocar nele. Catálogo com 52 conjuntos.

- D60 passa a `esgana_gata_ruido` (576 x 11, CC0), por decisão do professor (13/10/2026): o quadrado latino
  passa a ter peixes. Matchette e Herbert-Read (2021, *Animal Behaviour* 177:39-48; Dryad 10.5061/dryad.sj3tx962p):
  144 esgana-gatas focais, cada uma sob quatro ruídos visuais (estático, lento, médio, rápido) em quatro períodos;
  sequência x período forma um quadrado latino 4 x 4, repetido em 36 peixes por sequência. O período foi
  reconstruído pela Tabela A1 do artigo. Nas médias das 16 células, ruído F = 16,2 (p = 0,003); com o peixe como
  bloco, F = 10,1 (p = 2e-6). Saem `suinos_castracao` (D60) e o exercício `gatos_cardiacos` (D63), que nunca
  chegaram a um commit; as curadorias e a de `vacas_fistuladas` ficam em `data-raw/substituidos/`. O catálogo
  fica com 53 conjuntos.

- Arrumação leve de 25 conjuntos (12/10/2026), sem alterar valores nem linhas; script em
  `data-raw/arrumacao_leve_20261012.R`, aplicado depois dos `preparar.R` (que ainda geram a versão anterior).
  Removidas colunas constantes ou que repetiam outra: `area_surber_m2` (enobieta_baci), `arquivo_origem`
  (camarao_vannamei_biometria), `sterol_id` (artemia_fitoesterois), `semana` (truta_acidos_graxos), `id_tanque` e
  `peixes_estocados` (tilapia_microalgas), `data_inicial` (mesocosmos_secagem), `grupo_local_especie`
  (molinesias_parasitos), `id_amostra` (secagem_beterraba_gengibre), `ano` e `especie` (pollock_alasca),
  `categoria_mercado` e `porto` (anchova_norte_california), `rio` (morfometria_barbo), `especie_codigo`
  (peixes_morfometria_multivariada), `cluster_autores` (peixes_nutricao_portugal) e `linha_fonte`
  (solha_baltico_2008_t4). Renomeadas: cpue_tubarao (`embarcacao`, `ano`, `mes`, `cpue`, `data`),
  `formalin` -> `formalina` (salvelino_formalina_remocao) e as quatro colunas em inglês da artemia_fitoesterois
  (`experimento`, `esterol`, `biomassa_mg`, `massa_individual_ug`). Texto com poucas categorias virou fator
  (enobieta_baci, camarao_vannamei_biometria, artemia_fitoesterois, cowichan_amostragem, lebistes_parasitos,
  aquicultura_br) e `linha`, `coluna` e `operador` do trigo_quadrado_latino também, como a ANOVA do quadrado
  latino exige. Rótulos padronizados em português com acento (fêmea/macho, março, centro/borda/fora,
  verão/inverno, baixa/alta). Ficam de fora, de propósito, os conjuntos bagunçados de treino de preparo e os da
  QFASA (nomes exigidos pelo pacote). Ajuda, catálogo e testes atualizados.

- Licenças dos dez conjuntos que estavam sem licença resolvida (D01, D03, D14, D16, D20, D21, D22, D25, D28, D61)
  passam a "uso interno na Trilha e na ClaRa autorizado pelo professor" (12/10/2026), por decisão do professor:
  são dados de pesquisa e coleta do grupo ou de fonte pública (D14: revista Peixe-BR, de acesso livre; D25: Comex
  Stat, do governo federal; D61: CDFW/NOAA ERDDAP). A natureza pública de D14 e D25 é informação do professor, não
  conferida na fonte. Nenhum foi retirado. **Atenção antes de publicar no CRAN:** a autorização vale para o uso
  interno do grupo; nenhum desses dez declara licença aberta nomeada (CC, MIT etc.). Confira antes de distribuir o
  pacote fora do grupo.

- D19: `lebistes_parasitos` (Walsman et al. 2022, Dryad, CC0), 4715 lebistes selvagens (*Poecilia reticulata*) com sexo,
  peso e infecção por *Gyrodactylus*, substitui `camaroes_sexo` (tabela de livro sem referência) por decisão do
  professor (12/10/2026). Dados individuais para o qui-quadrado de independência: a tabela de contingência é
  montada pelo aluno depois do preparo (sexo × presença, 3 × 2, χ² = 200,3). Também serve ao teste de proporções
  e à comparação de peso. Limites na ficha e na ajuda: peixes agrupados em sítios, 113 NA no peso, 3 peixes com
  presença 1 e contagem 0, conferência com o CSV original do Dryad pendente. Catálogo mantém 53 conjuntos.

- D17: `solha_baltico_2008_t4` (Dryad, CC0 1.0, DOI 10.5061/dryad.kb2f352), 179 arrastos ou estações de
  solha-europeia no quarto trimestre de 2008, substitui o provisório `camarao_ecogreen` por decisão do professor
  (12/10/2026). A regressão de `log_cpue_g` pelos seis preditores ambientais e espaciais tem R² = 0,646 e VIF máximo
  4,21; CPUE tem 37 zeros, preservados por `log1p()`. O recorte é didático, não uma base para inferir todo o Báltico.
  Catálogo mantém 53 conjuntos.

- D04: `lago_vitoria` (Okechi et al. 2025, Dryad, CC0), 217 leituras de água em 25 colunas em português,
  substitui `doubs_ambiente` (ade4, GPL), por decisão do professor (12/10/2026). Gaiolas de tilápia e controle em
  quatro locais do Lago Vitória, 2023 e 2024. Todas as linhas, os 81 NA de `profundidade_local_m` e os valores
  estranhos (24 turbidezes negativas) preservados; limites de dependência entre profundidades e unidades a
  conferir documentados na ficha e na ajuda. Catálogo mantém 53 conjuntos.

- Retirados do pacote por decisão do professor (12/10/2026): D42
  `plantas_crescimento`, D45 `insetos_inseticidas`, D51 `seguros_sinistros`,
  D53 `navios_incidentes` e D59 `peixes_recrutamento`. D51 e D53 têm
  `larvas_peixes_captura` (D62) como substituto; D59 tem
  `anchova_norte_california` (D61); D42 e D45 saem sem substituto. Fontes e
  receitas em `data-raw/retirados/`. Catálogo com 53 conjuntos (44 internos,
  oito do FSAdata e um do MASS). Resta sem substituto o D04 `doubs_ambiente` (resolvido abaixo).

- Retirados do pacote, sem substituto, por decisão do professor
  (12/10/2026): D11 `puromicina_reacao`, D43 `ervilhas_adubacao`, D46
  `carros_frenagem` e D49 `aveia_parcelas` (todos de pacotes GPL, fora do
  contexto de pesca e aquicultura). Objetos, ajuda e linhas do catálogo
  removidos; fontes e receitas preservadas em `data-raw/retirados/`. Catálogo
  com 58 conjuntos (49 internos, oito do FSAdata e um do MASS).

- D60 passa a `vacas_fistuladas` (16 x 8, CC BY 4.0), substituindo `trigo_quadrado_latino` (agridat), por decisão
  do professor (12/10/2026): o trigo estava fora do contexto do ecossistema. Quadrado latino 4 x 4 de verdade (4 vacas
  fistuladas em pastagem, 4 períodos, 4 dietas = oferta de forragem x suplemento), do Experimento II de Merino et al.
  (2021, *Animals* 11:919). Os sete horários de coleta por célula viram a média (a unidade é a célula vaca x período).
  As ANOVAs reproduzem a Tabela 4 do artigo (oferta p = 0,810, suplemento 0,856, interação 0,528 no pH) e o efeito de
  período (F = 13,1; p = 0,005) mostra o ganho do bloqueio. Os códigos 1/2 da planilha foram resolvidos pelas médias da
  tabela. Fonte e receita em `data-raw/D60_vacas_fistuladas/`; o trigo foi para `data-raw/substituidos/`.
  Catálogo mantém 53 conjuntos.

- D12 passa a `garoupa_pcr_histologia` (123 x 4, CC BY 3.0 Austrália), substituindo `ovinos_caprinos_fmdv`, por
  decisão do professor (13/10/2026): o exemplo de McNemar passa a ser de pesca e aquicultura. Reconstrução, a partir das
  Tabelas 32 e 34 do relatório FRDC 2010/034 (Bowater 2015), do PCR e da histologia para *Streptococcus agalactiae*
  nos mesmos juvenis de garoupa-de-Queensland em desafio por coabitação, em duas réplicas (74 e 49 peixes). Só as
  contagens são reais; a ficha, a ajuda e o catálogo (`natureza`) dizem isso. McNemar com discordância de um lado só
  (2 contra 50; p = 7,1e-11): o PCR detecta mais positivos, o que não é sensibilidade absoluta. A réplica 1
  é a planilha do professor, na ordem dela. Os resultados por peixe e por órgão estão nos Apêndices 8 e 9 do relatório e
  podem tornar o conjunto real. Fonte e receita em `data-raw/D12_garoupa_pcr/`; os ovinos foram para
  `data-raw/substituidos/`. O D12 segue um só conjunto no catálogo.

- D12 passa a `ovinos_caprinos_fmdv` (418 x 11, CC0 para os dados; artigo CC BY 4.0), substituindo
  `cabras_toxoplasma`, que reconstruía linhas a partir de tabelas publicadas. Dados individuais reais de
  Gubbins et al. (2025, *Veterinary Research* 56:76): 418 pares de soro e swab oral por rRT-PCR para o vírus
  da febre aftosa em ovinos e caprinos do norte da Nigéria, 323 animais (152 linhas de animais repetidos).
  McNemar com discordantes nos dois sentidos (8 e 9; p = 1; o artigo relata p > 0,9 e kappa = 0,08), uma coleta
  por animal para discutir independência (308, 8, 6, 1) e ELISA NSP contra PCR para o contraste (p ~ 1e-36).
  Planilha de partida montada pelo professor, fonte e receita em `data-raw/D12_ovinos_fmdv/`; as cabras e a
  erva-marinha foram para `data-raw/substituidos/`. Catálogo mantém 53 conjuntos.

- Fusão das branches `dados` e `codex/substitutos-literatura-20261012`
  (12/10/2026). D12 `bufalos_estrongilos` (418 × 6, CC0) substituiu
  temporariamente `bacterias_tratamento` (MASS::bacteria) e D52 `secagem_beterraba_gengibre`
  (594 × 8, CC BY 4.0) substitui `paciente_peso` (MASS::wtloss); os códigos D
  foram mantidos. Fontes GPL antigas em `data-raw/substituidos/`. Para D44 e
  D48 valem os objetos da `dados` (`percas_hipoxia` e `molinesias_crescimento`,
  com 1.178 medições); as variantes da outra branch (`percas_respirometria` e
  o recorte equilibrado de 340 medições das molinésias) ficam arquivadas em
  `data-raw/alternativas_codex/`, fora do pacote. Relatório da outra branch em
  `docs/RELATORIO_INCORPORACAO_20261012.md`.

- Corrige a colisão provisória de registros entre checkouts: D61 permanece
  `anchova_norte_california`; `larvas_peixes_captura` passa a D62. Ambos
  preservados no catálogo consolidado, agora com 62 conjuntos (53 internos,
  oito FSAdata e um MASS). Fichas, preparo, ajuda e testes atualizados.

- D44/D48: `percas_hipoxia` (449 medições, 40 peixes, CC0) e `molinesias_crescimento` (1178 medições, 34 peixes, CC BY 4.0) substituem CO2 e Orange por decisão do autor. Fontes arquivadas, preparo reproduzível, colunas em português, NA preservados e limites de medidas repetidas documentados. Catálogo permanece com 61 registros.

- D47: `pollock_alasca` (NOAA/DisMAP, CC0), 523 lances de 2023 e oito colunas em português, substitui `terremotos_fiji`. Coordenadas WGS84, profundidade, CPUE kg/ha, estratos e 91 zeros preservados; fonte antiga arquivada. Dois pontos junto à costa exigem conferência cartográfica, sem deslocamento ou exclusão. Catálogo mantém 61 registros.

- D62: `larvas_peixes_captura`, Dryad CC0, 58 eventos e sete colunas em português. Esforço reconstruído de horas e minutos; todos os eventos preservados. Inclusão autorizada em 12/10/2026, catálogo com 61 registros. D51 e D53 preservados. Fonte, preparo e limites do delineamento documentados.

# clara 0.16.0

- D18: `truta_acidos_graxos` (Happel et al., Mendeley Data V2, CC BY 4.0) substitui `cabritos_acidos_graxos`, por decisão do autor. Semana 12, 21 aquários, sete dietas e 27 ácidos; 31 colunas. Fontes originais e preparo em R preservados. Catálogo tem 61 conjuntos após a inclusão do D61. Biplot exploratório aprovado como referência para futura reprodução em R.

# clara 0.15.0

- `carregar_dados()` oferece uma porta de entrada para os 61 conjuntos do catálogo.
- Oito conjuntos do FSAdata e `MASS::crabs` passam a ser lidos e traduzidos na hora. Retiradas as nove cópias de `data/` e as cópias binárias das respectivas pastas de fontes; códigos D e nomes preservados.
- Catálogo com `fonte_dados` (`clara`, `FSAdata` ou `MASS`); fornecedores opcionais em Suggests. Mensagens em português explicam como instalar o fornecedor quando necessário.
- Receitas conferidas contra os nove objetos anteriores com `identical()`, inclusive os quatro que passaram pelo EAPADados. Preservados filtro de idade e quartis anteriores ao filtro em `snapper_hg`.
- Para esses nove conjuntos, substituir `data(nome, package = "clara")` ou `clara::nome` por `carregar_dados("nome")`. Ajuda e referências continuam disponíveis.

# clara 0.14.0 (11 de outubro de 2026)

- Dados: D50 `molinesias_parasitos` (128 peixes, oito colunas, CC0) substitui `escolares_ausencias` (MASS::quine), mantendo o código D50 por decisão do professor. Objeto antigo retirado do pacote; fontes preservadas no histórico.

- D39: `cowichan_amostragem`, fonte CC0, substitui `walleye_erie` por decisão do professor; 246 peixes e oito colunas. Comprimento do registro 234 a conferir.

- Dados: D09 `tilapia_sensorial`, provisório, da literatura; 122 avaliadores, notas pareadas e escala pendente de interpretação.

- Dados: D08 `pinguins`, provisório, adaptado de `EAPADados::pinguins`; fonte preservada.

- Dados: D07 `camarao_vannamei_biometria`, provisório, adaptado de `EAPADados::camarao_vannamei_biometria`; fonte preservada.

- Dados: D06 `salvelino_formalina_remocao`, provisório, adaptado de `EAPADados::salvelino_formalina_remocao`; fonte preservada.

- Dados: D05 `abalone_adultos`, provisório, adaptado de `EAPADados::abalone_adultos`; fonte preservada.

- Dados: D04 `doubs_ambiente`, provisório, adaptado de `EAPADados::doubs_ambiente`; fonte preservada.

- Dados: D03 `cpue_tubarao`, provisório, adaptado de `EAPADados::cpue_tubarao`; fonte preservada.

- Dados: D02 `morfometria_barbo`, provisório, adaptado de `EAPADados::morfometria_barbo`; fonte preservada.

* D01: `bagre_racao_isoproteica`, com 19 observações preservadas, documentação, catálogo e preparo reproduzível; curadoria aprovada e autorização dos autores pendente.


Ajuste do p nas comparações de Dunn (decisão do professor, 11/10/2026),
pedido pela Trilha, cuja tela do Kruskal-Wallis oferece Bonferroni, Holm e
BH.

* `comparar_medianas(..., ajuste_p = "holm")`, com `"bonferroni"` e `"bh"`
  (Benjamini-Hochberg). Holm continua o padrão, então quem já usa a função
  sem escrever o ajuste não vê mudança. Só vale com três ou mais grupos;
  com dois, a função recusa com mensagem. A escolha fica em
  `resultado$nomes$ajuste_p`, e a receita escreve o método no
  `p.adjust()`.
* As frases (comparações, nota da tabela e legenda) e o console citam o
  ajuste escolhido.

# clara 0.13.0 (10 de outubro de 2026)

Mann-Whitney unilateral, pedido pela Trilha, cuja tela do Mann-Whitney
oferece a hipótese unilateral. Segue a decisão do professor para o teste t
(0.11.0): é argumento, não função nova.

* `comparar_medianas(..., alternativa = "bilateral")`, com `"maior"` ou
  `"menor"` (as observações do primeiro grupo, na ordem dos níveis, tendem
  a valores maiores ou menores que as do segundo). Só com dois grupos: o
  Kruskal-Wallis é sempre bilateral, e a função recusa com mensagem. A
  escolha fica em `resultado$nomes$alternativa`, e a receita escreve
  `alternative =` no `wilcox.test()`.
* No unilateral, o intervalo do deslocamento (Hodges-Lehmann) fica aberto
  de um lado; frases, tabela e console escrevem `+∞` ou `-∞`. Com
  dispersões parecidas, a frase fala da mediana; com dispersões
  diferentes, das observações como um todo. O intervalo do tamanho de
  efeito continua bilateral.
* `escrever_resultados()` das medianas (Mann-Whitney e Kruskal-Wallis)
  passa a trazer `$nota_tabela` e `$legenda_figura`, como as médias, para
  o relatório na Trilha.
* Arrumação: `alternativas_r` e a conferência da alternativa
  (`escolher_alternativa()`) passam para o motor, usadas pelas médias e
  pelas medianas.

# clara 0.12.0 (10 de outubro de 2026)

Relacionar variáveis (decisões do professor de 10/10/2026), pedida pela
Trilha para levar a regressão linear simples para a ClaRa. Nova pergunta,
em `R/clara_regressao.R`.

* `relacionar_variaveis(dados, resposta, preditor, rotulo_resposta,
  rotulo_preditor, confianca = 0.95, avaliar_autocorrelacao = FALSE)`: a
  regressão linear simples. Devolve `$coeficientes` (intercepto e
  inclinação, com EP, IC, t e p), `$ajuste` (n, R², R² ajustado, erro
  padrão dos resíduos e F), `$pressupostos` (Shapiro-Wilk e
  Breusch-Pagan nos resíduos; Durbin-Watson só com
  `avaliar_autocorrelacao = TRUE`, com `set.seed(1)` porque o p vem de
  reamostragem), `$influencia` (as observações com resíduo padronizado
  acima de 3, alavancagem acima de 2p/n ou Cook acima de 4/n, com
  `linha_da_base`), `$amostra`, `$dados` e `$modelo`. Os testes são os
  mesmos da tela da Trilha (`car::ncvTest()` dá o mesmo p de
  `performance::check_heteroscedasticity()`).
* `grafico_reta()`: a figura principal, com os pontos, a reta, a faixa de
  confiança (calculada com `predict()`, no nível da análise) e a equação
  com o R². `colorir_por` dá uma cor por grupo aos pontos, só para a
  leitura: a reta continua uma só.
* Receitas da regressão nos verbos para qualquer análise:
  `medir_efeito()` (r de Pearson e R², com IC; leitura de Cohen para r,
  que ao quadrado vale para o R²), `escrever_resultados()` (com
  `$equacao` e `$influencia`; `$nota_tabela` e `$legenda_figura` da
  regressão), `exibir_teste()` (os coeficientes), `exibir_resumo()` (o
  ajuste do modelo), `grafico_residuos()` (nuvem única com uma curva loess,
  para mostrar curvatura e funil) e `grafico_qq()` (resíduos
  padronizados, como na ANOVA).
* `exibir_teste()` ganhou `rotulo_preditor` e `casas` (só a regressão os usa)
  e `nota`, a nota de rodapé, como `exibir_resumo()` (em todas as análises);
  `escrever_resultados()` ganhou `rotulo_preditor`, que só vale para a
  regressão.
* Dados de treino novos: `real_barbo_morfometria` (reta limpa, cinco
  populações) e `real_cangulo_peso_comprimento` (relação curva). Roteiro
  novo: `exemplos/regressao_barbo.R`.

# clara 0.11.0 (10 de outubro de 2026)

Teste t unilateral (decisão do professor, 10/10/2026), para a Trilha levar
o teste t de duas amostras para a ClaRa sem perder a hipótese unilateral
que a tela dela oferece.

* `comparar_medias(..., alternativa = "bilateral")`: com dois grupos,
  `"maior"` (a média do primeiro grupo, na ordem dos níveis, é maior que a
  do segundo) ou `"menor"`. Com três ou mais grupos, só `"bilateral"`: a
  ANOVA é sempre bilateral, e a função recusa com mensagem. A escolha fica
  em `resultado$nomes$alternativa`, e a receita escreve `alternative =` no
  `t.test()`.
* No unilateral, o intervalo da diferença é aberto de um lado. As frases
  de `escrever_resultados()`, a tabela de `exibir_teste()` (coluna
  "IC 95% unilateral") e o console escrevem `+∞` ou `-∞`;
  `grafico_pares()` tem receita própria, com uma seta no lado aberto. O
  intervalo do tamanho de efeito continua bilateral.
* No unilateral, o poder é calculado no sentido da hipótese; se a
  diferença saiu no sentido contrário, `$poder` diz isso.
* `escrever_resultados()` do teste t passa a trazer `$nota_tabela` e
  `$legenda_figura`, como a ANOVA (para o relatório do teste t na Trilha).
* `formatar_numero()` e as tabelas escrevem `+∞` e `-∞` no lugar de `Inf`.

# clara 0.10.0 (9 de outubro de 2026)

Formatar e exibir (decisões B, C e D do professor): uma só versão das
funções de formatação que hoje se repetem nos moldes da Trilha
(`fmt()`, `formatar_p()`, `flextable_ocean()`) e no EAPADados
(`flextable_ocean()`, `flextable_cinza()`).

* `formatar_numero()`: vírgula decimal, casas fixas e traço no `NA`; faz
  o que o `fmt()` dos moldes fazia.
* `formatar_p()`: `"0,032"`, `"< 0,001"` e, com `no_texto = TRUE`,
  `"p = 0,032"`; traço no `NA`.
* `exibir_tabela()`: qualquer tabela no tema `"ocean"` (relatório Word,
  Times New Roman 10, cabeçalho azul-marinho) ou `"cinza"` (Viewer, letra
  de console, fundo verde acinzentado).
* `exibir_teste()` e `exibir_resumo()`: as duas tabelas do relatório a
  partir do resultado, com uma receita por análise (ANOVA, ANOVA de Welch,
  teste t, Kruskal-Wallis e Mann-Whitney) e o código visível com
  `mostrar_codigo = TRUE`. `exibir_resumo()` põe a letra das comparações
  sobrescrita à média (ou à mediana) e aceita a nota de rodapé de
  `escrever_resultados()` em `nota = textos$nota_tabela`.
* flextable entra em Imports.
* Os `print()` dos resultados usam `formatar_numero()` e `formatar_p()`; as
  peças internas `numero()` e `escrever_p()` saíram. A saída no console não
  mudou.

# clara 0.9.0 (9 de outubro de 2026)

A ClaRa vira pacote R (`library(clara)`). As funções, os argumentos e os
resultados são os mesmos da ClaRa 0.8.9: os seis roteiros de `exemplos/`
dão os mesmos números e as mesmas figuras.

* Instalação: `remotes::install_github("cluberufpa/ClaRa")`. No roteiro,
  `library(clara)` no lugar de `source("R/clara.R")`.
* Documentação pelo roxygen2: cada função tem a sua página no painel Help
  (`?comparar_medias`), com a pergunta da pesquisa como título e exemplos
  que rodam com dados do próprio R (`PlantGrowth`, `ToothGrowth`,
  `InsectSprays`).
* `ajuda()` lista as funções a partir das páginas de ajuda do pacote e
  abre a página de uma função no painel Help. O argumento `onde` passa a
  aceitar `"painel"` (padrão) ou `"console"`.
* As receitas rodam sem `library()`: os pacotes ficam visíveis só para a
  receita, e o caminho de busca do aluno não muda. O código mostrado com
  `mostrar_codigo = TRUE` traz os `library()` no topo, para a receita
  copiada rodar numa sessão nova.
* A semente aleatória do aluno é preservada, mesmo quando a receita usa
  `set.seed()` (o intervalo do ε² por bootstrap).
* A versão vem do `DESCRIPTION` (`packageVersion("clara")`); acabou o
  `versao_clara` em `R/clara.R`.
* Testes com testthat: os números conferem com `aov()`, `TukeyHSD()`,
  `oneway.test()`, `t.test()`, `kruskal.test()` e `wilcox.test()`, e a
  receita mostrada, rodada sem a ClaRa, dá o mesmo resultado da função.

- Passada 1: D10 `enobieta_baci`, macroinvertebrados para planejamento BACI; fonte completa preservada.

- Dados: D11 `puromicina_reacao`, provisório, com fonte e decisões anteriores registradas.

- Dados: D12 `bacterias_tratamento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D13 `artemia_fitoesterois`, provisório, com fonte e decisões anteriores registradas.

- Dados: D14 `aquicultura_br`, provisório, com fonte e decisões anteriores registradas.

- Dados: D15 `peixes_neotropicais_biometria`, provisório, com fonte e decisões anteriores registradas.

- Dados: D16 `caranguejos_biometria`, provisório, com fonte e decisões anteriores registradas.

- Dados: D17 `salmouras_carbonatos`, provisório, com fonte e decisões anteriores registradas.

- Dados: D18 `cabritos_acidos_graxos`, provisório, com fonte e decisões anteriores registradas.

- Dados: D19 `camaroes_sexo`, provisório, com fonte e decisões anteriores registradas.

- Dados: D20 `cangulo_crescimento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D21 `captura_pescada_amarela`, provisório, com fonte e decisões anteriores registradas.

- Dados: D22 `captura_pescada_amarela_bruta`, provisório, com fonte e decisões anteriores registradas.

- Dados: D23 `crabs_morfometria`, provisório, com fonte e decisões anteriores registradas.

- Dados: D24 `darter_ontario`, provisório, com fonte e decisões anteriores registradas.

- Dados: D25 `exportacao_pargo`, provisório, com fonte e decisões anteriores registradas.

- Dados: D26 `gammarus_dieta_temperatura_resumo`, provisório, com fonte e decisões anteriores registradas.

- Dados: D27 `idades_savel_repetibilidade`, provisório, com fonte e decisões anteriores registradas.

- Dados: D28 `lagostas_kelp_sexo`, provisório, com fonte e decisões anteriores registradas.

- Dados: D29 `peixes_morfometria_multivariada`, provisório, com fonte e decisões anteriores registradas.

- Dados: D30 `peixes_nutricao_portugal`, provisório, com fonte e decisões anteriores registradas.

- Dados: D31 `qfasa_predadores`, provisório, com fonte e decisões anteriores registradas.

- Dados: D32 `qfasa_presas`, provisório, com fonte e decisões anteriores registradas.

- Dados: D33 `recifes_ostras_heatmap`, provisório, com fonte e decisões anteriores registradas.

- Dados: D34 `snapper_hg`, provisório, com fonte e decisões anteriores registradas.

- Dados: D35 `tilapia_microalgas`, provisório, com fonte e decisões anteriores registradas.

- Dados: D36 `treino_coletas`, provisório, com fonte e decisões anteriores registradas.

- Dados: D37 `treino_desembarque`, provisório, com fonte e decisões anteriores registradas.

- Dados: D38 `truta_riacho_crescimento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D40 `whitefish_salinidade`, provisório, com fonte e decisões anteriores registradas.

- Dados: D41 `mesocosmos_secagem`, provisório, com fonte e decisões anteriores registradas.

- Dados: D42 `plantas_crescimento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D43 `ervilhas_adubacao`, provisório, com fonte e decisões anteriores registradas.

- Dados: D44 `plantas_absorcao_co2`, provisório, com fonte e decisões anteriores registradas.

- Dados: D45 `insetos_inseticidas`, provisório, com fonte e decisões anteriores registradas.

- Dados: D46 `carros_frenagem`, provisório, com fonte e decisões anteriores registradas.

- Dados: D47 `terremotos_fiji`, provisório, com fonte e decisões anteriores registradas.

- Dados: D48 `laranjeiras_crescimento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D49 `aveia_parcelas`, provisório, com fonte e decisões anteriores registradas.

- Dados: D50 `escolares_ausencias`, provisório, com fonte e decisões anteriores registradas.

- Dados: D51 `seguros_sinistros`, provisório, com fonte e decisões anteriores registradas.

- Dados: D52 `paciente_peso`, provisório, com fonte e decisões anteriores registradas.

- Dados: D53 `navios_incidentes`, provisório, com fonte e decisões anteriores registradas.

- Dados: D54 `haemulon_crescimento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D55 `cabezon_maturidade`, provisório, com fonte e decisões anteriores registradas.

- Dados: D56 `ruffe_biometria`, provisório, com fonte e decisões anteriores registradas.

- Dados: D57 `bighill_amostras`, provisório, com fonte e decisões anteriores registradas.

- Dados: D58 `bighill_peixes`, provisório, com fonte e decisões anteriores registradas.

- Dados: D59 `peixes_recrutamento`, provisório, com fonte e decisões anteriores registradas.

- Dados: D60 `trigo_quadrado_latino`, provisório, com fonte e decisões anteriores registradas.
