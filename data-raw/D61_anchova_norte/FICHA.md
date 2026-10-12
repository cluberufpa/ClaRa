# D61 — Anchova-do-norte: desembarques mensais na Califórnia

| Campo | Registro |
|---|---|
| Nome na ClaRa | `anchova_norte_california` |
| Nome no EAPADados | `anchova_norte_california` |
| Natureza | Dados reais agregados mensalmente |
| Unidade amostral | Mês de desembarque agregado em todos os portos da Califórnia |
| Período | Janeiro de 1971 a dezembro de 1991 (252 meses) |
| Fonte | California Department of Fish and Game, distribuído pelo NOAA ERDDAP |
| Licença | Permissão de uso e redistribuição gratuita declarada pelo ERDDAP; sem licença Creative Commons nomeada |

## Curadoria

A fonte oficial traz uma linha inicial de unidades e uma data de referência no
dia 16 de cada mês. A preparação remove apenas a linha de unidades e normaliza a
data para o primeiro dia do mês, sem alterar os desembarques em libras. O recorte
mantém somente `Anchovy, Northern` e `All`, já selecionados na extração oficial.

`categoria_mercado = "anchova-do-norte"` identifica a categoria comercial do
arquivo, não uma afirmação sobre o estoque biológico. `porto = "todos_os_portos"`
explicita que cada observação já é um total estadual mensal.

## Utilidade no ecossistema

Na **Trilha**, este é o exemplo da tela de Séries Temporais: permite explorar a
ordem mensal, sazonalidade, tendência e autocorrelação sem esconder os
desembarques originais. Na **ClaRa**, o conjunto fica no catálogo para leitura e
estudo do formato de uma série mensal. A ClaRa ainda não tem verbo próprio para
séries temporais; portanto, ele não deve ser forçado em comparações de médias ou
regressões que tratem os meses como observações independentes.
