# D11 — Biometria de pescado: DADOS SINTÉTICOS DE TREINO

- Registro: `D11_treino_biometria`; objeto: `treino_biometria`.
- Ocupa o D11, vago desde a retirada de `puromicina_reacao` (`datasets::Puromycin`). Entra em 13/10/2026, por decisão do professor, ao separar as planilhas de treino da Trilha em conjuntos da ClaRa sem duplicações.
- Fonte: aba `biometria` de `Treino-Transformacoes.xlsx`, a planilha de treino da Trilha, copiada sem alteração (`fonte/`, com SHA-256). Detalhes e lista dos defeitos em `fonte/PROVENIENCIA.md`.
- Dimensões: 71 × 10; unidade: registro fictício de um peixe medido numa coleta em Ajuruteua, Bragança ou Caratateua, na estação seca ou chuvosa.
- **Sintético e com defeitos de propósito**: texto inconsistente (caixa, espaços, `f`/`F`/`Femea`), 5 + 6 valores ausentes, três linhas duplicadas, coluna composta `amostra`, data como texto. Nada foi corrigido: corrigir é o exercício.
- Uso didático: todo o menu de preparo, um conjunto só (a aba `guia` da planilha, transcrita na ajuda, diz que coluna exercita cada recurso).
- Duplicações evitadas: a aba `desembarques_largo` não entrou, porque o D37 `treino_desembarque` faz o mesmo exercício de empilhar com mais recursos. O D36 `treino_coletas` fica: o capítulo 5 do livro o usa no exercício de separar com expressão regular.
- Reproduzir na raiz: `source("data-raw/D11_treino_biometria/preparar.R")`.
