# D42 — Artêmia: crescimento com duas rações

- Registro: `D42_artemia_racao`; objeto: `artemia_racao`; nome_eapadados: `artemia`.
- Ocupa o D42 (antes `plantas_crescimento`, retirado em 12/10/2026), por decisão do professor em 13/10/2026.
- Fonte: **exercício 82** de Ivo e Fonteles Filho (1997), *Estatística pesqueira*. Uma fábrica afirma que a ração de farelo de arroz (A) acelera o crescimento de *Artemia salina* mais que a de farelo de babaçu (B); o livro pede o teste t unilateral com α = 0,05. Detalhes em `fonte/PROVENIENCIA.md`.
- Dimensões: 20 × 2 (dez por ração); colunas `racao` (A, B) e `taxa_crescimento_mg_dia`.
- Natureza: exercício de livro; o experimento não é descrito (número de animais, recipientes, duração). Cada valor é tratado como independente, como no exercício.
- Licença: obra com direitos reservados; uso didático autorizado pelo professor, com citação. Sem licença pública.
- Situação: revisado.

## Relação com o antigo `EAPADados::artemia`

O conjunto do EAPADados (14 × 2), recusado na passada 1 por se declarar fictício, é o mesmo exercício com só os sete primeiros valores de cada ração. A fonte agora está identificada; a proposta antiga fica em `propostas_nao_integradas/artemia/`. Os nomes das colunas são os do EAPADados, que a Trilha já conhece.

## Uso didático

Teste t de duas amostras unilateral: `comparar_medias(artemia_racao, taxa_crescimento_mg_dia, racao, alternativa = "maior")` dá t = 4,20 e p = 0,0003 (médias 4,10 e 3,42 mg/dia). Mann-Whitney com `comparar_medianas()`. Bom para discutir a hipótese unilateral escolhida antes de olhar os dados e a diferença entre a afirmação da propaganda e o que o teste sustenta.

Reproduzir na raiz: `source("data-raw/D42_artemia_racao/preparar.R")`.
