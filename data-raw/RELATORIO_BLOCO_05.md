# Bloco 5 — passada 1 (11/10/2026)

Dez novos conjuntos: D42–D51. Um commit de incorporação por conjunto na
branch dados. O catálogo passa a **51 conjuntos; restam 9 do Núcleo 60**.
Todos os dez entram provisórios. Tradução mínima dos cabeçalhos e categorias
de pacotes R, nomes definitivos dos objetos e identificadores em texto.
Nenhuma linha excluída, simulada ou reordenada; unidades originais preservadas.
nome_eapadados fica vazio nas dez entradas diretas de pacotes R, sem inventar
um objeto herdado. origem mantém pacote::objeto para rastreabilidade.

| Código | Objeto | Linhas × colunas | Bytes xz |
|---|---|---|---:|
| D42 | plantas_crescimento | 30 × 2 | 392 |
| D43 | ervilhas_adubacao | 24 × 5 | 416 |
| D44 | plantas_absorcao_co2 | 84 × 5 | 608 |
| D45 | insetos_inseticidas | 72 × 2 | 364 |
| D46 | carros_frenagem | 50 × 2 | 340 |
| D47 | terremotos_fiji | 1000 × 5 | 7.352 |
| D48 | laranjeiras_crescimento | 35 × 3 | 352 |
| D49 | aveia_parcelas | 72 × 4 | 472 |
| D50 | escolares_ausencias | 146 × 5 | 588 |
| D51 | seguros_sinistros | 64 × 5 | 576 |

Total de data/, incluindo catálogo: **217.680 bytes**, abaixo de 3 MB.
Nenhum arquivo do bloco ultrapassa 100 KB; compressão xz conferida.
Fontes congeladas e hashes dos 51 registros conferidos. Permanecem apenas
dois sintéticos no catálogo: D36 treino_coletas e D37 treino_desembarque,
autorizados para preparar dados e testar as funcionalidades do menu.

Documentação, suíte completa e exemplo da ajuda conferidos a cada conjunto.
Estado final: **602 expectativas**, zero falhas, erros, avisos ou skips.
O processo R continua encerrando com a falha nativa conhecida após gravar
as verificações (código 3221225477 nas execuções individuais). Build passou.
R CMD check completo (--no-manual) terminou com **1 ERROR na instalação,
durante lazy loading**. Check pendente; integração local não equivale a
instalação aprovada. Logs e produtos em verificacao-clara/bloco05_check,
fora do repositório e de data-raw/.

## Correção de fonte — D44

A entrada do levantamento seleciona datasets::CO2, experimento de absorção
por plantas (84 × 5), mas a cópia datasets__CO2.rda e sua ajuda continham
co2, a série atmosférica (468 observações). Foi recapturado **CO2**, pelo
nome exato, da distribuição R 4.6.1, juntamente com sua ajuda correta.
A série atmosférica foi preservada com nome inequívoco entre as fontes
auxiliares; não integra o objeto plantas_absorcao_co2. O preparo verifica
12 plantas, sete medições por planta e os cinco cabeçalhos esperados.
Nenhuma alteração foi feita no EAPADados ou na Trilha para essa correção.

Os outros nove objetos primários foram recapturados dos pacotes R/MASS e
comparados à cópia original do levantamento, incluindo atributos. As
referências e os termos GPL-2/GPL-3 da distribuição foram preservados.
Esta conferência não substitui reextração das publicações históricas.

## Pendências para a curadoria

- D42: ajuda não informa espécie, unidade da massa seca nem protocolo
  completo. Confirmar delineamento antes de tratar como DIC.
- D43: fatorial fracionado em seis blocos, com quatro parcelas por bloco;
  interação NPK confundida com blocos. Não é fatorial completo por bloco.
- D44: 84 medições em 12 plantas; respeitar medidas repetidas. Confirmar
  unidade da concentração na publicação: ajuda registra mL/L. Unidade da
  absorção preservada como micromoles por metro quadrado por segundo.
- D45: composição dos inseticidas e protocolo detalhado não informados;
  contagens e zeros preservados, avaliar dispersão na análise.
- D46: dados históricos da década de 1920, em mph e pés. Confirmar
  protocolo e repetição de veículos; evitar extrapolação das curvas.
- D47: mil eventos de uma subamostra, sem datas individuais. Preservadas
  longitudes acima de 180 graus; conferir convenção no mapa e escala de
  magnitude. Não inventar série temporal ou contexto pesqueiro.
- D48: sete medições em cada uma de cinco árvores. idade_dias é contagem
  desde 31/12/1968 segundo a ajuda; confirmar idade biológica e altura da
  medição. ID em texto, sem usar ordem original como preditor.
- D49: parcelas subdivididas — variedade na parcela principal, nitrogênio
  na subparcela. Respeitar estratos de erro. Confirmar padrão de cwt antes
  de converter; produção em quartos de libra por subparcela preservada.
- D50: classificações históricas de aprendizagem e origem cultural,
  sem interpretação causal. etapa_escolar é série/form, não idade em anos;
  confirmar equivalência de F1/F2/F3 e tempo de exposição.
- D51: células agregadas de seguros, não indivíduos. numero_segurados
  pode representar exposição; não inventar pessoas-ano nem presumir no
  máximo um sinistro por segurado. Avaliar dispersão do modelo.

Detalhes nas fichas e ajudas. Não há decisão urgente do professor neste
bloco; pendências ficam para a passada 2. Sem aumento de versão, novas
dependências, alteração de funções de análise, edição da Trilha ou push.
Acompanhamento distingue integração provisória de revisão concluída;
a falha do check não é marcada como aprovada.
