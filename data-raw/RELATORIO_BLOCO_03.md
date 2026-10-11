# Bloco 3 — passada 1 (11/10/2026)

Dez incorporações, D21 a D30, com um commit por conjunto na branch dados.
São **31 conjuntos no catálogo**, contando D39, antecipado como substituto
aprovado de walleye_erie. Restam 29 entradas do Núcleo 60.

| Código | Objeto | Linhas × colunas | Bytes xz |
|---|---|---|---:|
| D21 | captura_pescada_amarela | 252 × 14 | 2.324 |
| D22 | captura_pescada_amarela_bruta | 252 × 16 | 2.892 |
| D23 | crabs_morfometria | 200 × 10 | 2.224 |
| D24 | darter_ontario | 54 × 3 | 440 |
| D25 | exportacao_pargo | 4 × 48 | 952 |
| D26 | gammarus_dieta_temperatura_resumo | 12 × 11 | 768 |
| D27 | idades_savel_repetibilidade | 53 × 8 | 684 |
| D28 | lagostas_kelp_sexo | 1457 × 8 | 2.800 |
| D29 | peixes_morfometria_multivariada | 299 × 39 | 72.468 |
| D30 | peixes_nutricao_portugal | 40 × 22 | 2.492 |

Total de data/, incluindo catálogo: **163.416 bytes**, abaixo de 3 MB.
Nenhum arquivo deste bloco ultrapassa 100 KB. Fontes congeladas e hashes
SHA256 conferidos nos 31 registros. Valores comparados com a fonte local
que originou o objeto do EAPADados, respeitando suas transformações herdadas.

Documentação, suíte completa e exemplo da ajuda conferidos a cada conjunto.
Estado final: **439 expectativas**, zero falhas, erros, avisos e skips.
O processo R registra sucesso nas verificações e depois encerra com a falha
nativa conhecida (3221225477). Build passou. R CMD check foi executado e
terminou com **1 ERROR na instalação, durante lazy loading**. Check pendente;
integração no Git não equivale a instalação aprovada.

Produtos e logs estão em verificacao-clara/bloco03_check, fora do repositório.
Versão, dependências e funções de análise preservadas. Sem push.

## Pendências para a curadoria

- D21/D22: completar referência e licença dos dados de pescada; confirmar
  unidades e datas. Na versão tratada foram retiradas as duas CPUE quase
  vazias, conforme decisão anterior; a versão bruta preserva os defeitos.
- D23: revisão dos quartis de largura e da finalidade de cada estrato.
  Identificador convertido em texto; licença MASS preservada com as fontes.
- D24: dados reconstruídos aproximadamente de figura, conforme a fonte;
  explicitar essa limitação nos exercícios. Repetições preservadas.
- D25: conferir cobertura de 2025 e licença; formato largo mantido para
  exercícios de arrumação, sem tratar anos como observações independentes.
- D26: são médias, desvios-padrão e n por tratamento. As 12 linhas não são
  réplicas experimentais; não reconstruir indivíduos nem aplicar ANOVA como
  se fossem dados brutos. Útil para planejamento e gráficos de resumos.
- D27: faltantes por leitor preservados. Ausência de diferença em Wilcoxon
  não demonstra concordância entre leituras.
- D28: completar DOI, autoria, licença e significado de DIAZ/SWB; considerar
  armadilhas e eventos na independência. Filtro herdado preservado.
- D29: preservar as 35 medidas até a revisão; confirmar créditos, unidades
  e códigos anatômicos. Seleção e padronização alteram PCA/HCA.
- D30: rótulos de cluster/perfil dos autores ficam fora das entradas da PCA
  e HCA. Siglas e categorias aguardam curadoria; nenhuma espécie excluída.

Detalhes nas fichas. Nenhuma nova decisão do professor é necessária para
seguir a passada 1; essas pendências seguem para revisão posterior.
