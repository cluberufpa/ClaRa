# D46 — Lagosta-verde: CPUE e esforço de pesca

- Registro: `D46_lagosta_esforco`; objeto: `lagosta_cpue_esforco`.
- Ocupa o D46 (antes `carros_frenagem`, retirado em 12/10/2026), por decisão do professor em 13/10/2026. A lista de substitutos pedia duas medidas contínuas para comparar a reta com uma curva; é o caso.
- Fonte: **exercício 11.1** de Ivo e Fonteles Filho (1997), *Estatística pesqueira*: verificar se há correlação entre a CPUE (kg/covo-dia) e o esforço de pesca (10³ covos-dia) do estoque da lagosta *Panulirus laevicauda* e, se houver, ajustar y = A e^(−bx). Detalhes em `fonte/PROVENIENCIA.md`.
- Dimensões: 14 × 2; colunas `esforco_mil_covo_dia` e `cpue_kg_covo_dia`.
- Natureza: dados de pesca declarados no enunciado; o livro não diz os anos nem o local. A ordem das linhas é a do livro.
- Licença: obra com direitos reservados; uso didático autorizado pelo professor, com citação. Sem licença pública.
- Situação: revisado.

## Uso didático

Correlação (r = −0,92 sem logaritmo) e regressão exponencial pela reta de `log(cpue_kg_covo_dia)` contra o esforço: b = 0,052 por mil covos-dia, R² = 0,94. É a forma do modelo de produção de Fox; com ele se discute o esforço ótimo e o risco de extrapolar além do esforço observado. Comparar com a reta sem logaritmo mostra por que a curva serve melhor. Verbo ClaRa: `relacionar_variaveis()` depois de criar a coluna do logaritmo.

## Limites

Os períodos devem ser consecutivos no tempo (provavelmente anos de uma série), então os resíduos podem ter autocorrelação; com 14 pontos, os valores de p são aproximados. Sem os anos, não dá para fazer o gráfico da série.

Reproduzir na raiz: `source("data-raw/D46_lagosta_esforco/preparar.R")`.
