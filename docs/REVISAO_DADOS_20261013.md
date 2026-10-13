# Revisão dos dados — 13/10/2026

Revisão do catálogo inteiro (56 conjuntos: 47 internos, oito do FSAdata, um do
MASS), feita depois das trocas da tarde (D11 `treino_biometria`, D52
`secagem_bagre`) e a partir de um extrato em PDF do livro de Ivo e Fonteles
Filho (1997), trazido pelo professor.

Ivo, C. T. C.; Fonteles Filho, A. A. (1997). *Estatística pesqueira: aplicação em
Engenharia de Pesca*. Fortaleza: Tom Gráfica e Editora. vi, 193 p. (CDD 639.2072).

## 1. Todos os conjuntos são de organismos aquáticos?

Sim. Não sobrou nenhum conjunto de organismo terrestre. Casos de fronteira, todos
aceitáveis:

| Código | Conjunto | Por que é de fronteira |
|---|---|---|
| D08 | `pinguins` | Ave marinha, vive na interface com o mar |
| D14 | `aquicultura_br` | Produção aquícola por estado, não medidas de organismos |
| D25 | `exportacao_pargo` | Comércio de pescado |
| D30 | `peixes_nutricao_portugal` | Composição nutricional por espécie (tecnologia do pescado) |
| D41 | `mesocosmos_secagem` | Peixes em tanques; a presença de anfíbios é um fator |
| D11, D36, D37 | treinos | Sintéticos de propósito, com peixes e desembarques fictícios |

## 2. O que o livro de Ivo e Fonteles Filho resolveu

| Código | Conjunto | O que mudou |
|---|---|---|
| D20 | `cangulo_crescimento` | Fonte identificada: Tabela 11.2 (*Balistes vetula*, Ceará), conferida valor a valor. Colunas renomeadas: `p1`–`p3` → `peso1_g`–`peso3_g`, `peso_g` → `peso_medio_g`, logaritmos → `ln_comprimento`, `ln_peso_medio`. A licença dizia "dados de coleta do grupo". |
| D42 | `artemia_racao` (novo) | Exercício 82: *Artemia salina*, ração A (farelo de arroz) × B (farelo de babaçu), 10 + 10, teste t unilateral. O antigo `EAPADados::artemia`, recusado como "fictício", é este exercício com 7 + 7 linhas. |
| D46 | `lagosta_cpue_esforco` (novo) | Exercício 11.1: CPUE × esforço de pesca da lagosta-verde (*Panulirus laevicauda*), 14 linhas, modelo exponencial (forma de Fox). |

Os três ficaram com a mesma licença: uso didático com citação da obra, sem termo
de consentimento (decisão do professor, 13/10/2026), sem licença pública. O
professor conferiu as 20 linhas do D42 no livro impresso. O PDF não foi guardado
no repositório; só as transcrições, em `fonte/`.

O exercício 11.2 (fecundidade de *P. argus*) tem só a equação, sem dados.

## 3. Licenças: o quadro atual

| Situação | Códigos |
|---|---|
| CC0 | D04 D08 D10 D17 D19 D38 D39 D40 D41 D44 D47 D50 D60 D62 |
| CC BY | D02 D05 D06 D07 D09 D12 D13 D15 D18 D26 **D28** D29 D30 D33 D35 D48 D52 |
| Licença do pacote fornecedor (GPL/MIT) | D23 D24 D27 D31 D32 D34 D36 D37 D54 D55 D56 D57 D58 |
| Livro, uso didático autorizado | **D01** (Bhujel, 2011), **D20 D42 D46** (Ivo e Fonteles Filho, 1997) |
| Uso interno autorizado | D03 D14 D16 D21 D22 D25 D61 |
| Sintético do professor | D11 |

Correções desta revisão, além do D20:

- **D28 `lagostas_kelp_sexo`** dizia "dados de pesquisa e coleta do grupo". É um
  depósito aberto: Malyenge, S. (2025), Mendeley Data, v1, DOI
  10.17632/y4vc857g9y.1, **CC BY 4.0** (Universidade da Namíbia). Ajuda, ficha,
  metadados e catálogo corrigidos. Continua sem se saber qual sítio, DIAZ ou
  SWB, é o kelp cultivado.
- **D01 `bagre_racao_isoproteica`** dizia "dados de pesquisa e coleta do grupo",
  mas a referência é a Tabela 7.4 de Bhujel (2011), *Statistics for Aquaculture*.
  Licença reescrita como tabela de livro. O valor original do livro continua não
  conferido.

Ainda sem referência completa: D16 (caranguejos de Bragança) e D21/D22 (pescada,
Lucas et al.). São dados do grupo; falta a citação.

## 4. Verbos da ClaRa no catálogo

`verbo_clara` estava preenchido em só cinco conjuntos. Cada verbo abaixo foi
rodado no conjunto e responde a uma pergunta que ele permite:

| Código | Verbo | Pergunta |
|---|---|---|
| D15 | `relacionar_variaveis` | Peso × comprimento nos logaritmos, por espécie |
| D16 | `comparar_medias`; `relacionar_variaveis` | Largura da carapaça por local; comprimento × largura |
| D20 | `relacionar_variaveis` | `ln_peso_medio ~ ln_comprimento` |
| D24 | `comparar_medianas` | Comprimento por rio (Mann-Whitney) |
| D28 | `comparar_medias` | Comprimento do cefalotórax por sexo |
| D42 | `comparar_medias`; `comparar_medianas` | A > B (unilateral) |
| D46 | `relacionar_variaveis` | ln(CPUE) × esforço |
| D50 | `comparar_medianas` | Parasitos por espécie |
| D52 | `relacionar_variaveis` | A reta, para comparar com o modelo de Page |

Ficaram de fora de propósito: D38 e D40 (peixes dentro de tanques, a ClaRa
trataria cada peixe como réplica), D13 (veja abaixo) e D35 (precisa de uma coluna
de dieta).

## 5. Decisões do professor (13/10/2026, mesma noite)

1. **D13**: entrou `esterol_rotulo`, o nome químico sem hífen; `esterol` fica como na
   fonte. `comparar_medias()` roda dentro de cada experimento.
2. **D35**: entrou `dieta`, conferida no artigo de dados (Amira et al. 2021, *Data
   in Brief* 38:107422: cinco dietas, três aquários de 30 L, 18 alevinos cada, 56
   dias). A ANOVA dá F(4, 10) = 766,8, com as cinco dietas diferentes entre si.
3. **`situacao`**: vocabulário fixo, `provisório` (36), `revisado` (17) e `sintético
   de treino` (3). O texto que acompanhava o termo foi para a coluna nova `limites`.
   Passaram a `revisado` os que estavam como curado, curadoria aprovada, revisado ou
   pronto para exploração; D36 e D37 passaram de provisório a sintético de treino.
4. **Ivo e Fonteles Filho**: sem termo de consentimento. **Bhujel (2011)**: o professor
   tem o livro impresso e vai procurar o autor; fica registrado em `limites` do D01.
5. **Trilha**: o mapa de `utils_export.R` muda na troca da fonte para a ClaRa; o
   `artemia` certo é o de 20 linhas.

## 5a. Pendências originais (registro)

1. **D13 `artemia_fitoesterois`**: os nomes químicos dos esteróis têm hífen
   (`23-methylbrassicasterol`), e `comparar_medias()` recusa grupos com hífen. Os
   nomes foram preservados por decisão anterior. Opções: um rótulo curto ao lado do
   nome químico, ou deixar o aluno renomear.
2. **D35 `tilapia_microalgas`**: cinco dietas (tipo de microalga × nível) com três
   tanques cada, mas não há uma coluna `dieta`; `tratamento_codigo` tem um nível por
   tanque. Uma coluna `dieta` deixaria a ANOVA pronta para `comparar_medias()`.
3. **Campo `situacao`**: 11 redações diferentes ("provisório", "Pronto para
   exploração", "curado", "revisado em 13/10/2026"...). Vale um vocabulário fixo
   (provisório, revisado, sintético de treino).
4. **Termos da obra de Ivo e Fonteles Filho** e de Bhujel (2011): o professor vai
   trazer mais material sobre licenças e créditos.

Divergências pequenas corrigidas: D50 com 8 colunas nos metadados e 7 no objeto;
D13 com 69 × 5 na ficha e 69 × 4 no objeto. D24 tem travessão nos metadados e
hífen no catálogo (o catálogo é Latin-1); não muda nada.

## 6. O que a Trilha precisa saber ao trocar a fonte para a ClaRa

- `cangulo_crescimento`: as colunas mudaram de nome (ver item 2). O mapa de
  descrições de `inst/app/modules/utils_export.R` usa os nomes antigos.
- `artemia`: o substituto é `clara::artemia_racao`, com as mesmas colunas
  (`racao`, `taxa_crescimento_mg_dia`) e 20 linhas em vez de 14; os testes que
  usam `EAPADados::artemia` vão dar números diferentes.
- `lagosta_cpue_esforco` é novo e serve à regressão exponencial da tela.
