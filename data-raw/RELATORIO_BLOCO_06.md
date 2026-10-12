# Bloco 6 — passada 1 (11/10/2026)

Últimos nove conjuntos: D52–D60. Um commit de incorporação por conjunto
na branch dados. **Todos os 60 conjuntos do Núcleo estão incorporados**,
com as substituições já autorizadas. Os nove deste bloco entram provisórios;
a incorporação não equivale a curadoria concluída nem a instalação aprovada.

| Código | Objeto | Linhas × colunas | Bytes xz |
|---|---|---|---:|
| D52 | paciente_peso | 52 × 2 | 436 |
| D53 | navios_incidentes | 40 × 5 | 468 |
| D54 | haemulon_crescimento | 465 × 3 | 1.404 |
| D55 | cabezon_maturidade | 525 × 5 | 2.020 |
| D56 | ruffe_biometria | 738 × 11 | 4.976 |
| D57 | bighill_amostras | 20 × 4 | 356 |
| D58 | bighill_peixes | 266 × 6 | 1.304 |
| D59 | peixes_recrutamento | 453 × 2 | 2.188 |
| D60 | trigo_quadrado_latino | 36 × 4 | 396 |

Total de data/, incluindo catálogo: **232.684 bytes**, abaixo de 3 MB.
Todos os arquivos do bloco têm menos de 100 KB; compressão xz conferida.
Hashes dos 60 registros conferidos. Catálogo sem códigos ou nomes duplicados,
com D01 a D60 em ordem e apenas dois sintéticos: treino_coletas (D36) e
treino_desembarque (D37), autorizados para as funcionalidades de preparo.
Datas e identificadores dos novos objetos foram adaptados de modo documentado;
nenhuma linha foi excluída, simulada, expandida ou reordenada.

Documentação, suíte completa e exemplo da ajuda conferidos a cada conjunto.
Estado final: **668 expectativas**, zero falhas, erros, avisos ou skips.
Os nove exemplos passaram. As execuções individuais do R continuam
encerrando com o código nativo 3221225477 depois de gravar os resultados.
Build passou. R CMD check completo (--no-manual) terminou com **1 ERROR
na instalação, durante lazy loading**. Check pendente; não marcado como
aprovado. Logs e produtos em verificacao-clara/bloco06_check, fora do repo.

## Fontes e adaptações

- D52/D53: objetos conferidos com MASS instalado e snapshot do levantamento.
- D54–D58: objetos conferidos com os arquivos primários da distribuição
  FSAdata 0.4.1 preservada no levantamento, incluindo atributos. Ajuda Rd,
  DESCRIPTION e termos da licença preservados; pacote não instalado.
- D59: série rec conferida com a distribuição astsa 2.5. Os 453 valores
  mensais e sua ordem foram preservados; calendário derivado de tsp,
  janeiro de 1950 a setembro de 1987. Primeiro dia representa o mês.
- D60: comparação exata com a tabela textual cochran.latin da distribuição
  agridat 1.26, incluindo atributos. Ajuda Rd e MIT + file LICENSE preservados.
- nome_eapadados vazio nas nove entradas diretas de pacotes. origem guarda
  pacote::objeto para rastreabilidade e correspondência no balanço.

## Pendências para a curadoria

- D52: 52 medições de um paciente, não 52 réplicas independentes. Série
  humana candidata à substituição por contexto aquático de curva não linear.
- D53: 40 células agregadas; seis têm serviço zero. Manter na base e tratar
  apenas no ramo com log da exposição. Não são necessariamente navios de pesca.
- D54: 465 pontos reconstruídos aproximadamente de figura do estudo de
  Haemulon plumierii; não são dados brutos cedidos pelos autores. Preferir
  tabela original se encontrada. Reconstrução de figura não é simulação.
- D55: 226 idades ausentes e maturidade desconhecida preservadas. Desconhecida
  não vira resposta binária; seleção para logística fica no ramo analítico.
  Confirmar unidade da idade e significado dos estágios. Datas mês/dia/ano.
- D56: 726 idades ausentes (só 12 conhecidas), dois pesos ausentes. IDs
  decimais/repetidos e códigos de local preservados; confirmar chaves e
  duplicatas antes de excluir. Rever significado dos estágios traduzidos.
- D57/D58: UID relaciona as tabelas, sem executar união na passada 1.
  As 266 linhas de peixes somam 296 indivíduos nas contagens da fonte.
  Captura usa soma de contagem, não número de linhas. Esforço não pode ser
  somado depois de repetido por peixe. Na tabela de peixes, 81 fishID e
  91 pesos ausentes preservados; ID é local à amostra, não chave global.
- D59: índice de recrutamento, não contagem. Confirmar espécie, área,
  construção e escala. Respeitar dependência temporal e calendário mensal.
- D60: diferença entre altura medida e verdadeira, inclusive valores
  negativos. Confirmar unidade, papéis de linha/coluna e randomização.
  Usar códigos de blocagem como fatores no ramo de quadrado latino.

Não há decisão urgente do professor neste bloco. A próxima etapa é a
revisão da integração pela sessão da Trilha e a curadoria com o professor;
o check completo continua sendo uma pendência técnica a resolver. Nenhuma
alteração foi feita na Trilha, funções de análise, versão ou dependências.
Merge local por bloco, sem push. Balanço distingue integração provisória
de revisão concluída e de check aprovado.

## Busca de substitutos

O professor está buscando fontes mais alinhadas à bioecologia geral,
bioecologia pesqueira, pesca, aquicultura e tecnologia do pescado.
As prioridades e estruturas necessárias estão em
[CANDIDATOS_SUBSTITUICAO.md](CANDIDATOS_SUBSTITUICAO.md). Não foram trocados
objetos já integrados nem inventadas fontes substitutas nesta etapa.
