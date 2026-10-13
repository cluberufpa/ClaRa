# D52 — Secagem de beterraba e gengibre

- Registro: `D52_secagem_vegetais`; objeto: `secagem_beterraba_gengibre`.
- Substitui `paciente_peso` (`MASS::wtloss`) por decisão do professor em 12/10/2026, mantendo D52.
- Fonte: Granella (2025), Mendeley Data DOI 10.17632/zkvb73tn79.1; licença CC BY 4.0, conferida em 12/10/2026.
- 594 observações, 36 séries e oito colunas. Cada série é produto × código de tratamento × temperatura × réplica.
- B/G e C/E são preservados literalmente: a fonte não confirma qual código nomeia cada produto ou pré-tratamento. `tempo_origem` é arredondado a três casas para eliminar artefatos como 4,99999999999998; sua unidade continua pendente.
- Não há NA em `razao_umidade`; não há imputação nem exclusão. A espessura original não entra porque é constante dentro de cada produto e não faz parte da curva inicial.
- Limites: não interpretar meia-vida como minutos ou horas, nem atribuir os códigos a beterraba/gengibre ou controle/etanol antes da confirmação do depositante.
- Reproduzir na raiz: `source("data-raw/D52_secagem_vegetais/preparar.R")`.
