# Bloco 2 — passada 1, integração provisória (11/10/2026)

Dez incorporações, D11 a D20, com um commit por conjunto na branch dados.
O catálogo passa a conter 20 conjuntos. Sem push ou aumento de versão.

| Código | Objeto | Linhas × colunas | Bytes xz |
|---|---|---|---:|
| D11 | puromicina_reacao | 23 × 4 | 452 |
| D12 | bacterias_tratamento | 220 × 6 | 688 |
| D13 | artemia_fitoesterois | 69 × 5 | 832 |
| D14 | aquicultura_br | 216 × 5 | 1.404 |
| D15 | peixes_neotropicais_biometria | 306 × 9 | 5.960 |
| D16 | caranguejos_biometria | 993 × 5 | 1.860 |
| D17 | salmouras_carbonatos | 19 × 8 | 724 |
| D18 | cabritos_acidos_graxos | 32 × 10 | 1.756 |
| D19 | camaroes_sexo | 170 × 2 | 296 |
| D20 | cangulo_crescimento | 16 × 7 | 736 |

Total de data/, incluindo catálogo: **70.016 bytes**. Nenhum arquivo deste
bloco ultrapassa 100 KB. Compressão xz e hashes SHA256 conferidos. Fontes
originais preservadas em cada registro; transformações nas fichas e scripts.

Documentação regenerada e suíte completa executada a cada conjunto, além
do exemplo de sua ajuda. Estado final: **354 expectativas**, zero falhas,
erros, avisos e skips. O processo R grava os resultados e continua encerrando
com a falha nativa já reproduzida fora da ClaRa (3221225477).

R CMD build passou. R CMD check permanece com **1 ERROR na instalação**,
na preparação para lazy loading. Não equivale a check aprovado. Logs,
tarball, biblioteca temporária e clara.Rcheck estão em verificacao-clara
deste chat, fora do repositório. Mantida a pendência de ambiente conhecida
e a instrução do professor de integração local por blocos.

## Pendências para a passada 2

- D11: índice da planilha não identifica réplica biológica; um experimento
  por condição. Revisar aproximação logarítmica e significado da velocidade.
- D12: 220 registros longitudinais de 50 crianças; McNemar nas semanas 0 e
  11 tem 44 pares completos. Confirmar incentivo e adesão no protocolo.
- D13: fonte real da artêmia, quatro experimentos e três recipientes por
  tratamento. Separar experimentos; massa seca final não é taxa de crescimento.
- D14: completar edições/páginas dos anuários Peixe-BR e licença específica.
- D15: aplicadas exclusões e nomes previamente aprovados; revisar os nove
  rótulos taxonômicos e grupos sem identificação precisa.
- D16: confirmar unidades e protocolo da fonte; duplicatas preservadas.
- D17: correções herdadas preservadas; completar licença da fonte BRINE.
- D18: completar permissão e conferência da extração do artigo; evitar usar
  razões junto com seus componentes sem justificativa na PCA.
- D19: completar referência e permissão; não expandir abreviações taxonômicas
  sem fonte. Linhas repetidas preservadas.
- D20: corrigida a troca herdada entre ln_peso e ln_comp conforme pedido da
  Trilha; confirmar origem e significado das três pesagens por comprimento.

Pendências detalhadas constam das fichas de cada registro. Provisório no
catálogo não significa aprovação da curadoria fina ou da instalação.
