# D63 — Gatos: tolerância a substâncias cardíacas em quadrado latino

- Registro: `D63_gatos_cardiacos`; objeto: `gatos_cardiacos`.
- Papel: exercício complementar ao D60. É útil para reconhecer o quadrado latino 4 × 4, fazer a ANOVA e discutir diagnósticos; não é o exemplo principal de qualidade experimental.
- Fonte: Costa, *Estatística Experimental com o uso do software R*, capítulo 5, Tabela 5.9. A tabela é atribuída no livro a Gener (UNESP Jaboticabal), citando Rao. A fonte primária e a licença não são identificadas; os 16 valores foram transcritos para uso didático local.
- Estrutura: linhas = quatro combinações de técnica (I/II) e período (AM/PM); colunas = dia 1 a 4; tratamentos = substâncias A–D; resposta = log10 da dose em microgramas que provocou o efeito especificado.
- Limite central: técnica e período foram combinados em um único bloqueio de quatro níveis. A ANOVA em quadrado latino controla a variação dessas combinações, mas não separa o efeito de técnica do efeito de horário.
- Resultado para conferir: F = 0,29, com 3 e 6 g.l. para substância; não há evidência de diferença nas doses médias entre as substâncias nos dados da tabela.
- Reproduzir na raiz: `source("data-raw/D63_gatos_cardiacos/preparar.R")`.
