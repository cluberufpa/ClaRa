# D60 — Suínos: idade de castração em quadrados latinos repetidos

- Registro: `D60_suinos_castracao`; objeto: `suinos_castracao`.
- Substitui `vacas_fistuladas` como exemplo principal de quadrado latino por decisão do professor em 13/10/2026. A curadoria anterior permanece em `data-raw/substituidos/D60_vacas_fistuladas/`.
- Fonte imediata: Costa, *Estatística Experimental com o uso do software R*, capítulo 5, Tabelas 5.1 e 5.6. Os 32 valores foram transcritos das tabelas; o livro não identifica a fonte primária, a randomização ou uma licença de redistribuição.
- Estrutura: dois quadrados latinos 4 × 4. Linhas = leitegadas; colunas = posição de peso inicial dentro da leitegada; tratamentos = quatro idades de castração; resposta = ganho de peso (kg) aos 252 dias.
- Tratamentos: A = 56 dias; B = inteiro; C = 7 dias; D = 21 dias. A unidade experimental é o leitão, se a atribuição de tratamento foi realmente individual e aleatória dentro de cada célula; essa condição precisa ser ensinada, pois não é documentada pela fonte.
- Análise principal: caso 3 de quadrados latinos repetidos. As leitegadas e os pesos iniciais diferem entre os dois quadrados. A Tabela 5.8 relata F = 5,77, p = 0,0079 para tratamento, com 15 g.l. residuais; A tem ganho médio inferior aos demais tratamentos.
- Modelo: `aov(ganho_peso_kg ~ tratamento + quadrado + quadrado:leitegada + quadrado:posicao_peso_inicial, data = suinos_castracao)`.
- Limites: as posições de peso são ordinais, não valores de peso; o estudo publicado não permite auditar a aleatorização, independência entre leitões de uma mesma leitegada ou pressupostos a partir dos dados primários.
- Reproduzir na raiz: `source("data-raw/D60_suinos_castracao/preparar.R")`.
