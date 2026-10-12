# Bloco 4 — passada 1 (11/10/2026)

Dez novos conjuntos: D31–D38, D40 e D41. D39 já estava integrado como
Cowichan; não foi contado novamente. Um commit de incorporação por conjunto
na branch dados. O catálogo passa a **41 conjuntos; restam 19 do Núcleo 60**.
Todos os dez entram provisórios, com a curadoria fina pendente.

| Código | Objeto | Linhas × colunas | Bytes xz |
|---|---|---|---:|
| D31 | qfasa_predadores | 10 × 70 | 1.616 |
| D32 | qfasa_presas | 302 × 70 | 20.648 |
| D33 | recifes_ostras_heatmap | 301 × 26 | 7.820 |
| D34 | snapper_hg | 1331 × 6 | 2.124 |
| D35 | tilapia_microalgas | 15 × 32 | 2.252 |
| D36 | treino_coletas | 15 × 5 | 500 |
| D37 | treino_desembarque | 12 × 8 | 576 |
| D38 | truta_riacho_crescimento | 69 × 8 | 1.440 |
| D40 | whitefish_salinidade | 59 × 11 | 1.660 |
| D41 | mesocosmos_secagem | 30 × 12 | 940 |

Total de data/, incluindo catálogo: **204.592 bytes** (~205 KB), abaixo de
3 MB. Nenhum arquivo do bloco ultrapassa 100 KB; compressão xz conferida.
Fontes congeladas e hashes dos 41 registros conferidos. Arquivos dos dois
novos estudos também conferidos contra os hashes do levantamento original.

Documentação, suíte completa e exemplo da ajuda conferidos a cada conjunto.
Estado final, após ampliar a conferência primária dos recifes: **522
expectativas**, zero falhas, erros, avisos e skips. O processo R continua
encerrando com a falha nativa conhecida após gravar as verificações (código
3221225477 nas execuções individuais). Build passou. R CMD check completo
(--no-manual) foi executado e terminou com **1 ERROR na instalação, durante
lazy loading**. Check pendente; integração local não equivale a instalação
aprovada. Logs e produtos em verificacao-clara/bloco04_check, fora do repo.

Sem aumento de versão, novas dependências, alteração nas funções de análise,
edição da Trilha ou push. Situação na planilha distingue integração provisória
de revisão concluída; a falha do check não é marcada como aprovada.

## Fontes e decisões aplicadas

- D31: comparação exata com predatorFAs, do QFASA 1.2.1. Aplicada decisão
  anterior: id_amostra, id_animal, grupo_amostra e biopsia. Preservados os
  66 códigos de ácidos e os valores. D32: comparação exata com preyFAs;
  cabeçalhos/categorias herdados, sem aplicar proposta ainda pendente.
- D33: comparação exata dos 301 × 26 valores com a tabela primária
  MeanCount.NO.hyperabundants.dat.csv. Apenas o índice de exportação foi
  desconsiderado na conferência; a tradução herdada de cabeçalhos é bijetiva.
  Referência corrigida para Pine e colaboradores (2026), conforme
  [metadados oficiais](https://zenodo.org/records/19993470); licença CC BY 4.0.
  Ambas as versões primárias e o código do artigo foram preservados.
- D34: RDS herdado e subconjunto com idade do FSAdata conferidos; IDs
  originais preservados em texto. Não reinseridos peixes sem idade simulados.
- D35/D38: conferência com os CSVs curados e importações herdadas. Nenhum
  novo filtro ou renomeação fina. D36/D37: conferência com abas originais da
  planilha; sintéticos de treino expressamente autorizados, sem nova simulação.
- D40: File_A.csv como tabela principal de condição/fisiologia. Todos os
  quatro CSVs e README preservados. Tradução de cabeçalhos e Cool/Warm para
  frio/quente, IDs textuais; sem alteração de medidas ou exclusão de linhas.
  [Depósito Dryad](https://datadryad.org/dataset/doi:10.5061/dryad.bg79cnpph), CC0.
- D41: Fish Growth como tabela principal para fatorial e crescimento. Todas
  as seis planilhas e scripts preservados. Tradução documentada de cabeçalhos
  e categorias, IDs textuais e datas sem horário; 30 linhas preservadas.
  [Depósito Dryad](https://datadryad.org/dataset/doi:10.5061/dryad.hx3ffbgkn), CC0.
  Os dois estudos não receberam nome_eapadados inventado: campo vazio.

## Pendências para a curadoria

- D31: dez biópsias de quatro animais não são dez réplicas independentes;
  confirmar significado dos grupos e tratamento composicional.
- D32: confirmar identificação taxonômica, unidades e correspondência do
  painel com os predadores. Há grafias diferentes e um ácido adicional;
  não igualar por posição. FAset fica como fonte auxiliar, sem nova entrada.
- D33: justificar exclusão de espécies hiperabundantes, feita na própria
  fonte; abundância total difere da alternativa com elas. Conferir unidades
  geométricas e dependência entre levantamentos do mesmo recife.
- D34: idade 20 é 19+, não idade exata. Origem em tabelas e seleção de
  peixes para leitura de otólitos limitam interpretação e amostragem.
- D35: são 15 tanques, três por dieta; evitar modelo com dezenas de
  preditores. tratamento_codigo inclui a réplica. Expandir siglas depois.
- D36/D37: **DADOS SINTÉTICOS DE TREINO**, sem inferência científica.
  Preservadas colunas compostas e formato largo para os exercícios.
- D38: verificar alocação por tanque e fórmula de eficiencia_conversao;
  não usar indivíduos como réplicas independentes dos tratamentos nem uma
  variável derivada da resposta como preditor sem justificativa.
- D40: 59 registros na tabela, com nove no grupo frio/salinidade 30; não
  completar o décimo. Temperatura coincide com dia, grupos são indivíduos
  distintos e há subamostras por tanque. Ausências preservadas: 2 lactato,
  33 cortisol e 31 osmolaridade. Não imputar nem parear entre ocasiões.
- D41: 30 peixes, 7 ou 8 por combinação; fonte menciona 32 introduzidos.
  Confirmar duas ausências. Biomassas estimadas por regressão; crescimento
  relativo é razão sem dimensão, apesar de cm no README. Duração varia de
  65 a 91 dias. Dois pontos por peixe não sustentam curva de Gompertz.

Detalhes nas fichas e nas ajudas. Não há decisão urgente do professor para
este bloco; limitações ficam explícitas para revisão na passada 2.
