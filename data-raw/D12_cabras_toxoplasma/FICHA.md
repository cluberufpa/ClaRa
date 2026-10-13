# D12 — Cabras: Toxoplasma em soro, sangue e leite

- Registro: `D12_cabras_toxoplasma`; objeto: `cabras_toxoplasma`.
- Substitui `erva_marinha_lesoes` (antes, `bufalos_estrongilos`), mantendo D12 e o exercício de McNemar. A erva-marinha foi retirada porque a medição "antes" era constante (todas as plantas começavam sem lesão por desenho), a tabela de pares ficava 1 × 2 e `mcnemar.test()` não rodava.
- Fonte: Dahmane et al. (2025), *Pathogens* 14(2):174, DOI 10.3390/pathogens14020174. Licença CC BY 4.0, conferida em 12/10/2026.
- 106 linhas, quatro colunas: `id_cabra`, `elisa_soro`, `pcr_sangue`, `pcr_leite`. Uma linha por cabra leiteira (31 rebanhos, Mila, Argélia).
- **As linhas são reconstruídas.** O artigo publica só as tabelas 2 × 2 (Tabelas 1 a 4); os dados individuais estão "sob pedido" ao autor correspondente. A receita monta as 106 linhas a partir das contagens, sorteia a ordem com `set.seed()` e cria identificadores fictícios. Só as contagens são reais.
- A tabela tripla (ELISA, sangue, leite) é única: as Tabelas 1 e 2 dão o sangue × leite entre soropositivas (6, 9, 7, 29) e, por diferença, entre soronegativas (1, 0, 1, 53). A receita confere as quatro tabelas publicadas e para se alguma não bater.
- Tabelas 2 × 2 para o aluno (positivo primeiro):
  - sangue × leite: 7, 9, 8, 82 (McNemar p = 1; discordantes 9 e 8, equilibrados);
  - ELISA × leite: 13, 38, 2, 53 (p < 0,000001; discordantes 38 e 2);
  - ELISA × sangue: 15, 36, 1, 54 (p < 0,000001; discordantes 36 e 1).
- Uso na Trilha: importar o CSV e escolher duas colunas, ou digitar as quatro células na entrada direta da tabela 2 × 2. As duas rotas dão o mesmo resultado.
- Limites: o McNemar trata as cabras como independentes, mas elas vêm de 31 rebanhos. ELISA mede anticorpo (exposição) e PCR mede DNA; nenhum é padrão-ouro. A PCR do leite leva uma etapa extra de pré-tratamento. No artigo, 13/51 aparece como 20,6% no texto e como 25,49% na tabela (o correto é 25,49%); não afeta as tabelas usadas aqui.
- Ponte para a aquicultura: dois tecidos ou sorologia × PCR no mesmo indivíduo (hemolinfa × brânquia no camarão, ELISA × PCR em peixes).
- Se o autor correspondente enviar a planilha por cabra, o conjunto pode passar a `natureza: "real"`.
- Reproduzir na raiz: `source("data-raw/D12_cabras_toxoplasma/preparar.R")`.
