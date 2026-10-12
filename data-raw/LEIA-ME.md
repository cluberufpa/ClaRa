# Dados da ClaRa — acompanhamento da migração

## Mudança de plano — passada 1 (11/10/2026)

Esta seção vence as descrições históricas abaixo. O professor autorizou a
integração do Núcleo 60 em seis blocos de dez, sem aprovação individual.
Aplicar decisões anteriores e tradução mínima de fontes de pacotes R;
curadoria fina fica para a passada 2. Os novos conjuntos entram como
provisórios. D01 conserva a curadoria aprovada e a autorização da fonte pendente.

Código com dois dígitos (`D01`), registro com até duas palavras
(`D01_bagre_racao`), objeto sem número e definitivo. D001 foi ajustado
para D01. A artêmia fictícia não entra; `artemia_fitoesterois` é um conjunto
próprio. As cópias da proposta anterior foram preservadas em
`propostas_nao_integradas/artemia/`, fora da fila de registros incorporados.

Decisão do professor: manter **somente dois conjuntos sintéticos** no
catálogo da migração: `treino_coletas` (D36) e `treino_desembarque` (D37).
Sua finalidade é preparar dados e testar as funcionalidades do menu
Preparar Dados, preservando colunas compostas e o formato largo dos
exercícios. Ambos ficam identificados como sintéticos de treino. Esta
autorização não se estende a outros conjuntos sintéticos; se outro for
identificado, interromper sua incorporação e apresentar a questão ao professor.

Bloco 1: bagre, barbo, CPUE de tubarão, Doubs, abalone, salvelino, camarão,
pinguins, tilápia sensorial e Enobieta. Os demais seguem a ordem do Núcleo 60.
Um commit por conjunto; merge local por bloco após conferir a main parada
e limpa. Sem push, aumento de versão ou alterações na Trilha.

Limite de `data/`, incluindo catálogo: 3 MB; compressão xz. Antes de
incorporar qualquer conjunto acima de 100 KB, apresentar seu tamanho.
Produtos de verificação ficam em pasta temporária fora do repositório.
Não marcar como concluído no balanço um conjunto com check pendente.

### Pendências para a curadoria e a integração

- Bloco 6 (D52–D60): **60 conjuntos incorporados; nenhum restante**
  do Núcleo. 232.684 bytes em data/. 668 expectativas e nove exemplos
  passaram; build aprovado. Check mantém 1 ERROR na instalação.
  A incorporação da passada 1 terminou; curadoria e validação final ainda
  pendentes. Apenas D36/D37 são sintéticos. Detalhes em
  RELATORIO_BLOCO_06.md; prioridades de busca em CANDIDATOS_SUBSTITUICAO.md.

- Bloco 5 (D42–D51): 51 conjuntos no catálogo; 217.680 bytes em
  data/. 602 expectativas e dez exemplos passaram. Build aprovado;
  check mantém 1 ERROR na instalação. Fonte de CO2 corrigida para o
  experimento de plantas, preservando a cópia equivocada da série como
  auxiliar. Apenas D36/D37 são sintéticos. Pendências de delineamento e
  unidades em RELATORIO_BLOCO_05.md. Restam 9 do Núcleo 60.

- Bloco 4 (D31–D38, D40/D41): 41 conjuntos no catálogo; 204.592 bytes
  em data/. 522 expectativas e dez exemplos passaram. Build aprovado;
  check mantém 1 ERROR na instalação. Recifes conferidos no CSV primário,
  referência corrigida. Whitefish e mesocosmos têm uma tabela principal
  cada e todas as fontes preservadas. Pendências em RELATORIO_BLOCO_04.md.
  Restam 19 conjuntos do Núcleo 60.

- Bloco 3 (D21–D30): 31 conjuntos no catálogo, incluindo D39 antecipado;
  163.416 bytes em data/. 439 expectativas e dez exemplos passaram. Build
  aprovado; check mantém 1 ERROR na instalação. Pendências de fonte,
  unidades e uso de dados agregados em RELATORIO_BLOCO_03.md. Restam 29.

- Bloco 2 (D11–D20): vinte conjuntos no catálogo; 70.016 bytes em data/.
  354 expectativas e os dez novos exemplos passaram. Build aprovado;
  check continua com falha nativa na instalação. Detalhes e pendências em
  RELATORIO_BLOCO_02.md; não marcar check como aprovado no balanço.
- walleye_erie: professor autorizou manter os 33.734 peixes × 12 colunas,
  132.676 bytes (~133 KB) em xz com identificadores em texto (11/10/2026).
  Em seguida pediu pesquisar uma fonte substituta na internet. A busca
  foi seguida da decisão de substituir por Cowichan em 11/10/2026.
  Professor escolheu avaliar Cowichan e forneceu XLSX/README, cujos hashes
  conferem com Dryad. A pedido, versão de revisão com 246 × 8, 3.504 bytes
  xz, sem ausências nas colunas retidas. Cinco locais permitem estratificação;
  usar massa inicialmente: um par total/padrão de comprimento conflita na
  fonte (linha 235). Avaliação e recorte em propostas_nao_integradas/
  cowichan_amostragem/. Substituição aprovada e preparada como D39,
  cowichan_amostragem, em D39_cowichan_amostragem/. D39 foi antecipado da
  posição prevista para walleye, sem criar entrada adicional ao Núcleo 60.
  Objeto definitivo: 3.500 bytes xz; catálogo passa a 21 objetos e data/ a
  73.800 bytes. 361 expectativas e exemplo passaram; build aprovado.
  Check mantém 1 ERROR na instalação; falha de encerramento do R persiste.
  Valor 51,09 mm preservado: não é aberrante pelo critério 1,5 IQR, global
  ou dentro de Cowichan Lake. Pendência é conflito total/padrão, não extremo.
  Professor aprovou colunas e categorias em 11/10/2026; situação revisado,
  mantendo a ressalva do comprimento e o check do pacote pendente.

- D09 (`tilapia_sensorial`): 122 × 7, 848 bytes em xz; notas preservadas.
  Confirmar significado, âncoras e sentido da escala; não presumir aceitação.
  Professor consultará o artigo. Depois, explicar as medidas e avaliar a
  pertinência das colunas para a análise; eventual retirada depende dessa
  revisão e da identificação da coluna, preservando a fonte integral.
- Bloco 1 preparado: dez conjuntos, 53.388 bytes com catálogo; 277
  expectativas e dez exemplos passaram; hashes das fontes conferidos.
  Collate atualizado com autorização expressa do professor. Build aprovado;
  check repetido falhou no carregamento lazy durante a instalação. O processo
  R encerra com -1073741819 mesmo com `--vanilla`; resultados foram salvos
  antes do encerramento. A falha foi reproduzida sem ClaRa, carregando
  somente rlang ou dplyr. Cópias binárias novas nas mesmas versões, em
  biblioteca temporária, não resolveram. Nenhuma biblioteca global alterada.
  O professor autorizou expressamente o merge do bloco 1 com essa pendência.
  A integração não equivale a aprovação da instalação ou do check.
- D10 (`enobieta_baci`): 135 × 94, 6.936 bytes em xz; tabela principal de
  macroinvertebrados para planejamento BACI. Substrato integral preservado
  no XLSX-fonte, sem outro objeto. Uma intervenção e uma campanha por fase
  limitam a inferência; revisar taxonomia e IASPT na passada 2.
- Não expandir automaticamente Enobieta/whitefish/mesocosmos para 69 objetos.
  Selecionar pelo uso didático previsto; as tabelas auxiliares permanecem
  preservadas na fonte. Whitefish e mesocosmos ainda não foram incorporados.

- D08 (`pinguins`): fonte palmerpenguins congelada e conferida; 344 × 8;
  2.380 bytes em xz. Aplicada decisão anterior de sexo fêmea/macho;
  ausências e ordem preservadas. Revisar casos completos por análise.

- D07 (`camarao_vannamei_biometria`): CSV conferido; 170 × 9; 1.588 bytes
  em xz. Confirmar a denominação anatômica do comprimento; manter NA de
  cefalotórax no DB1 e o contexto dos cinco subconjuntos.

- D06 (`salvelino_formalina_remocao`): CSV conferido; 30 × 7; 696 bytes
  em xz. Preservar unidades experimentais e o desenho desequilibrado;
  revisar pressupostos e transformação antes da análise fatorial.

- D05 (`abalone_adultos`): recorte conferido com CSV UCI; 2.641 × 9;
  26.096 bytes em xz. Revisar em detalhe unidades e critérios herdados,
  sem nova seleção na migração.

- D04 (`doubs_ambiente`): fonte ade4 1.7-24 congelada e conferida; 30 × 13;
  1.112 bytes em xz. Escalas descritas corretamente, sem transformar dados.
  Licença GPL (>= 2) da origem registrada; não substituída pela MIT.
  Professor decidiu manter a fonte em 11/10/2026; encaminhamento de
  licenciamento será definido depois.
  Propor identificação explícita das estações na passada 2.

- D03 (`cpue_tubarao`): fonte original conferida; 424 × 5; 3.376 bytes
  em xz. Professor confirmou dados próprios, publicados em outro formato
  (11/10/2026). Uso autorizado; completar referência bibliográfica, créditos,
  licença específica, unidade da CPUE e desenho da coleta.
  Colunas herdadas em inglês preservadas por decisão da passada 1.

- D02 (`morfometria_barbo`): fonte curada conferida; 100 × 13; 7.536 bytes
  em xz. Provisório; nenhuma mudança de coluna ou categoria. Revisar a
  correção alométrica na fonte completa e a redundância rio/população.
  Arquivo incluído em Collate com autorização expressa do professor.

- D01: autorização dos autores e confirmação da descrição da replicação.
- A planilha de revisão original ainda está toda pendente; o balanço dos
  60 preserva aprovações anteriores em coluna própria. Estas serão
  respeitadas, mantendo pendências técnicas de unidade e de procedência.
- Os testes do D01 passaram nas 209 expectativas, sem falhas, avisos ou
  skips. Depois dos resultados, o processo R encerrou com código
  -1073741819 (violação de acesso no Windows). A falha de instalação/check
  é preexistente e não equivale a falha nas expectativas dos testes.
  Nenhuma função foi alterada para contorná-la.

## Como revisar o primeiro conjunto

Abra `D01_bagre_racao/bagres_para_revisao.xlsx`. A aba **Dados para revisar**
reproduz somente a aba `src_isoproteica` da fonte, sem mudar nomes, valores ou
ordem. A aba **Revisão do autor** reúne o contexto e os campos azuis para suas
observações. Salve a planilha e avise no chat para que as decisões sejam lidas.
Ela é uma cópia de consulta; a fonte preservada em `fonte/` não deve ser editada.

O professor aprovou os bagres no chat em 11/10/2026 e solicitou o preparo
enquanto aguarda a resposta dos autores. O nome final é
`bagre_racao_isoproteica`, com `racao` e `peso_g`. As fontes e a
planilha de revisão continuam preservadas; a autorização da fonte permanece
pendente na ficha, na ajuda e no catálogo.

| Conjunto atual | Situação | Data | Código | Registro |
|---|---|---|---|---|
| isoproteica_bagre → bagre_racao_isoproteica | Curadoria aprovada; preparo aprovado; integração local autorizada; check e autorização da fonte pendentes | 11/10/2026 | D01 | D01_bagre_racao |

## Planilha de acompanhamento

Por solicitação do professor em 11/10/2026, o acompanhamento passa a usar também
`EAPADados/nova_estetegia_levantamento/balanco_fase2_60_conjuntos.xlsx`.
Essa autorização permite atualizar o acompanhamento, sem alterar dados,
documentação ou decisões anteriores do EAPADados.

- **Dados prontos**: conjunto, análises úteis, data de conclusão, identificador
  permanente no formato `D01`, `D002`, ... e nome anterior/origem.
- Um conjunto só entra nessa aba após aprovação, documentação e validação na
  ClaRa. A linha correspondente recebe preenchimento verde `#C6E0B4` em
  **Núcleo 60** e **Inventário**; as novas colunas registram a situação, o
  identificador e a data sem substituir avaliações anteriores.
- Bases em `dados_treino/` e rótulos históricos como “pronto” ou “já ajustado”
  não equivalem a incorporação aprovada na ClaRa. Nesta etapa não há conjuntos
  concluídos pelo novo fluxo na primeira revisão. A aprovação posterior dos
  bagres está registrada na ficha; autorização e integração são acompanhadas
  separadamente.
- `acompanhamento/` guarda a cópia do balanço anterior à primeira edição.

## Limite desta etapa

Autorizado o preparo dos bagres após a avaliação. O objeto e o catálogo estão
em `data/`; nenhuma função de análise foi alterada. O professor autorizou a integração local na `main`; o check de instalação
permanece pendente e não houve push. O trabalho está na branch `dados`, na pasta separada
`ClaRa-dados/`, iniciada na `main` local `44cb0fe` para incluir o estado local
mais recente sem trocar a branch da pasta compartilhada `ClaRa/`.

## Pedido prioritário da Trilha (11/10/2026)

O pedido em `TRILHA/.claude/worktrees/elated-bhaskara-88c769/docs/`
`PEDIDO_DADOS_TRILHA_PARA_CLARA.md` orienta a prioridade atual.
Código, registro e objeto são campos diferentes: `D01`,
`D01_bagre_racao` e `bagre_racao_isoproteica`. A pasta de preparo usa
o registro curto; o objeto mantém nome sem prefixo numérico. O catálogo
informa `nome_eapadados` para a transição de nomes da Trilha.

| Prioridade | Origem no EAPADados | Situação | Colunas indispensáveis |
|---|---|---|---|
| 1 | isoproteica_bagre | Ajuste ao contrato da Trilha preparado; D01_bagre_racao | racao (fator), peso_g |
| 2 | artemia | Professor recusou o sintético; fonte real artemia_fitoesterois localizada, disponível para revisão em D002_artemia_racao/artemia_real_para_revisao.xlsx | Contrato anterior: racao e taxa_crescimento_mg_dia. Fonte candidata mede biomassa e peso seco; exige ajustar o contrato na sessão da Trilha após a curadoria. |
| 3 | morfometria_barbo | Aguarda curadoria individual | altura_maxima_corpo, distancia_dorsal_pelvica, comprimento_cabeca, distancia_pre_peitoral, populacao (fator) |
| 4 | cpue_tubarao | Aguarda curadoria individual | data Date e resposta numérica; radicais data/ano/mes |
| 5 | doubs_ambiente | Aguarda curadoria individual | riqueza, trecho (fator) |

Os números posteriores a D01 só serão atribuídos definitivamente na
incorporação aprovada. Não alterar a Trilha nesta sessão. Só avisar que a
troca está liberada quando os cinco estiverem integrados e a versão estiver
atualizada. Não subir a versão nesta correção isolada.
